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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThemePageConfigCopyWith<ThemePageConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemePageConfigCopyWith<$Res> {
  factory $ThemePageConfigCopyWith(
          ThemePageConfig value, $Res Function(ThemePageConfig) then) =
      _$ThemePageConfigCopyWithImpl<$Res, ThemePageConfig>;
  @useResult
  $Res call({LoginPageConfig? login});

  $LoginPageConfigCopyWith<$Res>? get login;
}

/// @nodoc
class _$ThemePageConfigCopyWithImpl<$Res, $Val extends ThemePageConfig>
    implements $ThemePageConfigCopyWith<$Res> {
  _$ThemePageConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = freezed,
  }) {
    return _then(_value.copyWith(
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as LoginPageConfig?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LoginPageConfigCopyWith<$Res>? get login {
    if (_value.login == null) {
      return null;
    }

    return $LoginPageConfigCopyWith<$Res>(_value.login!, (value) {
      return _then(_value.copyWith(login: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ThemePageConfigImplCopyWith<$Res>
    implements $ThemePageConfigCopyWith<$Res> {
  factory _$$ThemePageConfigImplCopyWith(_$ThemePageConfigImpl value,
          $Res Function(_$ThemePageConfigImpl) then) =
      __$$ThemePageConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LoginPageConfig? login});

  @override
  $LoginPageConfigCopyWith<$Res>? get login;
}

/// @nodoc
class __$$ThemePageConfigImplCopyWithImpl<$Res>
    extends _$ThemePageConfigCopyWithImpl<$Res, _$ThemePageConfigImpl>
    implements _$$ThemePageConfigImplCopyWith<$Res> {
  __$$ThemePageConfigImplCopyWithImpl(
      _$ThemePageConfigImpl _value, $Res Function(_$ThemePageConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = freezed,
  }) {
    return _then(_$ThemePageConfigImpl(
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as LoginPageConfig?,
    ));
  }
}

/// @nodoc

@themeJsonSerializable
class _$ThemePageConfigImpl implements _ThemePageConfig {
  const _$ThemePageConfigImpl({this.login});

  factory _$ThemePageConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemePageConfigImplFromJson(json);

  @override
  final LoginPageConfig? login;

  @override
  String toString() {
    return 'ThemePageConfig(login: $login)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemePageConfigImpl &&
            (identical(other.login, login) || other.login == login));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, login);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemePageConfigImplCopyWith<_$ThemePageConfigImpl> get copyWith =>
      __$$ThemePageConfigImplCopyWithImpl<_$ThemePageConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemePageConfigImplToJson(
      this,
    );
  }
}

abstract class _ThemePageConfig implements ThemePageConfig {
  const factory _ThemePageConfig({final LoginPageConfig? login}) =
      _$ThemePageConfigImpl;

  factory _ThemePageConfig.fromJson(Map<String, dynamic> json) =
      _$ThemePageConfigImpl.fromJson;

  @override
  LoginPageConfig? get login;
  @override
  @JsonKey(ignore: true)
  _$$ThemePageConfigImplCopyWith<_$ThemePageConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginPageConfig _$LoginPageConfigFromJson(Map<String, dynamic> json) {
  return _LoginPageConfig.fromJson(json);
}

/// @nodoc
mixin _$LoginPageConfig {
  LoginModeSelectPageConfig get modeSelect =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginPageConfigCopyWith<LoginPageConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginPageConfigCopyWith<$Res> {
  factory $LoginPageConfigCopyWith(
          LoginPageConfig value, $Res Function(LoginPageConfig) then) =
      _$LoginPageConfigCopyWithImpl<$Res, LoginPageConfig>;
  @useResult
  $Res call({LoginModeSelectPageConfig modeSelect});

  $LoginModeSelectPageConfigCopyWith<$Res> get modeSelect;
}

/// @nodoc
class _$LoginPageConfigCopyWithImpl<$Res, $Val extends LoginPageConfig>
    implements $LoginPageConfigCopyWith<$Res> {
  _$LoginPageConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modeSelect = null,
  }) {
    return _then(_value.copyWith(
      modeSelect: null == modeSelect
          ? _value.modeSelect
          : modeSelect // ignore: cast_nullable_to_non_nullable
              as LoginModeSelectPageConfig,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LoginModeSelectPageConfigCopyWith<$Res> get modeSelect {
    return $LoginModeSelectPageConfigCopyWith<$Res>(_value.modeSelect, (value) {
      return _then(_value.copyWith(modeSelect: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginPageConfigImplCopyWith<$Res>
    implements $LoginPageConfigCopyWith<$Res> {
  factory _$$LoginPageConfigImplCopyWith(_$LoginPageConfigImpl value,
          $Res Function(_$LoginPageConfigImpl) then) =
      __$$LoginPageConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LoginModeSelectPageConfig modeSelect});

  @override
  $LoginModeSelectPageConfigCopyWith<$Res> get modeSelect;
}

/// @nodoc
class __$$LoginPageConfigImplCopyWithImpl<$Res>
    extends _$LoginPageConfigCopyWithImpl<$Res, _$LoginPageConfigImpl>
    implements _$$LoginPageConfigImplCopyWith<$Res> {
  __$$LoginPageConfigImplCopyWithImpl(
      _$LoginPageConfigImpl _value, $Res Function(_$LoginPageConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modeSelect = null,
  }) {
    return _then(_$LoginPageConfigImpl(
      modeSelect: null == modeSelect
          ? _value.modeSelect
          : modeSelect // ignore: cast_nullable_to_non_nullable
              as LoginModeSelectPageConfig,
    ));
  }
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
  String toString() {
    return 'LoginPageConfig(modeSelect: $modeSelect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginPageConfigImpl &&
            (identical(other.modeSelect, modeSelect) ||
                other.modeSelect == modeSelect));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, modeSelect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginPageConfigImplCopyWith<_$LoginPageConfigImpl> get copyWith =>
      __$$LoginPageConfigImplCopyWithImpl<_$LoginPageConfigImpl>(
          this, _$identity);

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
  @override
  @JsonKey(ignore: true)
  _$$LoginPageConfigImplCopyWith<_$LoginPageConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginModeSelectPageConfigCopyWith<LoginModeSelectPageConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginModeSelectPageConfigCopyWith<$Res> {
  factory $LoginModeSelectPageConfigCopyWith(LoginModeSelectPageConfig value,
          $Res Function(LoginModeSelectPageConfig) then) =
      _$LoginModeSelectPageConfigCopyWithImpl<$Res, LoginModeSelectPageConfig>;
  @useResult
  $Res call(
      {ElevatedButtonStyleType buttonLoginStyleType,
      ElevatedButtonStyleType buttonSignupStyleType});
}

/// @nodoc
class _$LoginModeSelectPageConfigCopyWithImpl<$Res,
        $Val extends LoginModeSelectPageConfig>
    implements $LoginModeSelectPageConfigCopyWith<$Res> {
  _$LoginModeSelectPageConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buttonLoginStyleType = null,
    Object? buttonSignupStyleType = null,
  }) {
    return _then(_value.copyWith(
      buttonLoginStyleType: null == buttonLoginStyleType
          ? _value.buttonLoginStyleType
          : buttonLoginStyleType // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonStyleType,
      buttonSignupStyleType: null == buttonSignupStyleType
          ? _value.buttonSignupStyleType
          : buttonSignupStyleType // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonStyleType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginModeSelectPageConfigImplCopyWith<$Res>
    implements $LoginModeSelectPageConfigCopyWith<$Res> {
  factory _$$LoginModeSelectPageConfigImplCopyWith(
          _$LoginModeSelectPageConfigImpl value,
          $Res Function(_$LoginModeSelectPageConfigImpl) then) =
      __$$LoginModeSelectPageConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ElevatedButtonStyleType buttonLoginStyleType,
      ElevatedButtonStyleType buttonSignupStyleType});
}

/// @nodoc
class __$$LoginModeSelectPageConfigImplCopyWithImpl<$Res>
    extends _$LoginModeSelectPageConfigCopyWithImpl<$Res,
        _$LoginModeSelectPageConfigImpl>
    implements _$$LoginModeSelectPageConfigImplCopyWith<$Res> {
  __$$LoginModeSelectPageConfigImplCopyWithImpl(
      _$LoginModeSelectPageConfigImpl _value,
      $Res Function(_$LoginModeSelectPageConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buttonLoginStyleType = null,
    Object? buttonSignupStyleType = null,
  }) {
    return _then(_$LoginModeSelectPageConfigImpl(
      buttonLoginStyleType: null == buttonLoginStyleType
          ? _value.buttonLoginStyleType
          : buttonLoginStyleType // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonStyleType,
      buttonSignupStyleType: null == buttonSignupStyleType
          ? _value.buttonSignupStyleType
          : buttonSignupStyleType // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonStyleType,
    ));
  }
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
  String toString() {
    return 'LoginModeSelectPageConfig(buttonLoginStyleType: $buttonLoginStyleType, buttonSignupStyleType: $buttonSignupStyleType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginModeSelectPageConfigImpl &&
            (identical(other.buttonLoginStyleType, buttonLoginStyleType) ||
                other.buttonLoginStyleType == buttonLoginStyleType) &&
            (identical(other.buttonSignupStyleType, buttonSignupStyleType) ||
                other.buttonSignupStyleType == buttonSignupStyleType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, buttonLoginStyleType, buttonSignupStyleType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginModeSelectPageConfigImplCopyWith<_$LoginModeSelectPageConfigImpl>
      get copyWith => __$$LoginModeSelectPageConfigImplCopyWithImpl<
          _$LoginModeSelectPageConfigImpl>(this, _$identity);

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
  @override
  @JsonKey(ignore: true)
  _$$LoginModeSelectPageConfigImplCopyWith<_$LoginModeSelectPageConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}
