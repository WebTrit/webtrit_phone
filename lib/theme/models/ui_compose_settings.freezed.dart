// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_compose_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UiComposeSettings _$UiComposeSettingsFromJson(Map<String, dynamic> json) {
  return _UiComposeSettings.fromJson(json);
}

/// @nodoc
mixin _$UiComposeSettings {
  UiComposeSettingsLogin? get login => throw _privateConstructorUsedError;

  /// Serializes this UiComposeSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UiComposeSettingsCopyWith<UiComposeSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiComposeSettingsCopyWith<$Res> {
  factory $UiComposeSettingsCopyWith(
          UiComposeSettings value, $Res Function(UiComposeSettings) then) =
      _$UiComposeSettingsCopyWithImpl<$Res, UiComposeSettings>;
  @useResult
  $Res call({UiComposeSettingsLogin? login});

  $UiComposeSettingsLoginCopyWith<$Res>? get login;
}

/// @nodoc
class _$UiComposeSettingsCopyWithImpl<$Res, $Val extends UiComposeSettings>
    implements $UiComposeSettingsCopyWith<$Res> {
  _$UiComposeSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = freezed,
  }) {
    return _then(_value.copyWith(
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsLogin?,
    ) as $Val);
  }

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UiComposeSettingsLoginCopyWith<$Res>? get login {
    if (_value.login == null) {
      return null;
    }

    return $UiComposeSettingsLoginCopyWith<$Res>(_value.login!, (value) {
      return _then(_value.copyWith(login: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UiComposeSettingsImplCopyWith<$Res>
    implements $UiComposeSettingsCopyWith<$Res> {
  factory _$$UiComposeSettingsImplCopyWith(_$UiComposeSettingsImpl value,
          $Res Function(_$UiComposeSettingsImpl) then) =
      __$$UiComposeSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UiComposeSettingsLogin? login});

  @override
  $UiComposeSettingsLoginCopyWith<$Res>? get login;
}

/// @nodoc
class __$$UiComposeSettingsImplCopyWithImpl<$Res>
    extends _$UiComposeSettingsCopyWithImpl<$Res, _$UiComposeSettingsImpl>
    implements _$$UiComposeSettingsImplCopyWith<$Res> {
  __$$UiComposeSettingsImplCopyWithImpl(_$UiComposeSettingsImpl _value,
      $Res Function(_$UiComposeSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = freezed,
  }) {
    return _then(_$UiComposeSettingsImpl(
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsLogin?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiComposeSettingsImpl extends _UiComposeSettings {
  const _$UiComposeSettingsImpl({this.login}) : super._();

  factory _$UiComposeSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UiComposeSettingsImplFromJson(json);

  @override
  final UiComposeSettingsLogin? login;

  @override
  String toString() {
    return 'UiComposeSettings(login: $login)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiComposeSettingsImpl &&
            (identical(other.login, login) || other.login == login));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, login);

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiComposeSettingsImplCopyWith<_$UiComposeSettingsImpl> get copyWith =>
      __$$UiComposeSettingsImplCopyWithImpl<_$UiComposeSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UiComposeSettingsImplToJson(
      this,
    );
  }
}

abstract class _UiComposeSettings extends UiComposeSettings {
  const factory _UiComposeSettings({final UiComposeSettingsLogin? login}) =
      _$UiComposeSettingsImpl;
  const _UiComposeSettings._() : super._();

  factory _UiComposeSettings.fromJson(Map<String, dynamic> json) =
      _$UiComposeSettingsImpl.fromJson;

  @override
  UiComposeSettingsLogin? get login;

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiComposeSettingsImplCopyWith<_$UiComposeSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UiComposeSettingsLogin _$UiComposeSettingsLoginFromJson(
    Map<String, dynamic> json) {
  return _UiComposeSettingsLogin.fromJson(json);
}

/// @nodoc
mixin _$UiComposeSettingsLogin {
  UiComposeSettingsLoginCustomSignIn? get customSignIn =>
      throw _privateConstructorUsedError;

  /// Serializes this UiComposeSettingsLogin to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UiComposeSettingsLogin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UiComposeSettingsLoginCopyWith<UiComposeSettingsLogin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiComposeSettingsLoginCopyWith<$Res> {
  factory $UiComposeSettingsLoginCopyWith(UiComposeSettingsLogin value,
          $Res Function(UiComposeSettingsLogin) then) =
      _$UiComposeSettingsLoginCopyWithImpl<$Res, UiComposeSettingsLogin>;
  @useResult
  $Res call({UiComposeSettingsLoginCustomSignIn? customSignIn});

  $UiComposeSettingsLoginCustomSignInCopyWith<$Res>? get customSignIn;
}

/// @nodoc
class _$UiComposeSettingsLoginCopyWithImpl<$Res,
        $Val extends UiComposeSettingsLogin>
    implements $UiComposeSettingsLoginCopyWith<$Res> {
  _$UiComposeSettingsLoginCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiComposeSettingsLogin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customSignIn = freezed,
  }) {
    return _then(_value.copyWith(
      customSignIn: freezed == customSignIn
          ? _value.customSignIn
          : customSignIn // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsLoginCustomSignIn?,
    ) as $Val);
  }

  /// Create a copy of UiComposeSettingsLogin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UiComposeSettingsLoginCustomSignInCopyWith<$Res>? get customSignIn {
    if (_value.customSignIn == null) {
      return null;
    }

    return $UiComposeSettingsLoginCustomSignInCopyWith<$Res>(
        _value.customSignIn!, (value) {
      return _then(_value.copyWith(customSignIn: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UiComposeSettingsLoginImplCopyWith<$Res>
    implements $UiComposeSettingsLoginCopyWith<$Res> {
  factory _$$UiComposeSettingsLoginImplCopyWith(
          _$UiComposeSettingsLoginImpl value,
          $Res Function(_$UiComposeSettingsLoginImpl) then) =
      __$$UiComposeSettingsLoginImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UiComposeSettingsLoginCustomSignIn? customSignIn});

  @override
  $UiComposeSettingsLoginCustomSignInCopyWith<$Res>? get customSignIn;
}

/// @nodoc
class __$$UiComposeSettingsLoginImplCopyWithImpl<$Res>
    extends _$UiComposeSettingsLoginCopyWithImpl<$Res,
        _$UiComposeSettingsLoginImpl>
    implements _$$UiComposeSettingsLoginImplCopyWith<$Res> {
  __$$UiComposeSettingsLoginImplCopyWithImpl(
      _$UiComposeSettingsLoginImpl _value,
      $Res Function(_$UiComposeSettingsLoginImpl) _then)
      : super(_value, _then);

  /// Create a copy of UiComposeSettingsLogin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customSignIn = freezed,
  }) {
    return _then(_$UiComposeSettingsLoginImpl(
      customSignIn: freezed == customSignIn
          ? _value.customSignIn
          : customSignIn // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsLoginCustomSignIn?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiComposeSettingsLoginImpl extends _UiComposeSettingsLogin {
  const _$UiComposeSettingsLoginImpl({this.customSignIn}) : super._();

  factory _$UiComposeSettingsLoginImpl.fromJson(Map<String, dynamic> json) =>
      _$$UiComposeSettingsLoginImplFromJson(json);

  @override
  final UiComposeSettingsLoginCustomSignIn? customSignIn;

  @override
  String toString() {
    return 'UiComposeSettingsLogin(customSignIn: $customSignIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiComposeSettingsLoginImpl &&
            (identical(other.customSignIn, customSignIn) ||
                other.customSignIn == customSignIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, customSignIn);

  /// Create a copy of UiComposeSettingsLogin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiComposeSettingsLoginImplCopyWith<_$UiComposeSettingsLoginImpl>
      get copyWith => __$$UiComposeSettingsLoginImplCopyWithImpl<
          _$UiComposeSettingsLoginImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UiComposeSettingsLoginImplToJson(
      this,
    );
  }
}

abstract class _UiComposeSettingsLogin extends UiComposeSettingsLogin {
  const factory _UiComposeSettingsLogin(
          {final UiComposeSettingsLoginCustomSignIn? customSignIn}) =
      _$UiComposeSettingsLoginImpl;
  const _UiComposeSettingsLogin._() : super._();

  factory _UiComposeSettingsLogin.fromJson(Map<String, dynamic> json) =
      _$UiComposeSettingsLoginImpl.fromJson;

  @override
  UiComposeSettingsLoginCustomSignIn? get customSignIn;

  /// Create a copy of UiComposeSettingsLogin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiComposeSettingsLoginImplCopyWith<_$UiComposeSettingsLoginImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UiComposeSettingsLoginCustomSignIn _$UiComposeSettingsLoginCustomSignInFromJson(
    Map<String, dynamic> json) {
  return _UiComposeSettingsLoginCustomSignIn.fromJson(json);
}

/// @nodoc
mixin _$UiComposeSettingsLoginCustomSignIn {
  bool? get enabled => throw _privateConstructorUsedError;
  String? get titleL10n => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this UiComposeSettingsLoginCustomSignIn to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UiComposeSettingsLoginCustomSignIn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UiComposeSettingsLoginCustomSignInCopyWith<
          UiComposeSettingsLoginCustomSignIn>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiComposeSettingsLoginCustomSignInCopyWith<$Res> {
  factory $UiComposeSettingsLoginCustomSignInCopyWith(
          UiComposeSettingsLoginCustomSignIn value,
          $Res Function(UiComposeSettingsLoginCustomSignIn) then) =
      _$UiComposeSettingsLoginCustomSignInCopyWithImpl<$Res,
          UiComposeSettingsLoginCustomSignIn>;
  @useResult
  $Res call({bool? enabled, String? titleL10n, String? url});
}

/// @nodoc
class _$UiComposeSettingsLoginCustomSignInCopyWithImpl<$Res,
        $Val extends UiComposeSettingsLoginCustomSignIn>
    implements $UiComposeSettingsLoginCustomSignInCopyWith<$Res> {
  _$UiComposeSettingsLoginCustomSignInCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiComposeSettingsLoginCustomSignIn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
    Object? titleL10n = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      titleL10n: freezed == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UiComposeSettingsLoginCustomSignInImplCopyWith<$Res>
    implements $UiComposeSettingsLoginCustomSignInCopyWith<$Res> {
  factory _$$UiComposeSettingsLoginCustomSignInImplCopyWith(
          _$UiComposeSettingsLoginCustomSignInImpl value,
          $Res Function(_$UiComposeSettingsLoginCustomSignInImpl) then) =
      __$$UiComposeSettingsLoginCustomSignInImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? enabled, String? titleL10n, String? url});
}

/// @nodoc
class __$$UiComposeSettingsLoginCustomSignInImplCopyWithImpl<$Res>
    extends _$UiComposeSettingsLoginCustomSignInCopyWithImpl<$Res,
        _$UiComposeSettingsLoginCustomSignInImpl>
    implements _$$UiComposeSettingsLoginCustomSignInImplCopyWith<$Res> {
  __$$UiComposeSettingsLoginCustomSignInImplCopyWithImpl(
      _$UiComposeSettingsLoginCustomSignInImpl _value,
      $Res Function(_$UiComposeSettingsLoginCustomSignInImpl) _then)
      : super(_value, _then);

  /// Create a copy of UiComposeSettingsLoginCustomSignIn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
    Object? titleL10n = freezed,
    Object? url = freezed,
  }) {
    return _then(_$UiComposeSettingsLoginCustomSignInImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      titleL10n: freezed == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiComposeSettingsLoginCustomSignInImpl
    extends _UiComposeSettingsLoginCustomSignIn {
  const _$UiComposeSettingsLoginCustomSignInImpl(
      {this.enabled, this.titleL10n, this.url})
      : super._();

  factory _$UiComposeSettingsLoginCustomSignInImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UiComposeSettingsLoginCustomSignInImplFromJson(json);

  @override
  final bool? enabled;
  @override
  final String? titleL10n;
  @override
  final String? url;

  @override
  String toString() {
    return 'UiComposeSettingsLoginCustomSignIn(enabled: $enabled, titleL10n: $titleL10n, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiComposeSettingsLoginCustomSignInImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.titleL10n, titleL10n) ||
                other.titleL10n == titleL10n) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, titleL10n, url);

  /// Create a copy of UiComposeSettingsLoginCustomSignIn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiComposeSettingsLoginCustomSignInImplCopyWith<
          _$UiComposeSettingsLoginCustomSignInImpl>
      get copyWith => __$$UiComposeSettingsLoginCustomSignInImplCopyWithImpl<
          _$UiComposeSettingsLoginCustomSignInImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UiComposeSettingsLoginCustomSignInImplToJson(
      this,
    );
  }
}

abstract class _UiComposeSettingsLoginCustomSignIn
    extends UiComposeSettingsLoginCustomSignIn {
  const factory _UiComposeSettingsLoginCustomSignIn(
      {final bool? enabled,
      final String? titleL10n,
      final String? url}) = _$UiComposeSettingsLoginCustomSignInImpl;
  const _UiComposeSettingsLoginCustomSignIn._() : super._();

  factory _UiComposeSettingsLoginCustomSignIn.fromJson(
          Map<String, dynamic> json) =
      _$UiComposeSettingsLoginCustomSignInImpl.fromJson;

  @override
  bool? get enabled;
  @override
  String? get titleL10n;
  @override
  String? get url;

  /// Create a copy of UiComposeSettingsLoginCustomSignIn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiComposeSettingsLoginCustomSignInImplCopyWith<
          _$UiComposeSettingsLoginCustomSignInImpl>
      get copyWith => throw _privateConstructorUsedError;
}
