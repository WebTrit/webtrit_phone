import 'package:flutter/widgets.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'icon_data_converter.dart';

part 'app_config.freezed.dart';

part 'app_config.g.dart';

@freezed
class AppConfig with _$AppConfig {
  const AppConfig._();

  const factory AppConfig({
    AppConfigLogin? login,
    AppConfigMain? main,
    AppConfigSettings? settings,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);

  bool get isCustomSignInEnabled => login?.customSignIn?.enabled == true;
}

@freezed
class AppConfigLogin with _$AppConfigLogin {
  const AppConfigLogin._();

  const factory AppConfigLogin({
    AppConfigLoginCustomSignIn? customSignIn,
  }) = _AppConfigLogin;

  factory AppConfigLogin.fromJson(Map<String, dynamic> json) => _$AppConfigLoginFromJson(json);
}

@freezed
class AppConfigLoginCustomSignIn with _$AppConfigLoginCustomSignIn {
  const AppConfigLoginCustomSignIn._();

  const factory AppConfigLoginCustomSignIn({
    bool? enabled,
    String? titleL10n,
    String? url,
  }) = _AppConfigLoginCustomSignIn;

  factory AppConfigLoginCustomSignIn.fromJson(Map<String, dynamic> json) => _$AppConfigLoginCustomSignInFromJson(json);
}

@freezed
class AppConfigMain with _$AppConfigMain {
  const AppConfigMain._();

  const factory AppConfigMain({
    AppConfigBottomMenu? bottomMenu,
  }) = _AppConfigMain;

  factory AppConfigMain.fromJson(Map<String, dynamic> json) => _$AppConfigMainFromJson(json);
}

@freezed
class AppConfigBottomMenu with _$AppConfigBottomMenu {
  const AppConfigBottomMenu._();

  const factory AppConfigBottomMenu({
    @Default(true) bool cacheSelectedTab,
    @Default([]) List<AppConfigBottomMenuTab> tabs,
  }) = _AppConfigBottomMenu;

  factory AppConfigBottomMenu.fromJson(Map<String, dynamic> json) => _$AppConfigBottomMenuFromJson(json);
}

@freezed
class AppConfigBottomMenuTab with _$AppConfigBottomMenuTab {
  const AppConfigBottomMenuTab._();

  const factory AppConfigBottomMenuTab({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    required String type,
    required String titleL10n,
    @IconDataConverter() required IconData icon,
    AppConfigData? data,
  }) = _AppConfigBottomMenuTab;

  factory AppConfigBottomMenuTab.fromJson(Map<String, dynamic> json) => _$AppConfigBottomMenuTabFromJson(json);
}

@freezed
class AppConfigSettings with _$AppConfigSettings {
  const AppConfigSettings._();

  const factory AppConfigSettings({
    @Default([]) List<AppConfigSettingsSection> sections,
  }) = _AppConfigSettings;

  factory AppConfigSettings.fromJson(Map<String, dynamic> json) => _$AppConfigSettingsFromJson(json);
}

@freezed
class AppConfigSettingsSection with _$AppConfigSettingsSection {
  const AppConfigSettingsSection._();

  const factory AppConfigSettingsSection({
    required String titleL10n,
    @Default(true) bool enabled,
    @Default([]) List<AppConfigSettingsItem> items,
  }) = _AppConfigSettingsSection;

  factory AppConfigSettingsSection.fromJson(Map<String, dynamic> json) => _$AppConfigSettingsSectionFromJson(json);
}

@freezed
class AppConfigSettingsItem with _$AppConfigSettingsItem {
  const AppConfigSettingsItem._();

  const factory AppConfigSettingsItem({
    @Default(true) bool enabled,
    required String titleL10n,
    String? type,
    @IconDataConverter() required IconData icon,
    required AppConfigData? data,
  }) = _AppConfigSettingsItem;

  factory AppConfigSettingsItem.fromJson(Map<String, dynamic> json) => _$AppConfigSettingsItemFromJson(json);
}

@freezed
class AppConfigData with _$AppConfigData {
  const AppConfigData._();

  const factory AppConfigData({
    required String url,
  }) = _AppConfigData;

  factory AppConfigData.fromJson(Map<String, dynamic> json) => _$AppConfigDataFromJson(json);
}
