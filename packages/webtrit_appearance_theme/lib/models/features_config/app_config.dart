import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webtrit_appearance_theme/converters/converters.dart';

part 'app_config.freezed.dart';

part 'app_config.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfig with _$AppConfig {
  const AppConfig({
    this.loginConfig = const AppConfigLogin(),
    this.mainConfig = const AppConfigMain(),
    this.settingsConfig = const AppConfigSettings(),
    this.callConfig = const AppConfigCall(),
    this.contacts = const AppConfigContacts(),
  });

  @override
  final AppConfigLogin loginConfig;

  @override
  final AppConfigMain mainConfig;

  @override
  final AppConfigSettings settingsConfig;

  @override
  final AppConfigCall callConfig;

  @override
  final AppConfigContacts contacts;

  factory AppConfig.fromJson(Map<String, Object?> json) => _$AppConfigFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigLogin with _$AppConfigLogin {
  const AppConfigLogin({
    this.common = const AppConfigLoginCommon(),
    this.modeSelect = const AppConfigLoginModeSelect(),
  });

  @override
  final AppConfigLoginCommon common;

  @override
  final AppConfigLoginModeSelect modeSelect;

  factory AppConfigLogin.fromJson(Map<String, Object?> json) => _$AppConfigLoginFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigLoginToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigLoginCommon with _$AppConfigLoginCommon {
  const AppConfigLoginCommon({this.fullScreenLaunchEmbeddedResourceId});

  @override
  final String? fullScreenLaunchEmbeddedResourceId;

  factory AppConfigLoginCommon.fromJson(Map<String, Object?> json) => _$AppConfigLoginCommonFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigLoginCommonToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigLoginModeSelect with _$AppConfigLoginModeSelect {
  const AppConfigLoginModeSelect({
    this.greetingL10n,
    this.actions = const [
      AppConfigModeSelectAction(enabled: true, type: 'login', titleL10n: 'login_Button_signUpToDemoInstance'),
    ],
  });

  @override
  final String? greetingL10n;

  @override
  final List<AppConfigModeSelectAction> actions;

  factory AppConfigLoginModeSelect.fromJson(Map<String, Object?> json) => _$AppConfigLoginModeSelectFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigLoginModeSelectToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigModeSelectAction with _$AppConfigModeSelectAction {
  const AppConfigModeSelectAction({
    required this.enabled,
    required this.type,
    required this.titleL10n,
    this.embeddedId,
  });

  @override
  final bool enabled;

  @override
  final String type;

  @override
  final String titleL10n;

  @override
  final String? embeddedId;

  factory AppConfigModeSelectAction.fromJson(Map<String, Object?> json) => _$AppConfigModeSelectActionFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigModeSelectActionToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigMain with _$AppConfigMain {
  const AppConfigMain({
    this.bottomMenu = const AppConfigBottomMenu(
      cacheSelectedTab: true,
      tabs: [
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
        ),
      ],
    ),
    this.systemNotificationsEnabled = true,
    this.sipPresenceEnabled = false,
  });

  @override
  final AppConfigBottomMenu bottomMenu;

  @override
  final bool systemNotificationsEnabled;

  @override
  final bool sipPresenceEnabled;

  factory AppConfigMain.fromJson(Map<String, Object?> json) => _$AppConfigMainFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigMainToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigBottomMenu with _$AppConfigBottomMenu {
  const AppConfigBottomMenu({this.cacheSelectedTab = true, this.tabs = const []});

  @override
  final bool cacheSelectedTab;

  @override
  final List<BottomMenuTabScheme> tabs;

  factory AppConfigBottomMenu.fromJson(Map<String, Object?> json) => _$AppConfigBottomMenuFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigBottomMenuToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigCall with _$AppConfigCall {
  const AppConfigCall({
    this.videoEnabled = true,
    this.transfer = const AppConfigTransfer(enableBlindTransfer: true, enableAttendedTransfer: true),
    this.encoding = const AppConfigEncoding(),
    this.peerConnection = const AppConfigPeerConnection(),
  });

  @override
  final bool videoEnabled;

  @override
  final AppConfigTransfer transfer;

  @override
  final AppConfigEncoding encoding;

  @override
  final AppConfigPeerConnection peerConnection;

  factory AppConfigCall.fromJson(Map<String, Object?> json) => _$AppConfigCallFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigCallToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigTransfer with _$AppConfigTransfer {
  const AppConfigTransfer({this.enableBlindTransfer = true, this.enableAttendedTransfer = true});

  @override
  final bool enableBlindTransfer;

  @override
  final bool enableAttendedTransfer;

  factory AppConfigTransfer.fromJson(Map<String, Object?> json) => _$AppConfigTransferFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigTransferToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigEncoding with _$AppConfigEncoding {
  const AppConfigEncoding({
    this.bypassConfig = false,
    this.defaultPresetOverride = const EncodingDefaultPresetOverride(),
  });

  @override
  final bool bypassConfig;

  @override
  final EncodingDefaultPresetOverride defaultPresetOverride;

  factory AppConfigEncoding.fromJson(Map<String, Object?> json) => _$AppConfigEncodingFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigEncodingToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigPeerConnection with _$AppConfigPeerConnection {
  const AppConfigPeerConnection({this.negotiation = const AppConfigNegotiationSettingsOverride()});

  @override
  final AppConfigNegotiationSettingsOverride negotiation;

  factory AppConfigPeerConnection.fromJson(Map<String, Object?> json) => _$AppConfigPeerConnectionFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigPeerConnectionToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigNegotiationSettingsOverride with _$AppConfigNegotiationSettingsOverride {
  const AppConfigNegotiationSettingsOverride({this.includeInactiveVideoInOfferAnswer = false});

  @override
  final bool includeInactiveVideoInOfferAnswer;

  factory AppConfigNegotiationSettingsOverride.fromJson(Map<String, Object?> json) =>
      _$AppConfigNegotiationSettingsOverrideFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigNegotiationSettingsOverrideToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class EncodingDefaultPresetOverride with _$EncodingDefaultPresetOverride {
  const EncodingDefaultPresetOverride({
    this.audioBitrate,
    this.videoBitrate,
    this.ptime,
    this.maxptime,
    this.opusSamplingRate,
    this.opusBitrate,
    this.opusStereo,
    this.opusDtx,
    this.removeExtmaps,
    this.removeStaticAudioRtpMaps,
    this.remapTE8payloadTo101,
  });

  @override
  final int? audioBitrate;

  @override
  final int? videoBitrate;

  @override
  final int? ptime;

  @override
  final int? maxptime;

  @override
  final int? opusSamplingRate;

  @override
  final int? opusBitrate;

  @override
  final bool? opusStereo;

  @override
  final bool? opusDtx;

  @override
  final bool? removeExtmaps;

  @override
  final bool? removeStaticAudioRtpMaps;

  @override
  final bool? remapTE8payloadTo101;

  factory EncodingDefaultPresetOverride.fromJson(Map<String, Object?> json) =>
      _$EncodingDefaultPresetOverrideFromJson(json);

  Map<String, Object?> toJson() => _$EncodingDefaultPresetOverrideToJson(this);
}

@Freezed(unionKey: 'type')
sealed class BottomMenuTabScheme with _$BottomMenuTabScheme {
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
@JsonSerializable(explicitToJson: true)
class AppConfigSettings with _$AppConfigSettings {
  const AppConfigSettings({
    this.sections = const [
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
    ],
  });

  @override
  final List<AppConfigSettingsSection> sections;

  factory AppConfigSettings.fromJson(Map<String, Object?> json) => _$AppConfigSettingsFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigSettingsToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigSettingsSection with _$AppConfigSettingsSection {
  const AppConfigSettingsSection({required this.titleL10n, this.enabled = true, this.items = const []});

  @override
  final String titleL10n;

  @override
  final bool enabled;

  @override
  final List<AppConfigSettingsItem> items;

  factory AppConfigSettingsSection.fromJson(Map<String, Object?> json) => _$AppConfigSettingsSectionFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigSettingsSectionToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigSettingsItem with _$AppConfigSettingsItem {
  const AppConfigSettingsItem({
    this.enabled = true,
    required this.titleL10n,
    required this.type,
    required this.icon,

    /// TODO: Migration workaround - accepts both int and string IDs.
    /// Remove [IntToStringConverter] once all JSONs use string IDs only.
    @IntToStringOptionalConverter() this.embeddedResourceId,
  });

  @override
  final bool enabled;

  @override
  final String titleL10n;

  @override
  final String type;

  @override
  final String icon;

  @override
  @IntToStringOptionalConverter()
  final String? embeddedResourceId;

  factory AppConfigSettingsItem.fromJson(Map<String, Object?> json) => _$AppConfigSettingsItemFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigSettingsItemToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigContacts with _$AppConfigContacts {
  const AppConfigContacts({this.list = const AppConfigContactList(), this.details = const AppConfigContactDetails()});

  @override
  final AppConfigContactList list;

  @override
  final AppConfigContactDetails details;

  factory AppConfigContacts.fromJson(Map<String, Object?> json) => _$AppConfigContactsFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigContactsToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigContactList with _$AppConfigContactList {
  const AppConfigContactList();

  factory AppConfigContactList.fromJson(Map<String, Object?> json) => _$AppConfigContactListFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigContactListToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigContactDetails with _$AppConfigContactDetails {
  const AppConfigContactDetails({this.actions = const AppConfigContactDetailsActions()});

  @override
  final AppConfigContactDetailsActions actions;

  factory AppConfigContactDetails.fromJson(Map<String, Object?> json) => _$AppConfigContactDetailsFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigContactDetailsToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigContactDetailsActions with _$AppConfigContactDetailsActions {
  const AppConfigContactDetailsActions({this.appBar, this.phoneTile, this.emailTile});

  @override
  final List<String>? appBar;

  @override
  final List<String>? phoneTile;

  @override
  final List<String>? emailTile;

  factory AppConfigContactDetailsActions.fromJson(Map<String, Object?> json) =>
      _$AppConfigContactDetailsActionsFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigContactDetailsActionsToJson(this);
}
