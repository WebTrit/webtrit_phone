import 'package:flutter/material.dart';

import 'presence_status_style.dart';

class PresenceStatusStyles extends ThemeExtension<PresenceStatusStyles> {
  const PresenceStatusStyles({required this.primary});

  final PresenceStatusStyle primary;

  @override
  ThemeExtension<PresenceStatusStyles> copyWith({PresenceStatusStyle? primary}) {
    return PresenceStatusStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<PresenceStatusStyles> lerp(ThemeExtension<PresenceStatusStyles>? other, double t) {
    if (other == null || other is! PresenceStatusStyles) {
      return this;
    }

    return PresenceStatusStyles(primary: PresenceStatusStyle.lerp(primary, other.primary, t));
  }
}
