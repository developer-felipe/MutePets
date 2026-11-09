local _, ns = ...

-- Localization core. Each file in this folder registers one language with
-- ns.RegisterLocale(); to add a language see CONTRIBUTING.md.
--
-- ns.L is a single shared table that is rewritten in place, so every file that
-- keeps a reference to it sees the language change.
local L = {}
ns.L = L

local registry = {}      -- ["esES"] = { KEY = "text", ... }
ns.LOCALES = registry

-- codes: one client locale ("deDE") or a list ({"esES", "esMX"}).
function ns.RegisterLocale(codes, strings)
    if type(codes) == "string" then codes = { codes } end
    for _, code in ipairs(codes) do registry[code] = strings end
end

-- English is always loaded first, so anything a language does not translate
-- falls back to English.
function ns.SetLocale(code)
    for k in pairs(L) do L[k] = nil end
    for k, v in pairs(registry.enUS or {}) do L[k] = v end
    for k, v in pairs(registry[code] or {}) do L[k] = v end
end

-- Turns what the player typed ("en", "es", "pt", "ptBR") into a registered
-- code. Exact match first, then the first code starting with the input.
function ns.ResolveLocale(input)
    input = (input or ""):lower()
    if input == "" then return nil end
    local prefixMatch
    for code in pairs(registry) do
        local lc = code:lower()
        if lc == input then return code end
        if lc:sub(1, #input) == input and (not prefixMatch or code < prefixMatch) then prefixMatch = code end
    end
    return prefixMatch
end

-- Languages for the panel buttons: one entry per language (esES and esMX share
-- a table, so they show up once). Name comes from the LANG_NAME key.
function ns.LanguageChoices()
    local seen, list = {}, {}
    for _, code in ipairs(ns.LocaleList()) do
        local strings = registry[code]
        if not seen[strings] then
            seen[strings] = true
            list[#list + 1] = { code = code, name = strings.LANG_NAME or code }
        end
    end
    return list
end

function ns.LocaleList()
    local list = {}
    for code in pairs(registry) do list[#list + 1] = code end
    table.sort(list)
    return list
end
