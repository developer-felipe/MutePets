local _, ns = ...

-- TEMPLATE for a new language. Steps are in CONTRIBUTING.md.
-- 1. Copy this file to Locales/<code>.lua (for example Locales/ptBR.lua).
-- 2. Replace "xxXX" below with your client locale code (see the list in CONTRIBUTING.md).
-- 3. Translate the texts between quotes. Delete any line you do not want to translate:
--    missing lines fall back to English.
-- 4. Add the file to MutePets.toc, right after the line Locales/esES.lua.
ns.RegisterLocale("xxXX", {
    LANG_NAME = "English", -- your language's own name, shown on the language button
    LANGUAGE = "Language:",
    LANG_AUTO = "Auto",
    DEV_TIP_PLAY = "Play the next sound (its fileID is logged in the chat)",
    DEV_TIP_RESET = "Right-click: start over",
    DEV_RESET = "sound list restarted",
    DEV_WRAPPED = "every sound of this category has been played, starting over",
    SUBTITLE = "Check a pet to mute it. Click its name to see the breakdown by sound type and listen to each sound with the play button.",
    MUTE_ALL = "Mute ALL pets",
    MUTED = "muted",
    PARTIAL = "partial",
    ALL_MUTED = "all pets muted",
    ALL_UNMUTED = "all pets unmuted",

    cat_aggro = "Battle cry",
    cat_attack = "Attacks",
    cat_wound = "Wounds",
    cat_death = "Death",
    cat_voice = "Voices",
    cat_movement = "Movement",
    cat_other = "Other",

    class_WARLOCK = "Warlock",
    class_HUNTER = "Hunter",

    -- Pet names. Optional: delete a line to keep the English name.
    pet_imp = "Imp",
    pet_voidwalker = "Voidwalker",
    pet_felhunter = "Felhunter",
    pet_succubus = "Succubus",
    pet_incubus = "Incubus",
    pet_felguard = "Felguard",
    pet_wrathguard = "Wrathguard",
    pet_shivarra = "Shivarra",
    pet_observer = "Observer",
    pet_voidlord = "Voidlord",
    pet_infernal = "Infernal",
    pet_doomguard = "Doomguard",
    pet_wolf = "Wolf",
    pet_bear = "Bear",
    pet_boar = "Boar",
    pet_cat = "Cat",
    pet_crab = "Crab",
    pet_gorilla = "Gorilla",
    pet_raptor = "Raptor",
    pet_hyena = "Hyena",
    pet_owl = "Owl",
    pet_eagle = "Eagle",
    pet_carrion = "Carrion Bird",
    pet_ravager = "Ravager",
    pet_sporebat = "Sporebat",
    pet_warpstalker = "Warp Stalker",
    pet_tallstrider = "Tallstrider",
    pet_chimaera = "Chimaera",
    pet_wyvern = "Wyvern",
    pet_quilen = "Quilen",
    pet_fox = "Fox",
    pet_basilisk = "Basilisk",
    pet_hydra = "Hydra",
    pet_porcupine = "Porcupine",
    pet_spider = "Spider",
})
