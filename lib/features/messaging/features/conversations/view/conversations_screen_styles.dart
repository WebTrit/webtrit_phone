import 'package:flutter/material.dart';

import 'conversations_screen_style.dart';

class ConversationsScreenStyles extends ThemeExtension<ConversationsScreenStyles> {
  const ConversationsScreenStyles({required this.primary});

  final ConversationsScreenStyle? primary;

  @override
  ConversationsScreenStyles copyWith({ConversationsScreenStyle? primary}) {
    return ConversationsScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<ConversationsScreenStyles> lerp(ThemeExtension<ConversationsScreenStyles>? other, double t) {
    if (other is! ConversationsScreenStyles) return this;
    return ConversationsScreenStyles(primary: ConversationsScreenStyle.lerp(primary, other.primary, t));
  }
}
