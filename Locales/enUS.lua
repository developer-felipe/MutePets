local _, ns = ...

-- English: the reference language. Every key must exist here.
ns.RegisterLocale("enUS", {
    LANG_NAME = "English",
    LANGUAGE = "Language:",
    LANG_AUTO = "Auto",
    TITLE = "MutePets",
    SUBTITLE = "Check a pet to mute it. Once a pet is muted, click its name to see the breakdown by sound type.",
    MUTE_ALL = "Mute ALL pets",
    MUTED = "muted",
    PARTIAL = "partial",
    ALL_MUTED = "all pets muted",
    ALL_UNMUTED = "all pets unmuted",

    -- Sound types shown in the breakdown
    cat_aggro = "Aggro / battle cry",
    cat_attack = "Attacks",
    cat_wound = "Wounds",
    cat_death = "Death",
    cat_voice = "Voices",
    cat_other = "Other",

    -- Class headers
    class_WARLOCK = "Warlock",
    class_HUNTER = "Hunter",
})
