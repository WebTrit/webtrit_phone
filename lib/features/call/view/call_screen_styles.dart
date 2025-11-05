import 'package:flutter/material.dart';

import 'call_screen_style.dart';

class CallScreenStyles extends ThemeExtension<CallScreenStyles> {
  const CallScreenStyles({required this.primary});

  final CallScreenStyle? primary;

  @override
  ThemeExtension<CallScreenStyles> copyWith({CallScreenStyle? primary}) {
    return CallScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<CallScreenStyles> lerp(ThemeExtension<CallScreenStyles>? other, double t) {
    if (other == null || primary == null || other is! CallScreenStyles) {
      return this;
    }

    return CallScreenStyles(primary: CallScreenStyle.lerp(primary, other.primary, t));
  }
}
