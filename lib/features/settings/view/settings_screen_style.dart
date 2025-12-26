import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/styles/base_screen_style.dart';

import '../widgets/group_title_list_tile.dart';

class SettingScreenStyle extends BaseScreenStyle with Diagnosticable {
  const SettingScreenStyle({
    super.background,
    this.leadingIconsColor,
    this.logoutIconColor,
    this.userIconColor,
    this.groupTitleListStyle,
    this.listViewPadding,
    this.showSeparators,
    this.itemTextStyle,
  });

  final Color? leadingIconsColor;
  final Color? logoutIconColor;
  final Color? userIconColor;

  /// Style for group titles (text + background)
  final GroutTitleListStyle? groupTitleListStyle;

  final EdgeInsetsGeometry? listViewPadding;
  final bool? showSeparators;

  /// Text style for list items
  final TextStyle? itemTextStyle;

  SettingScreenStyle copyWith({
    Color? leadingIconsColor,
    Color? logoutIconColor,
    Color? userIconColor,
    GroutTitleListStyle? groupTitleListStyle,
    EdgeInsetsGeometry? listViewPadding,
    bool? showSeparators,
    TextStyle? itemTextStyle,
  }) {
    return SettingScreenStyle(
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
      leadingIconsColor: b.leadingIconsColor ?? a.leadingIconsColor,
      logoutIconColor: b.logoutIconColor ?? a.logoutIconColor,
      userIconColor: b.userIconColor ?? a.userIconColor,
      groupTitleListStyle: GroutTitleListStyle.merge(a.groupTitleListStyle, b.groupTitleListStyle),
      listViewPadding: b.listViewPadding ?? a.listViewPadding,
      showSeparators: b.showSeparators ?? a.showSeparators,
      // Merge text styles to allow cascading properties
      itemTextStyle: a.itemTextStyle?.merge(b.itemTextStyle) ?? b.itemTextStyle,
    );
  }

  static SettingScreenStyle lerp(SettingScreenStyle? a, SettingScreenStyle? b, double t) {
    return SettingScreenStyle(
      leadingIconsColor: Color.lerp(a?.leadingIconsColor, b?.leadingIconsColor, t),
      logoutIconColor: Color.lerp(a?.logoutIconColor, b?.logoutIconColor, t),
      userIconColor: Color.lerp(a?.userIconColor, b?.userIconColor, t),
      groupTitleListStyle: GroutTitleListStyle.lerp(a?.groupTitleListStyle, b?.groupTitleListStyle, t),
      listViewPadding: EdgeInsetsGeometry.lerp(a?.listViewPadding, b?.listViewPadding, t),
      showSeparators: t < 0.5 ? a?.showSeparators : b?.showSeparators,
      itemTextStyle: TextStyle.lerp(a?.itemTextStyle, b?.itemTextStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('leadingIconsColor', leadingIconsColor))
      ..add(ColorProperty('logoutIconColor', logoutIconColor))
      ..add(ColorProperty('userIconColor', userIconColor))
      ..add(DiagnosticsProperty<GroutTitleListStyle?>('groupTitleListStyle', groupTitleListStyle))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry?>('listViewPadding', listViewPadding))
      ..add(DiagnosticsProperty<bool?>('showSeparators', showSeparators))
      ..add(DiagnosticsProperty<TextStyle?>('itemTextStyle', itemTextStyle));
  }
}
