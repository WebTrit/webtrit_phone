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
    );

Map<String, dynamic> _$$UiComposeSettingsImplToJson(
        _$UiComposeSettingsImpl instance) =>
    <String, dynamic>{
      'login': instance.login,
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
