import 'package:flutter/material.dart';

class TextButtonStyles extends ThemeExtension<TextButtonStyles> {
  const TextButtonStyles({
    required this.neutral,
    required this.dangerous,
    required this.callStart,
    required this.callHangup,
    required this.callTransfer,
    required this.callAction,
    required this.callActiveAction,
  });

  final ButtonStyle? neutral;
  final ButtonStyle? dangerous;
  final ButtonStyle? callStart;
  final ButtonStyle? callHangup;
  final ButtonStyle? callTransfer;
  final ButtonStyle? callAction;
  final ButtonStyle? callActiveAction;

  @override
  ThemeExtension<TextButtonStyles> copyWith({
    ButtonStyle? neutral,
    ButtonStyle? dangerous,
    ButtonStyle? callStart,
    ButtonStyle? callHangup,
    ButtonStyle? callTransfer,
    ButtonStyle? callAction,
    ButtonStyle? callActiveAction,
  }) {
    return TextButtonStyles(
      neutral: neutral ?? this.neutral,
      dangerous: dangerous ?? this.dangerous,
      callStart: callStart ?? this.callStart,
      callHangup: callHangup ?? this.callHangup,
      callTransfer: callTransfer ?? this.callTransfer,
      callAction: callAction ?? this.callAction,
      callActiveAction: callActiveAction ?? this.callActiveAction,
    );
  }

  @override
  ThemeExtension<TextButtonStyles> lerp(ThemeExtension<TextButtonStyles>? other, double t) {
    if (other is! TextButtonStyles) {
      return this;
    }
    return TextButtonStyles(
      neutral: ButtonStyle.lerp(neutral, other.neutral, t),
      dangerous: ButtonStyle.lerp(dangerous, other.dangerous, t),
      callStart: ButtonStyle.lerp(callStart, other.callStart, t),
      callHangup: ButtonStyle.lerp(callHangup, other.callHangup, t),
      callTransfer: ButtonStyle.lerp(callTransfer, other.callTransfer, t),
      callAction: ButtonStyle.lerp(callAction, other.callAction, t),
      callActiveAction: ButtonStyle.lerp(callActiveAction, other.callActiveAction, t),
    );
  }
}
