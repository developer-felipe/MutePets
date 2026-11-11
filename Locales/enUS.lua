local _, ns = ...

-- English: the reference language. Every key must exist here.
ns.RegisterLocale("enUS", {
    LANG_NAME = "English",
    LANGUAGE = "Language:",
    LANG_AUTO = "Auto",
    DEV_TIP_PLAY = "Play the next sound (its fileID is logged in the chat)",
    DEV_TIP_RESET = "Right-click: start over",
    DEV_RESET = "sound list restarted",
    DEV_WRAPPED = "every sound of this category has been played, starting over",
    TITLE = "MutePets",
    SUBTITLE = "Check a pet to mute it. Click its name to see the breakdown by sound type and listen to each sound with the play button.",
    MUTE_ALL = "Mute ALL pets",
    MUTED = "muted",
    PARTIAL = "partial",
    ALL_MUTED = "all pets muted",
    ALL_UNMUTED = "all pets unmuted",

    -- Sound types shown in the breakdown
    cat_aggro = "Battle cry",
    cat_attack = "Attacks",
    cat_wound = "Wounds",
    cat_death = "Death",
    cat_voice = "Voices",
    cat_movement = "Movement",
    cat_other = "Other",

    -- Class headers
    class_WARLOCK = "Warlock",
    class_HUNTER = "Hunter",
})
