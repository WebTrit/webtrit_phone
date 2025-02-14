import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_appearance_theme/converters/converters.dart';
import 'package:webtrit_appearance_theme/parsers/parsers.dart';

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
    @Default([
      AppConfigModeSelectAction(
        enabled: true,
        type: 'login',
        titleL10n: 'login_Button_signUpToDemoInstance',
      )
    ])
    List<AppConfigModeSelectAction> modeSelectActions,
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
    @Default(
      AppConfigBottomMenu(cacheSelectedTab: true, tabs: [
        BaseTabScheme(
          enabled: true,
          initial: false,
          type: BottomMenuTabType.favorites,
          titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
          icon: '0xe5fd',
        ),
        BaseTabScheme(
          enabled: true,
          initial: false,
          type: BottomMenuTabType.recents,
          titleL10n: 'main_BottomNavigationBarItemLabel_recents',
          icon: '0xe03a',
        ),
        ContactsTabScheme(
          enabled: true,
          initial: false,
          type: BottomMenuTabType.contacts,
          titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
          icon: '0xee35',
          contactSourceTypes: ['local', 'external'],
        ),
        BaseTabScheme(
          enabled: true,
          initial: true,
          type: BottomMenuTabType.keypad,
          titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
          icon: '0xe1ce',
        ),
        BaseTabScheme(
          enabled: false,
          initial: false,
          type: BottomMenuTabType.messaging,
          titleL10n: 'main_BottomNavigationBarItemLabel_chats',
          icon: '0xe155',
        )
      ]),
    )
    AppConfigBottomMenu bottomMenu,
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
    @Default([
      AppConfigSettingsSection(
        titleL10n: 'settings_ListViewTileTitle_settings',
        enabled: true,
        items: [
          AppConfigSettingsItem(
            enabled: true,
            type: 'network',
            titleL10n: 'settings_ListViewTileTitle_network',
            icon: '0xe424',
          ),
          AppConfigSettingsItem(
            enabled: true,
            type: 'encoding',
            titleL10n: 'settings_ListViewTileTitle_encoding',
            icon: '0xf1cf',
          ),
          AppConfigSettingsItem(
            enabled: true,
            type: 'language',
            titleL10n: 'settings_ListViewTileTitle_language',
            icon: '0xe366',
          ),
          AppConfigSettingsItem(
            enabled: true,
            type: 'terms',
            titleL10n: 'settings_ListViewTileTitle_termsConditions',
            icon: '0xeedf',
            embeddedData: EmbeddedData(
              resource: 'https://webtrit-app.web.app/example/example_embedded_call.html',
              toolbar: ToolbarConfig(
                showToolbar: true,
                titleL10n: 'login_requestCredentials_title',
              ),
            ),
          ),
          AppConfigSettingsItem(
            enabled: true,
            type: 'about',
            titleL10n: 'settings_ListViewTileTitle_about',
            icon: '0xe140',
          ),
        ],
      ),
      AppConfigSettingsSection(
        titleL10n: 'settings_ListViewTileTitle_toolbox',
        enabled: true,
        items: [
          AppConfigSettingsItem(
            enabled: true,
            type: 'log',
            titleL10n: 'settings_ListViewTileTitle_logRecordsConsole',
            icon: '0xee79',
          ),
          AppConfigSettingsItem(
            enabled: true,
            type: 'selfConfig',
            titleL10n: 'settings_ListViewTileTitle_self_config',
            icon: '0xef7a',
          ),
          AppConfigSettingsItem(
            enabled: true,
            type: 'deleteAccount',
            titleL10n: 'settings_ListViewTileTitle_accountDelete',
            icon: '0xe1bb',
          )
        ],
      ),
    ])
    List<AppConfigSettingsSection> sections,
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
    required String resource,
    @Default({}) Map<String, dynamic> attributes,
    @Default(ToolbarConfig()) ToolbarConfig toolbar,
    @Default(Metadata()) Metadata metadata,
  }) = _EmbeddedData;

  factory EmbeddedData.fromJson(Map<String, dynamic> json) => _$EmbeddedDataFromJson(json);

  /// Safely parses `resource` to a `uri`, returning `null` if invalid
  Uri? get uri => Uri.tryParse(resource);

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataResourceUrl = 'resourceUrl';

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataResourceId = 'resourceId';

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataResourceURI = 'resourceURI';
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
