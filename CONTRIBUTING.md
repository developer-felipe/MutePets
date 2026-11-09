# Contributing to MutePets

Thanks for helping! The easiest way to contribute is **adding a translation**. You do not need to know how to program, only how to edit a text file.

## Add a new language

Every language lives in its own small file in the [`Locales/`](Locales) folder. English ([`enUS.lua`](Locales/enUS.lua)) is the reference, and anything you do not translate falls back to English, so a partial translation is fine.

### 1. Find your locale code

Use the code of the WoW client language you want to translate:

| Code | Language | Code | Language |
|------|----------|------|----------|
| `deDE` | German | `ptBR` | Portuguese (Brazil) |
| `frFR` | French | `ruRU` | Russian |
| `itIT` | Italian | `koKR` | Korean |
| `esES` / `esMX` | Spanish (already done) | `zhCN` / `zhTW` | Chinese |

You can check your own client's code in game with `/dump GetLocale()`.

### 2. Create the file

1. Copy [`Locales/_template.lua`](Locales/_template.lua) to `Locales/<code>.lua`, for example `Locales/ptBR.lua`.
2. In the new file, replace `"xxXX"` with your code. If one translation serves two codes, use a list: `{ "ptBR", "ptPT" }`.
3. Translate the text between the quotes. Do not change the names on the left of the `=` sign.
4. Delete any line you do not want to translate.

### 3. Register the file

Open [`MutePets.toc`](MutePets.toc) and add your file right after the Spanish one:

```
Locales/enUS.lua
Locales/esES.lua
Locales/ptBR.lua
```

Optionally add a translated description line, for example `## Notes-ptBR: ...`, next to the other `Notes-` lines.

### 4. Test it in game

1. Copy the `MutePets` folder to `World of Warcraft/_forever_/Interface/AddOns/`.
2. In game, type `/mp lang ptBR` (use your code). The UI reloads and MutePets appears in that language.
3. Open Options > AddOns > MutePets and check that the texts fit and nothing is cut off. Long pet names are the usual problem.
4. Type `/mp lang auto` to go back to the game language.

Typing `/mp lang` with no code lists every language the addon knows.

### 5. Send it

- **With GitHub:** fork the repo, add your file, and open a Pull Request.
- **Without GitHub knowledge:** open a [translation issue](../../issues/new?template=translation.md) and paste your file. We will add it for you.

## Pet names

Pet names such as "Imp" or "Wolf" are translated with `pet_<key>` lines (for example `pet_wolf = "Lobo"`). These are optional: without one, the English name from `Data.lua` is shown. The template lists every pet key.

## Other contributions

- **A pet is still making noise, or a sound is missing:** open an [issue](../../issues) with the pet and, if you can, which sound it is.
- **Sound data:** `Data.lua` holds the sound file IDs grouped by pet and sound type. It was generated from the [WoW community listfile](https://github.com/wowdev/wow-listfile). To add a group, add an entry to `ns.GROUPS` with its `cats` (`aggro`, `attack`, `wound`, `death`, `voice`, `other`) and add the class to `ns.CLASS_ORDER` if it is new.
