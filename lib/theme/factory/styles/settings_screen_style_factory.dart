import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'package:webtrit_phone/features/settings/view/settings_screen.dart';

import '../../extension/extension.dart';
import '../theme_style_factory.dart';

import 'group_title_list_styles.dart';

class SettingsScreenStyleFactory implements ThemeStyleFactory<SettingsScreenStyles> {
  SettingsScreenStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final SettingsPageConfig? config;

  @override
  SettingsScreenStyles create() {
    final leadingIconsColor = config?.leadingIconsColor?.toColor();
    final logoutIconColor = config?.logoutIconColor?.toColor();
    final userIconColor = config?.userIconColor?.toColor();
    final itemTextStyle = config?.itemTextStyle?.toTextStyle();
    final backgroundStyle = config?.background?.toStyle();
    final groupTitleListStyle = GroupTitleListStyleFactory(colors, config?.groupTitleListTile).create().primary;

    // Resolve theme override values safely
    final contentThemeOverride = config?.themeOverride.mode.toThemeMode();
    final applyToAppBar = config?.themeOverride.applyToAppBar;

    return SettingsScreenStyles(
      primary: SettingScreenStyle(
        background: backgroundStyle,
        contentThemeOverride: contentThemeOverride,
        applyToAppBar: applyToAppBar,
        leadingIconsColor: leadingIconsColor,
        userIconColor: userIconColor,
        logoutIconColor: logoutIconColor,
        groupTitleListStyle: groupTitleListStyle,
        listViewPadding: null,
        showSeparators: config?.showSeparators,
        itemTextStyle: itemTextStyle,
      ),
    );
  }
}
