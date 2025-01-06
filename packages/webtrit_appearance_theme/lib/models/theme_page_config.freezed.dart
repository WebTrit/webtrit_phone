// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_page_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ThemePageConfig _$ThemePageConfigFromJson(Map<String, dynamic> json) {
  return _ThemePageConfig.fromJson(json);
}

/// @nodoc
mixin _$ThemePageConfig {
  LoginPageConfig? get login => throw _privateConstructorUsedError;
  AboutPageConfig? get about => throw _privateConstructorUsedError;

  /// Serializes this ThemePageConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$ThemePageConfigImpl implements _ThemePageConfig {
  const _$ThemePageConfigImpl({this.login, this.about});

  factory _$ThemePageConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemePageConfigImplFromJson(json);

  @override
  final LoginPageConfig? login;
  @override
  final AboutPageConfig? about;

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemePageConfigImplToJson(
      this,
    );
  }
}

abstract class _ThemePageConfig implements ThemePageConfig {
  const factory _ThemePageConfig(
      {final LoginPageConfig? login,
      final AboutPageConfig? about}) = _$ThemePageConfigImpl;

  factory _ThemePageConfig.fromJson(Map<String, dynamic> json) =
      _$ThemePageConfigImpl.fromJson;

  @override
  LoginPageConfig? get login;
  @override
  AboutPageConfig? get about;
}

LoginPageConfig _$LoginPageConfigFromJson(Map<String, dynamic> json) {
  return _LoginPageConfig.fromJson(json);
}

/// @nodoc
mixin _$LoginPageConfig {
  LoginModeSelectPageConfig get modeSelect =>
      throw _privateConstructorUsedError;

  /// Serializes this LoginPageConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$LoginPageConfigImpl implements _LoginPageConfig {
  const _$LoginPageConfigImpl({required this.modeSelect});

  factory _$LoginPageConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginPageConfigImplFromJson(json);

  @override
  final LoginModeSelectPageConfig modeSelect;

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginPageConfigImplToJson(
      this,
    );
  }
}

abstract class _LoginPageConfig implements LoginPageConfig {
  const factory _LoginPageConfig(
          {required final LoginModeSelectPageConfig modeSelect}) =
      _$LoginPageConfigImpl;

  factory _LoginPageConfig.fromJson(Map<String, dynamic> json) =
      _$LoginPageConfigImpl.fromJson;

  @override
  LoginModeSelectPageConfig get modeSelect;
}

LoginModeSelectPageConfig _$LoginModeSelectPageConfigFromJson(
    Map<String, dynamic> json) {
  return _LoginModeSelectPageConfig.fromJson(json);
}

/// @nodoc
mixin _$LoginModeSelectPageConfig {
  ElevatedButtonStyleType get buttonLoginStyleType =>
      throw _privateConstructorUsedError;
  ElevatedButtonStyleType get buttonSignupStyleType =>
      throw _privateConstructorUsedError;

  /// Serializes this LoginModeSelectPageConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$LoginModeSelectPageConfigImpl implements _LoginModeSelectPageConfig {
  const _$LoginModeSelectPageConfigImpl(
      {required this.buttonLoginStyleType,
      required this.buttonSignupStyleType});

  factory _$LoginModeSelectPageConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginModeSelectPageConfigImplFromJson(json);

  @override
  final ElevatedButtonStyleType buttonLoginStyleType;
  @override
  final ElevatedButtonStyleType buttonSignupStyleType;

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginModeSelectPageConfigImplToJson(
      this,
    );
  }
}

abstract class _LoginModeSelectPageConfig implements LoginModeSelectPageConfig {
  const factory _LoginModeSelectPageConfig(
          {required final ElevatedButtonStyleType buttonLoginStyleType,
          required final ElevatedButtonStyleType buttonSignupStyleType}) =
      _$LoginModeSelectPageConfigImpl;

  factory _LoginModeSelectPageConfig.fromJson(Map<String, dynamic> json) =
      _$LoginModeSelectPageConfigImpl.fromJson;

  @override
  ElevatedButtonStyleType get buttonLoginStyleType;
  @override
  ElevatedButtonStyleType get buttonSignupStyleType;
}

AboutPageConfig _$AboutPageConfigFromJson(Map<String, dynamic> json) {
  return _AboutPageConfig.fromJson(json);
}

/// @nodoc
mixin _$AboutPageConfig {
  String get picture => throw _privateConstructorUsedError;

  /// Serializes this AboutPageConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$AboutPageConfigImpl implements _AboutPageConfig {
  const _$AboutPageConfigImpl({required this.picture});

  factory _$AboutPageConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AboutPageConfigImplFromJson(json);

  @override
  final String picture;

  @override
  Map<String, dynamic> toJson() {
    return _$$AboutPageConfigImplToJson(
      this,
    );
  }
}

abstract class _AboutPageConfig implements AboutPageConfig {
  const factory _AboutPageConfig({required final String picture}) =
      _$AboutPageConfigImpl;

  factory _AboutPageConfig.fromJson(Map<String, dynamic> json) =
      _$AboutPageConfigImpl.fromJson;

  @override
  String get picture;
}
