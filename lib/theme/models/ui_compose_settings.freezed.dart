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
  UiComposeSettingsMain? get main => throw _privateConstructorUsedError;

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
  $Res call({UiComposeSettingsLogin? login, UiComposeSettingsMain? main});

  $UiComposeSettingsLoginCopyWith<$Res>? get login;
  $UiComposeSettingsMainCopyWith<$Res>? get main;
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
    Object? main = freezed,
  }) {
    return _then(_value.copyWith(
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsLogin?,
      main: freezed == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsMain?,
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

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UiComposeSettingsMainCopyWith<$Res>? get main {
    if (_value.main == null) {
      return null;
    }

    return $UiComposeSettingsMainCopyWith<$Res>(_value.main!, (value) {
      return _then(_value.copyWith(main: value) as $Val);
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
  $Res call({UiComposeSettingsLogin? login, UiComposeSettingsMain? main});

  @override
  $UiComposeSettingsLoginCopyWith<$Res>? get login;
  @override
  $UiComposeSettingsMainCopyWith<$Res>? get main;
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
    Object? main = freezed,
  }) {
    return _then(_$UiComposeSettingsImpl(
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsLogin?,
      main: freezed == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsMain?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiComposeSettingsImpl extends _UiComposeSettings {
  const _$UiComposeSettingsImpl({this.login, this.main}) : super._();

  factory _$UiComposeSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UiComposeSettingsImplFromJson(json);

  @override
  final UiComposeSettingsLogin? login;
  @override
  final UiComposeSettingsMain? main;

  @override
  String toString() {
    return 'UiComposeSettings(login: $login, main: $main)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiComposeSettingsImpl &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.main, main) || other.main == main));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, login, main);

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
  const factory _UiComposeSettings(
      {final UiComposeSettingsLogin? login,
      final UiComposeSettingsMain? main}) = _$UiComposeSettingsImpl;
  const _UiComposeSettings._() : super._();

  factory _UiComposeSettings.fromJson(Map<String, dynamic> json) =
      _$UiComposeSettingsImpl.fromJson;

  @override
  UiComposeSettingsLogin? get login;
  @override
  UiComposeSettingsMain? get main;

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

UiComposeSettingsMain _$UiComposeSettingsMainFromJson(
    Map<String, dynamic> json) {
  return _UiComposeSettingsMain.fromJson(json);
}

/// @nodoc
mixin _$UiComposeSettingsMain {
  UiComposeSettingsBottomMenu? get bottomMenu =>
      throw _privateConstructorUsedError;

  /// Serializes this UiComposeSettingsMain to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UiComposeSettingsMain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UiComposeSettingsMainCopyWith<UiComposeSettingsMain> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiComposeSettingsMainCopyWith<$Res> {
  factory $UiComposeSettingsMainCopyWith(UiComposeSettingsMain value,
          $Res Function(UiComposeSettingsMain) then) =
      _$UiComposeSettingsMainCopyWithImpl<$Res, UiComposeSettingsMain>;
  @useResult
  $Res call({UiComposeSettingsBottomMenu? bottomMenu});

  $UiComposeSettingsBottomMenuCopyWith<$Res>? get bottomMenu;
}

/// @nodoc
class _$UiComposeSettingsMainCopyWithImpl<$Res,
        $Val extends UiComposeSettingsMain>
    implements $UiComposeSettingsMainCopyWith<$Res> {
  _$UiComposeSettingsMainCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiComposeSettingsMain
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bottomMenu = freezed,
  }) {
    return _then(_value.copyWith(
      bottomMenu: freezed == bottomMenu
          ? _value.bottomMenu
          : bottomMenu // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsBottomMenu?,
    ) as $Val);
  }

  /// Create a copy of UiComposeSettingsMain
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UiComposeSettingsBottomMenuCopyWith<$Res>? get bottomMenu {
    if (_value.bottomMenu == null) {
      return null;
    }

    return $UiComposeSettingsBottomMenuCopyWith<$Res>(_value.bottomMenu!,
        (value) {
      return _then(_value.copyWith(bottomMenu: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UiComposeSettingsMainImplCopyWith<$Res>
    implements $UiComposeSettingsMainCopyWith<$Res> {
  factory _$$UiComposeSettingsMainImplCopyWith(
          _$UiComposeSettingsMainImpl value,
          $Res Function(_$UiComposeSettingsMainImpl) then) =
      __$$UiComposeSettingsMainImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UiComposeSettingsBottomMenu? bottomMenu});

  @override
  $UiComposeSettingsBottomMenuCopyWith<$Res>? get bottomMenu;
}

/// @nodoc
class __$$UiComposeSettingsMainImplCopyWithImpl<$Res>
    extends _$UiComposeSettingsMainCopyWithImpl<$Res,
        _$UiComposeSettingsMainImpl>
    implements _$$UiComposeSettingsMainImplCopyWith<$Res> {
  __$$UiComposeSettingsMainImplCopyWithImpl(_$UiComposeSettingsMainImpl _value,
      $Res Function(_$UiComposeSettingsMainImpl) _then)
      : super(_value, _then);

  /// Create a copy of UiComposeSettingsMain
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bottomMenu = freezed,
  }) {
    return _then(_$UiComposeSettingsMainImpl(
      bottomMenu: freezed == bottomMenu
          ? _value.bottomMenu
          : bottomMenu // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsBottomMenu?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiComposeSettingsMainImpl extends _UiComposeSettingsMain {
  const _$UiComposeSettingsMainImpl({this.bottomMenu}) : super._();

  factory _$UiComposeSettingsMainImpl.fromJson(Map<String, dynamic> json) =>
      _$$UiComposeSettingsMainImplFromJson(json);

  @override
  final UiComposeSettingsBottomMenu? bottomMenu;

  @override
  String toString() {
    return 'UiComposeSettingsMain(bottomMenu: $bottomMenu)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiComposeSettingsMainImpl &&
            (identical(other.bottomMenu, bottomMenu) ||
                other.bottomMenu == bottomMenu));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bottomMenu);

  /// Create a copy of UiComposeSettingsMain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiComposeSettingsMainImplCopyWith<_$UiComposeSettingsMainImpl>
      get copyWith => __$$UiComposeSettingsMainImplCopyWithImpl<
          _$UiComposeSettingsMainImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UiComposeSettingsMainImplToJson(
      this,
    );
  }
}

abstract class _UiComposeSettingsMain extends UiComposeSettingsMain {
  const factory _UiComposeSettingsMain(
          {final UiComposeSettingsBottomMenu? bottomMenu}) =
      _$UiComposeSettingsMainImpl;
  const _UiComposeSettingsMain._() : super._();

  factory _UiComposeSettingsMain.fromJson(Map<String, dynamic> json) =
      _$UiComposeSettingsMainImpl.fromJson;

  @override
  UiComposeSettingsBottomMenu? get bottomMenu;

  /// Create a copy of UiComposeSettingsMain
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiComposeSettingsMainImplCopyWith<_$UiComposeSettingsMainImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UiComposeSettingsBottomMenu _$UiComposeSettingsBottomMenuFromJson(
    Map<String, dynamic> json) {
  return _UiComposeSettingsBottomMenu.fromJson(json);
}

/// @nodoc
mixin _$UiComposeSettingsBottomMenu {
  bool get cacheSelectedTab => throw _privateConstructorUsedError;
  List<UiComposeSettingsBottomMenuTab> get tabs =>
      throw _privateConstructorUsedError;

  /// Serializes this UiComposeSettingsBottomMenu to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UiComposeSettingsBottomMenu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UiComposeSettingsBottomMenuCopyWith<UiComposeSettingsBottomMenu>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiComposeSettingsBottomMenuCopyWith<$Res> {
  factory $UiComposeSettingsBottomMenuCopyWith(
          UiComposeSettingsBottomMenu value,
          $Res Function(UiComposeSettingsBottomMenu) then) =
      _$UiComposeSettingsBottomMenuCopyWithImpl<$Res,
          UiComposeSettingsBottomMenu>;
  @useResult
  $Res call({bool cacheSelectedTab, List<UiComposeSettingsBottomMenuTab> tabs});
}

/// @nodoc
class _$UiComposeSettingsBottomMenuCopyWithImpl<$Res,
        $Val extends UiComposeSettingsBottomMenu>
    implements $UiComposeSettingsBottomMenuCopyWith<$Res> {
  _$UiComposeSettingsBottomMenuCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiComposeSettingsBottomMenu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacheSelectedTab = null,
    Object? tabs = null,
  }) {
    return _then(_value.copyWith(
      cacheSelectedTab: null == cacheSelectedTab
          ? _value.cacheSelectedTab
          : cacheSelectedTab // ignore: cast_nullable_to_non_nullable
              as bool,
      tabs: null == tabs
          ? _value.tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<UiComposeSettingsBottomMenuTab>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UiComposeSettingsBottomMenuImplCopyWith<$Res>
    implements $UiComposeSettingsBottomMenuCopyWith<$Res> {
  factory _$$UiComposeSettingsBottomMenuImplCopyWith(
          _$UiComposeSettingsBottomMenuImpl value,
          $Res Function(_$UiComposeSettingsBottomMenuImpl) then) =
      __$$UiComposeSettingsBottomMenuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool cacheSelectedTab, List<UiComposeSettingsBottomMenuTab> tabs});
}

/// @nodoc
class __$$UiComposeSettingsBottomMenuImplCopyWithImpl<$Res>
    extends _$UiComposeSettingsBottomMenuCopyWithImpl<$Res,
        _$UiComposeSettingsBottomMenuImpl>
    implements _$$UiComposeSettingsBottomMenuImplCopyWith<$Res> {
  __$$UiComposeSettingsBottomMenuImplCopyWithImpl(
      _$UiComposeSettingsBottomMenuImpl _value,
      $Res Function(_$UiComposeSettingsBottomMenuImpl) _then)
      : super(_value, _then);

  /// Create a copy of UiComposeSettingsBottomMenu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacheSelectedTab = null,
    Object? tabs = null,
  }) {
    return _then(_$UiComposeSettingsBottomMenuImpl(
      cacheSelectedTab: null == cacheSelectedTab
          ? _value.cacheSelectedTab
          : cacheSelectedTab // ignore: cast_nullable_to_non_nullable
              as bool,
      tabs: null == tabs
          ? _value._tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<UiComposeSettingsBottomMenuTab>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiComposeSettingsBottomMenuImpl extends _UiComposeSettingsBottomMenu {
  const _$UiComposeSettingsBottomMenuImpl(
      {this.cacheSelectedTab = true,
      final List<UiComposeSettingsBottomMenuTab> tabs = const []})
      : _tabs = tabs,
        super._();

  factory _$UiComposeSettingsBottomMenuImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UiComposeSettingsBottomMenuImplFromJson(json);

  @override
  @JsonKey()
  final bool cacheSelectedTab;
  final List<UiComposeSettingsBottomMenuTab> _tabs;
  @override
  @JsonKey()
  List<UiComposeSettingsBottomMenuTab> get tabs {
    if (_tabs is EqualUnmodifiableListView) return _tabs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabs);
  }

  @override
  String toString() {
    return 'UiComposeSettingsBottomMenu(cacheSelectedTab: $cacheSelectedTab, tabs: $tabs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiComposeSettingsBottomMenuImpl &&
            (identical(other.cacheSelectedTab, cacheSelectedTab) ||
                other.cacheSelectedTab == cacheSelectedTab) &&
            const DeepCollectionEquality().equals(other._tabs, _tabs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, cacheSelectedTab,
      const DeepCollectionEquality().hash(_tabs));

  /// Create a copy of UiComposeSettingsBottomMenu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiComposeSettingsBottomMenuImplCopyWith<_$UiComposeSettingsBottomMenuImpl>
      get copyWith => __$$UiComposeSettingsBottomMenuImplCopyWithImpl<
          _$UiComposeSettingsBottomMenuImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UiComposeSettingsBottomMenuImplToJson(
      this,
    );
  }
}

abstract class _UiComposeSettingsBottomMenu
    extends UiComposeSettingsBottomMenu {
  const factory _UiComposeSettingsBottomMenu(
          {final bool cacheSelectedTab,
          final List<UiComposeSettingsBottomMenuTab> tabs}) =
      _$UiComposeSettingsBottomMenuImpl;
  const _UiComposeSettingsBottomMenu._() : super._();

  factory _UiComposeSettingsBottomMenu.fromJson(Map<String, dynamic> json) =
      _$UiComposeSettingsBottomMenuImpl.fromJson;

  @override
  bool get cacheSelectedTab;
  @override
  List<UiComposeSettingsBottomMenuTab> get tabs;

  /// Create a copy of UiComposeSettingsBottomMenu
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiComposeSettingsBottomMenuImplCopyWith<_$UiComposeSettingsBottomMenuImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UiComposeSettingsBottomMenuTab _$UiComposeSettingsBottomMenuTabFromJson(
    Map<String, dynamic> json) {
  return _UiComposeSettingsBottomMenuTab.fromJson(json);
}

/// @nodoc
mixin _$UiComposeSettingsBottomMenuTab {
  bool get enabled => throw _privateConstructorUsedError;
  bool get initial => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get titleL10n => throw _privateConstructorUsedError;
  @IconDataConverter()
  IconData get icon => throw _privateConstructorUsedError;

  /// Serializes this UiComposeSettingsBottomMenuTab to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UiComposeSettingsBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UiComposeSettingsBottomMenuTabCopyWith<UiComposeSettingsBottomMenuTab>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiComposeSettingsBottomMenuTabCopyWith<$Res> {
  factory $UiComposeSettingsBottomMenuTabCopyWith(
          UiComposeSettingsBottomMenuTab value,
          $Res Function(UiComposeSettingsBottomMenuTab) then) =
      _$UiComposeSettingsBottomMenuTabCopyWithImpl<$Res,
          UiComposeSettingsBottomMenuTab>;
  @useResult
  $Res call(
      {bool enabled,
      bool initial,
      String type,
      String titleL10n,
      @IconDataConverter() IconData icon});
}

/// @nodoc
class _$UiComposeSettingsBottomMenuTabCopyWithImpl<$Res,
        $Val extends UiComposeSettingsBottomMenuTab>
    implements $UiComposeSettingsBottomMenuTabCopyWith<$Res> {
  _$UiComposeSettingsBottomMenuTabCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiComposeSettingsBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? initial = null,
    Object? type = null,
    Object? titleL10n = null,
    Object? icon = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      titleL10n: null == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UiComposeSettingsBottomMenuTabImplCopyWith<$Res>
    implements $UiComposeSettingsBottomMenuTabCopyWith<$Res> {
  factory _$$UiComposeSettingsBottomMenuTabImplCopyWith(
          _$UiComposeSettingsBottomMenuTabImpl value,
          $Res Function(_$UiComposeSettingsBottomMenuTabImpl) then) =
      __$$UiComposeSettingsBottomMenuTabImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool enabled,
      bool initial,
      String type,
      String titleL10n,
      @IconDataConverter() IconData icon});
}

/// @nodoc
class __$$UiComposeSettingsBottomMenuTabImplCopyWithImpl<$Res>
    extends _$UiComposeSettingsBottomMenuTabCopyWithImpl<$Res,
        _$UiComposeSettingsBottomMenuTabImpl>
    implements _$$UiComposeSettingsBottomMenuTabImplCopyWith<$Res> {
  __$$UiComposeSettingsBottomMenuTabImplCopyWithImpl(
      _$UiComposeSettingsBottomMenuTabImpl _value,
      $Res Function(_$UiComposeSettingsBottomMenuTabImpl) _then)
      : super(_value, _then);

  /// Create a copy of UiComposeSettingsBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? initial = null,
    Object? type = null,
    Object? titleL10n = null,
    Object? icon = null,
  }) {
    return _then(_$UiComposeSettingsBottomMenuTabImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      titleL10n: null == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiComposeSettingsBottomMenuTabImpl
    extends _UiComposeSettingsBottomMenuTab {
  const _$UiComposeSettingsBottomMenuTabImpl(
      {this.enabled = true,
      this.initial = false,
      required this.type,
      required this.titleL10n,
      @IconDataConverter() required this.icon})
      : super._();

  factory _$UiComposeSettingsBottomMenuTabImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UiComposeSettingsBottomMenuTabImplFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final bool initial;
  @override
  final String type;
  @override
  final String titleL10n;
  @override
  @IconDataConverter()
  final IconData icon;

  @override
  String toString() {
    return 'UiComposeSettingsBottomMenuTab(enabled: $enabled, initial: $initial, type: $type, titleL10n: $titleL10n, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiComposeSettingsBottomMenuTabImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.initial, initial) || other.initial == initial) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.titleL10n, titleL10n) ||
                other.titleL10n == titleL10n) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, enabled, initial, type, titleL10n, icon);

  /// Create a copy of UiComposeSettingsBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiComposeSettingsBottomMenuTabImplCopyWith<
          _$UiComposeSettingsBottomMenuTabImpl>
      get copyWith => __$$UiComposeSettingsBottomMenuTabImplCopyWithImpl<
          _$UiComposeSettingsBottomMenuTabImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UiComposeSettingsBottomMenuTabImplToJson(
      this,
    );
  }
}

abstract class _UiComposeSettingsBottomMenuTab
    extends UiComposeSettingsBottomMenuTab {
  const factory _UiComposeSettingsBottomMenuTab(
          {final bool enabled,
          final bool initial,
          required final String type,
          required final String titleL10n,
          @IconDataConverter() required final IconData icon}) =
      _$UiComposeSettingsBottomMenuTabImpl;
  const _UiComposeSettingsBottomMenuTab._() : super._();

  factory _UiComposeSettingsBottomMenuTab.fromJson(Map<String, dynamic> json) =
      _$UiComposeSettingsBottomMenuTabImpl.fromJson;

  @override
  bool get enabled;
  @override
  bool get initial;
  @override
  String get type;
  @override
  String get titleL10n;
  @override
  @IconDataConverter()
  IconData get icon;

  /// Create a copy of UiComposeSettingsBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiComposeSettingsBottomMenuTabImplCopyWith<
          _$UiComposeSettingsBottomMenuTabImpl>
      get copyWith => throw _privateConstructorUsedError;
}
