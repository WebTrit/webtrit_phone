import 'package:flutter/widgets.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'icon_data_converter.dart';

part 'ui_compose_settings.freezed.dart';

part 'ui_compose_settings.g.dart';

@freezed
class UiComposeSettings with _$UiComposeSettings {
  const UiComposeSettings._();

  const factory UiComposeSettings({
    UiComposeSettingsLogin? login,
    UiComposeSettingsMain? main,
    UiComposeSettingsSettings? settings,
  }) = _UiComposeSettings;

  factory UiComposeSettings.fromJson(Map<String, dynamic> json) => _$UiComposeSettingsFromJson(json);

  bool get isCustomSignInEnabled => login?.customSignIn?.enabled == true;
}

@freezed
class UiComposeSettingsLogin with _$UiComposeSettingsLogin {
  const UiComposeSettingsLogin._();

  const factory UiComposeSettingsLogin({
    UiComposeSettingsLoginCustomSignIn? customSignIn,
  }) = _UiComposeSettingsLogin;

  factory UiComposeSettingsLogin.fromJson(Map<String, dynamic> json) => _$UiComposeSettingsLoginFromJson(json);
}

@freezed
class UiComposeSettingsLoginCustomSignIn with _$UiComposeSettingsLoginCustomSignIn {
  const UiComposeSettingsLoginCustomSignIn._();

  const factory UiComposeSettingsLoginCustomSignIn({
    bool? enabled,
    String? titleL10n,
    String? url,
  }) = _UiComposeSettingsLoginCustomSignIn;

  factory UiComposeSettingsLoginCustomSignIn.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsLoginCustomSignInFromJson(json);
}

@freezed
class UiComposeSettingsMain with _$UiComposeSettingsMain {
  const UiComposeSettingsMain._();

  const factory UiComposeSettingsMain({
    UiComposeSettingsBottomMenu? bottomMenu,
  }) = _UiComposeSettingsMain;

  factory UiComposeSettingsMain.fromJson(Map<String, dynamic> json) => _$UiComposeSettingsMainFromJson(json);
}

@freezed
class UiComposeSettingsBottomMenu with _$UiComposeSettingsBottomMenu {
  const UiComposeSettingsBottomMenu._();

  const factory UiComposeSettingsBottomMenu({
    @Default(true) bool cacheSelectedTab,
    @Default([]) List<UiComposeSettingsBottomMenuTab> tabs,
  }) = _UiComposeSettingsBottomMenu;

  factory UiComposeSettingsBottomMenu.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsBottomMenuFromJson(json);
}

@freezed
class UiComposeSettingsBottomMenuTab with _$UiComposeSettingsBottomMenuTab {
  const UiComposeSettingsBottomMenuTab._();

  const factory UiComposeSettingsBottomMenuTab({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    required String type,
    required String titleL10n,
    @IconDataConverter() required IconData icon,
    UiComposeSettingsData? data,
  }) = _UiComposeSettingsBottomMenuTab;

  factory UiComposeSettingsBottomMenuTab.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsBottomMenuTabFromJson(json);
}

@freezed
class UiComposeSettingsSettings with _$UiComposeSettingsSettings {
  const UiComposeSettingsSettings._();

  const factory UiComposeSettingsSettings({
    @Default([]) List<UiComposeSettingsSettingsSection> sections,
  }) = _UiComposeSettingsSettings;

  factory UiComposeSettingsSettings.fromJson(Map<String, dynamic> json) => _$UiComposeSettingsSettingsFromJson(json);
}

@freezed
class UiComposeSettingsSettingsSection with _$UiComposeSettingsSettingsSection {
  const UiComposeSettingsSettingsSection._();

  const factory UiComposeSettingsSettingsSection({
    required String titleL10n,
    @Default(true) bool enabled,
    @Default([]) List<UiComposeSettingsSettingsItem> items,
  }) = _UiComposeSettingsSettingsSection;

  factory UiComposeSettingsSettingsSection.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsSettingsSectionFromJson(json);
}

@freezed
class UiComposeSettingsSettingsItem with _$UiComposeSettingsSettingsItem {
  const UiComposeSettingsSettingsItem._();

  const factory UiComposeSettingsSettingsItem({
    @Default(true) bool enabled,
    required String titleL10n,
    String? type,
    @IconDataConverter() required IconData icon,
    required UiComposeSettingsData? data,
  }) = _UiComposeSettingsSettingsItem;

  factory UiComposeSettingsSettingsItem.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsSettingsItemFromJson(json);
}

@freezed
class UiComposeSettingsData with _$UiComposeSettingsData {
  const UiComposeSettingsData._();

  const factory UiComposeSettingsData({
    required String url,
  }) = _UiComposeSettingsData;

  factory UiComposeSettingsData.fromJson(Map<String, dynamic> json) => _$UiComposeSettingsDataFromJson(json);
}
