# Theming & UI Rules

## 1. Core Principles

* **Data-Driven Theming:** The application's appearance is defined by configuration, not hardcoded
  values. Never use raw colors (e.g., `Colors.red`) or raw `TextStyle` objects directly in widgets.
* **Separation of Concerns:** * **Contract:** Defined in `packages/webtrit_appearance_theme` (Pure
  Dart DTOs).
    * **Data:** Defined in `assets/themes/*.json` (Serialized DTOs).
    * **Bridge:** Defined in `lib/theme/` (Mapping DTOs to Flutter `ThemeData` and
      `ThemeExtension`).
    * **Consumption:** Widgets use `Theme.of(context).extension<T>()`.

## 2. The Appearance Package (`webtrit_appearance_theme`)

* **DTOs only:** This package must remain platform-independent. It uses `String` for colors (hex),
  `double` for sizes, and `String` for font names.
* **No Flutter dependencies:** Strictly avoid importing `package:flutter/material.dart` or any
  UI-related packages here.
* **Serialization:** Models must use `freezed` and `json_serializable`. When adding new themeable
  properties, update the DTOs first.

## 3. Bridge Strategy (`lib/theme/`)

* **AppThemeData Factory:** This is the only place where DTOs are converted into Flutter-specific
  types (`Color`, `TextStyle`, `ButtonStyle`).
* **Theme Extensions Convention:** For custom widget styles, follow the "Style/Styles" naming pair:
    * `XStyle`: A class holding concrete Flutter properties (e.g., `final ButtonStyle? hangup`).
    * `XStyles`: A class extending `ThemeExtension<XStyles>`, acting as a container/wrapper for one
      or more `XStyle` objects.
* **Registration:** All new `ThemeExtension` instances must be registered within the `AppThemeData`
  factory to be accessible in the UI.

## 4. Usage in Widgets

* **Accessing Custom Styles:** Always use the `ThemeExtension` getter.
    * Correct: `Theme.of(context).extension<CallActionsStyles>()?.primary?.hangup`.
* **Standard Material Theme:** Use standard `Theme.of(context).colorScheme` or
  `Theme.of(context).textTheme` only for generic properties defined in `ColorSchemeConfig` or
  `TextThemeConfig`.
* **Stateless over Methods:** As per global rules, always encapsulate themed UI components in
  `StatelessWidget` classes to ensure proper context access and rebuilds.

## 5. Modifications Workflow

If you need to add a new themeable property:

1. Add the property to the relevant DTO in `packages/webtrit_appearance_theme`.
2. Run code generation for the package.
3. Update the corresponding JSON files in `assets/themes/`.
4. Update the mapping logic in `lib/theme/` and the associated `ThemeExtension`.
5. Consume the property in the widget via the extension.
