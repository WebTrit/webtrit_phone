import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/themed_scaffold.dart';

import '../widgets/actionpad_style.dart';
import '../widgets/keypad_style.dart';

/// Defines the visual styling for the keypad screen.
///
/// This style extends [BaseScreenStyle] to include specific configurations
/// for the keypad's input fields, numeric grid, and action buttons.
class KeypadScreenStyle extends BaseScreenStyle with Diagnosticable {
  /// Creates a keypad screen style.
  const KeypadScreenStyle({
    super.background,
    this.contentThemeOverride,
    this.applyToAppBar,
    this.inputField,
    this.contactNameField,
    this.keypadStyle,
    this.actionpadStyle,
  });

  /// Overrides the theme brightness (Light/Dark) for the screen content.
  final ContentThemeOverride? contentThemeOverride;

  /// If true, the AppBar will ignore the [contentThemeOverride] and keep the global theme.
  final bool? applyToAppBar;

  /// The style for the main text input field (e.g., dialed number).
  final TextFieldStyle? inputField;

  /// The style for the contact name field, often shown when the dialed number matches a contact.
  final TextFieldStyle? contactNameField;

  /// The visual style for the numeric keypad grid.
  final KeypadStyle? keypadStyle;

  /// The visual style for the action pad (e.g., call button, backspace).
  final ActionpadStyle? actionpadStyle;

  /// Creates a copy of this style with the given fields replaced with the new values.
  KeypadScreenStyle copyWith({
    BackgroundStyle? background,
    ContentThemeOverride? contentThemeOverride,
    bool? applyToAppBar,
    TextFieldStyle? inputField,
    TextFieldStyle? contactNameField,
    KeypadStyle? keypadStyle,
    ActionpadStyle? actionpadStyle,
  }) {
    return KeypadScreenStyle(
      background: background ?? this.background,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
      inputField: inputField ?? this.inputField,
      contactNameField: contactNameField ?? this.contactNameField,
      keypadStyle: keypadStyle ?? this.keypadStyle,
      actionpadStyle: actionpadStyle ?? this.actionpadStyle,
    );
  }

  /// Creates a copy of [KeypadScreenStyle] where values from [b] take precedence over [a].
  static KeypadScreenStyle merge(KeypadScreenStyle? a, KeypadScreenStyle? b) {
    if (a == null) return b ?? const KeypadScreenStyle();
    if (b == null) return a;

    return KeypadScreenStyle(
      background: b.background ?? a.background,
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
      inputField: TextFieldStyle.merge(a.inputField, b.inputField),
      contactNameField: TextFieldStyle.merge(a.contactNameField, b.contactNameField),
      keypadStyle: KeypadStyle.merge(a.keypadStyle, b.keypadStyle),
      actionpadStyle: ActionpadStyle.merge(a.actionpadStyle, b.actionpadStyle),
    );
  }

  /// Linearly interpolates between two [KeypadScreenStyle]s.
  static KeypadScreenStyle lerp(KeypadScreenStyle? a, KeypadScreenStyle? b, double t) {
    return KeypadScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
      contentThemeOverride: t < 0.5 ? a?.contentThemeOverride : b?.contentThemeOverride,
      applyToAppBar: t < 0.5 ? a?.applyToAppBar : b?.applyToAppBar,
      inputField: TextFieldStyle.lerp(a?.inputField, b?.inputField, t),
      contactNameField: TextFieldStyle.lerp(a?.contactNameField, b?.contactNameField, t),
      keypadStyle: KeypadStyle.lerp(a?.keypadStyle, b?.keypadStyle, t),
      actionpadStyle: ActionpadStyle.lerp(a?.actionpadStyle, b?.actionpadStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BackgroundStyle?>('background', background))
      ..add(EnumProperty<ContentThemeOverride?>('contentThemeOverride', contentThemeOverride))
      ..add(DiagnosticsProperty<bool?>('applyToAppBar', applyToAppBar))
      ..add(DiagnosticsProperty<TextFieldStyle?>('inputField', inputField))
      ..add(DiagnosticsProperty<TextFieldStyle?>('contactNameField', contactNameField))
      ..add(DiagnosticsProperty<KeypadStyle?>('keypadStyle', keypadStyle))
      ..add(DiagnosticsProperty<ActionpadStyle?>('actionpadStyle', actionpadStyle));
  }
}
