// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_page_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemePageConfigImpl _$$ThemePageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ThemePageConfigImpl(
      login: json['login'] == null
          ? null
          : LoginPageConfig.fromJson(json['login'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ThemePageConfigImplToJson(
        _$ThemePageConfigImpl instance) =>
    <String, dynamic>{
      'login': instance.login,
    };

_$LoginPageConfigImpl _$$LoginPageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginPageConfigImpl(
      modeSelect: LoginModeSelectPageConfig.fromJson(
          json['modeSelect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoginPageConfigImplToJson(
        _$LoginPageConfigImpl instance) =>
    <String, dynamic>{
      'modeSelect': instance.modeSelect,
    };

_$LoginModeSelectPageConfigImpl _$$LoginModeSelectPageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginModeSelectPageConfigImpl(
      buttonLoginStyleType: $enumDecode(
          _$ElevatedButtonStyleTypeEnumMap, json['buttonLoginStyleType']),
      buttonSignupStyleType: $enumDecode(
          _$ElevatedButtonStyleTypeEnumMap, json['buttonSignupStyleType']),
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
