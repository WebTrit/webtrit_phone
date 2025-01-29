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
  LoginPageConfig get login => throw _privateConstructorUsedError;
  AboutPageConfig get about => throw _privateConstructorUsedError;

  /// Serializes this ThemePageConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemePageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemePageConfigCopyWith<ThemePageConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemePageConfigCopyWith<$Res> {
  factory $ThemePageConfigCopyWith(
          ThemePageConfig value, $Res Function(ThemePageConfig) then) =
      _$ThemePageConfigCopyWithImpl<$Res, ThemePageConfig>;
  @useResult
  $Res call({LoginPageConfig login, AboutPageConfig about});

  $LoginPageConfigCopyWith<$Res> get login;
  $AboutPageConfigCopyWith<$Res> get about;
}

/// @nodoc
class _$ThemePageConfigCopyWithImpl<$Res, $Val extends ThemePageConfig>
    implements $ThemePageConfigCopyWith<$Res> {
  _$ThemePageConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemePageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = null,
    Object? about = null,
  }) {
    return _then(_value.copyWith(
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as LoginPageConfig,
      about: null == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as AboutPageConfig,
    ) as $Val);
  }

  /// Create a copy of ThemePageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginPageConfigCopyWith<$Res> get login {
    return $LoginPageConfigCopyWith<$Res>(_value.login, (value) {
      return _then(_value.copyWith(login: value) as $Val);
    });
  }

  /// Create a copy of ThemePageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AboutPageConfigCopyWith<$Res> get about {
    return $AboutPageConfigCopyWith<$Res>(_value.about, (value) {
      return _then(_value.copyWith(about: value) as $Val);
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
  $Res call({LoginPageConfig login, AboutPageConfig about});

  @override
  $LoginPageConfigCopyWith<$Res> get login;
  @override
  $AboutPageConfigCopyWith<$Res> get about;
}

/// @nodoc
class __$$ThemePageConfigImplCopyWithImpl<$Res>
    extends _$ThemePageConfigCopyWithImpl<$Res, _$ThemePageConfigImpl>
    implements _$$ThemePageConfigImplCopyWith<$Res> {
  __$$ThemePageConfigImplCopyWithImpl(
      _$ThemePageConfigImpl _value, $Res Function(_$ThemePageConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThemePageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = null,
    Object? about = null,
  }) {
    return _then(_$ThemePageConfigImpl(
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as LoginPageConfig,
      about: null == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as AboutPageConfig,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ThemePageConfigImpl implements _ThemePageConfig {
  const _$ThemePageConfigImpl(
      {this.login = const LoginPageConfig(),
      this.about = const AboutPageConfig()});

  factory _$ThemePageConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemePageConfigImplFromJson(json);

  @override
  @JsonKey()
  final LoginPageConfig login;
  @override
  @JsonKey()
  final AboutPageConfig about;

  @override
  String toString() {
    return 'ThemePageConfig(login: $login, about: $about)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemePageConfigImpl &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.about, about) || other.about == about));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, login, about);

  /// Create a copy of ThemePageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  const factory _ThemePageConfig(
      {final LoginPageConfig login,
      final AboutPageConfig about}) = _$ThemePageConfigImpl;

  factory _ThemePageConfig.fromJson(Map<String, dynamic> json) =
      _$ThemePageConfigImpl.fromJson;

  @override
  LoginPageConfig get login;
  @override
  AboutPageConfig get about;

  /// Create a copy of ThemePageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemePageConfigImplCopyWith<_$ThemePageConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginPageConfig _$LoginPageConfigFromJson(Map<String, dynamic> json) {
  return _LoginPageConfig.fromJson(json);
}

/// @nodoc
mixin _$LoginPageConfig {
  String? get picture => throw _privateConstructorUsedError;
  double? get scale => throw _privateConstructorUsedError;
  String? get labelColor => throw _privateConstructorUsedError;
  LoginModeSelectPageConfig get modeSelect =>
      throw _privateConstructorUsedError;
  Metadata get metadata => throw _privateConstructorUsedError;

  /// Serializes this LoginPageConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginPageConfigCopyWith<LoginPageConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginPageConfigCopyWith<$Res> {
  factory $LoginPageConfigCopyWith(
          LoginPageConfig value, $Res Function(LoginPageConfig) then) =
      _$LoginPageConfigCopyWithImpl<$Res, LoginPageConfig>;
  @useResult
  $Res call(
      {String? picture,
      double? scale,
      String? labelColor,
      LoginModeSelectPageConfig modeSelect,
      Metadata metadata});

  $LoginModeSelectPageConfigCopyWith<$Res> get modeSelect;
  $MetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$LoginPageConfigCopyWithImpl<$Res, $Val extends LoginPageConfig>
    implements $LoginPageConfigCopyWith<$Res> {
  _$LoginPageConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? picture = freezed,
    Object? scale = freezed,
    Object? labelColor = freezed,
    Object? modeSelect = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      scale: freezed == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double?,
      labelColor: freezed == labelColor
          ? _value.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as String?,
      modeSelect: null == modeSelect
          ? _value.modeSelect
          : modeSelect // ignore: cast_nullable_to_non_nullable
              as LoginModeSelectPageConfig,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
    ) as $Val);
  }

  /// Create a copy of LoginPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginModeSelectPageConfigCopyWith<$Res> get modeSelect {
    return $LoginModeSelectPageConfigCopyWith<$Res>(_value.modeSelect, (value) {
      return _then(_value.copyWith(modeSelect: value) as $Val);
    });
  }

  /// Create a copy of LoginPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetadataCopyWith<$Res> get metadata {
    return $MetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
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
  $Res call(
      {String? picture,
      double? scale,
      String? labelColor,
      LoginModeSelectPageConfig modeSelect,
      Metadata metadata});

  @override
  $LoginModeSelectPageConfigCopyWith<$Res> get modeSelect;
  @override
  $MetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$LoginPageConfigImplCopyWithImpl<$Res>
    extends _$LoginPageConfigCopyWithImpl<$Res, _$LoginPageConfigImpl>
    implements _$$LoginPageConfigImplCopyWith<$Res> {
  __$$LoginPageConfigImplCopyWithImpl(
      _$LoginPageConfigImpl _value, $Res Function(_$LoginPageConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? picture = freezed,
    Object? scale = freezed,
    Object? labelColor = freezed,
    Object? modeSelect = null,
    Object? metadata = null,
  }) {
    return _then(_$LoginPageConfigImpl(
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      scale: freezed == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double?,
      labelColor: freezed == labelColor
          ? _value.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as String?,
      modeSelect: null == modeSelect
          ? _value.modeSelect
          : modeSelect // ignore: cast_nullable_to_non_nullable
              as LoginModeSelectPageConfig,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LoginPageConfigImpl implements _LoginPageConfig {
  const _$LoginPageConfigImpl(
      {this.picture,
      this.scale,
      this.labelColor,
      this.modeSelect = const LoginModeSelectPageConfig(),
      this.metadata = const Metadata()});

  factory _$LoginPageConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginPageConfigImplFromJson(json);

  @override
  final String? picture;
  @override
  final double? scale;
  @override
  final String? labelColor;
  @override
  @JsonKey()
  final LoginModeSelectPageConfig modeSelect;
  @override
  @JsonKey()
  final Metadata metadata;

  @override
  String toString() {
    return 'LoginPageConfig(picture: $picture, scale: $scale, labelColor: $labelColor, modeSelect: $modeSelect, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginPageConfigImpl &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.labelColor, labelColor) ||
                other.labelColor == labelColor) &&
            (identical(other.modeSelect, modeSelect) ||
                other.modeSelect == modeSelect) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, picture, scale, labelColor, modeSelect, metadata);

  /// Create a copy of LoginPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {final String? picture,
      final double? scale,
      final String? labelColor,
      final LoginModeSelectPageConfig modeSelect,
      final Metadata metadata}) = _$LoginPageConfigImpl;

  factory _LoginPageConfig.fromJson(Map<String, dynamic> json) =
      _$LoginPageConfigImpl.fromJson;

  @override
  String? get picture;
  @override
  double? get scale;
  @override
  String? get labelColor;
  @override
  LoginModeSelectPageConfig get modeSelect;
  @override
  Metadata get metadata;

  /// Create a copy of LoginPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this LoginModeSelectPageConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginModeSelectPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of LoginModeSelectPageConfig
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of LoginModeSelectPageConfig
  /// with the given fields replaced by the non-null parameter values.
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

@JsonSerializable(explicitToJson: true)
class _$LoginModeSelectPageConfigImpl implements _LoginModeSelectPageConfig {
  const _$LoginModeSelectPageConfigImpl(
      {this.buttonLoginStyleType = ElevatedButtonStyleType.primary,
      this.buttonSignupStyleType = ElevatedButtonStyleType.primary});

  factory _$LoginModeSelectPageConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginModeSelectPageConfigImplFromJson(json);

  @override
  @JsonKey()
  final ElevatedButtonStyleType buttonLoginStyleType;
  @override
  @JsonKey()
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, buttonLoginStyleType, buttonSignupStyleType);

  /// Create a copy of LoginModeSelectPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
          {final ElevatedButtonStyleType buttonLoginStyleType,
          final ElevatedButtonStyleType buttonSignupStyleType}) =
      _$LoginModeSelectPageConfigImpl;

  factory _LoginModeSelectPageConfig.fromJson(Map<String, dynamic> json) =
      _$LoginModeSelectPageConfigImpl.fromJson;

  @override
  ElevatedButtonStyleType get buttonLoginStyleType;
  @override
  ElevatedButtonStyleType get buttonSignupStyleType;

  /// Create a copy of LoginModeSelectPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginModeSelectPageConfigImplCopyWith<_$LoginModeSelectPageConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AboutPageConfig _$AboutPageConfigFromJson(Map<String, dynamic> json) {
  return _AboutPageConfig.fromJson(json);
}

/// @nodoc
mixin _$AboutPageConfig {
  String? get picture => throw _privateConstructorUsedError;
  Metadata get metadata => throw _privateConstructorUsedError;

  /// Serializes this AboutPageConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AboutPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AboutPageConfigCopyWith<AboutPageConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AboutPageConfigCopyWith<$Res> {
  factory $AboutPageConfigCopyWith(
          AboutPageConfig value, $Res Function(AboutPageConfig) then) =
      _$AboutPageConfigCopyWithImpl<$Res, AboutPageConfig>;
  @useResult
  $Res call({String? picture, Metadata metadata});

  $MetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$AboutPageConfigCopyWithImpl<$Res, $Val extends AboutPageConfig>
    implements $AboutPageConfigCopyWith<$Res> {
  _$AboutPageConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AboutPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? picture = freezed,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
    ) as $Val);
  }

  /// Create a copy of AboutPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetadataCopyWith<$Res> get metadata {
    return $MetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AboutPageConfigImplCopyWith<$Res>
    implements $AboutPageConfigCopyWith<$Res> {
  factory _$$AboutPageConfigImplCopyWith(_$AboutPageConfigImpl value,
          $Res Function(_$AboutPageConfigImpl) then) =
      __$$AboutPageConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? picture, Metadata metadata});

  @override
  $MetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$AboutPageConfigImplCopyWithImpl<$Res>
    extends _$AboutPageConfigCopyWithImpl<$Res, _$AboutPageConfigImpl>
    implements _$$AboutPageConfigImplCopyWith<$Res> {
  __$$AboutPageConfigImplCopyWithImpl(
      _$AboutPageConfigImpl _value, $Res Function(_$AboutPageConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of AboutPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? picture = freezed,
    Object? metadata = null,
  }) {
    return _then(_$AboutPageConfigImpl(
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AboutPageConfigImpl implements _AboutPageConfig {
  const _$AboutPageConfigImpl({this.picture, this.metadata = const Metadata()});

  factory _$AboutPageConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AboutPageConfigImplFromJson(json);

  @override
  final String? picture;
  @override
  @JsonKey()
  final Metadata metadata;

  @override
  String toString() {
    return 'AboutPageConfig(picture: $picture, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AboutPageConfigImpl &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, picture, metadata);

  /// Create a copy of AboutPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AboutPageConfigImplCopyWith<_$AboutPageConfigImpl> get copyWith =>
      __$$AboutPageConfigImplCopyWithImpl<_$AboutPageConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AboutPageConfigImplToJson(
      this,
    );
  }
}

abstract class _AboutPageConfig implements AboutPageConfig {
  const factory _AboutPageConfig(
      {final String? picture, final Metadata metadata}) = _$AboutPageConfigImpl;

  factory _AboutPageConfig.fromJson(Map<String, dynamic> json) =
      _$AboutPageConfigImpl.fromJson;

  @override
  String? get picture;
  @override
  Metadata get metadata;

  /// Create a copy of AboutPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AboutPageConfigImplCopyWith<_$AboutPageConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
