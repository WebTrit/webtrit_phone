# Localization

Git is the source of truth for the keys the app can show; the configurator's translation catalog
owns the text those keys resolve to for customers. Last reviewed: 2026-08-25.

The ARB files in `lib/l10n/arb/` (`app_en.arb` is the template; `app_uk.arb`, `app_it.arb`,
`app_th.arb` are the locales) are edited directly in this repository and reviewed as normal code.
No third-party translation service is involved: new keys are translated in the same PR that
introduces them (AI-assisted, see the prompt below) and reviewed by a native speaker where
available.

What the app itself renders always comes from these files, compiled in. What a white-label
customer receives is composed by the configurator from its catalog - see
[How these files reach a customer](#how-these-files-reach-a-customer), because the two diverge
in ways that surprise people.

Two consumers read these files:

- `flutter gen-l10n` + the `l10n_mapper_generator` build step produce the Dart localization
  classes used by the app;
- the configurator backend imports them into its global translation catalog, which is what
  customer bundles are composed from.

### How these files reach a customer

Since the global translation catalog landed in the configurator backend, this repository is no
longer read when a bundle is composed. `composeArb` builds each bundle from the catalog plus the
application's own overrides; the `ref` parameter it still accepts is deliberately ignored and
logs a warning. The ARB files reach the catalog through one command, run by hand in the backend
repository:

```sh
npm run translations:sync                 # plan and apply
npm run translations:sync -- --dry-run    # plan only, write nothing
npm run translations:sync -- --verify     # apply, then prove the round trip
```

It reads `TRANSLATIONS_REPO` (default `WebTrit/webtrit_phone`) and `TRANSLATIONS_REF` (default
`main`); `TRANSLATIONS_LOCALES` (default `en,uk,it,th`) picks the locales. All three are code
defaults in the backend's `src/config/environment.ts`, no deployment overrides them, and nothing
runs the sync on a schedule or from CI.

Who owns what:

| | Source of truth |
|---|---|
| Keys and their gen-l10n metadata | the ARB files here |
| Values, i.e. the translated text | the catalog |
| Per-application wording | configurator overrides |

Two consequences are worth knowing before editing an ARB file:

- **Changing an existing translation here does not change what customers receive.** Sync only
  inserts values the catalog has never seen - it never updates or deletes one, so text reviewed
  in the catalog survives any number of runs. Fix an existing string in the catalog. Fixing it
  here as well keeps the two in step for the next fresh import, but only the catalog copy ships.
- **New keys do flow through**, on the next sync run against a ref that carries them. On the
  very first run into an empty catalog every value arrives `approved`, because those strings had
  already shipped; after that a value coming from code is `approved` only for `en`, which a
  developer wrote deliberately, and arrives `needs_review` in every other locale. A locale whose
  ARB file lacks the key contributes no row at all - an untranslated value is an absent row, not
  an empty one.

Keys follow the code: a key the ARB files carry is `active`, one they stop carrying is `retired`,
one created in the catalog before the code knows it is `pending`. Nothing is deleted.

One timing trap: `TRANSLATIONS_REF` defaults to `main`, while work here lands on `develop`. A
sync run today therefore imports the released set rather than what `develop` carries - at the
time of writing `main` is at release 1.16.3 and its ARB files are about two thousand lines behind
`develop`. Merging a translation here does not put it in front of anyone until both a release
moves it to `main` and somebody runs the sync.

## Table of Contents

1. [Adding or Changing a Key](#adding-or-changing-a-key)
2. [Validation](#validation)
3. [Pulling the Catalog Back](#pulling-the-catalog-back)
4. [AI Translation Prompt](#ai-translation-prompt)
5. [Adding a New Locale](#adding-a-new-locale)
6. [Intentionally Empty Keys](#intentionally-empty-keys)

## Adding or Changing a Key

1. Add or edit the key in `lib/l10n/arb/app_en.arb`, including its `@key` metadata
   (description and `placeholders` where the value has arguments).
2. Add the translations to `app_uk.arb`, `app_it.arb`, and `app_th.arb` **in the same PR**
   (AI-assisted; see the prompt below). Keep the key in the same relative position as in
   `app_en.arb`.
3. Regenerate — **both steps are required**:

   ```sh
   melos run l10n:generate                                  # flutter gen-l10n + dart format
   dart run build_runner build --delete-conflicting-outputs # l10n mapper (lookupKey switch)
   ```

   Use `melos run l10n:generate` rather than bare `flutter gen-l10n`: the generator
   formats its output at the Dart default of 80 columns and does not read
   `formatter.page_width` from `analysis_options.yaml`, so calling it directly rewraps
   every generated file and buries the real change under thousands of lines. The melos
   script reformats at 120 afterwards; `l10n:check` fails if that step was skipped.

   `flutter gen-l10n` alone is NOT enough: the git-tracked
   `lib/l10n/app_localizations.g.mapper.dart` powers configurator-driven dynamic strings
   (`context.parseL10n` / `AppLocalizations.lookupKey`), and a key missing from it fails
   silently at runtime.

4. Validate: `melos run l10n:check`.
5. Commit everything together: the four ARB files and the regenerated
   `lib/l10n/app_localizations*` files.

**Changing the wording of a key that already exists** is the case to be careful with. The steps
above are right for the app itself, which compiles these files in. They do not reach white-label
customers: the catalog already holds a value for that key and the sync will not overwrite it, so
the old wording keeps shipping until it is changed in the catalog too. Reword it there, then
bring it back with `melos run l10n:fetch` - see [Pulling the Catalog Back](#pulling-the-catalog-back).

Review expectations: Ukrainian is reviewed by the team; Italian and Thai are AI-translated and
spot-checked. Per-customer wording changes do not belong here — they are configurator overrides.

## Validation

`melos run l10n:check` (also part of `melos run check`, `melos run ci`, the lefthook `pre-push`
hook, and the `l10n-check` GitHub workflow) runs `tool/check_l10n.dart`, which fails when:

- a locale file is missing a key (or its `@` metadata) present in `app_en.arb`, or carries an
  extra one;
- the ICU placeholder arguments of a translated value differ from the template value
  (plural/select branch sets may differ — uk legitimately uses `few`/`many`);
- a value is empty and not in the intentionally-empty allow-list;
- a file is not valid JSON;
- a template key is missing from the generated l10n mapper (forgotten `build_runner` run);
- a generated `lib/l10n/*.g.dart` file is not formatted at the project page width
  (bare `flutter gen-l10n` or `build_runner` without the follow-up `dart format`).

Because `dart format` output differs between SDK versions, the last check is only
meaningful on the SDK the project pins: the `l10n-check` workflow installs the Dart that
ships with the Flutter version in `.fvmrc` (Flutter 3.47.1 -> Dart 3.13.1) rather than
`stable`, and both must be bumped together. The failure message names the Dart version it
ran with, so a mismatch is recognisable as one.

## Pulling the Catalog Back

The catalog owns the values, so a wording change made there - by a reviewer in the
configurator, or in bulk - has to come back here or the two drift apart. Nothing in this
repository talks to the configurator directly; it goes through `webtrit_phone_tools`:

```sh
melos run l10n:fetch    # pull the catalog, then regenerate the localization classes
melos run l10n:pull     # pull only
```

Both read `CONFIGURATOR_TOKEN` from `.env`. An administrator-minted key of scope
`translations` works as well as a signed-in bearer token.

### Why a pull can refuse

`configurator-translations-fetch` **overwrites** each `app_<locale>.arb` with what the catalog
holds. It does not merge, and that is correct - the catalog is the source of truth for values.
But it makes the command destructive whenever the catalog has not been synced since the last
keys were added here: it would not carry them, and overwriting would delete them from every
locale at once. The app calls those keys, so the damage would surface as `undefined_getter`
from `flutter analyze` on generated code, a long way from the command that caused it.

The CLI checks for that before writing anything, and refuses:

```
The catalog export is behind this checkout: for en it carries 965 keys where app_en.arb
has 1097, so adopting it would delete 135 of them.
```

The fix is to run `npm run translations:sync` in the configurator backend against a ref that
carries these keys - not to force the files across. It refuses an export missing a locale this
checkout has, for the same reason.

A file whose content matches the catalog is left byte-for-byte alone, so a pull that changes
nothing leaves the working tree clean. The ARB files here are not shaped the way the export
renders them and the export orders keys differently, so a byte comparison would call every
file changed on every pull.

## AI Translation Prompt

When translating with an AI assistant (Claude, Copilot, etc.), use:

> Translate the following ARB entries from English into Ukrainian, Italian, and Thai for a
> business VoIP application (WebTrit Phone). Keep every ICU placeholder (`{name}`) and
> plural/select structure intact; use the locale's own CLDR plural categories (uk needs
> `few`/`many`). Do not translate technical terms (WiFi, VPN, SIP, Bluetooth, codec names,
> units). Match the tone of the existing translations in lib/l10n/arb/. Return one JSON
> fragment per locale, keys in the same order as the input.

Always run `melos run l10n:check` afterwards.

## Adding a New Locale

1. Create `lib/l10n/arb/app_<locale>.arb` (ARB filename spelling: underscore for region
   subtags, e.g. `app_pt_BR.arb`) and translate all keys from `app_en.arb`.
2. Add the locale to `TRANSLATIONS_LOCALES` in the configurator backend
   (`src/config/environment.ts`) so the sync imports it and bundles include it. That is a code
   change in that repository, not a deployment setting. The sync's fetch is all-or-nothing
   (`Promise.all` over every configured locale), so a locale listed there whose ARB file is not
   yet on the configured ref breaks the fetch for every locale - land the file first, then add
   the locale, then sync.
3. Regenerate (`melos run l10n:generate` + `dart run build_runner build`) and run
   `melos run l10n:check`.

## Intentionally Empty Keys

Seven `login_Text_*` keys (`otpSigninRequest`/`passwordSignin`/`signupRequest`
pre/post-description variants) are empty in **all** locales, including English: they are
white-label placeholders filled per application through configurator overrides. They are
allow-listed in `tool/check_l10n.dart` (`intentionallyEmptyKeys`); update that list only when a
key is deliberately designed to work this way.
