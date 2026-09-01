import 'package:freezed_annotation/freezed_annotation.dart';

import '../pages/page_background.dart';

import 'supported_feature.dart';

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
    this.messaging = const AppConfigMessaging(),
    this.localization = const AppConfigLocalization(),

    /// List of enabled features and global app configurations.
    this.supported = const [],
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

  @override
  final AppConfigMessaging messaging;

  @override
  final AppConfigLocalization localization;

  @override
  final List<SupportedFeature> supported;

  factory AppConfig.fromJson(Map<String, Object?> json) => _$AppConfigFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigLogin with _$AppConfigLogin {
  const AppConfigLogin({
    this.common = const AppConfigLoginCommon(),
    this.modeSelect = const AppConfigLoginModeSelect(),
    // Empty, for the reason above. `signinOrderOrDefault` names what it was.
    this.signinOrder = const [],
    this.qr = const AppConfigLoginQr(),
  });

  @override
  final AppConfigLoginCommon common;

  @override
  final AppConfigLoginModeSelect modeSelect;

  /// Order of the sign-in tabs on the login switch screen, by login type name
  /// (passwordSignin, otpSignin, signup, qrSignin). Only the types advertised by
  /// the backend are shown; this controls their order and which one is selected
  /// by default. Unknown or omitted names are placed last.
  @override
  final List<String> signinOrder;

  /// The order the sign-in methods are offered in.
  ///
  /// A config that names none gets the order it used to be given. Resolved
  /// here rather than in the constructor, so no document carries an order
  /// nobody wrote and the published schema stays free of a collection default.
  List<String> get signinOrderOrDefault =>
      signinOrder.isNotEmpty ? signinOrder : const ['passwordSignin', 'otpSignin', 'signup'];

  @override
  final AppConfigLoginQr qr;

  factory AppConfigLogin.fromJson(Map<String, Object?> json) => _$AppConfigLoginFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigLoginToJson(this);
}

/// Configuration of the QR-code sign-in tab.
///
/// The QR code carries plain credentials in a provisioning URI (for example
/// `csc:username:password@EXAMPLE` with percent-encoded segments); scanning it
/// signs the user in through the regular password login. The tab appears only
/// when [enabled] is true and the backend supports password sign-in; its
/// position among the other tabs follows [AppConfigLogin.signinOrder].
@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigLoginQr with _$AppConfigLoginQr {
  const AppConfigLoginQr({
    this.enabled = false,
    // Empty, for the reason every collection default here is: a non-empty one
    // crashes the schema generator. What it used to name is `qrFormats` below.
    this.formats = const [],
    this.expectedHost,
  });

  /// Whether the QR-code sign-in tab is available at all.
  @override
  final bool enabled;

  /// Accepted payload formats with their per-format options, probed in this
  /// order.
  @override
  final List<AppConfigLoginQrFormat> formats;

  /// The payload formats to probe, in order.
  ///
  /// A config that names none gets the two it used to be given: a `csc` URI
  /// and a bare JSON payload. Resolved here rather than in the constructor, so
  /// no document carries formats nobody wrote.
  List<AppConfigLoginQrFormat> get qrFormats => formats.isNotEmpty
      ? formats
      : const [
          AppConfigLoginQrFormat(type: 'uri', schemes: ['csc']),
          AppConfigLoginQrFormat(type: 'json'),
        ];

  /// Expected host (cloud id) of the code, shared by all formats. When set,
  /// codes issued for a different host are rejected; null accepts any host.
  @override
  final String? expectedHost;

  factory AppConfigLoginQr.fromJson(Map<String, Object?> json) => _$AppConfigLoginQrFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigLoginQrToJson(this);
}

/// One accepted QR payload format and its format-specific options.
@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigLoginQrFormat with _$AppConfigLoginQrFormat {
  const AppConfigLoginQrFormat({required this.type, this.schemes});

  /// Decoder name (`uri`, `json`).
  @override
  final String type;

  /// `uri` only: accepted scheme names, matched case-insensitively.
  @override
  final List<String>? schemes;

  factory AppConfigLoginQrFormat.fromJson(Map<String, Object?> json) => _$AppConfigLoginQrFormatFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigLoginQrFormatToJson(this);
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
    // Empty rather than one login button, for the reason `stops` carries
    // none: a non-empty collection default crashes the schema generator. The
    // button it used to name is supplied by `modeSelectActions` below, which
    // is where every reader already goes.
    this.actions = const [],
  });

  @override
  final String? greetingL10n;

  @override
  final List<AppConfigModeSelectAction> actions;

  /// The buttons the mode-select screen offers.
  ///
  /// A config that names none gets the one it used to be given by default:
  /// signing in. Resolved here rather than in the constructor, so no document
  /// carries a button nobody wrote and the published schema stays free of a
  /// collection default.
  List<AppConfigModeSelectAction> get modeSelectActions => actions.isNotEmpty
      ? actions
      : const [AppConfigModeSelectAction(enabled: true, type: 'login', titleL10n: 'login_Button_signUpToDemoInstance')];

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
          supportsCallHistory: true,
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
  });

  @override
  final AppConfigBottomMenu bottomMenu;

  @override
  @Deprecated('Use SupportedFeature.systemNotifications instead')
  final bool systemNotificationsEnabled;

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
    this.removeStaticAudioRtpMaps,
    this.remapTE8payloadTo101,
    this.removeREMBFeedback,
    this.removeTWCCFeedback,
    this.removeExtmaps,
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
  final bool? removeStaticAudioRtpMaps;

  @override
  final bool? remapTE8payloadTo101;

  @override
  final bool? removeREMBFeedback;

  @override
  final bool? removeTWCCFeedback;

  @override
  final List<String>? removeExtmaps;

  factory EncodingDefaultPresetOverride.fromJson(Map<String, Object?> json) =>
      _$EncodingDefaultPresetOverrideFromJson(json);

  Map<String, Object?> toJson() => _$EncodingDefaultPresetOverrideToJson(this);
}

// Migration shim for the recents tab call-history flag: prefer the current
// `supportsCallHistory` key (when present, even if null), fall back to the
// legacy `useCdrs` key, then let the field default apply when neither is present.
Object? _readRecentsSupportsCallHistory(Map json, String key) => json.containsKey(key) ? json[key] : json['useCdrs'];

/// How the contacts section arranges what it shows.
enum ContactsLayoutScheme {
  /// Each address book is a tab of its own, and favourites are a section
  /// elsewhere in the bottom bar.
  @JsonValue('tabbed')
  tabbed,

  /// One list at a time. A chooser on the line under the title says which:
  /// each address book, and - where [ContactsTabScheme.favorites] is on - the
  /// favourites, as one more entry of that same control.
  @JsonValue('unified')
  unified,
}

/// One tab of the bottom bar.
///
/// Written as a sealed base with a class per tab rather than as a freezed union
/// - see [PageBackground] for why. A new tab needs a redirecting factory and a
/// `fromJson` branch; the schema follows on its own.
sealed class BottomMenuTabScheme {
  const BottomMenuTabScheme();

  const factory BottomMenuTabScheme.favorites({
    bool enabled,
    bool initial,
    required String titleL10n,
    required String icon,
    String type,
  }) = FavoritesTabScheme;

  const factory BottomMenuTabScheme.recents({
    bool enabled,
    bool initial,
    required String titleL10n,
    required String icon,
    bool supportsCallHistory,
    String type,
  }) = RecentsTabScheme;

  const factory BottomMenuTabScheme.contacts({
    bool enabled,
    bool initial,
    required String titleL10n,
    required String icon,
    List<String> contactSourceTypes,
    ContactsLayoutScheme layout,
    bool favorites,
    String type,
  }) = ContactsTabScheme;

  const factory BottomMenuTabScheme.keypad({
    bool enabled,
    bool initial,
    required String titleL10n,
    required String icon,
    String type,
  }) = KeypadTabScheme;

  const factory BottomMenuTabScheme.messaging({
    bool enabled,
    bool initial,
    required String titleL10n,
    required String icon,
    String type,
  }) = MessagingTabScheme;

  const factory BottomMenuTabScheme.voicemail({
    bool enabled,
    bool initial,
    required String titleL10n,
    required String icon,
    String type,
  }) = VoicemailTabScheme;

  const factory BottomMenuTabScheme.embedded({
    bool enabled,
    bool initial,
    required String titleL10n,
    required String icon,
    required String embeddedResourceId,
    String type,
  }) = EmbeddedTabScheme;

  factory BottomMenuTabScheme.fromJson(Map<String, Object?> json) => switch (json['type']) {
    'favorites' => FavoritesTabScheme.fromJson(json),
    'recents' => RecentsTabScheme.fromJson(json),
    'contacts' => ContactsTabScheme.fromJson(json),
    'keypad' => KeypadTabScheme.fromJson(json),
    'messaging' => MessagingTabScheme.fromJson(json),
    'voicemail' => VoicemailTabScheme.fromJson(json),
    'embedded' => EmbeddedTabScheme.fromJson(json),
    final unknown => throw CheckedFromJsonException(
      json,
      'type',
      'BottomMenuTabScheme',
      'Invalid union type "$unknown"!',
    ),
  };

  /// Whether the tab is shown at all.
  bool get enabled;

  /// Whether the app opens on this tab.
  bool get initial;

  /// The l10n key of the tab's title.
  String get titleL10n;

  /// The tab's icon, as a code point.
  String get icon;

  /// The discriminator: which tab this is.
  String get type;

  Map<String, Object?> toJson();
}

/// The favourites tab.
@freezed
@JsonSerializable(explicitToJson: true)
class FavoritesTabScheme extends BottomMenuTabScheme with _$FavoritesTabScheme {
  const FavoritesTabScheme({
    this.enabled = true,
    this.initial = false,
    required this.titleL10n,
    required this.icon,
    this.type = 'favorites',
  });

  @override
  final bool enabled;

  @override
  final bool initial;

  @override
  final String titleL10n;

  @override
  final String icon;

  /// The discriminator. Always `favorites`.
  @override
  final String type;

  factory FavoritesTabScheme.fromJson(Map<String, Object?> json) => _$FavoritesTabSchemeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$FavoritesTabSchemeToJson(this);
}

/// The recents tab.
@freezed
@JsonSerializable(explicitToJson: true)
class RecentsTabScheme extends BottomMenuTabScheme with _$RecentsTabScheme {
  const RecentsTabScheme({
    this.enabled = true,
    this.initial = false,
    required this.titleL10n,
    required this.icon,
    this.supportsCallHistory = true,
    this.type = 'recents',
  });

  @override
  final bool enabled;

  @override
  final bool initial;

  @override
  final String titleL10n;

  @override
  final String icon;

  /// Local opt-in for remote call history (CDRs). Resolved against the server
  /// `callHistory` adapter capability in feature_access - both must be true.
  ///
  /// Reads the `supportsCallHistory` key and falls back to the legacy `useCdrs`
  /// key so existing configs keep their value.
  @JsonKey(readValue: _readRecentsSupportsCallHistory)
  @override
  final bool supportsCallHistory;

  /// The discriminator. Always `recents`.
  @override
  final String type;

  factory RecentsTabScheme.fromJson(Map<String, Object?> json) => _$RecentsTabSchemeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$RecentsTabSchemeToJson(this);
}

/// The contacts tab.
@freezed
@JsonSerializable(explicitToJson: true)
class ContactsTabScheme extends BottomMenuTabScheme with _$ContactsTabScheme {
  const ContactsTabScheme({
    this.enabled = true,
    this.initial = false,
    required this.titleL10n,
    required this.icon,
    this.contactSourceTypes = const <String>[],
    this.layout = ContactsLayoutScheme.tabbed,
    this.favorites = true,
    this.type = 'contacts',
  });

  @override
  final bool enabled;

  @override
  final bool initial;

  @override
  final String titleL10n;

  @override
  final String icon;

  @override
  final List<String> contactSourceTypes;

  /// How the section is arranged. A deployment that says nothing keeps the
  /// arrangement it already has.
  ///
  /// Read leniently: a configurator may offer an arrangement before an
  /// installed app knows how to draw it, and such a build has to fall back
  /// to the one it does know rather than fail to read its own settings.
  @JsonKey(unknownEnumValue: ContactsLayoutScheme.tabbed)
  @override
  final ContactsLayoutScheme layout;

  /// Whether the favourites are one of the lists the chooser offers.
  ///
  /// The list behind that entry is the favourites section's own - the same
  /// rows, in the order a person arranged them - not this section's list
  /// narrowed down. Read only where the arrangement has a chooser, which is
  /// the unified one; on by default, because a deployment picking that
  /// arrangement is picking the one favourites live in.
  @override
  final bool favorites;

  /// The discriminator. Always `contacts`.
  @override
  final String type;

  factory ContactsTabScheme.fromJson(Map<String, Object?> json) => _$ContactsTabSchemeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$ContactsTabSchemeToJson(this);
}

/// The keypad tab.
@freezed
@JsonSerializable(explicitToJson: true)
class KeypadTabScheme extends BottomMenuTabScheme with _$KeypadTabScheme {
  const KeypadTabScheme({
    this.enabled = true,
    this.initial = false,
    required this.titleL10n,
    required this.icon,
    this.type = 'keypad',
  });

  @override
  final bool enabled;

  @override
  final bool initial;

  @override
  final String titleL10n;

  @override
  final String icon;

  /// The discriminator. Always `keypad`.
  @override
  final String type;

  factory KeypadTabScheme.fromJson(Map<String, Object?> json) => _$KeypadTabSchemeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$KeypadTabSchemeToJson(this);
}

/// The messaging tab.
@freezed
@JsonSerializable(explicitToJson: true)
class MessagingTabScheme extends BottomMenuTabScheme with _$MessagingTabScheme {
  const MessagingTabScheme({
    this.enabled = true,
    this.initial = false,
    required this.titleL10n,
    required this.icon,
    this.type = 'messaging',
  });

  @override
  final bool enabled;

  @override
  final bool initial;

  @override
  final String titleL10n;

  @override
  final String icon;

  /// The discriminator. Always `messaging`.
  @override
  final String type;

  factory MessagingTabScheme.fromJson(Map<String, Object?> json) => _$MessagingTabSchemeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$MessagingTabSchemeToJson(this);
}

/// The voicemail tab.
@freezed
@JsonSerializable(explicitToJson: true)
class VoicemailTabScheme extends BottomMenuTabScheme with _$VoicemailTabScheme {
  const VoicemailTabScheme({
    this.enabled = true,
    this.initial = false,
    required this.titleL10n,
    required this.icon,
    this.type = 'voicemail',
  });

  @override
  final bool enabled;

  @override
  final bool initial;

  @override
  final String titleL10n;

  @override
  final String icon;

  /// The discriminator. Always `voicemail`.
  @override
  final String type;

  factory VoicemailTabScheme.fromJson(Map<String, Object?> json) => _$VoicemailTabSchemeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$VoicemailTabSchemeToJson(this);
}

/// A tab showing an embedded resource.
@freezed
@JsonSerializable(explicitToJson: true)
class EmbeddedTabScheme extends BottomMenuTabScheme with _$EmbeddedTabScheme {
  const EmbeddedTabScheme({
    this.enabled = true,
    this.initial = false,
    required this.titleL10n,
    required this.icon,
    required this.embeddedResourceId,
    this.type = 'embedded',
  });

  @override
  final bool enabled;

  @override
  final bool initial;

  @override
  final String titleL10n;

  @override
  final String icon;

  /// Names the [EmbeddedResource] this tab shows.
  @override
  final String embeddedResourceId;

  /// The discriminator. Always `embedded`.
  @override
  final String type;

  factory EmbeddedTabScheme.fromJson(Map<String, Object?> json) => _$EmbeddedTabSchemeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$EmbeddedTabSchemeToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigSettings with _$AppConfigSettings {
  const AppConfigSettings({
    // Empty, for the reason every collection default here is: a non-empty one
    // crashes the schema generator. What it used to name is `settingsSections`
    // below, which is where the reader already goes.
    this.sections = const [],
  });

  @override
  final List<AppConfigSettingsSection> sections;

  /// The settings screen's sections.
  ///
  /// A config that names none gets the ones it used to be given. Resolved here
  /// rather than in the constructor, so no document carries a section nobody
  /// wrote and the published schema stays free of a collection default.
  List<AppConfigSettingsSection> get settingsSections => sections.isNotEmpty ? sections : _defaultSections;

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
    // TODO: Separate UI configuration from logical configuration.
    // Move UI-only fields (e.g., `icon`, `iconColor`) into a dedicated UI/widget config so core config remains behavior/data focused.
    required this.icon,
    // Optional hex color string for the icon (e.g., '#RRGGBB'). Consider moving to UI config.
    this.iconColor,

    this.embeddedResourceId,
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
  final String? iconColor;

  @override
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

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigMessaging with _$AppConfigMessaging {
  const AppConfigMessaging({this.sms = const AppConfigSms(), this.chats = const AppConfigChats()});

  @override
  final AppConfigSms sms;

  @override
  final AppConfigChats chats;

  factory AppConfigMessaging.fromJson(Map<String, Object?> json) => _$AppConfigMessagingFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigMessagingToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigSms with _$AppConfigSms {
  const AppConfigSms();

  factory AppConfigSms.fromJson(Map<String, Object?> json) => _$AppConfigSmsFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigSmsToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigChats with _$AppConfigChats {
  const AppConfigChats({this.groupChatButtonEnabled = true, this.contactInfo = const ChatContactInfo()});

  @override
  final bool groupChatButtonEnabled;

  @override
  final ChatContactInfo contactInfo;

  factory AppConfigChats.fromJson(Map<String, Object?> json) => _$AppConfigChatsFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigChatsToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ChatContactInfo with _$ChatContactInfo {
  const ChatContactInfo({this.showVideoButtonAction = true});

  @override
  final bool showVideoButtonAction;

  factory ChatContactInfo.fromJson(Map<String, Object?> json) => _$ChatContactInfoFromJson(json);

  Map<String, Object?> toJson() => _$ChatContactInfoToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppConfigLocalization with _$AppConfigLocalization {
  const AppConfigLocalization({this.enabledLanguages = const []});

  /// Allowlist of language codes (ISO 639-1, e.g. 'en', 'it') the app exposes.
  /// The app intersects this with the locales it actually bundles, so only
  /// languages present in both are selectable and used for auto-resolution.
  /// An empty list (the default) means "no restriction" - all bundled locales
  /// are available, preserving the previous behavior.
  @override
  final List<String> enabledLanguages;

  factory AppConfigLocalization.fromJson(Map<String, Object?> json) => _$AppConfigLocalizationFromJson(json);

  Map<String, Object?> toJson() => _$AppConfigLocalizationToJson(this);
}

const _defaultSections = [
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
];
