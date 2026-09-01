import 'package:flutter/material.dart';

/// The two text button looks the confirm dialog is built from.
///
/// It carried five more - `callStart`, `callHangup`, `callTransfer`,
/// `callAction` and `callActiveAction` - from before the call screen had
/// styles of its own. Nothing read them: a call button takes
/// `CallScreenActionsStyle`, so these were built on every theme change and
/// thrown away.
///
/// The extension itself is still registered on the theme twice, by two
/// instances of this type, and read from it never - `neutral` and `dangerous`
/// reach the dialog by being handed to it. That is a separate thing to
/// straighten out.
class TextButtonStyles extends ThemeExtension<TextButtonStyles> {
  const TextButtonStyles({required this.neutral, required this.dangerous});

  final ButtonStyle? neutral;
  final ButtonStyle? dangerous;

  @override
  ThemeExtension<TextButtonStyles> copyWith({ButtonStyle? neutral, ButtonStyle? dangerous}) {
    return TextButtonStyles(neutral: neutral ?? this.neutral, dangerous: dangerous ?? this.dangerous);
  }

  @override
  ThemeExtension<TextButtonStyles> lerp(ThemeExtension<TextButtonStyles>? other, double t) {
    if (other is! TextButtonStyles) {
      return this;
    }
    return TextButtonStyles(
      neutral: ButtonStyle.lerp(neutral, other.neutral, t),
      dangerous: ButtonStyle.lerp(dangerous, other.dangerous, t),
    );
  }
}
