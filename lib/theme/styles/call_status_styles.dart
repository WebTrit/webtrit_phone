import 'package:flutter/material.dart';

import 'call_status_style.dart';

class CallStatusStyles extends ThemeExtension<CallStatusStyles> {
  const CallStatusStyles({
    required this.primary,
  });

  final CallStatusStyle? primary;

  @override
  ThemeExtension<CallStatusStyles> copyWith({
    CallStatusStyle? primary,
  }) {
    return CallStatusStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<CallStatusStyles> lerp(ThemeExtension<CallStatusStyles>? other, double t) {
    if (other == null || primary == null || other is! CallStatusStyles) {
      return this;
    }

    return CallStatusStyles(primary: CallStatusStyle.lerp(primary, other.primary, t));
  }
}
