# Localization

## Table of Contents

1. [Localization Process](#localization-process)
    1. [Adding, Updating, or Removing Keys](#adding-updating-or-removing-keys)
    2. [Refinement](#refinement)
    3. [Adding a New Locale](#adding-a-new-locale)

### Preparation

Before starting, install the [Localizely CLI](https://github.com/localizely/localizely-cli#install).

### Workflow

Follow these structured steps to manage the localization of your application efficiently.

## Localization Process

### Adding, Updating, or Removing Keys

1. Add, update, or remove the necessary key(s) in `lib/l10n/arb/app_en.arb`.
2. Push the key(s) to [Localizely](https://localizely.com) using the command: `localizely-cli push`.
3. If necessary, translate the key(s) on the [Localizely](https://localizely.com) platform, ensuring to remove helper
   tags from the key(s).
4. Pull the key(s) from [Localizely](https://localizely.com) using the command: `localizely-cli pull`.
5. Generate the localizations with the command: `flutter gen-l10n`.
6. Commit the changes.

### Refinement

1. Pull the key(s) from [Localizely](https://localizely.com) using the command: `localizely-cli pull`.
2. Generate the localizations with the command: `flutter gen-l10n`.
3. Commit the changes.

### Adding a New Locale

1. Add the new locale to the `download files` list in `localizely.yml`.
2. Insert `locale_<locale code>` in `lib/l10n/arb/app_en.arb`.
3. Push the newly added key with the ‘unreviewed’ flag to [Localizely](https://localizely.com) using the command:
   ```sh
   localizely-cli --reviewed=false push --api-token=token
   ```
4. Translate the added key on the [Localizely](https://localizely.com) platform, remembering to remove helper tags from
   the key(s).
5. Pull the newly added key from [Localizely](https://localizely.com) using the command:
   ```sh
   localizely-cli pull --api-token=token
   ```
6. Generate the localizations with the command: `flutter gen-l10n`.
7. Commit the changes.
