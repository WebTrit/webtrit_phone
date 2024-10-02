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
    );

Map<String, dynamic> _$$AppConfigImplToJson(_$AppConfigImpl instance) =>
    <String, dynamic>{
      'loginConfig': instance.loginConfig,
      'mainConfig': instance.mainConfig,
      'settingsConfig': instance.settingsConfig,
      'callConfig': instance.callConfig,
    };

_$AppConfigLoginImpl _$$AppConfigLoginImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigLoginImpl(
      modeSelectActions: (json['modeSelectActions'] as List<dynamic>?)
              ?.map((e) =>
                  AppConfigModeSelectAction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      embedded: (json['embedded'] as List<dynamic>?)
              ?.map((e) =>
                  AppConfigLoginEmbedded.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AppConfigLoginImplToJson(
        _$AppConfigLoginImpl instance) =>
    <String, dynamic>{
      'modeSelectActions': instance.modeSelectActions,
      'embedded': instance.embedded,
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

_$AppConfigLoginEmbeddedImpl _$$AppConfigLoginEmbeddedImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigLoginEmbeddedImpl(
      id: (json['id'] as num).toInt(),
      launch: json['launch'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String?,
      showToolbar: json['showToolbar'] as bool? ?? false,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$AppConfigLoginEmbeddedImplToJson(
        _$AppConfigLoginEmbeddedImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'launch': instance.launch,
      'titleL10n': instance.titleL10n,
      'showToolbar': instance.showToolbar,
      'url': instance.url,
    };

_$AppConfigMainImpl _$$AppConfigMainImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigMainImpl(
      bottomMenu: json['bottomMenu'] == null
          ? const AppConfigBottomMenu(cacheSelectedTab: true, tabs: [])
          : AppConfigBottomMenu.fromJson(
              json['bottomMenu'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppConfigMainImplToJson(_$AppConfigMainImpl instance) =>
    <String, dynamic>{
      'bottomMenu': instance.bottomMenu,
    };

_$AppConfigBottomMenuImpl _$$AppConfigBottomMenuImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigBottomMenuImpl(
      cacheSelectedTab: json['cacheSelectedTab'] as bool? ?? true,
      tabs: (json['tabs'] as List<dynamic>?)
              ?.map((e) =>
                  AppConfigBottomMenuTab.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AppConfigBottomMenuImplToJson(
        _$AppConfigBottomMenuImpl instance) =>
    <String, dynamic>{
      'cacheSelectedTab': instance.cacheSelectedTab,
      'tabs': instance.tabs,
    };

_$AppConfigBottomMenuTabImpl _$$AppConfigBottomMenuTabImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigBottomMenuTabImpl(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      type: json['type'] as String,
      titleL10n: json['titleL10n'] as String,
      icon: const IconDataConverter().fromJson(json['icon'] as String),
      data: json['data'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$AppConfigBottomMenuTabImplToJson(
        _$AppConfigBottomMenuTabImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'type': instance.type,
      'titleL10n': instance.titleL10n,
      'icon': const IconDataConverter().toJson(instance.icon),
      'data': instance.data,
    };

_$AppConfigSettingsImpl _$$AppConfigSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigSettingsImpl(
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) =>
                  AppConfigSettingsSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AppConfigSettingsImplToJson(
        _$AppConfigSettingsImpl instance) =>
    <String, dynamic>{
      'sections': instance.sections,
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
      'items': instance.items,
    };

_$AppConfigSettingsItemImpl _$$AppConfigSettingsItemImplFromJson(
        Map<String, dynamic> json) =>
    _$AppConfigSettingsItemImpl(
      enabled: json['enabled'] as bool? ?? true,
      titleL10n: json['titleL10n'] as String,
      type: json['type'] as String,
      icon: const IconDataConverter().fromJson(json['icon'] as String),
      data: json['data'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$AppConfigSettingsItemImplToJson(
        _$AppConfigSettingsItemImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'titleL10n': instance.titleL10n,
      'type': instance.type,
      'icon': const IconDataConverter().toJson(instance.icon),
      'data': instance.data,
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
      'transfer': instance.transfer,
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
