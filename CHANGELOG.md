# Changelog

All notable changes to this project are documented in this file.

## [0.3.0] - 11-11-2026
### Added
- Spider hunter pet.
- "Movement" sound type, shown for the pets whose footsteps are separate sound files (Spider and Crab).
- Play button next to every sound type: each click plays the next sound of that type and never repeats one until all of them were heard. Right-click starts over. Muted sounds are unmuted just long enough to be heard.
- Chat log of the sounds being played, with the pet, the sound type, the position in the list and the fileID.

### Changed
- The breakdown by sound type can be opened for any pet, muted or not, so its sounds can be listened to before muting.
- Pets, sound types and classes are listed alphabetically in the current language, with "Other" always last.
- Spanish: "Grito de combate" and "Movimiento" use a single name, and every pet has its Spanish name.
- Removed metadata entries (`.meta`) from the sound lists. They are not playable sounds, so muting works the same, but the counts shown are lower.
- The Crab footsteps moved from "Other" to "Movement".

## [0.2.0] - 11-09-2026
### Added
- Language selector in the options panel (Auto / English / Español). Changing it updates the panel without reloading the UI.
- `/mp lang <code>` and `/mp lang auto` commands.
- Translation system in `Locales/`, with a template and a step-by-step guide in `CONTRIBUTING.md`.
- Translation issue template for contributors who do not use Pull Requests.

### Changed
- Pet names now show in a single language instead of "English / Spanish".
- Spanish names added for every pet.
- Translations moved from `Locales.lua` to one file per language inside `Locales/`.

### Removed
- CurseForge-only assets (logo and page descriptions) are no longer part of the repository.

## [0.1.0] - 11-08-2026
### Added
- First release: mute warlock and hunter pet sounds, all at once, by pet or by sound type.
- English and Spanish interface, chosen from the game client language.
