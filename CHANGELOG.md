# Changelog

All notable changes to this project are documented in this file.
The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.2.0] - 2026-11-09
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

## [0.1.0] - 2026-11-08
### Added
- First release: mute warlock and hunter pet sounds, all at once, by pet or by sound type.
- English and Spanish interface, chosen from the game client language.
