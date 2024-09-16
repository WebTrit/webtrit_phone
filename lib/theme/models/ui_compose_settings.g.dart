// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_compose_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UiComposeSettingsImpl _$$UiComposeSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$UiComposeSettingsImpl(
      login: json['login'] == null
          ? null
          : UiComposeSettingsLogin.fromJson(
              json['login'] as Map<String, dynamic>),
      main: json['main'] == null
          ? null
          : UiComposeSettingsMain.fromJson(
              json['main'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UiComposeSettingsImplToJson(
        _$UiComposeSettingsImpl instance) =>
    <String, dynamic>{
      'login': instance.login,
      'main': instance.main,
    };

_$UiComposeSettingsLoginImpl _$$UiComposeSettingsLoginImplFromJson(
        Map<String, dynamic> json) =>
    _$UiComposeSettingsLoginImpl(
      customSignIn: json['customSignIn'] == null
          ? null
          : UiComposeSettingsLoginCustomSignIn.fromJson(
              json['customSignIn'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UiComposeSettingsLoginImplToJson(
        _$UiComposeSettingsLoginImpl instance) =>
    <String, dynamic>{
      'customSignIn': instance.customSignIn,
    };

_$UiComposeSettingsLoginCustomSignInImpl
    _$$UiComposeSettingsLoginCustomSignInImplFromJson(
            Map<String, dynamic> json) =>
        _$UiComposeSettingsLoginCustomSignInImpl(
          enabled: json['enabled'] as bool?,
          titleL10n: json['titleL10n'] as String?,
          url: json['url'] as String?,
        );

Map<String, dynamic> _$$UiComposeSettingsLoginCustomSignInImplToJson(
        _$UiComposeSettingsLoginCustomSignInImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'titleL10n': instance.titleL10n,
      'url': instance.url,
    };

_$UiComposeSettingsMainImpl _$$UiComposeSettingsMainImplFromJson(
        Map<String, dynamic> json) =>
    _$UiComposeSettingsMainImpl(
      bottomMenu: json['bottomMenu'] == null
          ? null
          : UiComposeSettingsBottomMenu.fromJson(
              json['bottomMenu'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UiComposeSettingsMainImplToJson(
        _$UiComposeSettingsMainImpl instance) =>
    <String, dynamic>{
      'bottomMenu': instance.bottomMenu,
    };

_$UiComposeSettingsBottomMenuImpl _$$UiComposeSettingsBottomMenuImplFromJson(
        Map<String, dynamic> json) =>
    _$UiComposeSettingsBottomMenuImpl(
      cacheSelectedTab: json['cacheSelectedTab'] as bool? ?? true,
      tabs: (json['tabs'] as List<dynamic>?)
              ?.map((e) => UiComposeSettingsBottomMenuTab.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UiComposeSettingsBottomMenuImplToJson(
        _$UiComposeSettingsBottomMenuImpl instance) =>
    <String, dynamic>{
      'cacheSelectedTab': instance.cacheSelectedTab,
      'tabs': instance.tabs,
    };

_$UiComposeSettingsBottomMenuTabImpl
    _$$UiComposeSettingsBottomMenuTabImplFromJson(Map<String, dynamic> json) =>
        _$UiComposeSettingsBottomMenuTabImpl(
          enabled: json['enabled'] as bool? ?? true,
          initial: json['initial'] as bool? ?? false,
          type: json['type'] as String,
          titleL10n: json['titleL10n'] as String,
          icon: const IconDataConverter().fromJson(json['icon'] as String),
        );

Map<String, dynamic> _$$UiComposeSettingsBottomMenuTabImplToJson(
        _$UiComposeSettingsBottomMenuTabImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'type': instance.type,
      'titleL10n': instance.titleL10n,
      'icon': const IconDataConverter().toJson(instance.icon),
    };
