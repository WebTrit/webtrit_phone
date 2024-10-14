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
  List<AppConfigModeSelectAction> get modeSelectActions =>
      throw _privateConstructorUsedError;
  List<AppConfigLoginEmbedded> get embedded =>
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
  $Res call(
      {List<AppConfigModeSelectAction> modeSelectActions,
      List<AppConfigLoginEmbedded> embedded});
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
    Object? modeSelectActions = null,
    Object? embedded = null,
  }) {
    return _then(_value.copyWith(
      modeSelectActions: null == modeSelectActions
          ? _value.modeSelectActions
          : modeSelectActions // ignore: cast_nullable_to_non_nullable
              as List<AppConfigModeSelectAction>,
      embedded: null == embedded
          ? _value.embedded
          : embedded // ignore: cast_nullable_to_non_nullable
              as List<AppConfigLoginEmbedded>,
    ) as $Val);
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
  $Res call(
      {List<AppConfigModeSelectAction> modeSelectActions,
      List<AppConfigLoginEmbedded> embedded});
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
    Object? modeSelectActions = null,
    Object? embedded = null,
  }) {
    return _then(_$AppConfigLoginImpl(
      modeSelectActions: null == modeSelectActions
          ? _value._modeSelectActions
          : modeSelectActions // ignore: cast_nullable_to_non_nullable
              as List<AppConfigModeSelectAction>,
      embedded: null == embedded
          ? _value._embedded
          : embedded // ignore: cast_nullable_to_non_nullable
              as List<AppConfigLoginEmbedded>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigLoginImpl extends _AppConfigLogin {
  const _$AppConfigLoginImpl(
      {final List<AppConfigModeSelectAction> modeSelectActions = const [],
      final List<AppConfigLoginEmbedded> embedded = const []})
      : _modeSelectActions = modeSelectActions,
        _embedded = embedded,
        super._();

  factory _$AppConfigLoginImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigLoginImplFromJson(json);

  final List<AppConfigModeSelectAction> _modeSelectActions;
  @override
  @JsonKey()
  List<AppConfigModeSelectAction> get modeSelectActions {
    if (_modeSelectActions is EqualUnmodifiableListView)
      return _modeSelectActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modeSelectActions);
  }

  final List<AppConfigLoginEmbedded> _embedded;
  @override
  @JsonKey()
  List<AppConfigLoginEmbedded> get embedded {
    if (_embedded is EqualUnmodifiableListView) return _embedded;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_embedded);
  }

  @override
  String toString() {
    return 'AppConfigLogin(modeSelectActions: $modeSelectActions, embedded: $embedded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigLoginImpl &&
            const DeepCollectionEquality()
                .equals(other._modeSelectActions, _modeSelectActions) &&
            const DeepCollectionEquality().equals(other._embedded, _embedded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_modeSelectActions),
      const DeepCollectionEquality().hash(_embedded));

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
      {final List<AppConfigModeSelectAction> modeSelectActions,
      final List<AppConfigLoginEmbedded> embedded}) = _$AppConfigLoginImpl;
  const _AppConfigLogin._() : super._();

  factory _AppConfigLogin.fromJson(Map<String, dynamic> json) =
      _$AppConfigLoginImpl.fromJson;

  @override
  List<AppConfigModeSelectAction> get modeSelectActions;
  @override
  List<AppConfigLoginEmbedded> get embedded;
  @override
  @JsonKey(ignore: true)
  _$$AppConfigLoginImplCopyWith<_$AppConfigLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppConfigModeSelectAction _$AppConfigModeSelectActionFromJson(
    Map<String, dynamic> json) {
  return _AppConfigModeSelectAction.fromJson(json);
}

/// @nodoc
mixin _$AppConfigModeSelectAction {
  bool get enabled => throw _privateConstructorUsedError;
  int? get embeddedId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get titleL10n => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppConfigModeSelectActionCopyWith<AppConfigModeSelectAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigModeSelectActionCopyWith<$Res> {
  factory $AppConfigModeSelectActionCopyWith(AppConfigModeSelectAction value,
          $Res Function(AppConfigModeSelectAction) then) =
      _$AppConfigModeSelectActionCopyWithImpl<$Res, AppConfigModeSelectAction>;
  @useResult
  $Res call({bool enabled, int? embeddedId, String type, String titleL10n});
}

/// @nodoc
class _$AppConfigModeSelectActionCopyWithImpl<$Res,
        $Val extends AppConfigModeSelectAction>
    implements $AppConfigModeSelectActionCopyWith<$Res> {
  _$AppConfigModeSelectActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? embeddedId = freezed,
    Object? type = null,
    Object? titleL10n = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      embeddedId: freezed == embeddedId
          ? _value.embeddedId
          : embeddedId // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      titleL10n: null == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppConfigModeSelectActionImplCopyWith<$Res>
    implements $AppConfigModeSelectActionCopyWith<$Res> {
  factory _$$AppConfigModeSelectActionImplCopyWith(
          _$AppConfigModeSelectActionImpl value,
          $Res Function(_$AppConfigModeSelectActionImpl) then) =
      __$$AppConfigModeSelectActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enabled, int? embeddedId, String type, String titleL10n});
}

/// @nodoc
class __$$AppConfigModeSelectActionImplCopyWithImpl<$Res>
    extends _$AppConfigModeSelectActionCopyWithImpl<$Res,
        _$AppConfigModeSelectActionImpl>
    implements _$$AppConfigModeSelectActionImplCopyWith<$Res> {
  __$$AppConfigModeSelectActionImplCopyWithImpl(
      _$AppConfigModeSelectActionImpl _value,
      $Res Function(_$AppConfigModeSelectActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? embeddedId = freezed,
    Object? type = null,
    Object? titleL10n = null,
  }) {
    return _then(_$AppConfigModeSelectActionImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      embeddedId: freezed == embeddedId
          ? _value.embeddedId
          : embeddedId // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      titleL10n: null == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigModeSelectActionImpl extends _AppConfigModeSelectAction {
  const _$AppConfigModeSelectActionImpl(
      {required this.enabled,
      this.embeddedId,
      required this.type,
      required this.titleL10n})
      : super._();

  factory _$AppConfigModeSelectActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigModeSelectActionImplFromJson(json);

  @override
  final bool enabled;
  @override
  final int? embeddedId;
  @override
  final String type;
  @override
  final String titleL10n;

  @override
  String toString() {
    return 'AppConfigModeSelectAction(enabled: $enabled, embeddedId: $embeddedId, type: $type, titleL10n: $titleL10n)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigModeSelectActionImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.embeddedId, embeddedId) ||
                other.embeddedId == embeddedId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.titleL10n, titleL10n) ||
                other.titleL10n == titleL10n));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, enabled, embeddedId, type, titleL10n);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigModeSelectActionImplCopyWith<_$AppConfigModeSelectActionImpl>
      get copyWith => __$$AppConfigModeSelectActionImplCopyWithImpl<
          _$AppConfigModeSelectActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigModeSelectActionImplToJson(
      this,
    );
  }
}

abstract class _AppConfigModeSelectAction extends AppConfigModeSelectAction {
  const factory _AppConfigModeSelectAction(
      {required final bool enabled,
      final int? embeddedId,
      required final String type,
      required final String titleL10n}) = _$AppConfigModeSelectActionImpl;
  const _AppConfigModeSelectAction._() : super._();

  factory _AppConfigModeSelectAction.fromJson(Map<String, dynamic> json) =
      _$AppConfigModeSelectActionImpl.fromJson;

  @override
  bool get enabled;
  @override
  int? get embeddedId;
  @override
  String get type;
  @override
  String get titleL10n;
  @override
  @JsonKey(ignore: true)
  _$$AppConfigModeSelectActionImplCopyWith<_$AppConfigModeSelectActionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppConfigLoginEmbedded _$AppConfigLoginEmbeddedFromJson(
    Map<String, dynamic> json) {
  return _AppConfigLoginEmbedded.fromJson(json);
}

/// @nodoc
mixin _$AppConfigLoginEmbedded {
  int get id => throw _privateConstructorUsedError;
  bool get launch => throw _privateConstructorUsedError;
  String? get titleL10n => throw _privateConstructorUsedError;
  bool get showToolbar => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppConfigLoginEmbeddedCopyWith<AppConfigLoginEmbedded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigLoginEmbeddedCopyWith<$Res> {
  factory $AppConfigLoginEmbeddedCopyWith(AppConfigLoginEmbedded value,
          $Res Function(AppConfigLoginEmbedded) then) =
      _$AppConfigLoginEmbeddedCopyWithImpl<$Res, AppConfigLoginEmbedded>;
  @useResult
  $Res call(
      {int id, bool launch, String? titleL10n, bool showToolbar, String url});
}

/// @nodoc
class _$AppConfigLoginEmbeddedCopyWithImpl<$Res,
        $Val extends AppConfigLoginEmbedded>
    implements $AppConfigLoginEmbeddedCopyWith<$Res> {
  _$AppConfigLoginEmbeddedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? launch = null,
    Object? titleL10n = freezed,
    Object? showToolbar = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      launch: null == launch
          ? _value.launch
          : launch // ignore: cast_nullable_to_non_nullable
              as bool,
      titleL10n: freezed == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String?,
      showToolbar: null == showToolbar
          ? _value.showToolbar
          : showToolbar // ignore: cast_nullable_to_non_nullable
              as bool,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppConfigLoginEmbeddedImplCopyWith<$Res>
    implements $AppConfigLoginEmbeddedCopyWith<$Res> {
  factory _$$AppConfigLoginEmbeddedImplCopyWith(
          _$AppConfigLoginEmbeddedImpl value,
          $Res Function(_$AppConfigLoginEmbeddedImpl) then) =
      __$$AppConfigLoginEmbeddedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, bool launch, String? titleL10n, bool showToolbar, String url});
}

/// @nodoc
class __$$AppConfigLoginEmbeddedImplCopyWithImpl<$Res>
    extends _$AppConfigLoginEmbeddedCopyWithImpl<$Res,
        _$AppConfigLoginEmbeddedImpl>
    implements _$$AppConfigLoginEmbeddedImplCopyWith<$Res> {
  __$$AppConfigLoginEmbeddedImplCopyWithImpl(
      _$AppConfigLoginEmbeddedImpl _value,
      $Res Function(_$AppConfigLoginEmbeddedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? launch = null,
    Object? titleL10n = freezed,
    Object? showToolbar = null,
    Object? url = null,
  }) {
    return _then(_$AppConfigLoginEmbeddedImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      launch: null == launch
          ? _value.launch
          : launch // ignore: cast_nullable_to_non_nullable
              as bool,
      titleL10n: freezed == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String?,
      showToolbar: null == showToolbar
          ? _value.showToolbar
          : showToolbar // ignore: cast_nullable_to_non_nullable
              as bool,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppConfigLoginEmbeddedImpl extends _AppConfigLoginEmbedded {
  const _$AppConfigLoginEmbeddedImpl(
      {required this.id,
      this.launch = false,
      this.titleL10n,
      this.showToolbar = false,
      required this.url})
      : super._();

  factory _$AppConfigLoginEmbeddedImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigLoginEmbeddedImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final bool launch;
  @override
  final String? titleL10n;
  @override
  @JsonKey()
  final bool showToolbar;
  @override
  final String url;

  @override
  String toString() {
    return 'AppConfigLoginEmbedded(id: $id, launch: $launch, titleL10n: $titleL10n, showToolbar: $showToolbar, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigLoginEmbeddedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.launch, launch) || other.launch == launch) &&
            (identical(other.titleL10n, titleL10n) ||
                other.titleL10n == titleL10n) &&
            (identical(other.showToolbar, showToolbar) ||
                other.showToolbar == showToolbar) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, launch, titleL10n, showToolbar, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppConfigLoginEmbeddedImplCopyWith<_$AppConfigLoginEmbeddedImpl>
      get copyWith => __$$AppConfigLoginEmbeddedImplCopyWithImpl<
          _$AppConfigLoginEmbeddedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppConfigLoginEmbeddedImplToJson(
      this,
    );
  }
}

abstract class _AppConfigLoginEmbedded extends AppConfigLoginEmbedded {
  const factory _AppConfigLoginEmbedded(
      {required final int id,
      final bool launch,
      final String? titleL10n,
      final bool showToolbar,
      required final String url}) = _$AppConfigLoginEmbeddedImpl;
  const _AppConfigLoginEmbedded._() : super._();

  factory _AppConfigLoginEmbedded.fromJson(Map<String, dynamic> json) =
      _$AppConfigLoginEmbeddedImpl.fromJson;

  @override
  int get id;
  @override
  bool get launch;
  @override
  String? get titleL10n;
  @override
  bool get showToolbar;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$AppConfigLoginEmbeddedImplCopyWith<_$AppConfigLoginEmbeddedImpl>
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
  bool get videoEnabled => throw _privateConstructorUsedError;
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
  $Res call({bool videoEnabled, AppConfigTransfer transfer});

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
    Object? videoEnabled = null,
    Object? transfer = null,
  }) {
    return _then(_value.copyWith(
      videoEnabled: null == videoEnabled
          ? _value.videoEnabled
          : videoEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call({bool videoEnabled, AppConfigTransfer transfer});

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
    Object? videoEnabled = null,
    Object? transfer = null,
  }) {
    return _then(_$AppConfigCallImpl(
      videoEnabled: null == videoEnabled
          ? _value.videoEnabled
          : videoEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {this.videoEnabled = true,
      this.transfer = const AppConfigTransfer(
          enableBlindTransfer: true, enableAttendedTransfer: true)})
      : super._();

  factory _$AppConfigCallImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppConfigCallImplFromJson(json);

  @override
  @JsonKey()
  final bool videoEnabled;
  @override
  @JsonKey()
  final AppConfigTransfer transfer;

  @override
  String toString() {
    return 'AppConfigCall(videoEnabled: $videoEnabled, transfer: $transfer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigCallImpl &&
            (identical(other.videoEnabled, videoEnabled) ||
                other.videoEnabled == videoEnabled) &&
            (identical(other.transfer, transfer) ||
                other.transfer == transfer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, videoEnabled, transfer);

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
  const factory _AppConfigCall(
      {final bool videoEnabled,
      final AppConfigTransfer transfer}) = _$AppConfigCallImpl;
  const _AppConfigCall._() : super._();

  factory _AppConfigCall.fromJson(Map<String, dynamic> json) =
      _$AppConfigCallImpl.fromJson;

  @override
  bool get videoEnabled;
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
