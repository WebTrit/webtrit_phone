import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'package:webtrit_phone/features/settings/view/settings_screen.dart';

import '../../extension/extension.dart';
import '../theme_style_factory.dart';

import 'group_title_list_styles.dart';

class SettingsScreenStyleFactory implements ThemeStyleFactory<SettingsScreenStyles> {
  SettingsScreenStyleFactory(this.colors, this.config, this.defaultFontFamily, {this.appBarTheme});

  final ColorScheme colors;
  final SettingsPageConfig? config;
  final String? defaultFontFamily;
  final AppBarTheme? appBarTheme;

  @override
  SettingsScreenStyles create() {
    final leadingIconsColor = config?.leadingIconsColor?.toColor();
    final logoutIconColor = config?.logoutIconColor?.toColor();
    final userIconColor = config?.userIconColor?.toColor();
    final itemTextStyle = config?.itemTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily);
    final backgroundStyle = config?.background?.toStyle();
    final groupTitleListStyle = GroupTitleListStyleFactory(
      colors,
      config?.groupTitleListTile,
      defaultFontFamily,
    ).create().primary;

    // Whether the separator is shown is decided by the value, not by whether
    // the object holding it exists.
    //
    // It used to be the object: a `separator` present meant the legacy boolean
    // must not override it, on the grounds that a theme carrying the new style
    // had already said what it wanted. It had not necessarily said this part.
    // The store builds `separator` as soon as either of its two columns is
    // filled, so setting a colour alone produces `{enabled: null, color: ...}`
    // - and a brand that had turned separators off got them back the day
    // somebody coloured them.
    final separator = config?.separator;
    // ignore: deprecated_member_use
    final showSeparators = separator?.enabled ?? config?.showSeparators;
    final separatorColor = separator?.color?.toColor();

    // Resolve theme override values safely
    final contentThemeOverride = config?.themeOverride.mode.toThemeMode();
    final applyToAppBar = config?.themeOverride.applyToAppBar;

    return SettingsScreenStyles(
      primary: SettingScreenStyle(
        background: backgroundStyle,
        appBarBlurredSurface: config?.appBarBlurredSurface?.toStyle(),
        contentThemeOverride: contentThemeOverride,
        applyToAppBar: applyToAppBar,
        appBarTheme: appBarTheme,
        leadingIconsColor: leadingIconsColor,
        userIconColor: userIconColor,
        logoutIconColor: logoutIconColor,
        groupTitleListStyle: groupTitleListStyle,
        listViewPadding: null,
        showSeparators: showSeparators,
        separatorColor: separatorColor,
        itemTextStyle: itemTextStyle,
      ),
    );
  }
}
