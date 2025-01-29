// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_page_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemePageConfigImpl _$$ThemePageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ThemePageConfigImpl(
      login: json['login'] == null
          ? const LoginPageConfig()
          : LoginPageConfig.fromJson(json['login'] as Map<String, dynamic>),
      about: json['about'] == null
          ? const AboutPageConfig()
          : AboutPageConfig.fromJson(json['about'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ThemePageConfigImplToJson(
        _$ThemePageConfigImpl instance) =>
    <String, dynamic>{
      'login': instance.login.toJson(),
      'about': instance.about.toJson(),
    };

_$LoginPageConfigImpl _$$LoginPageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginPageConfigImpl(
      picture: json['picture'] as String?,
      modeSelect: json['modeSelect'] == null
          ? const LoginModeSelectPageConfig()
          : LoginModeSelectPageConfig.fromJson(
              json['modeSelect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoginPageConfigImplToJson(
        _$LoginPageConfigImpl instance) =>
    <String, dynamic>{
      'picture': instance.picture,
      'modeSelect': instance.modeSelect.toJson(),
    };

_$LoginModeSelectPageConfigImpl _$$LoginModeSelectPageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginModeSelectPageConfigImpl(
      buttonLoginStyleType: $enumDecodeNullable(
              _$ElevatedButtonStyleTypeEnumMap, json['buttonLoginStyleType']) ??
          ElevatedButtonStyleType.primary,
      buttonSignupStyleType: $enumDecodeNullable(
              _$ElevatedButtonStyleTypeEnumMap,
              json['buttonSignupStyleType']) ??
          ElevatedButtonStyleType.primary,
    );

Map<String, dynamic> _$$LoginModeSelectPageConfigImplToJson(
        _$LoginModeSelectPageConfigImpl instance) =>
    <String, dynamic>{
      'buttonLoginStyleType':
          _$ElevatedButtonStyleTypeEnumMap[instance.buttonLoginStyleType]!,
      'buttonSignupStyleType':
          _$ElevatedButtonStyleTypeEnumMap[instance.buttonSignupStyleType]!,
    };

const _$ElevatedButtonStyleTypeEnumMap = {
  ElevatedButtonStyleType.primary: 'primary',
  ElevatedButtonStyleType.neutral: 'neutral',
  ElevatedButtonStyleType.primaryOnDark: 'primaryOnDark',
  ElevatedButtonStyleType.neutralOnDark: 'neutralOnDark',
};

_$AboutPageConfigImpl _$$AboutPageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$AboutPageConfigImpl(
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$$AboutPageConfigImplToJson(
        _$AboutPageConfigImpl instance) =>
    <String, dynamic>{
      'picture': instance.picture,
    };
