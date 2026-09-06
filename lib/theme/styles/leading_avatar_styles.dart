import 'package:flutter/material.dart';

import 'leading_avatar_style.dart';

class LeadingAvatarStyles extends ThemeExtension<LeadingAvatarStyles> {
  const LeadingAvatarStyles({required this.primary});

  final LeadingAvatarStyle? primary;

  /// Avatar appearance for this context: what the theme says on top of the
  /// app's own values, so widgets never carry appearance of their own.
  static LeadingAvatarStyle of(BuildContext context) {
    final theme = Theme.of(context);
    return LeadingAvatarStyle.merge(
      LeadingAvatarStyle.defaults(theme.colorScheme),
      theme.extension<LeadingAvatarStyles>()?.primary,
    );
  }

  @override
  ThemeExtension<LeadingAvatarStyles> copyWith({LeadingAvatarStyle? primary}) {
    return LeadingAvatarStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<LeadingAvatarStyles> lerp(ThemeExtension<LeadingAvatarStyles>? other, double t) {
    if (other is! LeadingAvatarStyles) return this;
    return LeadingAvatarStyles(primary: LeadingAvatarStyle.lerp(primary, other.primary, t));
  }
}
