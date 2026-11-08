local _, ns = ...

-- English is the default. Other locales override only what they translate.
local L = {
    TITLE = "MutePets",
    SUBTITLE = "Check a pet to mute it. Once a pet is muted, click its name to see the breakdown by sound type.",
    MUTE_ALL = "Mute ALL pets",
    MUTED = "muted",
    PARTIAL = "partial",
    ALL_MUTED = "all pets muted",
    ALL_UNMUTED = "all pets unmuted",
    cat_aggro = "Aggro / battle cry",
    cat_attack = "Attacks",
    cat_wound = "Wounds",
    cat_death = "Death",
    cat_voice = "Voices",
    cat_other = "Other",
    class_WARLOCK = "Warlock",
    class_HUNTER = "Hunter",
}

local overrides = {
    esES = {
        SUBTITLE = "Marca un pet para silenciarlo. Con el pet silenciado, haz clic en su nombre para ver el desglose por tipo de sonido.",
        MUTE_ALL = "Silenciar TODOS los pets",
        MUTED = "silenciado",
        PARTIAL = "parcial",
        ALL_MUTED = "todos los pets silenciados",
        ALL_UNMUTED = "todos los pets activados",
        cat_aggro = "Aggro / grito de combate",
        cat_attack = "Ataques",
        cat_wound = "Heridas",
        cat_death = "Muerte",
        cat_voice = "Voces",
        cat_other = "Otros",
        class_WARLOCK = "Brujo",
        class_HUNTER = "Cazador",
        pet_wolf = "Lobo", pet_bear = "Oso", pet_boar = "Jabalí", pet_cat = "Felino",
        pet_crab = "Cangrejo", pet_gorilla = "Gorila", pet_hyena = "Hiena", pet_owl = "Búho",
        pet_eagle = "Águila", pet_carrion = "Carroñero", pet_ravager = "Devastador",
        pet_sporebat = "Murciélago de esporas", pet_warpstalker = "Acechador deformador",
        pet_tallstrider = "Zancaalta", pet_chimaera = "Quimera", pet_fox = "Zorro",
        pet_basilisk = "Basilisco", pet_hydra = "Hidra", pet_porcupine = "Puercoespín",
        pet_imp = "Imp / Diablillo",
        pet_voidwalker = "Voidwalker / Abisario",
        pet_felhunter = "Felhunter / Manáfago",
        pet_succubus = "Succubus / Súcubo",
        pet_incubus = "Incubus / Íncubo",
        pet_felguard = "Felguard / Guardia vil",
    },
}
overrides.esMX = overrides.esES

-- The client locale follows the game language setting automatically.
local o = overrides[GetLocale()]
if o then for k, v in pairs(o) do L[k] = v end end

ns.L = L
