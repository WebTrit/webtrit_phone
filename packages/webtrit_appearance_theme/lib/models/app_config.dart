import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/converters.dart';
import '../parsers/parsers.dart';

import 'bottom_menu_tab_type.dart';
import 'metadata.dart';

part 'app_config.freezed.dart';

part 'app_config.g.dart';

@Freezed()
class AppConfig with _$AppConfig {
  const AppConfig._();

  @JsonSerializable(explicitToJson: true)
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

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigLogin({
    String? greetingL10n,
    @Default([]) List<AppConfigModeSelectAction> modeSelectActions,
    @Default([]) List<EmbeddedData> embedded,
  }) = _AppConfigLogin;

  factory AppConfigLogin.fromJson(Map<String, dynamic> json) => _$AppConfigLoginFromJson(json);
}

@freezed
class AppConfigModeSelectAction with _$AppConfigModeSelectAction {
  const AppConfigModeSelectAction._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigModeSelectAction({
    required bool enabled,
    int? embeddedId,
    required String type,
    required String titleL10n,
  }) = _AppConfigModeSelectAction;

  factory AppConfigModeSelectAction.fromJson(Map<String, dynamic> json) => _$AppConfigModeSelectActionFromJson(json);
}

@freezed
class AppConfigMain with _$AppConfigMain {
  const AppConfigMain._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigMain({
    @Default(AppConfigBottomMenu(cacheSelectedTab: true, tabs: [])) AppConfigBottomMenu bottomMenu,
  }) = _AppConfigMain;

  factory AppConfigMain.fromJson(Map<String, dynamic> json) => _$AppConfigMainFromJson(json);
}

@freezed
class AppConfigBottomMenu with _$AppConfigBottomMenu {
  const AppConfigBottomMenu._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigBottomMenu({
    @Default(true) bool cacheSelectedTab,
    @Default([]) List<BottomMenuTabScheme> tabs,
  }) = _AppConfigBottomMenu;

  factory AppConfigBottomMenu.fromJson(Map<String, dynamic> json) => _$AppConfigBottomMenuFromJson(json);
}

@freezed
class AppConfigCall with _$AppConfigCall {
  const AppConfigCall._();

  @JsonSerializable(explicitToJson: true)
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

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigTransfer({
    @Default(true) bool enableBlindTransfer,
    @Default(true) bool enableAttendedTransfer,
  }) = _AppConfigTransfer;

  factory AppConfigTransfer.fromJson(Map<String, dynamic> json) => _$AppConfigTransferFromJson(json);
}

@freezed
class BottomMenuTabScheme with _$BottomMenuTabScheme {
  static const String dataContactSourceTypes = 'contactSourceTypes';
  static const String dataResource = 'resource';

  const BottomMenuTabScheme._();

  @JsonSerializable(explicitToJson: true)
  const factory BottomMenuTabScheme.base({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    @BottomMenuTabTypeConverter() required BottomMenuTabType type,
    required String titleL10n,
    required String icon,
  }) = BaseTabScheme;

  @JsonSerializable(explicitToJson: true)
  const factory BottomMenuTabScheme.contacts({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    @BottomMenuTabTypeConverter() required BottomMenuTabType type,
    required String titleL10n,
    required String icon,
    @Default([]) List<String> contactSourceTypes,
  }) = ContactsTabScheme;

  @JsonSerializable(explicitToJson: true)
  const factory BottomMenuTabScheme.embedded({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    @BottomMenuTabTypeConverter() required BottomMenuTabType type,
    required String titleL10n,
    required String icon,
    required EmbeddedData data,
  }) = EmbededTabScheme;

  factory BottomMenuTabScheme.fromJson(Map<String, dynamic> json) => BottomMenuTabSchemeParser.fromJson(json);

  @override
  Map<String, dynamic> toJson() => BottomMenuTabSchemeParser.toJson(this);
}

@freezed
class AppConfigSettings with _$AppConfigSettings {
  const AppConfigSettings._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigSettings({
    @Default([]) List<AppConfigSettingsSection> sections,
  }) = _AppConfigSettings;

  factory AppConfigSettings.fromJson(Map<String, dynamic> json) => _$AppConfigSettingsFromJson(json);
}

@freezed
class AppConfigSettingsSection with _$AppConfigSettingsSection {
  const AppConfigSettingsSection._();

  @JsonSerializable(explicitToJson: true)
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

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigSettingsItem({
    @Default(true) bool enabled,
    required String titleL10n,
    required String type,
    required String icon,
    EmbeddedData? embeddedData,
  }) = _AppConfigSettingsItem;

  factory AppConfigSettingsItem.fromJson(Map<String, dynamic> json) => _$AppConfigSettingsItemFromJson(json);
}

@freezed
class EmbeddedData with _$EmbeddedData {
  const EmbeddedData._();

  @JsonSerializable(explicitToJson: true)
  const factory EmbeddedData({
    int? id,
    @UriConverter() required Uri resource,
    @Default({}) Map<String, dynamic> attributes,
    @Default(ToolbarConfig()) ToolbarConfig toolbar,
    @Default(Metadata()) Metadata metadata,
  }) = _EmbeddedData;

  factory EmbeddedData.fromJson(Map<String, dynamic> json) => _$EmbeddedDataFromJson(json);

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataResourceUrl = 'resourceUrl';
}

@freezed
class ToolbarConfig with _$ToolbarConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ToolbarConfig({
    String? titleL10n,
    @Default(false) bool showToolbar,
  }) = _ToolbarConfig;

  factory ToolbarConfig.fromJson(Map<String, dynamic> json) => _$ToolbarConfigFromJson(json);
}
