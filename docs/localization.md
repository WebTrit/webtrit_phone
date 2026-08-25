# Localization

Git is the single source of truth for translations. Last reviewed: 2026-08-20.

The ARB files in `lib/l10n/arb/` (`app_en.arb` is the template; `app_uk.arb`, `app_it.arb`,
`app_th.arb` are the locales) are edited directly in this repository and reviewed as normal code.
There is no external translation management system: new keys are translated in the same PR that
introduces them (AI-assisted, see the prompt below) and reviewed by a native speaker where
available.

Two consumers read these files:

- `flutter gen-l10n` + the `l10n_mapper_generator` build step produce the Dart localization
  classes used by the app;
- the configurator backend fetches the raw ARB files from this repository (branch `main` by
  default) to compose per-customer translation bundles with overrides applied.

## Table of Contents

1. [Adding or Changing a Key](#adding-or-changing-a-key)
2. [Validation](#validation)
3. [AI Translation Prompt](#ai-translation-prompt)
4. [Adding a New Locale](#adding-a-new-locale)
5. [Intentionally Empty Keys](#intentionally-empty-keys)

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
ships with the Flutter version in `.fvmrc` (Flutter 3.44.0 -> Dart 3.12.0) rather than
`stable`, and both must be bumped together. The failure message names the Dart version it
ran with, so a mismatch is recognisable as one.

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
2. Add the locale to the configurator backend's `TRANSLATIONS_LOCALES` parameter so
   white-label bundles include it.
3. Regenerate (`melos run l10n:generate` + `dart run build_runner build`) and run
   `melos run l10n:check`.

## Intentionally Empty Keys

Seven `login_Text_*` keys (`otpSigninRequest`/`passwordSignin`/`signupRequest`
pre/post-description variants) are empty in **all** locales, including English: they are
white-label placeholders filled per application through configurator overrides. They are
allow-listed in `tool/check_l10n.dart` (`intentionallyEmptyKeys`); update that list only when a
key is deliberately designed to work this way.
