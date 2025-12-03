// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
  loginConfig: json['loginConfig'] == null
      ? const AppConfigLogin()
      : AppConfigLogin.fromJson(json['loginConfig'] as Map<String, dynamic>),
  mainConfig: json['mainConfig'] == null
      ? const AppConfigMain()
      : AppConfigMain.fromJson(json['mainConfig'] as Map<String, dynamic>),
  settingsConfig: json['settingsConfig'] == null
      ? const AppConfigSettings()
      : AppConfigSettings.fromJson(
          json['settingsConfig'] as Map<String, dynamic>,
        ),
  callConfig: json['callConfig'] == null
      ? const AppConfigCall()
      : AppConfigCall.fromJson(json['callConfig'] as Map<String, dynamic>),
  contacts: json['contacts'] == null
      ? const AppConfigContacts()
      : AppConfigContacts.fromJson(json['contacts'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
  'loginConfig': instance.loginConfig.toJson(),
  'mainConfig': instance.mainConfig.toJson(),
  'settingsConfig': instance.settingsConfig.toJson(),
  'callConfig': instance.callConfig.toJson(),
  'contacts': instance.contacts.toJson(),
};

AppConfigLogin _$AppConfigLoginFromJson(Map<String, dynamic> json) =>
    AppConfigLogin(
      common: json['common'] == null
          ? const AppConfigLoginCommon()
          : AppConfigLoginCommon.fromJson(
              json['common'] as Map<String, dynamic>,
            ),
      modeSelect: json['modeSelect'] == null
          ? const AppConfigLoginModeSelect()
          : AppConfigLoginModeSelect.fromJson(
              json['modeSelect'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AppConfigLoginToJson(AppConfigLogin instance) =>
    <String, dynamic>{
      'common': instance.common.toJson(),
      'modeSelect': instance.modeSelect.toJson(),
    };

AppConfigLoginCommon _$AppConfigLoginCommonFromJson(
  Map<String, dynamic> json,
) => AppConfigLoginCommon(
  fullScreenLaunchEmbeddedResourceId:
      json['fullScreenLaunchEmbeddedResourceId'] as String?,
);

Map<String, dynamic> _$AppConfigLoginCommonToJson(
  AppConfigLoginCommon instance,
) => <String, dynamic>{
  'fullScreenLaunchEmbeddedResourceId':
      instance.fullScreenLaunchEmbeddedResourceId,
};

AppConfigLoginModeSelect _$AppConfigLoginModeSelectFromJson(
  Map<String, dynamic> json,
) => AppConfigLoginModeSelect(
  greetingL10n: json['greetingL10n'] as String?,
  actions:
      (json['actions'] as List<dynamic>?)
          ?.map(
            (e) =>
                AppConfigModeSelectAction.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [
        AppConfigModeSelectAction(
          enabled: true,
          type: 'login',
          titleL10n: 'login_Button_signUpToDemoInstance',
        ),
      ],
);

Map<String, dynamic> _$AppConfigLoginModeSelectToJson(
  AppConfigLoginModeSelect instance,
) => <String, dynamic>{
  'greetingL10n': instance.greetingL10n,
  'actions': instance.actions.map((e) => e.toJson()).toList(),
};

AppConfigModeSelectAction _$AppConfigModeSelectActionFromJson(
  Map<String, dynamic> json,
) => AppConfigModeSelectAction(
  enabled: json['enabled'] as bool,
  type: json['type'] as String,
  titleL10n: json['titleL10n'] as String,
  embeddedId: json['embeddedId'] as String?,
);

Map<String, dynamic> _$AppConfigModeSelectActionToJson(
  AppConfigModeSelectAction instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'type': instance.type,
  'titleL10n': instance.titleL10n,
  'embeddedId': instance.embeddedId,
};

AppConfigMain _$AppConfigMainFromJson(Map<String, dynamic> json) =>
    AppConfigMain(
      bottomMenu: json['bottomMenu'] == null
          ? const AppConfigBottomMenu(
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
            )
          : AppConfigBottomMenu.fromJson(
              json['bottomMenu'] as Map<String, dynamic>,
            ),
      systemNotificationsEnabled:
          json['systemNotificationsEnabled'] as bool? ?? true,
      sipPresenceEnabled: json['sipPresenceEnabled'] as bool? ?? false,
    );

Map<String, dynamic> _$AppConfigMainToJson(AppConfigMain instance) =>
    <String, dynamic>{
      'bottomMenu': instance.bottomMenu.toJson(),
      'systemNotificationsEnabled': instance.systemNotificationsEnabled,
      'sipPresenceEnabled': instance.sipPresenceEnabled,
    };

AppConfigBottomMenu _$AppConfigBottomMenuFromJson(Map<String, dynamic> json) =>
    AppConfigBottomMenu(
      cacheSelectedTab: json['cacheSelectedTab'] as bool? ?? true,
      tabs:
          (json['tabs'] as List<dynamic>?)
              ?.map(
                (e) => BottomMenuTabScheme.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AppConfigBottomMenuToJson(
  AppConfigBottomMenu instance,
) => <String, dynamic>{
  'cacheSelectedTab': instance.cacheSelectedTab,
  'tabs': instance.tabs.map((e) => e.toJson()).toList(),
};

AppConfigCall _$AppConfigCallFromJson(
  Map<String, dynamic> json,
) => AppConfigCall(
  videoEnabled: json['videoEnabled'] as bool? ?? true,
  transfer: json['transfer'] == null
      ? const AppConfigTransfer(
          enableBlindTransfer: true,
          enableAttendedTransfer: true,
        )
      : AppConfigTransfer.fromJson(json['transfer'] as Map<String, dynamic>),
  encoding: json['encoding'] == null
      ? const AppConfigEncoding()
      : AppConfigEncoding.fromJson(json['encoding'] as Map<String, dynamic>),
  peerConnection: json['peerConnection'] == null
      ? const AppConfigPeerConnection()
      : AppConfigPeerConnection.fromJson(
          json['peerConnection'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AppConfigCallToJson(AppConfigCall instance) =>
    <String, dynamic>{
      'videoEnabled': instance.videoEnabled,
      'transfer': instance.transfer.toJson(),
      'encoding': instance.encoding.toJson(),
      'peerConnection': instance.peerConnection.toJson(),
    };

AppConfigTransfer _$AppConfigTransferFromJson(Map<String, dynamic> json) =>
    AppConfigTransfer(
      enableBlindTransfer: json['enableBlindTransfer'] as bool? ?? true,
      enableAttendedTransfer: json['enableAttendedTransfer'] as bool? ?? true,
    );

Map<String, dynamic> _$AppConfigTransferToJson(AppConfigTransfer instance) =>
    <String, dynamic>{
      'enableBlindTransfer': instance.enableBlindTransfer,
      'enableAttendedTransfer': instance.enableAttendedTransfer,
    };

AppConfigEncoding _$AppConfigEncodingFromJson(Map<String, dynamic> json) =>
    AppConfigEncoding(
      bypassConfig: json['bypassConfig'] as bool? ?? false,
      defaultPresetOverride: json['defaultPresetOverride'] == null
          ? const EncodingDefaultPresetOverride()
          : EncodingDefaultPresetOverride.fromJson(
              json['defaultPresetOverride'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AppConfigEncodingToJson(AppConfigEncoding instance) =>
    <String, dynamic>{
      'bypassConfig': instance.bypassConfig,
      'defaultPresetOverride': instance.defaultPresetOverride.toJson(),
    };

AppConfigPeerConnection _$AppConfigPeerConnectionFromJson(
  Map<String, dynamic> json,
) => AppConfigPeerConnection(
  negotiation: json['negotiation'] == null
      ? const AppConfigNegotiationSettingsOverride()
      : AppConfigNegotiationSettingsOverride.fromJson(
          json['negotiation'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AppConfigPeerConnectionToJson(
  AppConfigPeerConnection instance,
) => <String, dynamic>{'negotiation': instance.negotiation.toJson()};

AppConfigNegotiationSettingsOverride
_$AppConfigNegotiationSettingsOverrideFromJson(Map<String, dynamic> json) =>
    AppConfigNegotiationSettingsOverride(
      includeInactiveVideoInOfferAnswer:
          json['includeInactiveVideoInOfferAnswer'] as bool? ?? false,
    );

Map<String, dynamic> _$AppConfigNegotiationSettingsOverrideToJson(
  AppConfigNegotiationSettingsOverride instance,
) => <String, dynamic>{
  'includeInactiveVideoInOfferAnswer':
      instance.includeInactiveVideoInOfferAnswer,
};

EncodingDefaultPresetOverride _$EncodingDefaultPresetOverrideFromJson(
  Map<String, dynamic> json,
) => EncodingDefaultPresetOverride(
  audioBitrate: (json['audioBitrate'] as num?)?.toInt(),
  videoBitrate: (json['videoBitrate'] as num?)?.toInt(),
  ptime: (json['ptime'] as num?)?.toInt(),
  maxptime: (json['maxptime'] as num?)?.toInt(),
  opusSamplingRate: (json['opusSamplingRate'] as num?)?.toInt(),
  opusBitrate: (json['opusBitrate'] as num?)?.toInt(),
  opusStereo: json['opusStereo'] as bool?,
  opusDtx: json['opusDtx'] as bool?,
  removeExtmaps: json['removeExtmaps'] as bool?,
  removeStaticAudioRtpMaps: json['removeStaticAudioRtpMaps'] as bool?,
  remapTE8payloadTo101: json['remapTE8payloadTo101'] as bool?,
);

Map<String, dynamic> _$EncodingDefaultPresetOverrideToJson(
  EncodingDefaultPresetOverride instance,
) => <String, dynamic>{
  'audioBitrate': instance.audioBitrate,
  'videoBitrate': instance.videoBitrate,
  'ptime': instance.ptime,
  'maxptime': instance.maxptime,
  'opusSamplingRate': instance.opusSamplingRate,
  'opusBitrate': instance.opusBitrate,
  'opusStereo': instance.opusStereo,
  'opusDtx': instance.opusDtx,
  'removeExtmaps': instance.removeExtmaps,
  'removeStaticAudioRtpMaps': instance.removeStaticAudioRtpMaps,
  'remapTE8payloadTo101': instance.remapTE8payloadTo101,
};

AppConfigSettings _$AppConfigSettingsFromJson(Map<String, dynamic> json) =>
    AppConfigSettings(
      sections:
          (json['sections'] as List<dynamic>?)
              ?.map(
                (e) => AppConfigSettingsSection.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [
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
    );

Map<String, dynamic> _$AppConfigSettingsToJson(AppConfigSettings instance) =>
    <String, dynamic>{
      'sections': instance.sections.map((e) => e.toJson()).toList(),
    };

AppConfigSettingsSection _$AppConfigSettingsSectionFromJson(
  Map<String, dynamic> json,
) => AppConfigSettingsSection(
  titleL10n: json['titleL10n'] as String,
  enabled: json['enabled'] as bool? ?? true,
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => AppConfigSettingsItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$AppConfigSettingsSectionToJson(
  AppConfigSettingsSection instance,
) => <String, dynamic>{
  'titleL10n': instance.titleL10n,
  'enabled': instance.enabled,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

AppConfigSettingsItem _$AppConfigSettingsItemFromJson(
  Map<String, dynamic> json,
) => AppConfigSettingsItem(
  enabled: json['enabled'] as bool? ?? true,
  titleL10n: json['titleL10n'] as String,
  type: json['type'] as String,
  icon: json['icon'] as String,
  embeddedResourceId: const IntToStringOptionalConverter().fromJson(
    json['embeddedResourceId'],
  ),
);

Map<String, dynamic> _$AppConfigSettingsItemToJson(
  AppConfigSettingsItem instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'titleL10n': instance.titleL10n,
  'type': instance.type,
  'icon': instance.icon,
  'embeddedResourceId': const IntToStringOptionalConverter().toJson(
    instance.embeddedResourceId,
  ),
};

AppConfigContacts _$AppConfigContactsFromJson(Map<String, dynamic> json) =>
    AppConfigContacts(
      list: json['list'] == null
          ? const AppConfigContactList()
          : AppConfigContactList.fromJson(json['list'] as Map<String, dynamic>),
      details: json['details'] == null
          ? const AppConfigContactDetails()
          : AppConfigContactDetails.fromJson(
              json['details'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AppConfigContactsToJson(AppConfigContacts instance) =>
    <String, dynamic>{
      'list': instance.list.toJson(),
      'details': instance.details.toJson(),
    };

AppConfigContactList _$AppConfigContactListFromJson(
  Map<String, dynamic> json,
) => AppConfigContactList();

Map<String, dynamic> _$AppConfigContactListToJson(
  AppConfigContactList instance,
) => <String, dynamic>{};

AppConfigContactDetails _$AppConfigContactDetailsFromJson(
  Map<String, dynamic> json,
) => AppConfigContactDetails(
  actions: json['actions'] == null
      ? const AppConfigContactDetailsActions()
      : AppConfigContactDetailsActions.fromJson(
          json['actions'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AppConfigContactDetailsToJson(
  AppConfigContactDetails instance,
) => <String, dynamic>{'actions': instance.actions.toJson()};

AppConfigContactDetailsActions _$AppConfigContactDetailsActionsFromJson(
  Map<String, dynamic> json,
) => AppConfigContactDetailsActions(
  appBar: (json['appBar'] as List<dynamic>?)?.map((e) => e as String).toList(),
  phoneTile: (json['phoneTile'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  emailTile: (json['emailTile'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$AppConfigContactDetailsActionsToJson(
  AppConfigContactDetailsActions instance,
) => <String, dynamic>{
  'appBar': instance.appBar,
  'phoneTile': instance.phoneTile,
  'emailTile': instance.emailTile,
};

FavoritesTabScheme _$FavoritesTabSchemeFromJson(Map<String, dynamic> json) =>
    FavoritesTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$FavoritesTabSchemeToJson(FavoritesTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'type': instance.$type,
    };

RecentsTabScheme _$RecentsTabSchemeFromJson(Map<String, dynamic> json) =>
    RecentsTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      useCdrs: json['useCdrs'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$RecentsTabSchemeToJson(RecentsTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'useCdrs': instance.useCdrs,
      'type': instance.$type,
    };

ContactsTabScheme _$ContactsTabSchemeFromJson(Map<String, dynamic> json) =>
    ContactsTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      contactSourceTypes:
          (json['contactSourceTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ContactsTabSchemeToJson(ContactsTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'contactSourceTypes': instance.contactSourceTypes,
      'type': instance.$type,
    };

KeypadTabScheme _$KeypadTabSchemeFromJson(Map<String, dynamic> json) =>
    KeypadTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$KeypadTabSchemeToJson(KeypadTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'type': instance.$type,
    };

MessagingTabScheme _$MessagingTabSchemeFromJson(Map<String, dynamic> json) =>
    MessagingTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MessagingTabSchemeToJson(MessagingTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'type': instance.$type,
    };

EmbeddedTabScheme _$EmbeddedTabSchemeFromJson(Map<String, dynamic> json) =>
    EmbeddedTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      embeddedResourceId: const IntToStringConverter().fromJson(
        json['embeddedResourceId'],
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$EmbeddedTabSchemeToJson(EmbeddedTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'embeddedResourceId': const IntToStringConverter().toJson(
        instance.embeddedResourceId,
      ),
      'type': instance.$type,
    };
