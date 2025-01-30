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
      'loginConfig': instance.loginConfig.toJson(),
      'mainConfig': instance.mainConfig.toJson(),
      'settingsConfig': instance.settingsConfig.toJson(),
      'callConfig': instance.callConfig.toJson(),
    };

_$AppConfigLoginImpl _$$AppConfigLoginImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigLoginImpl(
      greetingL10n: json['greetingL10n'] as String?,
      modeSelectActions: (json['modeSelectActions'] as List<dynamic>?)
              ?.map((e) =>
                  AppConfigModeSelectAction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      embedded: (json['embedded'] as List<dynamic>?)
              ?.map((e) => EmbeddedData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AppConfigLoginImplToJson(
        _$AppConfigLoginImpl instance) =>
    <String, dynamic>{
      'greetingL10n': instance.greetingL10n,
      'modeSelectActions':
          instance.modeSelectActions.map((e) => e.toJson()).toList(),
      'embedded': instance.embedded.map((e) => e.toJson()).toList(),
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
          ? const AppConfigBottomMenu(cacheSelectedTab: true, tabs: [])
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
      data: EmbeddedData.fromJson(json['data'] as Map<String, dynamic>),
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
      'data': instance.data.toJson(),
      'runtimeType': instance.$type,
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
      embeddedData: json['embeddedData'] == null
          ? null
          : EmbeddedData.fromJson(json['embeddedData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppConfigSettingsItemImplToJson(
        _$AppConfigSettingsItemImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'titleL10n': instance.titleL10n,
      'type': instance.type,
      'icon': instance.icon,
      'embeddedData': instance.embeddedData?.toJson(),
    };

_$EmbeddedDataImpl _$$EmbeddedDataImplFromJson(Map<String, dynamic> json) =>
    _$EmbeddedDataImpl(
      id: (json['id'] as num?)?.toInt(),
      resource: const UriConverter().fromJson(json['resource'] as String),
      attributes: json['attributes'] as Map<String, dynamic>? ?? const {},
      toolbar: json['toolbar'] == null
          ? const ToolbarConfig()
          : ToolbarConfig.fromJson(json['toolbar'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? const Metadata()
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EmbeddedDataImplToJson(_$EmbeddedDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource': const UriConverter().toJson(instance.resource),
      'attributes': instance.attributes,
      'toolbar': instance.toolbar.toJson(),
      'metadata': instance.metadata.toJson(),
    };

_$ToolbarConfigImpl _$$ToolbarConfigImplFromJson(Map<String, dynamic> json) =>
    _$ToolbarConfigImpl(
      titleL10n: json['titleL10n'] as String?,
      showToolbar: json['showToolbar'] as bool? ?? false,
    );

Map<String, dynamic> _$$ToolbarConfigImplToJson(_$ToolbarConfigImpl instance) =>
    <String, dynamic>{
      'titleL10n': instance.titleL10n,
      'showToolbar': instance.showToolbar,
    };
