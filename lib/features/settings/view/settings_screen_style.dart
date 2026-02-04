import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../widgets/group_title_list_style.dart';

/// Defines the visual styling for the settings screen.
///
/// Extends [BaseScreenStyle] to provide specific configuration for settings
/// items, including leading icon colors, logout and user icon colors, group
/// title appearance, list padding, separators, and item text styles.
class SettingScreenStyle extends BaseScreenStyle with Diagnosticable {
  const SettingScreenStyle({
    super.background,
    this.contentThemeOverride,
    this.applyToAppBar,
    this.leadingIconsColor,
    this.logoutIconColor,
    this.userIconColor,
    this.groupTitleListStyle,
    this.listViewPadding,
    this.showSeparators,
    this.itemTextStyle,
  });

  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;

  /// The color for leading icons in settings items (excluding logout and user icons which have specific overrides).
  final Color? leadingIconsColor;

  /// The color for the logout action icon in the settings list.
  final Color? logoutIconColor;

  /// The color for the user/profile icon in the settings list.
  final Color? userIconColor;

  /// Style for group titles (text + background)
  final GroupTitleListStyle? groupTitleListStyle;

  /// Padding around the settings list content.
  final EdgeInsetsGeometry? listViewPadding;

  /// Whether to show separators between settings list items.
  final bool? showSeparators;

  /// Text style for list items
  final TextStyle? itemTextStyle;

  SettingScreenStyle copyWith({
    BackgroundStyle? background,
    ThemeMode? contentThemeOverride,
    bool? applyToAppBar,
    Color? leadingIconsColor,
    Color? logoutIconColor,
    Color? userIconColor,
    GroupTitleListStyle? groupTitleListStyle,
    EdgeInsetsGeometry? listViewPadding,
    bool? showSeparators,
    TextStyle? itemTextStyle,
  }) {
    return SettingScreenStyle(
      background: background ?? this.background,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
      leadingIconsColor: leadingIconsColor ?? this.leadingIconsColor,
      logoutIconColor: logoutIconColor ?? this.logoutIconColor,
      userIconColor: userIconColor ?? this.userIconColor,
      groupTitleListStyle: groupTitleListStyle ?? this.groupTitleListStyle,
      listViewPadding: listViewPadding ?? this.listViewPadding,
      showSeparators: showSeparators ?? this.showSeparators,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
    );
  }

  static SettingScreenStyle merge(SettingScreenStyle? a, SettingScreenStyle? b) {
    if (a == null) return b ?? const SettingScreenStyle();
    if (b == null) return a;

    return SettingScreenStyle(
      background: b.background ?? a.background,
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
      leadingIconsColor: b.leadingIconsColor ?? a.leadingIconsColor,
      logoutIconColor: b.logoutIconColor ?? a.logoutIconColor,
      userIconColor: b.userIconColor ?? a.userIconColor,
      groupTitleListStyle: GroupTitleListStyle.merge(a.groupTitleListStyle, b.groupTitleListStyle),
      listViewPadding: b.listViewPadding ?? a.listViewPadding,
      showSeparators: b.showSeparators ?? a.showSeparators,
      itemTextStyle: a.itemTextStyle?.merge(b.itemTextStyle) ?? b.itemTextStyle,
    );
  }

  static SettingScreenStyle lerp(SettingScreenStyle? a, SettingScreenStyle? b, double t) {
    return SettingScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
      contentThemeOverride: t < 0.5 ? a?.contentThemeOverride : b?.contentThemeOverride,
      applyToAppBar: t < 0.5 ? a?.applyToAppBar : b?.applyToAppBar,
      leadingIconsColor: Color.lerp(a?.leadingIconsColor, b?.leadingIconsColor, t),
      logoutIconColor: Color.lerp(a?.logoutIconColor, b?.logoutIconColor, t),
      userIconColor: Color.lerp(a?.userIconColor, b?.userIconColor, t),
      groupTitleListStyle: GroupTitleListStyle.lerp(a?.groupTitleListStyle, b?.groupTitleListStyle, t),
      listViewPadding: EdgeInsetsGeometry.lerp(a?.listViewPadding, b?.listViewPadding, t),
      showSeparators: t < 0.5 ? a?.showSeparators : b?.showSeparators,
      itemTextStyle: TextStyle.lerp(a?.itemTextStyle, b?.itemTextStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BackgroundStyle?>('background', background))
      ..add(EnumProperty<ThemeMode?>('contentThemeOverride', contentThemeOverride))
      ..add(DiagnosticsProperty<bool?>('applyToAppBar', applyToAppBar))
      ..add(ColorProperty('leadingIconsColor', leadingIconsColor))
      ..add(ColorProperty('logoutIconColor', logoutIconColor))
      ..add(ColorProperty('userIconColor', userIconColor))
      ..add(DiagnosticsProperty<GroupTitleListStyle?>('groupTitleListStyle', groupTitleListStyle))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry?>('listViewPadding', listViewPadding))
      ..add(DiagnosticsProperty<bool?>('showSeparators', showSeparators))
      ..add(DiagnosticsProperty<TextStyle?>('itemTextStyle', itemTextStyle));
  }
}
