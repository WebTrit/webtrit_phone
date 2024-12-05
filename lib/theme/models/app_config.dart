import 'package:flutter/widgets.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'icon_data_converter.dart';

part 'app_config.freezed.dart';

part 'app_config.g.dart';

@freezed
class AppConfig with _$AppConfig {
  const AppConfig._();

  const factory AppConfig({
    @Default(AppConfigLogin()) AppConfigLogin loginConfig,
    @Default(AppConfigMain()) AppConfigMain mainConfig,
    @Default(AppConfigSettings()) AppConfigSettings settingsConfig,
    @Default(AppConfigCall()) AppConfigCall callConfig,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);
}

@freezed
class AppConfigLogin with _$AppConfigLogin {
  const AppConfigLogin._();

  const factory AppConfigLogin({
    @Default([]) List<AppConfigModeSelectAction> modeSelectActions,
    @Default([]) List<AppConfigLoginEmbedded> embedded,
  }) = _AppConfigLogin;

  factory AppConfigLogin.fromJson(Map<String, dynamic> json) => _$AppConfigLoginFromJson(json);
}

@freezed
class AppConfigModeSelectAction with _$AppConfigModeSelectAction {
  const AppConfigModeSelectAction._();

  const factory AppConfigModeSelectAction({
    required bool enabled,
    int? embeddedId,
    required String type,
    required String titleL10n,
  }) = _AppConfigModeSelectAction;

  factory AppConfigModeSelectAction.fromJson(Map<String, dynamic> json) => _$AppConfigModeSelectActionFromJson(json);
}

@freezed
class AppConfigLoginEmbedded with _$AppConfigLoginEmbedded {
  const AppConfigLoginEmbedded._();

  const factory AppConfigLoginEmbedded({
    required int id,
    @Default(false) bool launch,
    String? titleL10n,
    @Default(false) bool showToolbar,
    required String resource,
  }) = _AppConfigLoginEmbedded;

  factory AppConfigLoginEmbedded.fromJson(Map<String, dynamic> json) => _$AppConfigLoginEmbeddedFromJson(json);
}

@freezed
class AppConfigMain with _$AppConfigMain {
  const AppConfigMain._();

  const factory AppConfigMain({
    @Default(AppConfigBottomMenu(cacheSelectedTab: true, tabs: [])) AppConfigBottomMenu bottomMenu,
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

  static const String dataContactSourceTypes = 'contactSourceTypes';
  static const String dataResource = 'resource';

  const factory AppConfigBottomMenuTab({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    required String type,
    required String titleL10n,
    @IconDataConverter() required IconData icon,
    @Default({}) Map<String, dynamic> data,
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
    required String type,
    @IconDataConverter() required IconData icon,
    @Default({}) Map<String, dynamic> data,
  }) = _AppConfigSettingsItem;

  factory AppConfigSettingsItem.fromJson(Map<String, dynamic> json) => _$AppConfigSettingsItemFromJson(json);
}

@freezed
class AppConfigCall with _$AppConfigCall {
  const AppConfigCall._();

  const factory AppConfigCall({
    @Default(true) bool videoEnabled,
    @Default(AppConfigTransfer(
      enableBlindTransfer: true,
      enableAttendedTransfer: true,
    ))
    AppConfigTransfer transfer,
  }) = _AppConfigCall;

  factory AppConfigCall.fromJson(Map<String, dynamic> json) => _$AppConfigCallFromJson(json);
}

@freezed
class AppConfigTransfer with _$AppConfigTransfer {
  const AppConfigTransfer._();

  const factory AppConfigTransfer({
    @Default(true) bool enableBlindTransfer,
    @Default(true) bool enableAttendedTransfer,
  }) = _AppConfigTransfer;

  factory AppConfigTransfer.fromJson(Map<String, dynamic> json) => _$AppConfigTransferFromJson(json);
}
