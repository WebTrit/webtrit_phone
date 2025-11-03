import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_appearance_theme/converters/converters.dart';

import 'embedded_resource.dart';

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
    @Default([]) List<EmbeddedResource> embeddedResources,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);
}

@freezed
class AppConfigLogin with _$AppConfigLogin {
  const AppConfigLogin._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigLogin({
    @Default(AppConfigLoginCommon()) AppConfigLoginCommon common,
    @Default(AppConfigLoginModeSelect()) AppConfigLoginModeSelect modeSelect,
  }) = _AppConfigLogin;

  factory AppConfigLogin.fromJson(Map<String, dynamic> json) => _$AppConfigLoginFromJson(json);
}

@freezed
class AppConfigLoginCommon with _$AppConfigLoginCommon {
  const AppConfigLoginCommon._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigLoginCommon({
    String? fullScreenLaunchEmbeddedResourceId,
  }) = _AppConfigLoginCommon;

  factory AppConfigLoginCommon.fromJson(Map<String, dynamic> json) => _$AppConfigLoginCommonFromJson(json);
}

@freezed
class AppConfigLoginModeSelect with _$AppConfigLoginModeSelect {
  const AppConfigLoginModeSelect._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigLoginModeSelect({
    String? greetingL10n,
    @Default([
      AppConfigModeSelectAction(
        enabled: true,
        type: 'login',
        titleL10n: 'login_Button_signUpToDemoInstance',
      )
    ])
    List<AppConfigModeSelectAction> actions,
  }) = _AppConfigLoginModeSelect;

  factory AppConfigLoginModeSelect.fromJson(Map<String, dynamic> json) => _$AppConfigLoginModeSelectFromJson(json);
}

@freezed
class AppConfigModeSelectAction with _$AppConfigModeSelectAction {
  const AppConfigModeSelectAction._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigModeSelectAction({
    required bool enabled,
    required String type,
    required String titleL10n,
    String? embeddedId,
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
        FavoritesTabScheme(
          enabled: true,
          initial: false,
          titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
          icon: '0xe5fd',
        ),
        RecentsTabScheme(
          enabled: false,
          initial: false,
          titleL10n: 'main_BottomNavigationBarItemLabel_recents',
          icon: '0xe03a',
          useCdrs: false,
        ),
        ContactsTabScheme(
          enabled: true,
          initial: false,
          titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
          icon: '0xee35',
          contactSourceTypes: ['local', 'external'],
        ),
        KeypadTabScheme(
          enabled: true,
          initial: true,
          titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
          icon: '0xe1ce',
        ),
        MessagingTabScheme(
          enabled: false,
          initial: false,
          titleL10n: 'main_BottomNavigationBarItemLabel_chats',
          icon: '0xe155',
        )
      ]),
    )
    AppConfigBottomMenu bottomMenu,
    @Default(true) bool systemNotificationsEnabled,
    @Default(false) bool sipPresenceEnabled,
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
    @Default(AppConfigEncoding()) AppConfigEncoding encoding,
    @Default(AppConfigPeerConnection()) AppConfigPeerConnection peerConnection,
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
class AppConfigEncoding with _$AppConfigEncoding {
  const AppConfigEncoding._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigEncoding({
    @Default(false) bool bypassConfig,
    @Default(EncodingDefaultPresetOverride()) EncodingDefaultPresetOverride defaultPresetOverride,
  }) = _AppConfigEncoding;

  factory AppConfigEncoding.fromJson(Map<String, dynamic> json) => _$AppConfigEncodingFromJson(json);
}

@freezed
class AppConfigPeerConnection with _$AppConfigPeerConnection {
  const AppConfigPeerConnection._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigPeerConnection({
    @Default(AppConfigNegotiationSettingsOverride()) AppConfigNegotiationSettingsOverride negotiation,
  }) = _AppConfigPeerConnection;

  factory AppConfigPeerConnection.fromJson(Map<String, dynamic> json) => _$AppConfigPeerConnectionFromJson(json);
}

@freezed
class AppConfigNegotiationSettingsOverride with _$AppConfigNegotiationSettingsOverride {
  const AppConfigNegotiationSettingsOverride._();

  @JsonSerializable(explicitToJson: true)
  const factory AppConfigNegotiationSettingsOverride({
    @Default(false) bool includeInactiveVideoInOfferAnswer,
  }) = _AppConfigNegotiationSettingsOverride;

  factory AppConfigNegotiationSettingsOverride.fromJson(Map<String, dynamic> json) =>
      _$AppConfigNegotiationSettingsOverrideFromJson(json);
}

@freezed
class EncodingDefaultPresetOverride with _$EncodingDefaultPresetOverride {
  const EncodingDefaultPresetOverride._();

  @JsonSerializable(explicitToJson: true)
  const factory EncodingDefaultPresetOverride({
    int? audioBitrate,
    int? videoBitrate,
    int? ptime,
    int? maxptime,
    int? opusSamplingRate,
    int? opusBitrate,
    bool? opusStereo,
    bool? opusDtx,
    bool? removeExtmaps,
    bool? removeStaticAudioRtpMaps,
    bool? remapTE8payloadTo101,
  }) = _EncodingDefaultPresetOverride;

  factory EncodingDefaultPresetOverride.fromJson(Map<String, dynamic> json) =>
      _$EncodingDefaultPresetOverrideFromJson(json);
}

@Freezed(unionKey: 'type')
class BottomMenuTabScheme with _$BottomMenuTabScheme {
  const BottomMenuTabScheme._();

  @JsonSerializable(explicitToJson: true)
  const factory BottomMenuTabScheme.favorites({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    required String titleL10n,
    required String icon,
  }) = FavoritesTabScheme;

  @JsonSerializable(explicitToJson: true)
  const factory BottomMenuTabScheme.recents({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    required String titleL10n,
    required String icon,
    @Default(false) bool useCdrs,
  }) = RecentsTabScheme;

  @JsonSerializable(explicitToJson: true)
  const factory BottomMenuTabScheme.contacts({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    required String titleL10n,
    required String icon,
    @Default(<String>[]) List<String> contactSourceTypes,
  }) = ContactsTabScheme;

  @JsonSerializable(explicitToJson: true)
  const factory BottomMenuTabScheme.keypad({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    required String titleL10n,
    required String icon,
  }) = KeypadTabScheme;

  @JsonSerializable(explicitToJson: true)
  const factory BottomMenuTabScheme.messaging({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    required String titleL10n,
    required String icon,
  }) = MessagingTabScheme;

  @JsonSerializable(explicitToJson: true)
  const factory BottomMenuTabScheme.embedded({
    @Default(true) bool enabled,
    @Default(false) bool initial,
    required String titleL10n,
    required String icon,
    @IntToStringConverter() required String embeddedResourceId,
  }) = EmbeddedTabScheme;

  factory BottomMenuTabScheme.fromJson(Map<String, dynamic> json) => _$BottomMenuTabSchemeFromJson(json);
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
            type: 'mediaSettings',
            titleL10n: 'settings_ListViewTileTitle_mediaSettings',
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
            embeddedResourceId: '0',
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

    /// TODO: Migration workaround - accepts both int and string IDs.
    /// Remove [IntToStringConverter] once all JSONs use string IDs only.
    @IntToStringOptionalConverter() String? embeddedResourceId,
  }) = _AppConfigSettingsItem;

  factory AppConfigSettingsItem.fromJson(Map<String, dynamic> json) => _$AppConfigSettingsItemFromJson(json);
}
