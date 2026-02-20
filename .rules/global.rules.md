# GLOBAL FLUTTER & DART CODING STANDARDS

**[CRITICAL]** These rules apply to ALL files and ALL requests. You must strictly follow them before
writing any code.

## 1. CRITICAL: CLEAN CODE

* **No Cyrillic:** Strictly prohibited anywhere in the codebase. This includes source files,
  comments, strings, logs, identifiers, and JSON/YAML keys.
* **Self-Documenting Code:** Code must be clean and self-explanatory. Do not write comments to
  describe logic, UI structure, or use them as visual separators. Use DartDoc strictly for public
  APIs.
* **No Conversational Filler:** AI tools or generators must output pure, commit-ready code without
  unnecessary explanations.

## 2. FLUTTER ARCHITECTURE & LIFECYCLE

* **Widgets as Classes:** Always use a `StatelessWidget` class instead of a method returning a
  widget. The only exception is returning a simple list of widgets.
* **Dumb UI Widgets:** Widgets located in `features/<feature_name>/view/widgets` must not use
  Flutter Bloc (e.g., `BlocBuilder` or `context.read`) to fetch state directly. All required data
  and callbacks must be passed down via the constructor.
* **Lifecycle Order:**
    * **Init:** Always call `super.initState()` **first** in the `initState` method.
    * **Dispose:** Always call `super.dispose()` **last** in the `dispose` method. Controllers and
      resources should be disposed of in the reverse order of their creation.

## 3. UI & STYLING

* **Material Theme:** Always rely on `Theme.of(context)`. Do not hardcode colors or locally override
  Material properties.
* **Opacity:** Use `withValues(alpha: 0.x)` instead of the deprecated `withOpacity()` to prevent
  precision loss.
* **Surfaces & Elevation:** Use `Card` for surfaces requiring elevation, shadows, and material
  styling. Never use `Container` with `BoxShadow` unless a `Card` is fundamentally incompatible with
  the UI requirement.

## 4. DART STANDARDS & FORMATTING

* **Formatter & Linter:** Page width is strictly `120` characters. Prefer single quotes (
  `prefer_single_quotes: true`).
* **Callbacks:** Must be concise and single-expression only. If a callback requires multiple
  statements, extract the logic into a private method.
* **Parameters:** Required named parameters MUST always be declared before optional named
  parameters.
* **Doubles:** Avoid unnecessary `.0` literals. Do not force double values when not strictly
  required by the API or type context.

## 5. IMPORT ORDERING

Imports must be grouped into specific sections and sorted alphabetically within each group. Sections
must be separated by exactly **one empty line**. Omit any section if it has no imports. Do not add
comments to describe the sections.

1. **Dart SDK** (`import 'dart:async';`)
2. **Flutter SDK** (`import 'package:flutter/material.dart';`)
3. **External dependencies** (`import 'package:bloc/bloc.dart';`)
4. **Internal dependencies** (`import 'package:webtrit_callkeep/webtrit_callkeep.dart';`)
5. **Project package imports** (`import 'package:webtrit_phone/app/consts.dart';`)
6. **Relative imports** (`import '../models/models.dart';`)

## 6. LOCALIZATION (L10N)

* **Naming Template:** `<bloc_Name>_<Host_Widget_General_Name><Field_Names>[_<variation>]`
    * *Examples:* `lobby_AppBarTitle`, `lobby_AppBarActionsTooltip_settings`,
      `login_Button_getPasswordBySMS`.
* **Reusability:** To reduce duplication, sub-features can utilize l10n variables declared in their
  parent/main feature.
* **Global Terms:** General terms (e.g., Yes, No, Ok, Cancel) can be placed in the global namespace.
