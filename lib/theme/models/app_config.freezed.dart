// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) {
  return _AppConfig.fromJson(json);
}

/// @nodoc
mixin _$AppConfig {
  AppConfigLogin? get login => throw _privateConstructorUsedError;
  AppConfigMain? get main => throw _privateConstructorUsedError;
  AppConfigSettings? get settings => throw _privateConstructorUsedError;

  /// Serializes this AppConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppConfigCopyWith<AppConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigCopyWith<$Res> {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) then) =
      _$AppConfigCopyWithImpl<$Res, AppConfig>;
  @useResult
  $Res call(
      {AppConfigLogin? login,
      AppConfigMain? main,
      AppConfigSettings? settings});

  $AppConfigLoginCopyWith<$Res>? get login;
  $AppConfigMainCopyWith<$Res>? get main;
  $AppConfigSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class _$AppConfigCopyWithImpl<$Res, $Val extends AppConfig>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = freezed,
    Object? main = freezed,
    Object? settings = freezed,
  }) {
    return _then(_value.copyWith(
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as AppConfigLogin?,
      main: freezed == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as AppConfigMain?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AppConfigSettings?,
    ) as $Val);
  }

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppConfigLoginCopyWith<$Res>? get login {
    if (_value.login == null) {
      return null;
    }

    return $AppConfigLoginCopyWith<$Res>(_value.login!, (value) {
      return _then(_value.copyWith(login: value) as $Val);
    });
  }

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppConfigMainCopyWith<$Res>? get main {
    if (_value.main == null) {
      return null;
    }

    return $AppConfigMainCopyWith<$Res>(_value.main!, (value) {
      return _then(_value.copyWith(main: value) as $Val);
    });
  }

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppConfigSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $AppConfigSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppConfigImplCopyWith<$Res>
    implements $AppConfigCopyWith<$Res> {
  factory _$$AppConfigImplCopyWith(
          _$AppConfigImpl value, $Res Function(_$AppConfigImpl) then) =
      __$$AppConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppConfigLogin? login,
      AppConfigMain? main,
      AppConfigSettings? settings});

  @override
  $AppConfigLoginCopyWith<$Res>? get login;
  @override
  $AppConfigMainCopyWith<$Res>? get main;
  @override
  $AppConfigSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class __$$AppConfigImplCopyWithImpl<$Res>
    extends _$AppConfigCopyWithImpl<$Res, _$AppConfigImpl>
    implements _$$AppConfigImplCopyWith<$Res> {
  __$$AppConfigImplCopyWithImpl(
      _$AppConfigImpl _value, $Res Function(_$AppConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = freezed,
    Object? main = freezed,
    Object? settings = freezed,
  }) {
    return _then(_$AppConfigImpl(
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as AppConfigLogin?,
      main: freezed == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as AppConfigMain?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AppConfigSettings?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigImpl extends _AppConfig {
  const _$AppConfigImpl({this.login, this.main, this.settings}) : super._();

  factory _$AppConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigImplFromJson(json);

  @override
  final AppConfigLogin? login;
  @override
  final AppConfigMain? main;
  @override
  final AppConfigSettings? settings;

  @override
  String toString() {
    return 'AppConfig(login: $login, main: $main, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigImpl &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.main, main) || other.main == main) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, login, main, settings);

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigImplCopyWith<_$AppConfigImpl> get copyWith =>
      __$$AppConfigImplCopyWithImpl<_$AppConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigImplToJson(
      this,
    );
  }
}

abstract class _AppConfig extends AppConfig {
  const factory _AppConfig(
      {final AppConfigLogin? login,
      final AppConfigMain? main,
      final AppConfigSettings? settings}) = _$AppConfigImpl;
  const _AppConfig._() : super._();

  factory _AppConfig.fromJson(Map<String, dynamic> json) =
      _$AppConfigImpl.fromJson;

  @override
  AppConfigLogin? get login;
  @override
  AppConfigMain? get main;
  @override
  AppConfigSettings? get settings;

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConfigImplCopyWith<_$AppConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppConfigLogin _$AppConfigLoginFromJson(Map<String, dynamic> json) {
  return _AppConfigLogin.fromJson(json);
}

/// @nodoc
mixin _$AppConfigLogin {
  AppConfigLoginCustomSignIn? get customSignIn =>
      throw _privateConstructorUsedError;

  /// Serializes this AppConfigLogin to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppConfigLogin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppConfigLoginCopyWith<AppConfigLogin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigLoginCopyWith<$Res> {
  factory $AppConfigLoginCopyWith(
          AppConfigLogin value, $Res Function(AppConfigLogin) then) =
      _$AppConfigLoginCopyWithImpl<$Res, AppConfigLogin>;
  @useResult
  $Res call({AppConfigLoginCustomSignIn? customSignIn});

  $AppConfigLoginCustomSignInCopyWith<$Res>? get customSignIn;
}

/// @nodoc
class _$AppConfigLoginCopyWithImpl<$Res, $Val extends AppConfigLogin>
    implements $AppConfigLoginCopyWith<$Res> {
  _$AppConfigLoginCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppConfigLogin
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
              as AppConfigLoginCustomSignIn?,
    ) as $Val);
  }

  /// Create a copy of AppConfigLogin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppConfigLoginCustomSignInCopyWith<$Res>? get customSignIn {
    if (_value.customSignIn == null) {
      return null;
    }

    return $AppConfigLoginCustomSignInCopyWith<$Res>(_value.customSignIn!,
        (value) {
      return _then(_value.copyWith(customSignIn: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppConfigLoginImplCopyWith<$Res>
    implements $AppConfigLoginCopyWith<$Res> {
  factory _$$AppConfigLoginImplCopyWith(_$AppConfigLoginImpl value,
          $Res Function(_$AppConfigLoginImpl) then) =
      __$$AppConfigLoginImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppConfigLoginCustomSignIn? customSignIn});

  @override
  $AppConfigLoginCustomSignInCopyWith<$Res>? get customSignIn;
}

/// @nodoc
class __$$AppConfigLoginImplCopyWithImpl<$Res>
    extends _$AppConfigLoginCopyWithImpl<$Res, _$AppConfigLoginImpl>
    implements _$$AppConfigLoginImplCopyWith<$Res> {
  __$$AppConfigLoginImplCopyWithImpl(
      _$AppConfigLoginImpl _value, $Res Function(_$AppConfigLoginImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppConfigLogin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customSignIn = freezed,
  }) {
    return _then(_$AppConfigLoginImpl(
      customSignIn: freezed == customSignIn
          ? _value.customSignIn
          : customSignIn // ignore: cast_nullable_to_non_nullable
              as AppConfigLoginCustomSignIn?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigLoginImpl extends _AppConfigLogin {
  const _$AppConfigLoginImpl({this.customSignIn}) : super._();

  factory _$AppConfigLoginImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigLoginImplFromJson(json);

  @override
  final AppConfigLoginCustomSignIn? customSignIn;

  @override
  String toString() {
    return 'AppConfigLogin(customSignIn: $customSignIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigLoginImpl &&
            (identical(other.customSignIn, customSignIn) ||
                other.customSignIn == customSignIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, customSignIn);

  /// Create a copy of AppConfigLogin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigLoginImplCopyWith<_$AppConfigLoginImpl> get copyWith =>
      __$$AppConfigLoginImplCopyWithImpl<_$AppConfigLoginImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigLoginImplToJson(
      this,
    );
  }
}

abstract class _AppConfigLogin extends AppConfigLogin {
  const factory _AppConfigLogin(
      {final AppConfigLoginCustomSignIn? customSignIn}) = _$AppConfigLoginImpl;
  const _AppConfigLogin._() : super._();

  factory _AppConfigLogin.fromJson(Map<String, dynamic> json) =
      _$AppConfigLoginImpl.fromJson;

  @override
  AppConfigLoginCustomSignIn? get customSignIn;

  /// Create a copy of AppConfigLogin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConfigLoginImplCopyWith<_$AppConfigLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppConfigLoginCustomSignIn _$AppConfigLoginCustomSignInFromJson(
    Map<String, dynamic> json) {
  return _AppConfigLoginCustomSignIn.fromJson(json);
}

/// @nodoc
mixin _$AppConfigLoginCustomSignIn {
  bool? get enabled => throw _privateConstructorUsedError;
  String? get titleL10n => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this AppConfigLoginCustomSignIn to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppConfigLoginCustomSignIn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppConfigLoginCustomSignInCopyWith<AppConfigLoginCustomSignIn>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigLoginCustomSignInCopyWith<$Res> {
  factory $AppConfigLoginCustomSignInCopyWith(AppConfigLoginCustomSignIn value,
          $Res Function(AppConfigLoginCustomSignIn) then) =
      _$AppConfigLoginCustomSignInCopyWithImpl<$Res,
          AppConfigLoginCustomSignIn>;
  @useResult
  $Res call({bool? enabled, String? titleL10n, String? url});
}

/// @nodoc
class _$AppConfigLoginCustomSignInCopyWithImpl<$Res,
        $Val extends AppConfigLoginCustomSignIn>
    implements $AppConfigLoginCustomSignInCopyWith<$Res> {
  _$AppConfigLoginCustomSignInCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppConfigLoginCustomSignIn
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
abstract class _$$AppConfigLoginCustomSignInImplCopyWith<$Res>
    implements $AppConfigLoginCustomSignInCopyWith<$Res> {
  factory _$$AppConfigLoginCustomSignInImplCopyWith(
          _$AppConfigLoginCustomSignInImpl value,
          $Res Function(_$AppConfigLoginCustomSignInImpl) then) =
      __$$AppConfigLoginCustomSignInImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? enabled, String? titleL10n, String? url});
}

/// @nodoc
class __$$AppConfigLoginCustomSignInImplCopyWithImpl<$Res>
    extends _$AppConfigLoginCustomSignInCopyWithImpl<$Res,
        _$AppConfigLoginCustomSignInImpl>
    implements _$$AppConfigLoginCustomSignInImplCopyWith<$Res> {
  __$$AppConfigLoginCustomSignInImplCopyWithImpl(
      _$AppConfigLoginCustomSignInImpl _value,
      $Res Function(_$AppConfigLoginCustomSignInImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppConfigLoginCustomSignIn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
    Object? titleL10n = freezed,
    Object? url = freezed,
  }) {
    return _then(_$AppConfigLoginCustomSignInImpl(
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
class _$AppConfigLoginCustomSignInImpl extends _AppConfigLoginCustomSignIn {
  const _$AppConfigLoginCustomSignInImpl(
      {this.enabled, this.titleL10n, this.url})
      : super._();

  factory _$AppConfigLoginCustomSignInImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AppConfigLoginCustomSignInImplFromJson(json);

  @override
  final bool? enabled;
  @override
  final String? titleL10n;
  @override
  final String? url;

  @override
  String toString() {
    return 'AppConfigLoginCustomSignIn(enabled: $enabled, titleL10n: $titleL10n, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigLoginCustomSignInImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.titleL10n, titleL10n) ||
                other.titleL10n == titleL10n) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, titleL10n, url);

  /// Create a copy of AppConfigLoginCustomSignIn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigLoginCustomSignInImplCopyWith<_$AppConfigLoginCustomSignInImpl>
      get copyWith => __$$AppConfigLoginCustomSignInImplCopyWithImpl<
          _$AppConfigLoginCustomSignInImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigLoginCustomSignInImplToJson(
      this,
    );
  }
}

abstract class _AppConfigLoginCustomSignIn extends AppConfigLoginCustomSignIn {
  const factory _AppConfigLoginCustomSignIn(
      {final bool? enabled,
      final String? titleL10n,
      final String? url}) = _$AppConfigLoginCustomSignInImpl;
  const _AppConfigLoginCustomSignIn._() : super._();

  factory _AppConfigLoginCustomSignIn.fromJson(Map<String, dynamic> json) =
      _$AppConfigLoginCustomSignInImpl.fromJson;

  @override
  bool? get enabled;
  @override
  String? get titleL10n;
  @override
  String? get url;

  /// Create a copy of AppConfigLoginCustomSignIn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConfigLoginCustomSignInImplCopyWith<_$AppConfigLoginCustomSignInImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppConfigMain _$AppConfigMainFromJson(Map<String, dynamic> json) {
  return _AppConfigMain.fromJson(json);
}

/// @nodoc
mixin _$AppConfigMain {
  AppConfigBottomMenu? get bottomMenu => throw _privateConstructorUsedError;

  /// Serializes this AppConfigMain to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppConfigMain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppConfigMainCopyWith<AppConfigMain> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigMainCopyWith<$Res> {
  factory $AppConfigMainCopyWith(
          AppConfigMain value, $Res Function(AppConfigMain) then) =
      _$AppConfigMainCopyWithImpl<$Res, AppConfigMain>;
  @useResult
  $Res call({AppConfigBottomMenu? bottomMenu});

  $AppConfigBottomMenuCopyWith<$Res>? get bottomMenu;
}

/// @nodoc
class _$AppConfigMainCopyWithImpl<$Res, $Val extends AppConfigMain>
    implements $AppConfigMainCopyWith<$Res> {
  _$AppConfigMainCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppConfigMain
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
              as AppConfigBottomMenu?,
    ) as $Val);
  }

  /// Create a copy of AppConfigMain
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppConfigBottomMenuCopyWith<$Res>? get bottomMenu {
    if (_value.bottomMenu == null) {
      return null;
    }

    return $AppConfigBottomMenuCopyWith<$Res>(_value.bottomMenu!, (value) {
      return _then(_value.copyWith(bottomMenu: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppConfigMainImplCopyWith<$Res>
    implements $AppConfigMainCopyWith<$Res> {
  factory _$$AppConfigMainImplCopyWith(
          _$AppConfigMainImpl value, $Res Function(_$AppConfigMainImpl) then) =
      __$$AppConfigMainImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppConfigBottomMenu? bottomMenu});

  @override
  $AppConfigBottomMenuCopyWith<$Res>? get bottomMenu;
}

/// @nodoc
class __$$AppConfigMainImplCopyWithImpl<$Res>
    extends _$AppConfigMainCopyWithImpl<$Res, _$AppConfigMainImpl>
    implements _$$AppConfigMainImplCopyWith<$Res> {
  __$$AppConfigMainImplCopyWithImpl(
      _$AppConfigMainImpl _value, $Res Function(_$AppConfigMainImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppConfigMain
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bottomMenu = freezed,
  }) {
    return _then(_$AppConfigMainImpl(
      bottomMenu: freezed == bottomMenu
          ? _value.bottomMenu
          : bottomMenu // ignore: cast_nullable_to_non_nullable
              as AppConfigBottomMenu?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigMainImpl extends _AppConfigMain {
  const _$AppConfigMainImpl({this.bottomMenu}) : super._();

  factory _$AppConfigMainImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigMainImplFromJson(json);

  @override
  final AppConfigBottomMenu? bottomMenu;

  @override
  String toString() {
    return 'AppConfigMain(bottomMenu: $bottomMenu)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigMainImpl &&
            (identical(other.bottomMenu, bottomMenu) ||
                other.bottomMenu == bottomMenu));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bottomMenu);

  /// Create a copy of AppConfigMain
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigMainImplCopyWith<_$AppConfigMainImpl> get copyWith =>
      __$$AppConfigMainImplCopyWithImpl<_$AppConfigMainImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigMainImplToJson(
      this,
    );
  }
}

abstract class _AppConfigMain extends AppConfigMain {
  const factory _AppConfigMain({final AppConfigBottomMenu? bottomMenu}) =
      _$AppConfigMainImpl;
  const _AppConfigMain._() : super._();

  factory _AppConfigMain.fromJson(Map<String, dynamic> json) =
      _$AppConfigMainImpl.fromJson;

  @override
  AppConfigBottomMenu? get bottomMenu;

  /// Create a copy of AppConfigMain
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConfigMainImplCopyWith<_$AppConfigMainImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppConfigBottomMenu _$AppConfigBottomMenuFromJson(Map<String, dynamic> json) {
  return _AppConfigBottomMenu.fromJson(json);
}

/// @nodoc
mixin _$AppConfigBottomMenu {
  bool get cacheSelectedTab => throw _privateConstructorUsedError;
  List<AppConfigBottomMenuTab> get tabs => throw _privateConstructorUsedError;

  /// Serializes this AppConfigBottomMenu to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppConfigBottomMenu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppConfigBottomMenuCopyWith<AppConfigBottomMenu> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigBottomMenuCopyWith<$Res> {
  factory $AppConfigBottomMenuCopyWith(
          AppConfigBottomMenu value, $Res Function(AppConfigBottomMenu) then) =
      _$AppConfigBottomMenuCopyWithImpl<$Res, AppConfigBottomMenu>;
  @useResult
  $Res call({bool cacheSelectedTab, List<AppConfigBottomMenuTab> tabs});
}

/// @nodoc
class _$AppConfigBottomMenuCopyWithImpl<$Res, $Val extends AppConfigBottomMenu>
    implements $AppConfigBottomMenuCopyWith<$Res> {
  _$AppConfigBottomMenuCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppConfigBottomMenu
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
              as List<AppConfigBottomMenuTab>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppConfigBottomMenuImplCopyWith<$Res>
    implements $AppConfigBottomMenuCopyWith<$Res> {
  factory _$$AppConfigBottomMenuImplCopyWith(_$AppConfigBottomMenuImpl value,
          $Res Function(_$AppConfigBottomMenuImpl) then) =
      __$$AppConfigBottomMenuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool cacheSelectedTab, List<AppConfigBottomMenuTab> tabs});
}

/// @nodoc
class __$$AppConfigBottomMenuImplCopyWithImpl<$Res>
    extends _$AppConfigBottomMenuCopyWithImpl<$Res, _$AppConfigBottomMenuImpl>
    implements _$$AppConfigBottomMenuImplCopyWith<$Res> {
  __$$AppConfigBottomMenuImplCopyWithImpl(_$AppConfigBottomMenuImpl _value,
      $Res Function(_$AppConfigBottomMenuImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppConfigBottomMenu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacheSelectedTab = null,
    Object? tabs = null,
  }) {
    return _then(_$AppConfigBottomMenuImpl(
      cacheSelectedTab: null == cacheSelectedTab
          ? _value.cacheSelectedTab
          : cacheSelectedTab // ignore: cast_nullable_to_non_nullable
              as bool,
      tabs: null == tabs
          ? _value._tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<AppConfigBottomMenuTab>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigBottomMenuImpl extends _AppConfigBottomMenu {
  const _$AppConfigBottomMenuImpl(
      {this.cacheSelectedTab = true,
      final List<AppConfigBottomMenuTab> tabs = const []})
      : _tabs = tabs,
        super._();

  factory _$AppConfigBottomMenuImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigBottomMenuImplFromJson(json);

  @override
  @JsonKey()
  final bool cacheSelectedTab;
  final List<AppConfigBottomMenuTab> _tabs;
  @override
  @JsonKey()
  List<AppConfigBottomMenuTab> get tabs {
    if (_tabs is EqualUnmodifiableListView) return _tabs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabs);
  }

  @override
  String toString() {
    return 'AppConfigBottomMenu(cacheSelectedTab: $cacheSelectedTab, tabs: $tabs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigBottomMenuImpl &&
            (identical(other.cacheSelectedTab, cacheSelectedTab) ||
                other.cacheSelectedTab == cacheSelectedTab) &&
            const DeepCollectionEquality().equals(other._tabs, _tabs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, cacheSelectedTab,
      const DeepCollectionEquality().hash(_tabs));

  /// Create a copy of AppConfigBottomMenu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigBottomMenuImplCopyWith<_$AppConfigBottomMenuImpl> get copyWith =>
      __$$AppConfigBottomMenuImplCopyWithImpl<_$AppConfigBottomMenuImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigBottomMenuImplToJson(
      this,
    );
  }
}

abstract class _AppConfigBottomMenu extends AppConfigBottomMenu {
  const factory _AppConfigBottomMenu(
      {final bool cacheSelectedTab,
      final List<AppConfigBottomMenuTab> tabs}) = _$AppConfigBottomMenuImpl;
  const _AppConfigBottomMenu._() : super._();

  factory _AppConfigBottomMenu.fromJson(Map<String, dynamic> json) =
      _$AppConfigBottomMenuImpl.fromJson;

  @override
  bool get cacheSelectedTab;
  @override
  List<AppConfigBottomMenuTab> get tabs;

  /// Create a copy of AppConfigBottomMenu
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConfigBottomMenuImplCopyWith<_$AppConfigBottomMenuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppConfigBottomMenuTab _$AppConfigBottomMenuTabFromJson(
    Map<String, dynamic> json) {
  return _AppConfigBottomMenuTab.fromJson(json);
}

/// @nodoc
mixin _$AppConfigBottomMenuTab {
  bool get enabled => throw _privateConstructorUsedError;
  bool get initial => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get titleL10n => throw _privateConstructorUsedError;
  @IconDataConverter()
  IconData get icon => throw _privateConstructorUsedError;
  AppConfigData? get data => throw _privateConstructorUsedError;

  /// Serializes this AppConfigBottomMenuTab to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppConfigBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppConfigBottomMenuTabCopyWith<AppConfigBottomMenuTab> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigBottomMenuTabCopyWith<$Res> {
  factory $AppConfigBottomMenuTabCopyWith(AppConfigBottomMenuTab value,
          $Res Function(AppConfigBottomMenuTab) then) =
      _$AppConfigBottomMenuTabCopyWithImpl<$Res, AppConfigBottomMenuTab>;
  @useResult
  $Res call(
      {bool enabled,
      bool initial,
      String type,
      String titleL10n,
      @IconDataConverter() IconData icon,
      AppConfigData? data});

  $AppConfigDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$AppConfigBottomMenuTabCopyWithImpl<$Res,
        $Val extends AppConfigBottomMenuTab>
    implements $AppConfigBottomMenuTabCopyWith<$Res> {
  _$AppConfigBottomMenuTabCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppConfigBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? initial = null,
    Object? type = null,
    Object? titleL10n = null,
    Object? icon = null,
    Object? data = freezed,
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
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AppConfigData?,
    ) as $Val);
  }

  /// Create a copy of AppConfigBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppConfigDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $AppConfigDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppConfigBottomMenuTabImplCopyWith<$Res>
    implements $AppConfigBottomMenuTabCopyWith<$Res> {
  factory _$$AppConfigBottomMenuTabImplCopyWith(
          _$AppConfigBottomMenuTabImpl value,
          $Res Function(_$AppConfigBottomMenuTabImpl) then) =
      __$$AppConfigBottomMenuTabImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool enabled,
      bool initial,
      String type,
      String titleL10n,
      @IconDataConverter() IconData icon,
      AppConfigData? data});

  @override
  $AppConfigDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$AppConfigBottomMenuTabImplCopyWithImpl<$Res>
    extends _$AppConfigBottomMenuTabCopyWithImpl<$Res,
        _$AppConfigBottomMenuTabImpl>
    implements _$$AppConfigBottomMenuTabImplCopyWith<$Res> {
  __$$AppConfigBottomMenuTabImplCopyWithImpl(
      _$AppConfigBottomMenuTabImpl _value,
      $Res Function(_$AppConfigBottomMenuTabImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppConfigBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? initial = null,
    Object? type = null,
    Object? titleL10n = null,
    Object? icon = null,
    Object? data = freezed,
  }) {
    return _then(_$AppConfigBottomMenuTabImpl(
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
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AppConfigData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigBottomMenuTabImpl extends _AppConfigBottomMenuTab {
  const _$AppConfigBottomMenuTabImpl(
      {this.enabled = true,
      this.initial = false,
      required this.type,
      required this.titleL10n,
      @IconDataConverter() required this.icon,
      this.data})
      : super._();

  factory _$AppConfigBottomMenuTabImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigBottomMenuTabImplFromJson(json);

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
  final AppConfigData? data;

  @override
  String toString() {
    return 'AppConfigBottomMenuTab(enabled: $enabled, initial: $initial, type: $type, titleL10n: $titleL10n, icon: $icon, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigBottomMenuTabImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.initial, initial) || other.initial == initial) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.titleL10n, titleL10n) ||
                other.titleL10n == titleL10n) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, enabled, initial, type, titleL10n, icon, data);

  /// Create a copy of AppConfigBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigBottomMenuTabImplCopyWith<_$AppConfigBottomMenuTabImpl>
      get copyWith => __$$AppConfigBottomMenuTabImplCopyWithImpl<
          _$AppConfigBottomMenuTabImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigBottomMenuTabImplToJson(
      this,
    );
  }
}

abstract class _AppConfigBottomMenuTab extends AppConfigBottomMenuTab {
  const factory _AppConfigBottomMenuTab(
      {final bool enabled,
      final bool initial,
      required final String type,
      required final String titleL10n,
      @IconDataConverter() required final IconData icon,
      final AppConfigData? data}) = _$AppConfigBottomMenuTabImpl;
  const _AppConfigBottomMenuTab._() : super._();

  factory _AppConfigBottomMenuTab.fromJson(Map<String, dynamic> json) =
      _$AppConfigBottomMenuTabImpl.fromJson;

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
  @override
  AppConfigData? get data;

  /// Create a copy of AppConfigBottomMenuTab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConfigBottomMenuTabImplCopyWith<_$AppConfigBottomMenuTabImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppConfigSettings _$AppConfigSettingsFromJson(Map<String, dynamic> json) {
  return _AppConfigSettings.fromJson(json);
}

/// @nodoc
mixin _$AppConfigSettings {
  List<AppConfigSettingsSection> get sections =>
      throw _privateConstructorUsedError;

  /// Serializes this AppConfigSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppConfigSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppConfigSettingsCopyWith<AppConfigSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigSettingsCopyWith<$Res> {
  factory $AppConfigSettingsCopyWith(
          AppConfigSettings value, $Res Function(AppConfigSettings) then) =
      _$AppConfigSettingsCopyWithImpl<$Res, AppConfigSettings>;
  @useResult
  $Res call({List<AppConfigSettingsSection> sections});
}

/// @nodoc
class _$AppConfigSettingsCopyWithImpl<$Res, $Val extends AppConfigSettings>
    implements $AppConfigSettingsCopyWith<$Res> {
  _$AppConfigSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppConfigSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sections = null,
  }) {
    return _then(_value.copyWith(
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<AppConfigSettingsSection>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppConfigSettingsImplCopyWith<$Res>
    implements $AppConfigSettingsCopyWith<$Res> {
  factory _$$AppConfigSettingsImplCopyWith(_$AppConfigSettingsImpl value,
          $Res Function(_$AppConfigSettingsImpl) then) =
      __$$AppConfigSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AppConfigSettingsSection> sections});
}

/// @nodoc
class __$$AppConfigSettingsImplCopyWithImpl<$Res>
    extends _$AppConfigSettingsCopyWithImpl<$Res, _$AppConfigSettingsImpl>
    implements _$$AppConfigSettingsImplCopyWith<$Res> {
  __$$AppConfigSettingsImplCopyWithImpl(_$AppConfigSettingsImpl _value,
      $Res Function(_$AppConfigSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppConfigSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sections = null,
  }) {
    return _then(_$AppConfigSettingsImpl(
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<AppConfigSettingsSection>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigSettingsImpl extends _AppConfigSettings {
  const _$AppConfigSettingsImpl(
      {final List<AppConfigSettingsSection> sections = const []})
      : _sections = sections,
        super._();

  factory _$AppConfigSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigSettingsImplFromJson(json);

  final List<AppConfigSettingsSection> _sections;
  @override
  @JsonKey()
  List<AppConfigSettingsSection> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  String toString() {
    return 'AppConfigSettings(sections: $sections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigSettingsImpl &&
            const DeepCollectionEquality().equals(other._sections, _sections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_sections));

  /// Create a copy of AppConfigSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigSettingsImplCopyWith<_$AppConfigSettingsImpl> get copyWith =>
      __$$AppConfigSettingsImplCopyWithImpl<_$AppConfigSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigSettingsImplToJson(
      this,
    );
  }
}

abstract class _AppConfigSettings extends AppConfigSettings {
  const factory _AppConfigSettings(
          {final List<AppConfigSettingsSection> sections}) =
      _$AppConfigSettingsImpl;
  const _AppConfigSettings._() : super._();

  factory _AppConfigSettings.fromJson(Map<String, dynamic> json) =
      _$AppConfigSettingsImpl.fromJson;

  @override
  List<AppConfigSettingsSection> get sections;

  /// Create a copy of AppConfigSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConfigSettingsImplCopyWith<_$AppConfigSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppConfigSettingsSection _$AppConfigSettingsSectionFromJson(
    Map<String, dynamic> json) {
  return _AppConfigSettingsSection.fromJson(json);
}

/// @nodoc
mixin _$AppConfigSettingsSection {
  String get titleL10n => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  List<AppConfigSettingsItem> get items => throw _privateConstructorUsedError;

  /// Serializes this AppConfigSettingsSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppConfigSettingsSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppConfigSettingsSectionCopyWith<AppConfigSettingsSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigSettingsSectionCopyWith<$Res> {
  factory $AppConfigSettingsSectionCopyWith(AppConfigSettingsSection value,
          $Res Function(AppConfigSettingsSection) then) =
      _$AppConfigSettingsSectionCopyWithImpl<$Res, AppConfigSettingsSection>;
  @useResult
  $Res call(
      {String titleL10n, bool enabled, List<AppConfigSettingsItem> items});
}

/// @nodoc
class _$AppConfigSettingsSectionCopyWithImpl<$Res,
        $Val extends AppConfigSettingsSection>
    implements $AppConfigSettingsSectionCopyWith<$Res> {
  _$AppConfigSettingsSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppConfigSettingsSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleL10n = null,
    Object? enabled = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      titleL10n: null == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<AppConfigSettingsItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppConfigSettingsSectionImplCopyWith<$Res>
    implements $AppConfigSettingsSectionCopyWith<$Res> {
  factory _$$AppConfigSettingsSectionImplCopyWith(
          _$AppConfigSettingsSectionImpl value,
          $Res Function(_$AppConfigSettingsSectionImpl) then) =
      __$$AppConfigSettingsSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String titleL10n, bool enabled, List<AppConfigSettingsItem> items});
}

/// @nodoc
class __$$AppConfigSettingsSectionImplCopyWithImpl<$Res>
    extends _$AppConfigSettingsSectionCopyWithImpl<$Res,
        _$AppConfigSettingsSectionImpl>
    implements _$$AppConfigSettingsSectionImplCopyWith<$Res> {
  __$$AppConfigSettingsSectionImplCopyWithImpl(
      _$AppConfigSettingsSectionImpl _value,
      $Res Function(_$AppConfigSettingsSectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppConfigSettingsSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleL10n = null,
    Object? enabled = null,
    Object? items = null,
  }) {
    return _then(_$AppConfigSettingsSectionImpl(
      titleL10n: null == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<AppConfigSettingsItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigSettingsSectionImpl extends _AppConfigSettingsSection {
  const _$AppConfigSettingsSectionImpl(
      {required this.titleL10n,
      this.enabled = true,
      final List<AppConfigSettingsItem> items = const []})
      : _items = items,
        super._();

  factory _$AppConfigSettingsSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigSettingsSectionImplFromJson(json);

  @override
  final String titleL10n;
  @override
  @JsonKey()
  final bool enabled;
  final List<AppConfigSettingsItem> _items;
  @override
  @JsonKey()
  List<AppConfigSettingsItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'AppConfigSettingsSection(titleL10n: $titleL10n, enabled: $enabled, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigSettingsSectionImpl &&
            (identical(other.titleL10n, titleL10n) ||
                other.titleL10n == titleL10n) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, titleL10n, enabled,
      const DeepCollectionEquality().hash(_items));

  /// Create a copy of AppConfigSettingsSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigSettingsSectionImplCopyWith<_$AppConfigSettingsSectionImpl>
      get copyWith => __$$AppConfigSettingsSectionImplCopyWithImpl<
          _$AppConfigSettingsSectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigSettingsSectionImplToJson(
      this,
    );
  }
}

abstract class _AppConfigSettingsSection extends AppConfigSettingsSection {
  const factory _AppConfigSettingsSection(
          {required final String titleL10n,
          final bool enabled,
          final List<AppConfigSettingsItem> items}) =
      _$AppConfigSettingsSectionImpl;
  const _AppConfigSettingsSection._() : super._();

  factory _AppConfigSettingsSection.fromJson(Map<String, dynamic> json) =
      _$AppConfigSettingsSectionImpl.fromJson;

  @override
  String get titleL10n;
  @override
  bool get enabled;
  @override
  List<AppConfigSettingsItem> get items;

  /// Create a copy of AppConfigSettingsSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConfigSettingsSectionImplCopyWith<_$AppConfigSettingsSectionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppConfigSettingsItem _$AppConfigSettingsItemFromJson(
    Map<String, dynamic> json) {
  return _AppConfigSettingsItem.fromJson(json);
}

/// @nodoc
mixin _$AppConfigSettingsItem {
  bool get enabled => throw _privateConstructorUsedError;
  String get titleL10n => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @IconDataConverter()
  IconData get icon => throw _privateConstructorUsedError;
  AppConfigData? get data => throw _privateConstructorUsedError;

  /// Serializes this AppConfigSettingsItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppConfigSettingsItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppConfigSettingsItemCopyWith<AppConfigSettingsItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigSettingsItemCopyWith<$Res> {
  factory $AppConfigSettingsItemCopyWith(AppConfigSettingsItem value,
          $Res Function(AppConfigSettingsItem) then) =
      _$AppConfigSettingsItemCopyWithImpl<$Res, AppConfigSettingsItem>;
  @useResult
  $Res call(
      {bool enabled,
      String titleL10n,
      String? type,
      @IconDataConverter() IconData icon,
      AppConfigData? data});

  $AppConfigDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$AppConfigSettingsItemCopyWithImpl<$Res,
        $Val extends AppConfigSettingsItem>
    implements $AppConfigSettingsItemCopyWith<$Res> {
  _$AppConfigSettingsItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppConfigSettingsItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? titleL10n = null,
    Object? type = freezed,
    Object? icon = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      titleL10n: null == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AppConfigData?,
    ) as $Val);
  }

  /// Create a copy of AppConfigSettingsItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppConfigDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $AppConfigDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppConfigSettingsItemImplCopyWith<$Res>
    implements $AppConfigSettingsItemCopyWith<$Res> {
  factory _$$AppConfigSettingsItemImplCopyWith(
          _$AppConfigSettingsItemImpl value,
          $Res Function(_$AppConfigSettingsItemImpl) then) =
      __$$AppConfigSettingsItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool enabled,
      String titleL10n,
      String? type,
      @IconDataConverter() IconData icon,
      AppConfigData? data});

  @override
  $AppConfigDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$AppConfigSettingsItemImplCopyWithImpl<$Res>
    extends _$AppConfigSettingsItemCopyWithImpl<$Res,
        _$AppConfigSettingsItemImpl>
    implements _$$AppConfigSettingsItemImplCopyWith<$Res> {
  __$$AppConfigSettingsItemImplCopyWithImpl(_$AppConfigSettingsItemImpl _value,
      $Res Function(_$AppConfigSettingsItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppConfigSettingsItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? titleL10n = null,
    Object? type = freezed,
    Object? icon = null,
    Object? data = freezed,
  }) {
    return _then(_$AppConfigSettingsItemImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      titleL10n: null == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AppConfigData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigSettingsItemImpl extends _AppConfigSettingsItem {
  const _$AppConfigSettingsItemImpl(
      {this.enabled = true,
      required this.titleL10n,
      this.type,
      @IconDataConverter() required this.icon,
      required this.data})
      : super._();

  factory _$AppConfigSettingsItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigSettingsItemImplFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  final String titleL10n;
  @override
  final String? type;
  @override
  @IconDataConverter()
  final IconData icon;
  @override
  final AppConfigData? data;

  @override
  String toString() {
    return 'AppConfigSettingsItem(enabled: $enabled, titleL10n: $titleL10n, type: $type, icon: $icon, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigSettingsItemImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.titleL10n, titleL10n) ||
                other.titleL10n == titleL10n) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, enabled, titleL10n, type, icon, data);

  /// Create a copy of AppConfigSettingsItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigSettingsItemImplCopyWith<_$AppConfigSettingsItemImpl>
      get copyWith => __$$AppConfigSettingsItemImplCopyWithImpl<
          _$AppConfigSettingsItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigSettingsItemImplToJson(
      this,
    );
  }
}

abstract class _AppConfigSettingsItem extends AppConfigSettingsItem {
  const factory _AppConfigSettingsItem(
      {final bool enabled,
      required final String titleL10n,
      final String? type,
      @IconDataConverter() required final IconData icon,
      required final AppConfigData? data}) = _$AppConfigSettingsItemImpl;
  const _AppConfigSettingsItem._() : super._();

  factory _AppConfigSettingsItem.fromJson(Map<String, dynamic> json) =
      _$AppConfigSettingsItemImpl.fromJson;

  @override
  bool get enabled;
  @override
  String get titleL10n;
  @override
  String? get type;
  @override
  @IconDataConverter()
  IconData get icon;
  @override
  AppConfigData? get data;

  /// Create a copy of AppConfigSettingsItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConfigSettingsItemImplCopyWith<_$AppConfigSettingsItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppConfigData _$AppConfigDataFromJson(Map<String, dynamic> json) {
  return _AppConfigData.fromJson(json);
}

/// @nodoc
mixin _$AppConfigData {
  String get url => throw _privateConstructorUsedError;

  /// Serializes this AppConfigData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppConfigData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppConfigDataCopyWith<AppConfigData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigDataCopyWith<$Res> {
  factory $AppConfigDataCopyWith(
          AppConfigData value, $Res Function(AppConfigData) then) =
      _$AppConfigDataCopyWithImpl<$Res, AppConfigData>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$AppConfigDataCopyWithImpl<$Res, $Val extends AppConfigData>
    implements $AppConfigDataCopyWith<$Res> {
  _$AppConfigDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppConfigData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppConfigDataImplCopyWith<$Res>
    implements $AppConfigDataCopyWith<$Res> {
  factory _$$AppConfigDataImplCopyWith(
          _$AppConfigDataImpl value, $Res Function(_$AppConfigDataImpl) then) =
      __$$AppConfigDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$AppConfigDataImplCopyWithImpl<$Res>
    extends _$AppConfigDataCopyWithImpl<$Res, _$AppConfigDataImpl>
    implements _$$AppConfigDataImplCopyWith<$Res> {
  __$$AppConfigDataImplCopyWithImpl(
      _$AppConfigDataImpl _value, $Res Function(_$AppConfigDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppConfigData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$AppConfigDataImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigDataImpl extends _AppConfigData {
  const _$AppConfigDataImpl({required this.url}) : super._();

  factory _$AppConfigDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigDataImplFromJson(json);

  @override
  final String url;

  @override
  String toString() {
    return 'AppConfigData(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigDataImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  /// Create a copy of AppConfigData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigDataImplCopyWith<_$AppConfigDataImpl> get copyWith =>
      __$$AppConfigDataImplCopyWithImpl<_$AppConfigDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigDataImplToJson(
      this,
    );
  }
}

abstract class _AppConfigData extends AppConfigData {
  const factory _AppConfigData({required final String url}) =
      _$AppConfigDataImpl;
  const _AppConfigData._() : super._();

  factory _AppConfigData.fromJson(Map<String, dynamic> json) =
      _$AppConfigDataImpl.fromJson;

  @override
  String get url;

  /// Create a copy of AppConfigData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppConfigDataImplCopyWith<_$AppConfigDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
