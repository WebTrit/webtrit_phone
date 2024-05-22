import 'package:flutter/material.dart';

import 'actionpad_style.dart';

class ActionpadStyles extends ThemeExtension<ActionpadStyles> {
  const ActionpadStyles({
    required this.primary,
  });

  final ActionpadStyle? primary;

  @override
  ThemeExtension<ActionpadStyles> copyWith({
    ActionpadStyle? primary,
  }) {
    return ActionpadStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<ActionpadStyles> lerp(ThemeExtension<ActionpadStyles>? other, double t) {
    if (other == null || primary == null || other is! ActionpadStyles) {
      return this;
    }

    return ActionpadStyles(primary: ActionpadStyle.lerp(primary, other.primary, t));
  }
}
