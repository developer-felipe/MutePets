local addonName, ns = ...

-- MutePetsDB.muted["imp"]["wound"] = true  -> category muted
local db
local expanded = {}
local rows = {}

local function IsMuted(key, cat) return db.muted[key] and db.muted[key][cat] end

local function GroupState(g)
    local on, total = 0, 0
    for cat in pairs(g.cats) do
        total = total + 1
        if IsMuted(g.key, cat) then on = on + 1 end
    end
    return on, total
end

-- applied[key][cat] remembers what the engine already has, so we never repeat
-- Mute/UnmuteSoundFile calls for a state that has not changed (login does zero
-- unmute calls, and toggling only touches the categories that really changed).
local applied = {}

local function ApplyCategory(g, cat)
    local mute = IsMuted(g.key, cat) and true or false
    local a = applied[g.key]
    if not a then a = {} applied[g.key] = a end
    if (a[cat] or false) == mute then return end
    a[cat] = mute
    local fn = mute and MuteSoundFile or UnmuteSoundFile
    for _, id in ipairs(g.cats[cat]) do fn(id) end
end

local function SetGroup(g, value)
    db.muted[g.key] = db.muted[g.key] or {}
    for cat in pairs(g.cats) do
        db.muted[g.key][cat] = value or nil
        ApplyCategory(g, cat)
    end
end

local function ApplyAll()
    for _, g in ipairs(ns.GROUPS) do
        for cat in pairs(g.cats) do ApplyCategory(g, cat) end
    end
end

---------------------------------------------------------------- UI
local panel, content, Refresh, categoryID
local ROW_H, SUB_H, PLATE_W, HEADER_H, BAND_W = 28, 24, 470, 34, 540
local COL_W = 225
local classOpen = {} -- collapsed by default
local headers = {}
local L = ns.L
local function PetName(g) return L["pet_" .. g.key] or g.name end

local function NewCheck(parent, label, onClick)
    local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    cb:SetSize(26, 26)
    cb.text = cb:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    cb.text:SetPoint("LEFT", cb, "RIGHT", 4, 1)
    cb.text:SetText(label)
    cb:SetScript("OnClick", onClick)
    return cb
end

-- Expand/collapse chevron: Blizzard atlas when available, classic +/- buttons otherwise
local function SetArrow(tex, enabled, open)
    if not enabled then tex:Hide() return end
    tex:Show()
    local atlas = open and "Options_ListExpand_Right_Expanded" or "Options_ListExpand_Right"
    if C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(atlas) then
        tex:SetAtlas(atlas, true)
        tex:SetSize(16, 16)
    else
        tex:SetTexture(open and "Interface/Buttons/UI-MinusButton-Up" or "Interface/Buttons/UI-PlusButton-Up")
        tex:SetTexCoord(0, 1, 0, 1)
        tex:SetSize(14, 14)
    end
end

local function ClassColor(class)
    local c = RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]
    return c and c.colorStr and ("|c" .. c.colorStr) or "|cffffd100"
end

local function ClassState(class)
    local on, total = 0, 0
    for _, g in ipairs(ns.GROUPS) do
        if g.class == class then
            local o, t = GroupState(g)
            on, total = on + o, total + t
        end
    end
    return on, total
end

local function BuildRows()
    -- Class headers (one checkbox mutes every pet of that class)
    for _, class in ipairs(ns.CLASS_ORDER) do
        local h = {}
        -- Band like Blizzard's settings rows: click anywhere on it to expand/collapse the class
        h.btn = CreateFrame("Button", nil, content)
        h.btn:SetSize(BAND_W, HEADER_H)
        h.bg = h.btn:CreateTexture(nil, "BACKGROUND")
        h.bg:SetAllPoints()
        h.bg:SetColorTexture(0.35, 0.35, 0.35, 0.35)
        h.btn:SetHighlightTexture("Interface/QuestFrame/UI-QuestTitleHighlight", "ADD")
        h.btn:SetScript("OnClick", function()
            classOpen[class] = not classOpen[class]
            Refresh()
        end)
        h.label = h.btn:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        h.label:SetPoint("LEFT", 40, 0)
        h.label:SetText(ClassColor(class) .. (L["class_" .. class] or class) .. "|r")
        h.count = h.btn:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        h.count:SetPoint("RIGHT", -34, 0)
        h.arrow = h.btn:CreateTexture(nil, "ARTWORK")
        h.arrow:SetPoint("RIGHT", -10, 0)
        -- Checkbox mutes every pet of the class
        h.check = NewCheck(content, "", function(self)
            local on, total = ClassState(class)
            local mute = on < total
            for _, g in ipairs(ns.GROUPS) do
                if g.class == class then SetGroup(g, mute) end
            end
            Refresh()
        end)
        h.check:SetFrameLevel(h.btn:GetFrameLevel() + 3)
        headers[class] = h
    end

    -- Master toggle
    local master = NewCheck(content, "|cffffd100" .. L.MUTE_ALL .. "|r", function(self)
        for _, g in ipairs(ns.GROUPS) do SetGroup(g, self:GetChecked()) end
        Refresh()
    end)
    rows.master = master

    for _, g in ipairs(ns.GROUPS) do
        local r = { g = g, subs = {} }
        r.bg = content:CreateTexture(nil, "BACKGROUND")
        r.bg:SetSize(BAND_W - 16, ROW_H)
        r.bg:SetColorTexture(0.3, 0.3, 0.3, 0.22)
        r.check = NewCheck(content, "", function(self)
            local on, total = GroupState(g)
            SetGroup(g, on == 0)       -- nothing muted -> mute all; otherwise clear
            if on == 0 then expanded[g.key] = nil end
            Refresh()
        end)
        -- Clickable name area: expands the breakdown only while the pet is muted
        r.btn = CreateFrame("Button", nil, content)
        r.btn:SetPoint("LEFT", r.check, "RIGHT", 0, 0)
        r.btn:SetSize(BAND_W - 16 - 30 - 6, ROW_H)
        r.label = r.btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        r.label:SetPoint("LEFT", 4, 0)
        r.arrow = r.btn:CreateTexture(nil, "ARTWORK")
        r.arrow:SetSize(14, 14)
        r.arrow:SetPoint("RIGHT", -10, 0)
        r.btn:SetHighlightTexture("Interface/QuestFrame/UI-QuestTitleHighlight", "ADD")
        r.btn:SetScript("OnClick", function()
            if GroupState(g) > 0 then
                expanded[g.key] = not expanded[g.key]
                Refresh()
            end
        end)
        -- Plate that groups the breakdown checkboxes
        r.plate = CreateFrame("Frame", nil, content, "BackdropTemplate")
        r.plate:SetSize(PLATE_W, 10)
        r.plate:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true, tileSize = 16, edgeSize = 14,
            insets = { left = 3, right = 3, top = 3, bottom = 3 },
        })
        r.plate:SetBackdropColor(0.04, 0.04, 0.07, 0.9)
        r.plate:SetBackdropBorderColor(0.55, 0.45, 0.25, 1)
        r.plate:Hide()
        -- Breakdown checkboxes are only created the first time the plate is opened
        r.buildSubs = function()
            r.subsBuilt = true
            for _, cat in ipairs(ns.CATEGORY_ORDER) do
                if g.cats[cat] then
                    local s = NewCheck(r.plate, L["cat_" .. cat] .. " (" .. #g.cats[cat] .. ")", function(self)
                        db.muted[g.key] = db.muted[g.key] or {}
                        db.muted[g.key][cat] = self:GetChecked() or nil
                        ApplyCategory(g, cat)
                        Refresh()
                    end)
                    s.cat = cat
                    r.subs[#r.subs + 1] = s
                end
            end
        end
        r.subCount = 0
        for _, cat in ipairs(ns.CATEGORY_ORDER) do
            if g.cats[cat] then r.subCount = r.subCount + 1 end
        end
        rows[#rows + 1] = r
    end
end

function Refresh()
    local y = -8
    rows.master:ClearAllPoints()
    rows.master:SetPoint("TOPLEFT", 8, y)
    local allOn = true
    for _, g in ipairs(ns.GROUPS) do
        local on, total = GroupState(g)
        if on < total then allOn = false break end
    end
    rows.master:SetChecked(allOn)
    y = y - ROW_H - 8

    local lastClass, stripe = nil, 0
    for _, r in ipairs(rows) do
        local g = r.g
        if g.class ~= lastClass then
            lastClass = g.class
            stripe = 0
            local h = headers[g.class]
            y = y - 4
            h.btn:ClearAllPoints()
            h.btn:SetPoint("TOPLEFT", 8, y)
            h.check:ClearAllPoints()
            h.check:SetPoint("TOPLEFT", 14, y - 3)
            local con, ctotal = ClassState(g.class)
            h.check:SetChecked(con > 0)
            h.count:SetText((con > 0 and con < ctotal) and ("|cff999999" .. L.PARTIAL .. "|r") or "")
            SetArrow(h.arrow, true, classOpen[g.class])
            y = y - HEADER_H - 2
        end
        local classIsOpen = classOpen[g.class] and true or false
        r.check:SetShown(classIsOpen)
        r.btn:SetShown(classIsOpen)
        r.bg:SetShown(classIsOpen)
        if not classIsOpen then
            r.plate:Hide()
        else
        stripe = stripe + 1
        r.bg:SetAlpha(stripe % 2 == 1 and 1 or 0.4)
        r.bg:ClearAllPoints()
        r.bg:SetPoint("TOPLEFT", 16, y)
        local on, total = GroupState(g)
        r.check:ClearAllPoints()
        r.check:SetPoint("TOPLEFT", 20, y)
        r.check:SetChecked(on > 0)
        local suffix = (on > 0 and on < total) and (" |cff999999(" .. L.PARTIAL .. " " .. on .. "/" .. total .. ")|r") or ""
        r.label:SetText(PetName(g) .. suffix)
        local open = expanded[g.key] and on > 0
        SetArrow(r.arrow, on > 0, open)
        y = y - ROW_H
        local plateH = math.ceil(r.subCount / 2) * SUB_H + 16
        if open then
            if not r.subsBuilt then r.buildSubs() end
            r.plate:ClearAllPoints()
            r.plate:SetPoint("TOPLEFT", 44, y - 2)
            r.plate:SetHeight(plateH)
            r.plate:Show()
            for i, s in ipairs(r.subs) do
                local col, row = (i - 1) % 2, math.floor((i - 1) / 2)
                s:ClearAllPoints()
                s:SetPoint("TOPLEFT", r.plate, "TOPLEFT", 10 + col * COL_W, -8 - row * SUB_H)
                s:SetChecked(IsMuted(g.key, s.cat))
            end
            y = y - plateH - 8
        else
            r.plate:Hide()
        end
        end
    end
    content:SetHeight(-y + 10)
end

local function BuildPanel()
    panel = CreateFrame("Frame")
    panel.name = "MutePets"
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(L.TITLE)
    local sub = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    sub:SetPoint("RIGHT", panel, "RIGHT", -24, 0)
    sub:SetJustifyH("LEFT")
    sub:SetWordWrap(true)
    sub:SetText(L.SUBTITLE)

    -- Language selector: Auto + one button per registered language.
    -- Changing it reloads the UI so every text is rebuilt in the new language.
    local choices = { { code = nil, name = L.LANG_AUTO } }
    for _, c in ipairs(ns.LanguageChoices()) do choices[#choices + 1] = c end
    local current = db.lang and ns.ResolveLocale(db.lang)
    local function IsCurrent(c)
        if c.code == nil then return current == nil end
        return current ~= nil and ns.LOCALES[current] == ns.LOCALES[c.code]
    end
    local function CurrentName()
        for _, c in ipairs(choices) do if IsCurrent(c) then return c.name end end
        return L.LANG_AUTO
    end

    local langLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    langLabel:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -170, -78)
    langLabel:SetText(L.LANGUAGE)

    local dd = CreateFrame("Frame", "MutePetsLangDropdown", panel, "UIDropDownMenuTemplate")
    dd:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -4, -70)
    UIDropDownMenu_SetWidth(dd, 120)
    UIDropDownMenu_SetText(dd, CurrentName())
    -- Switch language live (no ReloadUI): retranslate the texts and rebuild the rows
    local function ApplyLanguage(code)
        db.lang = code
        current = code and ns.ResolveLocale(code) or nil
        ns.SetLocale(current or GetLocale())
        title:SetText(L.TITLE)
        sub:SetText(L.SUBTITLE)
        langLabel:SetText(L.LANGUAGE)
        choices[1].name = L.LANG_AUTO
        UIDropDownMenu_SetText(dd, CurrentName())
        if rows.master then
            local scroll = content:GetParent()
            content:Hide()
            wipe(rows)
            wipe(headers)
            content = CreateFrame("Frame", nil, scroll)
            content:SetSize(560, 600)
            scroll:SetScrollChild(content)
            BuildRows()
            Refresh()
        end
    end
    UIDropDownMenu_Initialize(dd, function()
        for _, c in ipairs(choices) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = c.name
            info.checked = IsCurrent(c)
            info.minWidth = 120 -- same width as the select button
            info.func = function()
                CloseDropDownMenus()
                if not IsCurrent(c) then ApplyLanguage(c.code) end
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    local scroll = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 16, -104)
    scroll:SetPoint("BOTTOMRIGHT", -36, 16)
    content = CreateFrame("Frame", nil, scroll)
    content:SetSize(560, 600)
    scroll:SetScrollChild(content)
    -- Scrollbar only when there is something to scroll
    local bar = scroll.ScrollBar or _G[scroll:GetName() and (scroll:GetName() .. "ScrollBar") or ""]
    local function UpdateBar()
        if not bar then return end
        bar:SetShown((scroll:GetVerticalScrollRange() or 0) > 0.5)
    end
    scroll:HookScript("OnScrollRangeChanged", UpdateBar)
    scroll:HookScript("OnShow", UpdateBar)
    scroll.UpdateBar = UpdateBar

    -- The UI is built lazily the first time the panel is shown: no frames at login
    panel:SetScript("OnShow", function()
        if not rows.master then BuildRows() end
        Refresh()
    end)

    local category = Settings.RegisterCanvasLayoutCategory(panel, "MutePets")
    Settings.RegisterAddOnCategory(category)
    categoryID = category:GetID()
end

---------------------------------------------------------------- init
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    MutePetsDB = MutePetsDB or {}
    MutePetsDB.muted = MutePetsDB.muted or {}
    db = MutePetsDB
    -- Language: the one saved with /mp lang, otherwise the game client language
    ns.SetLocale(ns.ResolveLocale(db.lang) or GetLocale())
    ApplyAll()
    BuildPanel()
end)

SLASH_MUTEPETS1 = "/mp"
SLASH_MUTEPETS2 = "/mutepets"
SlashCmdList.MUTEPETS = function(msg)
    msg = (msg or ""):lower():match("^%s*(.-)%s*$")
    local lang = msg:match("^lang%s*(%a*)$")
    if lang then
        if lang == "auto" then
            db.lang = nil
        else
            local code = ns.ResolveLocale(lang)
            if not code then
                print("|cff33ff99MutePets|r: /mp lang auto | " .. table.concat(ns.LocaleList(), " | "))
                return
            end
            db.lang = code
        end
        print("|cff33ff99MutePets|r: reloading UI...")
        ReloadUI()
    elseif msg == "on" or msg == "off" then
        for _, g in ipairs(ns.GROUPS) do SetGroup(g, msg == "on") end
        if rows.master and panel:IsVisible() then Refresh() end
        print("|cff33ff99MutePets|r:", msg == "on" and L.ALL_MUTED or L.ALL_UNMUTED)
    else
        if categoryID then Settings.OpenToCategory(categoryID) end
    end
end
