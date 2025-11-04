// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppConfigImpl _$$AppConfigImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigImpl(
      loginConfig: json['loginConfig'] == null
          ? const AppConfigLogin()
          : AppConfigLogin.fromJson(
              json['loginConfig'] as Map<String, dynamic>,
            ),
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
    );

Map<String, dynamic> _$$AppConfigImplToJson(_$AppConfigImpl instance) =>
    <String, dynamic>{
      'loginConfig': instance.loginConfig.toJson(),
      'mainConfig': instance.mainConfig.toJson(),
      'settingsConfig': instance.settingsConfig.toJson(),
      'callConfig': instance.callConfig.toJson(),
    };

_$AppConfigLoginImpl _$$AppConfigLoginImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigLoginImpl(
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

Map<String, dynamic> _$$AppConfigLoginImplToJson(
  _$AppConfigLoginImpl instance,
) => <String, dynamic>{
  'common': instance.common.toJson(),
  'modeSelect': instance.modeSelect.toJson(),
};

_$AppConfigLoginCommonImpl _$$AppConfigLoginCommonImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigLoginCommonImpl(
  fullScreenLaunchEmbeddedResourceId:
      json['fullScreenLaunchEmbeddedResourceId'] as String?,
);

Map<String, dynamic> _$$AppConfigLoginCommonImplToJson(
  _$AppConfigLoginCommonImpl instance,
) => <String, dynamic>{
  'fullScreenLaunchEmbeddedResourceId':
      instance.fullScreenLaunchEmbeddedResourceId,
};

_$AppConfigLoginModeSelectImpl _$$AppConfigLoginModeSelectImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigLoginModeSelectImpl(
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

Map<String, dynamic> _$$AppConfigLoginModeSelectImplToJson(
  _$AppConfigLoginModeSelectImpl instance,
) => <String, dynamic>{
  'greetingL10n': instance.greetingL10n,
  'actions': instance.actions.map((e) => e.toJson()).toList(),
};

_$AppConfigModeSelectActionImpl _$$AppConfigModeSelectActionImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigModeSelectActionImpl(
  enabled: json['enabled'] as bool,
  type: json['type'] as String,
  titleL10n: json['titleL10n'] as String,
  embeddedId: json['embeddedId'] as String?,
);

Map<String, dynamic> _$$AppConfigModeSelectActionImplToJson(
  _$AppConfigModeSelectActionImpl instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'type': instance.type,
  'titleL10n': instance.titleL10n,
  'embeddedId': instance.embeddedId,
};

_$AppConfigMainImpl _$$AppConfigMainImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigMainImpl(
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

Map<String, dynamic> _$$AppConfigMainImplToJson(_$AppConfigMainImpl instance) =>
    <String, dynamic>{
      'bottomMenu': instance.bottomMenu.toJson(),
      'systemNotificationsEnabled': instance.systemNotificationsEnabled,
      'sipPresenceEnabled': instance.sipPresenceEnabled,
    };

_$AppConfigBottomMenuImpl _$$AppConfigBottomMenuImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigBottomMenuImpl(
  cacheSelectedTab: json['cacheSelectedTab'] as bool? ?? true,
  tabs:
      (json['tabs'] as List<dynamic>?)
          ?.map((e) => BottomMenuTabScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AppConfigBottomMenuImplToJson(
  _$AppConfigBottomMenuImpl instance,
) => <String, dynamic>{
  'cacheSelectedTab': instance.cacheSelectedTab,
  'tabs': instance.tabs.map((e) => e.toJson()).toList(),
};

_$AppConfigCallImpl _$$AppConfigCallImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigCallImpl(
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

Map<String, dynamic> _$$AppConfigCallImplToJson(_$AppConfigCallImpl instance) =>
    <String, dynamic>{
      'videoEnabled': instance.videoEnabled,
      'transfer': instance.transfer.toJson(),
      'encoding': instance.encoding.toJson(),
      'peerConnection': instance.peerConnection.toJson(),
    };

_$AppConfigTransferImpl _$$AppConfigTransferImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigTransferImpl(
  enableBlindTransfer: json['enableBlindTransfer'] as bool? ?? true,
  enableAttendedTransfer: json['enableAttendedTransfer'] as bool? ?? true,
);

Map<String, dynamic> _$$AppConfigTransferImplToJson(
  _$AppConfigTransferImpl instance,
) => <String, dynamic>{
  'enableBlindTransfer': instance.enableBlindTransfer,
  'enableAttendedTransfer': instance.enableAttendedTransfer,
};

_$AppConfigEncodingImpl _$$AppConfigEncodingImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigEncodingImpl(
  bypassConfig: json['bypassConfig'] as bool? ?? false,
  defaultPresetOverride: json['defaultPresetOverride'] == null
      ? const EncodingDefaultPresetOverride()
      : EncodingDefaultPresetOverride.fromJson(
          json['defaultPresetOverride'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$AppConfigEncodingImplToJson(
  _$AppConfigEncodingImpl instance,
) => <String, dynamic>{
  'bypassConfig': instance.bypassConfig,
  'defaultPresetOverride': instance.defaultPresetOverride.toJson(),
};

_$AppConfigPeerConnectionImpl _$$AppConfigPeerConnectionImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigPeerConnectionImpl(
  negotiation: json['negotiation'] == null
      ? const AppConfigNegotiationSettingsOverride()
      : AppConfigNegotiationSettingsOverride.fromJson(
          json['negotiation'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$AppConfigPeerConnectionImplToJson(
  _$AppConfigPeerConnectionImpl instance,
) => <String, dynamic>{'negotiation': instance.negotiation.toJson()};

_$AppConfigNegotiationSettingsOverrideImpl
_$$AppConfigNegotiationSettingsOverrideImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigNegotiationSettingsOverrideImpl(
  includeInactiveVideoInOfferAnswer:
      json['includeInactiveVideoInOfferAnswer'] as bool? ?? false,
);

Map<String, dynamic> _$$AppConfigNegotiationSettingsOverrideImplToJson(
  _$AppConfigNegotiationSettingsOverrideImpl instance,
) => <String, dynamic>{
  'includeInactiveVideoInOfferAnswer':
      instance.includeInactiveVideoInOfferAnswer,
};

_$EncodingDefaultPresetOverrideImpl
_$$EncodingDefaultPresetOverrideImplFromJson(Map<String, dynamic> json) =>
    _$EncodingDefaultPresetOverrideImpl(
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

Map<String, dynamic> _$$EncodingDefaultPresetOverrideImplToJson(
  _$EncodingDefaultPresetOverrideImpl instance,
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

_$FavoritesTabSchemeImpl _$$FavoritesTabSchemeImplFromJson(
  Map<String, dynamic> json,
) => _$FavoritesTabSchemeImpl(
  enabled: json['enabled'] as bool? ?? true,
  initial: json['initial'] as bool? ?? false,
  titleL10n: json['titleL10n'] as String,
  icon: json['icon'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$FavoritesTabSchemeImplToJson(
  _$FavoritesTabSchemeImpl instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'initial': instance.initial,
  'titleL10n': instance.titleL10n,
  'icon': instance.icon,
  'type': instance.$type,
};

_$RecentsTabSchemeImpl _$$RecentsTabSchemeImplFromJson(
  Map<String, dynamic> json,
) => _$RecentsTabSchemeImpl(
  enabled: json['enabled'] as bool? ?? true,
  initial: json['initial'] as bool? ?? false,
  titleL10n: json['titleL10n'] as String,
  icon: json['icon'] as String,
  useCdrs: json['useCdrs'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$RecentsTabSchemeImplToJson(
  _$RecentsTabSchemeImpl instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'initial': instance.initial,
  'titleL10n': instance.titleL10n,
  'icon': instance.icon,
  'useCdrs': instance.useCdrs,
  'type': instance.$type,
};

_$ContactsTabSchemeImpl _$$ContactsTabSchemeImplFromJson(
  Map<String, dynamic> json,
) => _$ContactsTabSchemeImpl(
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

Map<String, dynamic> _$$ContactsTabSchemeImplToJson(
  _$ContactsTabSchemeImpl instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'initial': instance.initial,
  'titleL10n': instance.titleL10n,
  'icon': instance.icon,
  'contactSourceTypes': instance.contactSourceTypes,
  'type': instance.$type,
};

_$KeypadTabSchemeImpl _$$KeypadTabSchemeImplFromJson(
  Map<String, dynamic> json,
) => _$KeypadTabSchemeImpl(
  enabled: json['enabled'] as bool? ?? true,
  initial: json['initial'] as bool? ?? false,
  titleL10n: json['titleL10n'] as String,
  icon: json['icon'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$KeypadTabSchemeImplToJson(
  _$KeypadTabSchemeImpl instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'initial': instance.initial,
  'titleL10n': instance.titleL10n,
  'icon': instance.icon,
  'type': instance.$type,
};

_$MessagingTabSchemeImpl _$$MessagingTabSchemeImplFromJson(
  Map<String, dynamic> json,
) => _$MessagingTabSchemeImpl(
  enabled: json['enabled'] as bool? ?? true,
  initial: json['initial'] as bool? ?? false,
  titleL10n: json['titleL10n'] as String,
  icon: json['icon'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$MessagingTabSchemeImplToJson(
  _$MessagingTabSchemeImpl instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'initial': instance.initial,
  'titleL10n': instance.titleL10n,
  'icon': instance.icon,
  'type': instance.$type,
};

_$EmbeddedTabSchemeImpl _$$EmbeddedTabSchemeImplFromJson(
  Map<String, dynamic> json,
) => _$EmbeddedTabSchemeImpl(
  enabled: json['enabled'] as bool? ?? true,
  initial: json['initial'] as bool? ?? false,
  titleL10n: json['titleL10n'] as String,
  icon: json['icon'] as String,
  embeddedResourceId: const IntToStringConverter().fromJson(
    json['embeddedResourceId'],
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$EmbeddedTabSchemeImplToJson(
  _$EmbeddedTabSchemeImpl instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'initial': instance.initial,
  'titleL10n': instance.titleL10n,
  'icon': instance.icon,
  'embeddedResourceId': const IntToStringConverter().toJson(
    instance.embeddedResourceId,
  ),
  'type': instance.$type,
};

_$AppConfigSettingsImpl _$$AppConfigSettingsImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigSettingsImpl(
  sections:
      (json['sections'] as List<dynamic>?)
          ?.map(
            (e) => AppConfigSettingsSection.fromJson(e as Map<String, dynamic>),
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

Map<String, dynamic> _$$AppConfigSettingsImplToJson(
  _$AppConfigSettingsImpl instance,
) => <String, dynamic>{
  'sections': instance.sections.map((e) => e.toJson()).toList(),
};

_$AppConfigSettingsSectionImpl _$$AppConfigSettingsSectionImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigSettingsSectionImpl(
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

Map<String, dynamic> _$$AppConfigSettingsSectionImplToJson(
  _$AppConfigSettingsSectionImpl instance,
) => <String, dynamic>{
  'titleL10n': instance.titleL10n,
  'enabled': instance.enabled,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

_$AppConfigSettingsItemImpl _$$AppConfigSettingsItemImplFromJson(
  Map<String, dynamic> json,
) => _$AppConfigSettingsItemImpl(
  enabled: json['enabled'] as bool? ?? true,
  titleL10n: json['titleL10n'] as String,
  type: json['type'] as String,
  icon: json['icon'] as String,
  embeddedResourceId: const IntToStringOptionalConverter().fromJson(
    json['embeddedResourceId'],
  ),
);

Map<String, dynamic> _$$AppConfigSettingsItemImplToJson(
  _$AppConfigSettingsItemImpl instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'titleL10n': instance.titleL10n,
  'type': instance.type,
  'icon': instance.icon,
  'embeddedResourceId': const IntToStringOptionalConverter().toJson(
    instance.embeddedResourceId,
  ),
};
