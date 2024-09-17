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
    UiComposeSettingsAccount? account, // Added account
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
    UiComposeSettingsBottomMenuTabData? data,
  }) = _UiComposeSettingsBottomMenuTab;

  factory UiComposeSettingsBottomMenuTab.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsBottomMenuTabFromJson(json);
}

// New class for account settings
@freezed
class UiComposeSettingsAccount with _$UiComposeSettingsAccount {
  const UiComposeSettingsAccount._();

  const factory UiComposeSettingsAccount({
    @Default([]) List<UiComposeSettingsAccountSection> sections,
  }) = _UiComposeSettingsAccount;

  factory UiComposeSettingsAccount.fromJson(Map<String, dynamic> json) => _$UiComposeSettingsAccountFromJson(json);
}

@freezed
class UiComposeSettingsAccountSection with _$UiComposeSettingsAccountSection {
  const UiComposeSettingsAccountSection._();

  const factory UiComposeSettingsAccountSection({
    required String titleL10n,
    @Default([]) List<UiComposeSettingsAccountItem> items,
  }) = _UiComposeSettingsAccountSection;

  factory UiComposeSettingsAccountSection.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsAccountSectionFromJson(json);
}

@freezed
class UiComposeSettingsAccountItem with _$UiComposeSettingsAccountItem {
  const UiComposeSettingsAccountItem._();

  const factory UiComposeSettingsAccountItem({
    @Default(true) bool enabled,
    required String titleL10n,
    String? type,
    @IconDataConverter() required IconData icon,
    required UiComposeSettingsAccountItemData? data,
  }) = _UiComposeSettingsAccountItem;

  factory UiComposeSettingsAccountItem.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsAccountItemFromJson(json);
}

@freezed
class UiComposeSettingsAccountItemData with _$UiComposeSettingsAccountItemData {
  const UiComposeSettingsAccountItemData._();

  const factory UiComposeSettingsAccountItemData({
    required String url,
  }) = _UiComposeSettingsAccountItemData;

  factory UiComposeSettingsAccountItemData.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsAccountItemDataFromJson(json);
}

@unfreezed
class UiComposeSettingsBottomMenuTabData with _$UiComposeSettingsBottomMenuTabData {
  factory UiComposeSettingsBottomMenuTabData({
    required String url,
  }) = _UiComposeSettingsBottomMenuTabData;

  factory UiComposeSettingsBottomMenuTabData.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsBottomMenuTabDataFromJson(json);
}
