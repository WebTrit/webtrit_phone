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
  AppConfigLogin get loginConfig => throw _privateConstructorUsedError;
  AppConfigMain get mainConfig => throw _privateConstructorUsedError;
  AppConfigSettings get settingsConfig => throw _privateConstructorUsedError;
  AppConfigCall get callConfig => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppConfigCopyWith<AppConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigCopyWith<$Res> {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) then) =
      _$AppConfigCopyWithImpl<$Res, AppConfig>;
  @useResult
  $Res call(
      {AppConfigLogin loginConfig,
      AppConfigMain mainConfig,
      AppConfigSettings settingsConfig,
      AppConfigCall callConfig});

  $AppConfigLoginCopyWith<$Res> get loginConfig;
  $AppConfigMainCopyWith<$Res> get mainConfig;
  $AppConfigSettingsCopyWith<$Res> get settingsConfig;
  $AppConfigCallCopyWith<$Res> get callConfig;
}

/// @nodoc
class _$AppConfigCopyWithImpl<$Res, $Val extends AppConfig>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginConfig = null,
    Object? mainConfig = null,
    Object? settingsConfig = null,
    Object? callConfig = null,
  }) {
    return _then(_value.copyWith(
      loginConfig: null == loginConfig
          ? _value.loginConfig
          : loginConfig // ignore: cast_nullable_to_non_nullable
              as AppConfigLogin,
      mainConfig: null == mainConfig
          ? _value.mainConfig
          : mainConfig // ignore: cast_nullable_to_non_nullable
              as AppConfigMain,
      settingsConfig: null == settingsConfig
          ? _value.settingsConfig
          : settingsConfig // ignore: cast_nullable_to_non_nullable
              as AppConfigSettings,
      callConfig: null == callConfig
          ? _value.callConfig
          : callConfig // ignore: cast_nullable_to_non_nullable
              as AppConfigCall,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppConfigLoginCopyWith<$Res> get loginConfig {
    return $AppConfigLoginCopyWith<$Res>(_value.loginConfig, (value) {
      return _then(_value.copyWith(loginConfig: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppConfigMainCopyWith<$Res> get mainConfig {
    return $AppConfigMainCopyWith<$Res>(_value.mainConfig, (value) {
      return _then(_value.copyWith(mainConfig: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppConfigSettingsCopyWith<$Res> get settingsConfig {
    return $AppConfigSettingsCopyWith<$Res>(_value.settingsConfig, (value) {
      return _then(_value.copyWith(settingsConfig: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppConfigCallCopyWith<$Res> get callConfig {
    return $AppConfigCallCopyWith<$Res>(_value.callConfig, (value) {
      return _then(_value.copyWith(callConfig: value) as $Val);
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
      {AppConfigLogin loginConfig,
      AppConfigMain mainConfig,
      AppConfigSettings settingsConfig,
      AppConfigCall callConfig});

  @override
  $AppConfigLoginCopyWith<$Res> get loginConfig;
  @override
  $AppConfigMainCopyWith<$Res> get mainConfig;
  @override
  $AppConfigSettingsCopyWith<$Res> get settingsConfig;
  @override
  $AppConfigCallCopyWith<$Res> get callConfig;
}

/// @nodoc
class __$$AppConfigImplCopyWithImpl<$Res>
    extends _$AppConfigCopyWithImpl<$Res, _$AppConfigImpl>
    implements _$$AppConfigImplCopyWith<$Res> {
  __$$AppConfigImplCopyWithImpl(
      _$AppConfigImpl _value, $Res Function(_$AppConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginConfig = null,
    Object? mainConfig = null,
    Object? settingsConfig = null,
    Object? callConfig = null,
  }) {
    return _then(_$AppConfigImpl(
      loginConfig: null == loginConfig
          ? _value.loginConfig
          : loginConfig // ignore: cast_nullable_to_non_nullable
              as AppConfigLogin,
      mainConfig: null == mainConfig
          ? _value.mainConfig
          : mainConfig // ignore: cast_nullable_to_non_nullable
              as AppConfigMain,
      settingsConfig: null == settingsConfig
          ? _value.settingsConfig
          : settingsConfig // ignore: cast_nullable_to_non_nullable
              as AppConfigSettings,
      callConfig: null == callConfig
          ? _value.callConfig
          : callConfig // ignore: cast_nullable_to_non_nullable
              as AppConfigCall,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigImpl extends _AppConfig {
  const _$AppConfigImpl(
      {this.loginConfig = const AppConfigLogin(),
      this.mainConfig = const AppConfigMain(),
      this.settingsConfig = const AppConfigSettings(),
      this.callConfig = const AppConfigCall()})
      : super._();

  factory _$AppConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigImplFromJson(json);

  @override
  @JsonKey()
  final AppConfigLogin loginConfig;
  @override
  @JsonKey()
  final AppConfigMain mainConfig;
  @override
  @JsonKey()
  final AppConfigSettings settingsConfig;
  @override
  @JsonKey()
  final AppConfigCall callConfig;

  @override
  String toString() {
    return 'AppConfig(loginConfig: $loginConfig, mainConfig: $mainConfig, settingsConfig: $settingsConfig, callConfig: $callConfig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigImpl &&
            (identical(other.loginConfig, loginConfig) ||
                other.loginConfig == loginConfig) &&
            (identical(other.mainConfig, mainConfig) ||
                other.mainConfig == mainConfig) &&
            (identical(other.settingsConfig, settingsConfig) ||
                other.settingsConfig == settingsConfig) &&
            (identical(other.callConfig, callConfig) ||
                other.callConfig == callConfig));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, loginConfig, mainConfig, settingsConfig, callConfig);

  @JsonKey(ignore: true)
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
      {final AppConfigLogin loginConfig,
      final AppConfigMain mainConfig,
      final AppConfigSettings settingsConfig,
      final AppConfigCall callConfig}) = _$AppConfigImpl;
  const _AppConfig._() : super._();

  factory _AppConfig.fromJson(Map<String, dynamic> json) =
      _$AppConfigImpl.fromJson;

  @override
  AppConfigLogin get loginConfig;
  @override
  AppConfigMain get mainConfig;
  @override
  AppConfigSettings get settingsConfig;
  @override
  AppConfigCall get callConfig;
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, customSignIn);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$AppConfigLoginImplCopyWith<_$AppConfigLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppConfigLoginCustomSignIn _$AppConfigLoginCustomSignInFromJson(
    Map<String, dynamic> json) {
  return _AppConfigLoginCustomSignIn.fromJson(json);
}

/// @nodoc
mixin _$AppConfigLoginCustomSignIn {
  bool get enabled => throw _privateConstructorUsedError;
  String get titleL10n => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
  $Res call({bool enabled, String titleL10n, String url});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? titleL10n = null,
    Object? url = null,
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
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({bool enabled, String titleL10n, String url});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? titleL10n = null,
    Object? url = null,
  }) {
    return _then(_$AppConfigLoginCustomSignInImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      titleL10n: null == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigLoginCustomSignInImpl extends _AppConfigLoginCustomSignIn {
  const _$AppConfigLoginCustomSignInImpl(
      {required this.enabled, required this.titleL10n, required this.url})
      : super._();

  factory _$AppConfigLoginCustomSignInImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AppConfigLoginCustomSignInImplFromJson(json);

  @override
  final bool enabled;
  @override
  final String titleL10n;
  @override
  final String url;

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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, titleL10n, url);

  @JsonKey(ignore: true)
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
      {required final bool enabled,
      required final String titleL10n,
      required final String url}) = _$AppConfigLoginCustomSignInImpl;
  const _AppConfigLoginCustomSignIn._() : super._();

  factory _AppConfigLoginCustomSignIn.fromJson(Map<String, dynamic> json) =
      _$AppConfigLoginCustomSignInImpl.fromJson;

  @override
  bool get enabled;
  @override
  String get titleL10n;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$AppConfigLoginCustomSignInImplCopyWith<_$AppConfigLoginCustomSignInImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppConfigMain _$AppConfigMainFromJson(Map<String, dynamic> json) {
  return _AppConfigMain.fromJson(json);
}

/// @nodoc
mixin _$AppConfigMain {
  AppConfigBottomMenu get bottomMenu => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppConfigMainCopyWith<AppConfigMain> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigMainCopyWith<$Res> {
  factory $AppConfigMainCopyWith(
          AppConfigMain value, $Res Function(AppConfigMain) then) =
      _$AppConfigMainCopyWithImpl<$Res, AppConfigMain>;
  @useResult
  $Res call({AppConfigBottomMenu bottomMenu});

  $AppConfigBottomMenuCopyWith<$Res> get bottomMenu;
}

/// @nodoc
class _$AppConfigMainCopyWithImpl<$Res, $Val extends AppConfigMain>
    implements $AppConfigMainCopyWith<$Res> {
  _$AppConfigMainCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bottomMenu = null,
  }) {
    return _then(_value.copyWith(
      bottomMenu: null == bottomMenu
          ? _value.bottomMenu
          : bottomMenu // ignore: cast_nullable_to_non_nullable
              as AppConfigBottomMenu,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppConfigBottomMenuCopyWith<$Res> get bottomMenu {
    return $AppConfigBottomMenuCopyWith<$Res>(_value.bottomMenu, (value) {
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
  $Res call({AppConfigBottomMenu bottomMenu});

  @override
  $AppConfigBottomMenuCopyWith<$Res> get bottomMenu;
}

/// @nodoc
class __$$AppConfigMainImplCopyWithImpl<$Res>
    extends _$AppConfigMainCopyWithImpl<$Res, _$AppConfigMainImpl>
    implements _$$AppConfigMainImplCopyWith<$Res> {
  __$$AppConfigMainImplCopyWithImpl(
      _$AppConfigMainImpl _value, $Res Function(_$AppConfigMainImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bottomMenu = null,
  }) {
    return _then(_$AppConfigMainImpl(
      bottomMenu: null == bottomMenu
          ? _value.bottomMenu
          : bottomMenu // ignore: cast_nullable_to_non_nullable
              as AppConfigBottomMenu,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigMainImpl extends _AppConfigMain {
  const _$AppConfigMainImpl(
      {this.bottomMenu =
          const AppConfigBottomMenu(cacheSelectedTab: true, tabs: [])})
      : super._();

  factory _$AppConfigMainImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigMainImplFromJson(json);

  @override
  @JsonKey()
  final AppConfigBottomMenu bottomMenu;

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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bottomMenu);

  @JsonKey(ignore: true)
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
  const factory _AppConfigMain({final AppConfigBottomMenu bottomMenu}) =
      _$AppConfigMainImpl;
  const _AppConfigMain._() : super._();

  factory _AppConfigMain.fromJson(Map<String, dynamic> json) =
      _$AppConfigMainImpl.fromJson;

  @override
  AppConfigBottomMenu get bottomMenu;
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cacheSelectedTab,
      const DeepCollectionEquality().hash(_tabs));

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
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
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      Map<String, dynamic> data});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? initial = null,
    Object? type = null,
    Object? titleL10n = null,
    Object? icon = null,
    Object? data = null,
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
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
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
      Map<String, dynamic> data});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? initial = null,
    Object? type = null,
    Object? titleL10n = null,
    Object? icon = null,
    Object? data = null,
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
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
      final Map<String, dynamic> data = const {}})
      : _data = data,
        super._();

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
  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

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
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, initial, type,
      titleL10n, icon, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
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
      final Map<String, dynamic> data}) = _$AppConfigBottomMenuTabImpl;
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
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_sections));

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, titleL10n, enabled,
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
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
  String get type => throw _privateConstructorUsedError;
  @IconDataConverter()
  IconData get icon => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      String type,
      @IconDataConverter() IconData icon,
      Map<String, dynamic> data});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? titleL10n = null,
    Object? type = null,
    Object? icon = null,
    Object? data = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
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
      String type,
      @IconDataConverter() IconData icon,
      Map<String, dynamic> data});
}

/// @nodoc
class __$$AppConfigSettingsItemImplCopyWithImpl<$Res>
    extends _$AppConfigSettingsItemCopyWithImpl<$Res,
        _$AppConfigSettingsItemImpl>
    implements _$$AppConfigSettingsItemImplCopyWith<$Res> {
  __$$AppConfigSettingsItemImplCopyWithImpl(_$AppConfigSettingsItemImpl _value,
      $Res Function(_$AppConfigSettingsItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? titleL10n = null,
    Object? type = null,
    Object? icon = null,
    Object? data = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigSettingsItemImpl extends _AppConfigSettingsItem {
  const _$AppConfigSettingsItemImpl(
      {this.enabled = true,
      required this.titleL10n,
      required this.type,
      @IconDataConverter() required this.icon,
      final Map<String, dynamic> data = const {}})
      : _data = data,
        super._();

  factory _$AppConfigSettingsItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigSettingsItemImplFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  final String titleL10n;
  @override
  final String type;
  @override
  @IconDataConverter()
  final IconData icon;
  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

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
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, titleL10n, type, icon,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
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
      required final String type,
      @IconDataConverter() required final IconData icon,
      final Map<String, dynamic> data}) = _$AppConfigSettingsItemImpl;
  const _AppConfigSettingsItem._() : super._();

  factory _AppConfigSettingsItem.fromJson(Map<String, dynamic> json) =
      _$AppConfigSettingsItemImpl.fromJson;

  @override
  bool get enabled;
  @override
  String get titleL10n;
  @override
  String get type;
  @override
  @IconDataConverter()
  IconData get icon;
  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$AppConfigSettingsItemImplCopyWith<_$AppConfigSettingsItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppConfigCall _$AppConfigCallFromJson(Map<String, dynamic> json) {
  return _AppConfigCall.fromJson(json);
}

/// @nodoc
mixin _$AppConfigCall {
  AppConfigTransfer get transfer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppConfigCallCopyWith<AppConfigCall> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigCallCopyWith<$Res> {
  factory $AppConfigCallCopyWith(
          AppConfigCall value, $Res Function(AppConfigCall) then) =
      _$AppConfigCallCopyWithImpl<$Res, AppConfigCall>;
  @useResult
  $Res call({AppConfigTransfer transfer});

  $AppConfigTransferCopyWith<$Res> get transfer;
}

/// @nodoc
class _$AppConfigCallCopyWithImpl<$Res, $Val extends AppConfigCall>
    implements $AppConfigCallCopyWith<$Res> {
  _$AppConfigCallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transfer = null,
  }) {
    return _then(_value.copyWith(
      transfer: null == transfer
          ? _value.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as AppConfigTransfer,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppConfigTransferCopyWith<$Res> get transfer {
    return $AppConfigTransferCopyWith<$Res>(_value.transfer, (value) {
      return _then(_value.copyWith(transfer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppConfigCallImplCopyWith<$Res>
    implements $AppConfigCallCopyWith<$Res> {
  factory _$$AppConfigCallImplCopyWith(
          _$AppConfigCallImpl value, $Res Function(_$AppConfigCallImpl) then) =
      __$$AppConfigCallImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppConfigTransfer transfer});

  @override
  $AppConfigTransferCopyWith<$Res> get transfer;
}

/// @nodoc
class __$$AppConfigCallImplCopyWithImpl<$Res>
    extends _$AppConfigCallCopyWithImpl<$Res, _$AppConfigCallImpl>
    implements _$$AppConfigCallImplCopyWith<$Res> {
  __$$AppConfigCallImplCopyWithImpl(
      _$AppConfigCallImpl _value, $Res Function(_$AppConfigCallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transfer = null,
  }) {
    return _then(_$AppConfigCallImpl(
      transfer: null == transfer
          ? _value.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as AppConfigTransfer,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigCallImpl extends _AppConfigCall {
  const _$AppConfigCallImpl(
      {this.transfer = const AppConfigTransfer(
          enableBlindTransfer: true, enableAttendedTransfer: true)})
      : super._();

  factory _$AppConfigCallImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigCallImplFromJson(json);

  @override
  @JsonKey()
  final AppConfigTransfer transfer;

  @override
  String toString() {
    return 'AppConfigCall(transfer: $transfer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigCallImpl &&
            (identical(other.transfer, transfer) ||
                other.transfer == transfer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, transfer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigCallImplCopyWith<_$AppConfigCallImpl> get copyWith =>
      __$$AppConfigCallImplCopyWithImpl<_$AppConfigCallImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigCallImplToJson(
      this,
    );
  }
}

abstract class _AppConfigCall extends AppConfigCall {
  const factory _AppConfigCall({final AppConfigTransfer transfer}) =
      _$AppConfigCallImpl;
  const _AppConfigCall._() : super._();

  factory _AppConfigCall.fromJson(Map<String, dynamic> json) =
      _$AppConfigCallImpl.fromJson;

  @override
  AppConfigTransfer get transfer;
  @override
  @JsonKey(ignore: true)
  _$$AppConfigCallImplCopyWith<_$AppConfigCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppConfigTransfer _$AppConfigTransferFromJson(Map<String, dynamic> json) {
  return _AppConfigTransfer.fromJson(json);
}

/// @nodoc
mixin _$AppConfigTransfer {
  bool get enableBlindTransfer => throw _privateConstructorUsedError;
  bool get enableAttendedTransfer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppConfigTransferCopyWith<AppConfigTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigTransferCopyWith<$Res> {
  factory $AppConfigTransferCopyWith(
          AppConfigTransfer value, $Res Function(AppConfigTransfer) then) =
      _$AppConfigTransferCopyWithImpl<$Res, AppConfigTransfer>;
  @useResult
  $Res call({bool enableBlindTransfer, bool enableAttendedTransfer});
}

/// @nodoc
class _$AppConfigTransferCopyWithImpl<$Res, $Val extends AppConfigTransfer>
    implements $AppConfigTransferCopyWith<$Res> {
  _$AppConfigTransferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableBlindTransfer = null,
    Object? enableAttendedTransfer = null,
  }) {
    return _then(_value.copyWith(
      enableBlindTransfer: null == enableBlindTransfer
          ? _value.enableBlindTransfer
          : enableBlindTransfer // ignore: cast_nullable_to_non_nullable
              as bool,
      enableAttendedTransfer: null == enableAttendedTransfer
          ? _value.enableAttendedTransfer
          : enableAttendedTransfer // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppConfigTransferImplCopyWith<$Res>
    implements $AppConfigTransferCopyWith<$Res> {
  factory _$$AppConfigTransferImplCopyWith(_$AppConfigTransferImpl value,
          $Res Function(_$AppConfigTransferImpl) then) =
      __$$AppConfigTransferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enableBlindTransfer, bool enableAttendedTransfer});
}

/// @nodoc
class __$$AppConfigTransferImplCopyWithImpl<$Res>
    extends _$AppConfigTransferCopyWithImpl<$Res, _$AppConfigTransferImpl>
    implements _$$AppConfigTransferImplCopyWith<$Res> {
  __$$AppConfigTransferImplCopyWithImpl(_$AppConfigTransferImpl _value,
      $Res Function(_$AppConfigTransferImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableBlindTransfer = null,
    Object? enableAttendedTransfer = null,
  }) {
    return _then(_$AppConfigTransferImpl(
      enableBlindTransfer: null == enableBlindTransfer
          ? _value.enableBlindTransfer
          : enableBlindTransfer // ignore: cast_nullable_to_non_nullable
              as bool,
      enableAttendedTransfer: null == enableAttendedTransfer
          ? _value.enableAttendedTransfer
          : enableAttendedTransfer // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigTransferImpl extends _AppConfigTransfer {
  const _$AppConfigTransferImpl(
      {this.enableBlindTransfer = true, this.enableAttendedTransfer = true})
      : super._();

  factory _$AppConfigTransferImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigTransferImplFromJson(json);

  @override
  @JsonKey()
  final bool enableBlindTransfer;
  @override
  @JsonKey()
  final bool enableAttendedTransfer;

  @override
  String toString() {
    return 'AppConfigTransfer(enableBlindTransfer: $enableBlindTransfer, enableAttendedTransfer: $enableAttendedTransfer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigTransferImpl &&
            (identical(other.enableBlindTransfer, enableBlindTransfer) ||
                other.enableBlindTransfer == enableBlindTransfer) &&
            (identical(other.enableAttendedTransfer, enableAttendedTransfer) ||
                other.enableAttendedTransfer == enableAttendedTransfer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, enableBlindTransfer, enableAttendedTransfer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigTransferImplCopyWith<_$AppConfigTransferImpl> get copyWith =>
      __$$AppConfigTransferImplCopyWithImpl<_$AppConfigTransferImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigTransferImplToJson(
      this,
    );
  }
}

abstract class _AppConfigTransfer extends AppConfigTransfer {
  const factory _AppConfigTransfer(
      {final bool enableBlindTransfer,
      final bool enableAttendedTransfer}) = _$AppConfigTransferImpl;
  const _AppConfigTransfer._() : super._();

  factory _AppConfigTransfer.fromJson(Map<String, dynamic> json) =
      _$AppConfigTransferImpl.fromJson;

  @override
  bool get enableBlindTransfer;
  @override
  bool get enableAttendedTransfer;
  @override
  @JsonKey(ignore: true)
  _$$AppConfigTransferImplCopyWith<_$AppConfigTransferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
