# MutePets

![WoW Forever](https://img.shields.io/badge/WoW-Forever-c79c6e)
![Interface](https://img.shields.io/badge/interface-16001-blue)
![Version](https://img.shields.io/badge/version-0.2.0-brightgreen)

MutePets mutes pet sounds in WoW Forever (warlock and hunter): all of them at once, only the pets you pick, or even just certain sound types (attacks, wounds, voices...). Made for anyone who doesn't want to hear the Imp, Voidwalker or Felguard for hours.

## Why this addon exists
MutePets started with a single goal: removing the sound of the Succubus, the warlock summon. That idea grew into this project, and now you can also mute the pets of the hunter, besides the warlock ones. There are no mage pets in WoW Forever, so the mage is not part of the list.

## Language version
- [English](README.md)
- [Español](README_ES.md)

The addon picks its language automatically from your WoW client language: Spanish clients (esES, esMX) get Spanish, every other client gets English.

## Download
Get the [latest release](../../releases/latest) (`MutePets-x.y.z.zip`) and follow the installation guide below.

## Install
**Requirements:** WoW Forever (Interface 16001). Not compatible with Classic Era or other clients.

1. Unzip the file.
2. Copy the `MutePets` folder to:

```
World of Warcraft/_forever_/Interface/AddOns/MutePets/
```

3. The folder must be named exactly `MutePets`, the same as the `.toc` file.
4. Log in, or type `/reload` if the game is already running.

## Features
- Mute **all** pets with a single checkbox, or all the pets of one class with its header checkbox.
- Pets are grouped by class, collapsed by default:
  - **Warlock:** Imp, Voidwalker, Felhunter, Succubus, Incubus, Felguard, Wrathguard, Shivarra, Observer, Voidlord, Infernal and Doomguard.
  - **Hunter:** Wolf, Bear, Boar, Cat, Crab, Gorilla, Raptor, Hyena, Owl, Eagle, Carrion Bird, Ravager, Sporebat, Warp Stalker, Tallstrider, Chimaera, Wyvern, Quilen, Fox, Basilisk, Hydra and Porcupine.
- With a pet muted, click its name to open the **breakdown** and choose which sounds to silence:
  - Aggro / battle cry
  - Attacks
  - Wounds
  - Death
  - Voices
  - Other
- Shows each pet's state: `(muted)` or `(partial 3/5)`.
- Saves your settings between sessions.
- English and Spanish, chosen automatically from the client language.

## Slash Commands

| Command              | Description                  |
|----------------------|------------------------------|
| `/mp` or `/mutepets` | Open the options panel       |
| `/mp on`             | Mute all pets                |
| `/mp off`            | Unmute all pets              |
| `/mp lang <code>`   | Force a language, for example `/mp lang en` or `/mp lang es` (reloads the UI) |
| `/mp lang auto`    | Follow the game language again (reloads the UI) |

The panel is also available under Options > AddOns > MutePets.

## Information
- It uses `MuteSoundFile`, so the sound is muted across the whole game. Enemies that share the same sound file (for example a hostile Imp) will also go quiet.
- It is not possible to mute only your own pet, nor other players' pets.
- If a pet is still making noise or a sound is missing, open an [issue](../../issues) with the pet and, if you can, which sound it is.
- Hunter pets use the same sound files as wild animals: muting "Wolf" silences every wolf in the world, not only your pet. Other players' pets cannot be muted separately either.

## Contribution
Contributions are welcome: open a Pull Request on GitHub.

**Want to add your language?** It only takes a small text file and no programming. See [CONTRIBUTING.md](CONTRIBUTING.md) for the step-by-step guide.

- `Data.lua` holds the FileDataIDs grouped by pet and by sound type. It was generated from the [WoW community listfile](https://github.com/wowdev/wow-listfile).
- To add a new group, add an entry to `ns.GROUPS` with its `cats` (`aggro`, `attack`, `wound`, `death`, `voice`, `other`).
