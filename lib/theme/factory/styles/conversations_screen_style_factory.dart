import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_page_config.dart';

import 'package:webtrit_phone/features/messaging/features/conversations/view/conversations_screen_style.dart';
import 'package:webtrit_phone/features/messaging/features/conversations/view/conversations_screen_styles.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';

import '../theme_style_factory.dart';

class ConversationsScreenStyleFactory implements ThemeStyleFactory<ConversationsScreenStyles> {
  ConversationsScreenStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final ConversationsPageConfig config;

  @override
  ConversationsScreenStyles create() {
    final backgroundStyle = config.background?.toStyle();

    return ConversationsScreenStyles(
      primary: ConversationsScreenStyle(
        background: backgroundStyle,
        contentThemeOverride: config.themeOverride.mode.toThemeMode(),
        applyToAppBar: config.themeOverride.applyToAppBar,
      ),
    );
  }
}
