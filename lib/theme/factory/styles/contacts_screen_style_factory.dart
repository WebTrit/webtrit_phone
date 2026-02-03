import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_page_config.dart';
import 'package:webtrit_phone/features/contacts/view/contacts_screen_style.dart';
import 'package:webtrit_phone/features/contacts/view/contacts_screen_styles.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

import '../theme_style_factory.dart';

class ContactsScreenStyleFactory implements ThemeStyleFactory<ContactsScreenStyles> {
  ContactsScreenStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final ContactsPageConfig config;

  @override
  ContactsScreenStyles create() {
    final backgroundStyle = config.background?.toStyle();

    return ContactsScreenStyles(
      primary: ContactsScreenStyle(
        background: backgroundStyle,
        contentThemeOverride: config.themeOverride.mode.toContentThemeOverride(),
        applyToAppBar: config.themeOverride.applyToAppBar,
      ),
    );
  }
}
