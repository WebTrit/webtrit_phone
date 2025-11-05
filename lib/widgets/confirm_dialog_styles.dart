import 'package:flutter/material.dart';

import 'confirm_dialog_style.dart';

class ConfirmDialogStyles extends ThemeExtension<ConfirmDialogStyles> {
  const ConfirmDialogStyles({required this.primary});

  final ConfirmDialogStyle? primary;

  @override
  ThemeExtension<ConfirmDialogStyles> copyWith({ConfirmDialogStyle? primary}) {
    return ConfirmDialogStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<ConfirmDialogStyles> lerp(ThemeExtension<ConfirmDialogStyles>? other, double t) {
    if (other == null || primary == null || other is! ConfirmDialogStyles) {
      return this;
    }

    return ConfirmDialogStyles(primary: ConfirmDialogStyle.lerp(primary, other.primary, t));
  }
}
