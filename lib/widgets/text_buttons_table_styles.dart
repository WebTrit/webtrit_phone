import 'package:flutter/material.dart';

import 'text_buttons_table_style.dart';

class TextButtonsTableStyles extends ThemeExtension<TextButtonsTableStyles> {
  const TextButtonsTableStyles({
    required this.primary,
  });

  final TextButtonsTableStyle? primary;

  @override
  TextButtonsTableStyles copyWith({
    TextButtonsTableStyle? primary,
  }) {
    return TextButtonsTableStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<TextButtonsTableStyles> lerp(
    ThemeExtension<TextButtonsTableStyles>? other,
    double t,
  ) {
    if (other is! TextButtonsTableStyles) return this;
    return TextButtonsTableStyles(
      primary: TextButtonsTableStyle.lerp(primary, other.primary, t),
    );
  }
}
