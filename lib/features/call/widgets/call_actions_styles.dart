import 'package:flutter/material.dart';

import 'call_actions_style.dart';

class CallActionsStyles extends ThemeExtension<CallActionsStyles> {
  const CallActionsStyles({required this.primary});

  final CallActionsStyle? primary;

  @override
  ThemeExtension<CallActionsStyles> copyWith({CallActionsStyle? primary}) {
    return CallActionsStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<CallActionsStyles> lerp(ThemeExtension<CallActionsStyles>? other, double t) {
    if (other == null || primary == null || other is! CallActionsStyles) {
      return this;
    }

    return CallActionsStyles(primary: CallActionsStyle.lerp(primary, other.primary, t));
  }
}
