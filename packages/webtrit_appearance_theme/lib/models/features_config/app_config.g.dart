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
              json['loginConfig'] as Map<String, dynamic>),
      mainConfig: json['mainConfig'] == null
          ? const AppConfigMain()
          : AppConfigMain.fromJson(json['mainConfig'] as Map<String, dynamic>),
      settingsConfig: json['settingsConfig'] == null
          ? const AppConfigSettings()
          : AppConfigSettings.fromJson(
              json['settingsConfig'] as Map<String, dynamic>),
      callConfig: json['callConfig'] == null
          ? const AppConfigCall()
          : AppConfigCall.fromJson(json['callConfig'] as Map<String, dynamic>),
      embeddedResources: (json['embeddedResources'] as List<dynamic>?)
              ?.map((e) => EmbeddedResource.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AppConfigImplToJson(_$AppConfigImpl instance) =>
    <String, dynamic>{
      'loginConfig': instance.loginConfig.toJson(),
      'mainConfig': instance.mainConfig.toJson(),
      'settingsConfig': instance.settingsConfig.toJson(),
      'callConfig': instance.callConfig.toJson(),
      'embeddedResources':
          instance.embeddedResources.map((e) => e.toJson()).toList(),
    };

_$AppConfigLoginImpl _$$AppConfigLoginImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigLoginImpl(
      greetingL10n: json['greetingL10n'] as String?,
      modeSelectActions: (json['modeSelectActions'] as List<dynamic>?)
              ?.map((e) =>
                  AppConfigModeSelectAction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [
            AppConfigModeSelectAction(
                enabled: true,
                type: 'login',
                titleL10n: 'login_Button_signUpToDemoInstance')
          ],
    );

Map<String, dynamic> _$$AppConfigLoginImplToJson(
        _$AppConfigLoginImpl instance) =>
    <String, dynamic>{
      'greetingL10n': instance.greetingL10n,
      'modeSelectActions':
          instance.modeSelectActions.map((e) => e.toJson()).toList(),
    };

_$AppConfigModeSelectActionImpl _$$AppConfigModeSelectActionImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigModeSelectActionImpl(
      enabled: json['enabled'] as bool,
      embeddedId: (json['embeddedId'] as num?)?.toInt(),
      type: json['type'] as String,
      titleL10n: json['titleL10n'] as String,
    );

Map<String, dynamic> _$$AppConfigModeSelectActionImplToJson(
        _$AppConfigModeSelectActionImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'embeddedId': instance.embeddedId,
      'type': instance.type,
      'titleL10n': instance.titleL10n,
    };

_$AppConfigMainImpl _$$AppConfigMainImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigMainImpl(
      bottomMenu: json['bottomMenu'] == null
          ? const AppConfigBottomMenu(cacheSelectedTab: true, tabs: [
              BaseTabScheme(
                  enabled: true,
                  initial: false,
                  type: BottomMenuTabType.favorites,
                  titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
                  icon: '0xe5fd'),
              BaseTabScheme(
                  enabled: true,
                  initial: false,
                  type: BottomMenuTabType.recents,
                  titleL10n: 'main_BottomNavigationBarItemLabel_recents',
                  icon: '0xe03a'),
              ContactsTabScheme(
                  enabled: true,
                  initial: false,
                  type: BottomMenuTabType.contacts,
                  titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
                  icon: '0xee35',
                  contactSourceTypes: ['local', 'external']),
              BaseTabScheme(
                  enabled: true,
                  initial: true,
                  type: BottomMenuTabType.keypad,
                  titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
                  icon: '0xe1ce'),
              BaseTabScheme(
                  enabled: false,
                  initial: false,
                  type: BottomMenuTabType.messaging,
                  titleL10n: 'main_BottomNavigationBarItemLabel_chats',
                  icon: '0xe155')
            ])
          : AppConfigBottomMenu.fromJson(
              json['bottomMenu'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppConfigMainImplToJson(_$AppConfigMainImpl instance) =>
    <String, dynamic>{
      'bottomMenu': instance.bottomMenu.toJson(),
    };

_$AppConfigBottomMenuImpl _$$AppConfigBottomMenuImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigBottomMenuImpl(
      cacheSelectedTab: json['cacheSelectedTab'] as bool? ?? true,
      tabs: (json['tabs'] as List<dynamic>?)
              ?.map((e) =>
                  BottomMenuTabScheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AppConfigBottomMenuImplToJson(
        _$AppConfigBottomMenuImpl instance) =>
    <String, dynamic>{
      'cacheSelectedTab': instance.cacheSelectedTab,
      'tabs': instance.tabs.map((e) => e.toJson()).toList(),
    };

_$AppConfigCallImpl _$$AppConfigCallImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigCallImpl(
      videoEnabled: json['videoEnabled'] as bool? ?? true,
      transfer: json['transfer'] == null
          ? const AppConfigTransfer(
              enableBlindTransfer: true, enableAttendedTransfer: true)
          : AppConfigTransfer.fromJson(
              json['transfer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppConfigCallImplToJson(_$AppConfigCallImpl instance) =>
    <String, dynamic>{
      'videoEnabled': instance.videoEnabled,
      'transfer': instance.transfer.toJson(),
    };

_$AppConfigTransferImpl _$$AppConfigTransferImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigTransferImpl(
      enableBlindTransfer: json['enableBlindTransfer'] as bool? ?? true,
      enableAttendedTransfer: json['enableAttendedTransfer'] as bool? ?? true,
    );

Map<String, dynamic> _$$AppConfigTransferImplToJson(
        _$AppConfigTransferImpl instance) =>
    <String, dynamic>{
      'enableBlindTransfer': instance.enableBlindTransfer,
      'enableAttendedTransfer': instance.enableAttendedTransfer,
    };

_$BaseTabSchemeImpl _$$BaseTabSchemeImplFromJson(Map<String, dynamic> json) =>
    _$BaseTabSchemeImpl(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      type: const BottomMenuTabTypeConverter().fromJson(json['type'] as String),
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BaseTabSchemeImplToJson(_$BaseTabSchemeImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'type': const BottomMenuTabTypeConverter().toJson(instance.type),
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'runtimeType': instance.$type,
    };

_$ContactsTabSchemeImpl _$$ContactsTabSchemeImplFromJson(
        Map<String, dynamic> json) =>
    _$ContactsTabSchemeImpl(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      type: const BottomMenuTabTypeConverter().fromJson(json['type'] as String),
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      contactSourceTypes: (json['contactSourceTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ContactsTabSchemeImplToJson(
        _$ContactsTabSchemeImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'type': const BottomMenuTabTypeConverter().toJson(instance.type),
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'contactSourceTypes': instance.contactSourceTypes,
      'runtimeType': instance.$type,
    };

_$EmbededTabSchemeImpl _$$EmbededTabSchemeImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbededTabSchemeImpl(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      type: const BottomMenuTabTypeConverter().fromJson(json['type'] as String),
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      embeddedResourceId: (json['embeddedResourceId'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EmbededTabSchemeImplToJson(
        _$EmbededTabSchemeImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'type': const BottomMenuTabTypeConverter().toJson(instance.type),
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'embeddedResourceId': instance.embeddedResourceId,
      'runtimeType': instance.$type,
    };

_$AppConfigSettingsImpl _$$AppConfigSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigSettingsImpl(
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) =>
                  AppConfigSettingsSection.fromJson(e as Map<String, dynamic>))
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
                      icon: '0xe424'),
                  AppConfigSettingsItem(
                      enabled: true,
                      type: 'encoding',
                      titleL10n: 'settings_ListViewTileTitle_encoding',
                      icon: '0xf1cf'),
                  AppConfigSettingsItem(
                      enabled: true,
                      type: 'language',
                      titleL10n: 'settings_ListViewTileTitle_language',
                      icon: '0xe366'),
                  AppConfigSettingsItem(
                      enabled: true,
                      type: 'terms',
                      titleL10n: 'settings_ListViewTileTitle_termsConditions',
                      icon: '0xeedf',
                      embeddedResourceId: 0),
                  AppConfigSettingsItem(
                      enabled: true,
                      type: 'about',
                      titleL10n: 'settings_ListViewTileTitle_about',
                      icon: '0xe140')
                ]),
            AppConfigSettingsSection(
                titleL10n: 'settings_ListViewTileTitle_toolbox',
                enabled: true,
                items: [
                  AppConfigSettingsItem(
                      enabled: true,
                      type: 'log',
                      titleL10n: 'settings_ListViewTileTitle_logRecordsConsole',
                      icon: '0xee79'),
                  AppConfigSettingsItem(
                      enabled: true,
                      type: 'selfConfig',
                      titleL10n: 'settings_ListViewTileTitle_self_config',
                      icon: '0xef7a'),
                  AppConfigSettingsItem(
                      enabled: true,
                      type: 'deleteAccount',
                      titleL10n: 'settings_ListViewTileTitle_accountDelete',
                      icon: '0xe1bb')
                ])
          ],
    );

Map<String, dynamic> _$$AppConfigSettingsImplToJson(
        _$AppConfigSettingsImpl instance) =>
    <String, dynamic>{
      'sections': instance.sections.map((e) => e.toJson()).toList(),
    };

_$AppConfigSettingsSectionImpl _$$AppConfigSettingsSectionImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigSettingsSectionImpl(
      titleL10n: json['titleL10n'] as String,
      enabled: json['enabled'] as bool? ?? true,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) =>
                  AppConfigSettingsItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AppConfigSettingsSectionImplToJson(
        _$AppConfigSettingsSectionImpl instance) =>
    <String, dynamic>{
      'titleL10n': instance.titleL10n,
      'enabled': instance.enabled,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

_$AppConfigSettingsItemImpl _$$AppConfigSettingsItemImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigSettingsItemImpl(
      enabled: json['enabled'] as bool? ?? true,
      titleL10n: json['titleL10n'] as String,
      type: json['type'] as String,
      icon: json['icon'] as String,
      embeddedResourceId: (json['embeddedResourceId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AppConfigSettingsItemImplToJson(
        _$AppConfigSettingsItemImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'titleL10n': instance.titleL10n,
      'type': instance.type,
      'icon': instance.icon,
      'embeddedResourceId': instance.embeddedResourceId,
    };
