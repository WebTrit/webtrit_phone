// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SystemInfo _$SystemInfoFromJson(Map<String, dynamic> json) {
  return _SystemInfo.fromJson(json);
}

/// @nodoc
mixin _$SystemInfo {
  CoreInfo get core => throw _privateConstructorUsedError;
  PostgresInfo get postgres => throw _privateConstructorUsedError;
  JanusInfo? get janus => throw _privateConstructorUsedError;
  GorushInfo? get gorush => throw _privateConstructorUsedError;
  AdapterInfo? get adapter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SystemInfoCopyWith<SystemInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemInfoCopyWith<$Res> {
  factory $SystemInfoCopyWith(
          SystemInfo value, $Res Function(SystemInfo) then) =
      _$SystemInfoCopyWithImpl<$Res, SystemInfo>;
  @useResult
  $Res call(
      {CoreInfo core,
      PostgresInfo postgres,
      JanusInfo? janus,
      GorushInfo? gorush,
      AdapterInfo? adapter});

  $CoreInfoCopyWith<$Res> get core;
  $PostgresInfoCopyWith<$Res> get postgres;
  $JanusInfoCopyWith<$Res>? get janus;
  $GorushInfoCopyWith<$Res>? get gorush;
  $AdapterInfoCopyWith<$Res>? get adapter;
}

/// @nodoc
class _$SystemInfoCopyWithImpl<$Res, $Val extends SystemInfo>
    implements $SystemInfoCopyWith<$Res> {
  _$SystemInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? core = null,
    Object? postgres = null,
    Object? janus = freezed,
    Object? gorush = freezed,
    Object? adapter = freezed,
  }) {
    return _then(_value.copyWith(
      core: null == core
          ? _value.core
          : core // ignore: cast_nullable_to_non_nullable
              as CoreInfo,
      postgres: null == postgres
          ? _value.postgres
          : postgres // ignore: cast_nullable_to_non_nullable
              as PostgresInfo,
      janus: freezed == janus
          ? _value.janus
          : janus // ignore: cast_nullable_to_non_nullable
              as JanusInfo?,
      gorush: freezed == gorush
          ? _value.gorush
          : gorush // ignore: cast_nullable_to_non_nullable
              as GorushInfo?,
      adapter: freezed == adapter
          ? _value.adapter
          : adapter // ignore: cast_nullable_to_non_nullable
              as AdapterInfo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CoreInfoCopyWith<$Res> get core {
    return $CoreInfoCopyWith<$Res>(_value.core, (value) {
      return _then(_value.copyWith(core: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PostgresInfoCopyWith<$Res> get postgres {
    return $PostgresInfoCopyWith<$Res>(_value.postgres, (value) {
      return _then(_value.copyWith(postgres: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $JanusInfoCopyWith<$Res>? get janus {
    if (_value.janus == null) {
      return null;
    }

    return $JanusInfoCopyWith<$Res>(_value.janus!, (value) {
      return _then(_value.copyWith(janus: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GorushInfoCopyWith<$Res>? get gorush {
    if (_value.gorush == null) {
      return null;
    }

    return $GorushInfoCopyWith<$Res>(_value.gorush!, (value) {
      return _then(_value.copyWith(gorush: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AdapterInfoCopyWith<$Res>? get adapter {
    if (_value.adapter == null) {
      return null;
    }

    return $AdapterInfoCopyWith<$Res>(_value.adapter!, (value) {
      return _then(_value.copyWith(adapter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SystemInfoCopyWith<$Res>
    implements $SystemInfoCopyWith<$Res> {
  factory _$$_SystemInfoCopyWith(
          _$_SystemInfo value, $Res Function(_$_SystemInfo) then) =
      __$$_SystemInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CoreInfo core,
      PostgresInfo postgres,
      JanusInfo? janus,
      GorushInfo? gorush,
      AdapterInfo? adapter});

  @override
  $CoreInfoCopyWith<$Res> get core;
  @override
  $PostgresInfoCopyWith<$Res> get postgres;
  @override
  $JanusInfoCopyWith<$Res>? get janus;
  @override
  $GorushInfoCopyWith<$Res>? get gorush;
  @override
  $AdapterInfoCopyWith<$Res>? get adapter;
}

/// @nodoc
class __$$_SystemInfoCopyWithImpl<$Res>
    extends _$SystemInfoCopyWithImpl<$Res, _$_SystemInfo>
    implements _$$_SystemInfoCopyWith<$Res> {
  __$$_SystemInfoCopyWithImpl(
      _$_SystemInfo _value, $Res Function(_$_SystemInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? core = null,
    Object? postgres = null,
    Object? janus = freezed,
    Object? gorush = freezed,
    Object? adapter = freezed,
  }) {
    return _then(_$_SystemInfo(
      core: null == core
          ? _value.core
          : core // ignore: cast_nullable_to_non_nullable
              as CoreInfo,
      postgres: null == postgres
          ? _value.postgres
          : postgres // ignore: cast_nullable_to_non_nullable
              as PostgresInfo,
      janus: freezed == janus
          ? _value.janus
          : janus // ignore: cast_nullable_to_non_nullable
              as JanusInfo?,
      gorush: freezed == gorush
          ? _value.gorush
          : gorush // ignore: cast_nullable_to_non_nullable
              as GorushInfo?,
      adapter: freezed == adapter
          ? _value.adapter
          : adapter // ignore: cast_nullable_to_non_nullable
              as AdapterInfo?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SystemInfo implements _SystemInfo {
  const _$_SystemInfo(
      {required this.core,
      required this.postgres,
      this.janus,
      this.gorush,
      this.adapter});

  factory _$_SystemInfo.fromJson(Map<String, dynamic> json) =>
      _$$_SystemInfoFromJson(json);

  @override
  final CoreInfo core;
  @override
  final PostgresInfo postgres;
  @override
  final JanusInfo? janus;
  @override
  final GorushInfo? gorush;
  @override
  final AdapterInfo? adapter;

  @override
  String toString() {
    return 'SystemInfo(core: $core, postgres: $postgres, janus: $janus, gorush: $gorush, adapter: $adapter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SystemInfo &&
            (identical(other.core, core) || other.core == core) &&
            (identical(other.postgres, postgres) ||
                other.postgres == postgres) &&
            (identical(other.janus, janus) || other.janus == janus) &&
            (identical(other.gorush, gorush) || other.gorush == gorush) &&
            (identical(other.adapter, adapter) || other.adapter == adapter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, core, postgres, janus, gorush, adapter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SystemInfoCopyWith<_$_SystemInfo> get copyWith =>
      __$$_SystemInfoCopyWithImpl<_$_SystemInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SystemInfoToJson(
      this,
    );
  }
}

abstract class _SystemInfo implements SystemInfo {
  const factory _SystemInfo(
      {required final CoreInfo core,
      required final PostgresInfo postgres,
      final JanusInfo? janus,
      final GorushInfo? gorush,
      final AdapterInfo? adapter}) = _$_SystemInfo;

  factory _SystemInfo.fromJson(Map<String, dynamic> json) =
      _$_SystemInfo.fromJson;

  @override
  CoreInfo get core;
  @override
  PostgresInfo get postgres;
  @override
  JanusInfo? get janus;
  @override
  GorushInfo? get gorush;
  @override
  AdapterInfo? get adapter;
  @override
  @JsonKey(ignore: true)
  _$$_SystemInfoCopyWith<_$_SystemInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

PostgresInfo _$PostgresInfoFromJson(Map<String, dynamic> json) {
  return _PostgresInfo.fromJson(json);
}

/// @nodoc
mixin _$PostgresInfo {
  String? get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostgresInfoCopyWith<PostgresInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostgresInfoCopyWith<$Res> {
  factory $PostgresInfoCopyWith(
          PostgresInfo value, $Res Function(PostgresInfo) then) =
      _$PostgresInfoCopyWithImpl<$Res, PostgresInfo>;
  @useResult
  $Res call({String? version});
}

/// @nodoc
class _$PostgresInfoCopyWithImpl<$Res, $Val extends PostgresInfo>
    implements $PostgresInfoCopyWith<$Res> {
  _$PostgresInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostgresInfoCopyWith<$Res>
    implements $PostgresInfoCopyWith<$Res> {
  factory _$$_PostgresInfoCopyWith(
          _$_PostgresInfo value, $Res Function(_$_PostgresInfo) then) =
      __$$_PostgresInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? version});
}

/// @nodoc
class __$$_PostgresInfoCopyWithImpl<$Res>
    extends _$PostgresInfoCopyWithImpl<$Res, _$_PostgresInfo>
    implements _$$_PostgresInfoCopyWith<$Res> {
  __$$_PostgresInfoCopyWithImpl(
      _$_PostgresInfo _value, $Res Function(_$_PostgresInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_$_PostgresInfo(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_PostgresInfo implements _PostgresInfo {
  const _$_PostgresInfo({this.version});

  factory _$_PostgresInfo.fromJson(Map<String, dynamic> json) =>
      _$$_PostgresInfoFromJson(json);

  @override
  final String? version;

  @override
  String toString() {
    return 'PostgresInfo(version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostgresInfo &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostgresInfoCopyWith<_$_PostgresInfo> get copyWith =>
      __$$_PostgresInfoCopyWithImpl<_$_PostgresInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostgresInfoToJson(
      this,
    );
  }
}

abstract class _PostgresInfo implements PostgresInfo {
  const factory _PostgresInfo({final String? version}) = _$_PostgresInfo;

  factory _PostgresInfo.fromJson(Map<String, dynamic> json) =
      _$_PostgresInfo.fromJson;

  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$_PostgresInfoCopyWith<_$_PostgresInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

JanusInfo _$JanusInfoFromJson(Map<String, dynamic> json) {
  return _JanusInfo.fromJson(json);
}

/// @nodoc
mixin _$JanusInfo {
  Plugins? get plugins => throw _privateConstructorUsedError;
  Transports? get transports => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JanusInfoCopyWith<JanusInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JanusInfoCopyWith<$Res> {
  factory $JanusInfoCopyWith(JanusInfo value, $Res Function(JanusInfo) then) =
      _$JanusInfoCopyWithImpl<$Res, JanusInfo>;
  @useResult
  $Res call({Plugins? plugins, Transports? transports, String? version});

  $PluginsCopyWith<$Res>? get plugins;
  $TransportsCopyWith<$Res>? get transports;
}

/// @nodoc
class _$JanusInfoCopyWithImpl<$Res, $Val extends JanusInfo>
    implements $JanusInfoCopyWith<$Res> {
  _$JanusInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plugins = freezed,
    Object? transports = freezed,
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      plugins: freezed == plugins
          ? _value.plugins
          : plugins // ignore: cast_nullable_to_non_nullable
              as Plugins?,
      transports: freezed == transports
          ? _value.transports
          : transports // ignore: cast_nullable_to_non_nullable
              as Transports?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PluginsCopyWith<$Res>? get plugins {
    if (_value.plugins == null) {
      return null;
    }

    return $PluginsCopyWith<$Res>(_value.plugins!, (value) {
      return _then(_value.copyWith(plugins: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TransportsCopyWith<$Res>? get transports {
    if (_value.transports == null) {
      return null;
    }

    return $TransportsCopyWith<$Res>(_value.transports!, (value) {
      return _then(_value.copyWith(transports: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_JanusInfoCopyWith<$Res> implements $JanusInfoCopyWith<$Res> {
  factory _$$_JanusInfoCopyWith(
          _$_JanusInfo value, $Res Function(_$_JanusInfo) then) =
      __$$_JanusInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Plugins? plugins, Transports? transports, String? version});

  @override
  $PluginsCopyWith<$Res>? get plugins;
  @override
  $TransportsCopyWith<$Res>? get transports;
}

/// @nodoc
class __$$_JanusInfoCopyWithImpl<$Res>
    extends _$JanusInfoCopyWithImpl<$Res, _$_JanusInfo>
    implements _$$_JanusInfoCopyWith<$Res> {
  __$$_JanusInfoCopyWithImpl(
      _$_JanusInfo _value, $Res Function(_$_JanusInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plugins = freezed,
    Object? transports = freezed,
    Object? version = freezed,
  }) {
    return _then(_$_JanusInfo(
      plugins: freezed == plugins
          ? _value.plugins
          : plugins // ignore: cast_nullable_to_non_nullable
              as Plugins?,
      transports: freezed == transports
          ? _value.transports
          : transports // ignore: cast_nullable_to_non_nullable
              as Transports?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_JanusInfo implements _JanusInfo {
  const _$_JanusInfo({this.plugins, this.transports, this.version});

  factory _$_JanusInfo.fromJson(Map<String, dynamic> json) =>
      _$$_JanusInfoFromJson(json);

  @override
  final Plugins? plugins;
  @override
  final Transports? transports;
  @override
  final String? version;

  @override
  String toString() {
    return 'JanusInfo(plugins: $plugins, transports: $transports, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JanusInfo &&
            (identical(other.plugins, plugins) || other.plugins == plugins) &&
            (identical(other.transports, transports) ||
                other.transports == transports) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, plugins, transports, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JanusInfoCopyWith<_$_JanusInfo> get copyWith =>
      __$$_JanusInfoCopyWithImpl<_$_JanusInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JanusInfoToJson(
      this,
    );
  }
}

abstract class _JanusInfo implements JanusInfo {
  const factory _JanusInfo(
      {final Plugins? plugins,
      final Transports? transports,
      final String? version}) = _$_JanusInfo;

  factory _JanusInfo.fromJson(Map<String, dynamic> json) =
      _$_JanusInfo.fromJson;

  @override
  Plugins? get plugins;
  @override
  Transports? get transports;
  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$_JanusInfoCopyWith<_$_JanusInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

Transports _$TransportsFromJson(Map<String, dynamic> json) {
  return _Transports.fromJson(json);
}

/// @nodoc
mixin _$Transports {
  Websocket? get websocket => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransportsCopyWith<Transports> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransportsCopyWith<$Res> {
  factory $TransportsCopyWith(
          Transports value, $Res Function(Transports) then) =
      _$TransportsCopyWithImpl<$Res, Transports>;
  @useResult
  $Res call({Websocket? websocket});

  $WebsocketCopyWith<$Res>? get websocket;
}

/// @nodoc
class _$TransportsCopyWithImpl<$Res, $Val extends Transports>
    implements $TransportsCopyWith<$Res> {
  _$TransportsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websocket = freezed,
  }) {
    return _then(_value.copyWith(
      websocket: freezed == websocket
          ? _value.websocket
          : websocket // ignore: cast_nullable_to_non_nullable
              as Websocket?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WebsocketCopyWith<$Res>? get websocket {
    if (_value.websocket == null) {
      return null;
    }

    return $WebsocketCopyWith<$Res>(_value.websocket!, (value) {
      return _then(_value.copyWith(websocket: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TransportsCopyWith<$Res>
    implements $TransportsCopyWith<$Res> {
  factory _$$_TransportsCopyWith(
          _$_Transports value, $Res Function(_$_Transports) then) =
      __$$_TransportsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Websocket? websocket});

  @override
  $WebsocketCopyWith<$Res>? get websocket;
}

/// @nodoc
class __$$_TransportsCopyWithImpl<$Res>
    extends _$TransportsCopyWithImpl<$Res, _$_Transports>
    implements _$$_TransportsCopyWith<$Res> {
  __$$_TransportsCopyWithImpl(
      _$_Transports _value, $Res Function(_$_Transports) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websocket = freezed,
  }) {
    return _then(_$_Transports(
      websocket: freezed == websocket
          ? _value.websocket
          : websocket // ignore: cast_nullable_to_non_nullable
              as Websocket?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Transports implements _Transports {
  const _$_Transports({this.websocket});

  factory _$_Transports.fromJson(Map<String, dynamic> json) =>
      _$$_TransportsFromJson(json);

  @override
  final Websocket? websocket;

  @override
  String toString() {
    return 'Transports(websocket: $websocket)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transports &&
            (identical(other.websocket, websocket) ||
                other.websocket == websocket));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, websocket);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransportsCopyWith<_$_Transports> get copyWith =>
      __$$_TransportsCopyWithImpl<_$_Transports>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransportsToJson(
      this,
    );
  }
}

abstract class _Transports implements Transports {
  const factory _Transports({final Websocket? websocket}) = _$_Transports;

  factory _Transports.fromJson(Map<String, dynamic> json) =
      _$_Transports.fromJson;

  @override
  Websocket? get websocket;
  @override
  @JsonKey(ignore: true)
  _$$_TransportsCopyWith<_$_Transports> get copyWith =>
      throw _privateConstructorUsedError;
}

Websocket _$WebsocketFromJson(Map<String, dynamic> json) {
  return _Websocket.fromJson(json);
}

/// @nodoc
mixin _$Websocket {
  String? get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebsocketCopyWith<Websocket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebsocketCopyWith<$Res> {
  factory $WebsocketCopyWith(Websocket value, $Res Function(Websocket) then) =
      _$WebsocketCopyWithImpl<$Res, Websocket>;
  @useResult
  $Res call({String? version});
}

/// @nodoc
class _$WebsocketCopyWithImpl<$Res, $Val extends Websocket>
    implements $WebsocketCopyWith<$Res> {
  _$WebsocketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WebsocketCopyWith<$Res> implements $WebsocketCopyWith<$Res> {
  factory _$$_WebsocketCopyWith(
          _$_Websocket value, $Res Function(_$_Websocket) then) =
      __$$_WebsocketCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? version});
}

/// @nodoc
class __$$_WebsocketCopyWithImpl<$Res>
    extends _$WebsocketCopyWithImpl<$Res, _$_Websocket>
    implements _$$_WebsocketCopyWith<$Res> {
  __$$_WebsocketCopyWithImpl(
      _$_Websocket _value, $Res Function(_$_Websocket) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_$_Websocket(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Websocket implements _Websocket {
  const _$_Websocket({this.version});

  factory _$_Websocket.fromJson(Map<String, dynamic> json) =>
      _$$_WebsocketFromJson(json);

  @override
  final String? version;

  @override
  String toString() {
    return 'Websocket(version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Websocket &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WebsocketCopyWith<_$_Websocket> get copyWith =>
      __$$_WebsocketCopyWithImpl<_$_Websocket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WebsocketToJson(
      this,
    );
  }
}

abstract class _Websocket implements Websocket {
  const factory _Websocket({final String? version}) = _$_Websocket;

  factory _Websocket.fromJson(Map<String, dynamic> json) =
      _$_Websocket.fromJson;

  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$_WebsocketCopyWith<_$_Websocket> get copyWith =>
      throw _privateConstructorUsedError;
}

Plugins _$PluginsFromJson(Map<String, dynamic> json) {
  return _Plugins.fromJson(json);
}

/// @nodoc
mixin _$Plugins {
  SipVersion? get sip => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PluginsCopyWith<Plugins> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PluginsCopyWith<$Res> {
  factory $PluginsCopyWith(Plugins value, $Res Function(Plugins) then) =
      _$PluginsCopyWithImpl<$Res, Plugins>;
  @useResult
  $Res call({SipVersion? sip});

  $SipVersionCopyWith<$Res>? get sip;
}

/// @nodoc
class _$PluginsCopyWithImpl<$Res, $Val extends Plugins>
    implements $PluginsCopyWith<$Res> {
  _$PluginsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sip = freezed,
  }) {
    return _then(_value.copyWith(
      sip: freezed == sip
          ? _value.sip
          : sip // ignore: cast_nullable_to_non_nullable
              as SipVersion?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SipVersionCopyWith<$Res>? get sip {
    if (_value.sip == null) {
      return null;
    }

    return $SipVersionCopyWith<$Res>(_value.sip!, (value) {
      return _then(_value.copyWith(sip: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PluginsCopyWith<$Res> implements $PluginsCopyWith<$Res> {
  factory _$$_PluginsCopyWith(
          _$_Plugins value, $Res Function(_$_Plugins) then) =
      __$$_PluginsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SipVersion? sip});

  @override
  $SipVersionCopyWith<$Res>? get sip;
}

/// @nodoc
class __$$_PluginsCopyWithImpl<$Res>
    extends _$PluginsCopyWithImpl<$Res, _$_Plugins>
    implements _$$_PluginsCopyWith<$Res> {
  __$$_PluginsCopyWithImpl(_$_Plugins _value, $Res Function(_$_Plugins) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sip = freezed,
  }) {
    return _then(_$_Plugins(
      sip: freezed == sip
          ? _value.sip
          : sip // ignore: cast_nullable_to_non_nullable
              as SipVersion?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Plugins implements _Plugins {
  const _$_Plugins({this.sip});

  factory _$_Plugins.fromJson(Map<String, dynamic> json) =>
      _$$_PluginsFromJson(json);

  @override
  final SipVersion? sip;

  @override
  String toString() {
    return 'Plugins(sip: $sip)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Plugins &&
            (identical(other.sip, sip) || other.sip == sip));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sip);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PluginsCopyWith<_$_Plugins> get copyWith =>
      __$$_PluginsCopyWithImpl<_$_Plugins>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PluginsToJson(
      this,
    );
  }
}

abstract class _Plugins implements Plugins {
  const factory _Plugins({final SipVersion? sip}) = _$_Plugins;

  factory _Plugins.fromJson(Map<String, dynamic> json) = _$_Plugins.fromJson;

  @override
  SipVersion? get sip;
  @override
  @JsonKey(ignore: true)
  _$$_PluginsCopyWith<_$_Plugins> get copyWith =>
      throw _privateConstructorUsedError;
}

SipVersion _$SipVersionFromJson(Map<String, dynamic> json) {
  return _SipVersion.fromJson(json);
}

/// @nodoc
mixin _$SipVersion {
  String? get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SipVersionCopyWith<SipVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SipVersionCopyWith<$Res> {
  factory $SipVersionCopyWith(
          SipVersion value, $Res Function(SipVersion) then) =
      _$SipVersionCopyWithImpl<$Res, SipVersion>;
  @useResult
  $Res call({String? version});
}

/// @nodoc
class _$SipVersionCopyWithImpl<$Res, $Val extends SipVersion>
    implements $SipVersionCopyWith<$Res> {
  _$SipVersionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SipVersionCopyWith<$Res>
    implements $SipVersionCopyWith<$Res> {
  factory _$$_SipVersionCopyWith(
          _$_SipVersion value, $Res Function(_$_SipVersion) then) =
      __$$_SipVersionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? version});
}

/// @nodoc
class __$$_SipVersionCopyWithImpl<$Res>
    extends _$SipVersionCopyWithImpl<$Res, _$_SipVersion>
    implements _$$_SipVersionCopyWith<$Res> {
  __$$_SipVersionCopyWithImpl(
      _$_SipVersion _value, $Res Function(_$_SipVersion) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_$_SipVersion(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SipVersion implements _SipVersion {
  const _$_SipVersion({this.version});

  factory _$_SipVersion.fromJson(Map<String, dynamic> json) =>
      _$$_SipVersionFromJson(json);

  @override
  final String? version;

  @override
  String toString() {
    return 'SipVersion(version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SipVersion &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SipVersionCopyWith<_$_SipVersion> get copyWith =>
      __$$_SipVersionCopyWithImpl<_$_SipVersion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SipVersionToJson(
      this,
    );
  }
}

abstract class _SipVersion implements SipVersion {
  const factory _SipVersion({final String? version}) = _$_SipVersion;

  factory _SipVersion.fromJson(Map<String, dynamic> json) =
      _$_SipVersion.fromJson;

  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$_SipVersionCopyWith<_$_SipVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

GorushInfo _$GorushInfoFromJson(Map<String, dynamic> json) {
  return _GorushInfo.fromJson(json);
}

/// @nodoc
mixin _$GorushInfo {
  String? get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GorushInfoCopyWith<GorushInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GorushInfoCopyWith<$Res> {
  factory $GorushInfoCopyWith(
          GorushInfo value, $Res Function(GorushInfo) then) =
      _$GorushInfoCopyWithImpl<$Res, GorushInfo>;
  @useResult
  $Res call({String? version});
}

/// @nodoc
class _$GorushInfoCopyWithImpl<$Res, $Val extends GorushInfo>
    implements $GorushInfoCopyWith<$Res> {
  _$GorushInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GorushInfoCopyWith<$Res>
    implements $GorushInfoCopyWith<$Res> {
  factory _$$_GorushInfoCopyWith(
          _$_GorushInfo value, $Res Function(_$_GorushInfo) then) =
      __$$_GorushInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? version});
}

/// @nodoc
class __$$_GorushInfoCopyWithImpl<$Res>
    extends _$GorushInfoCopyWithImpl<$Res, _$_GorushInfo>
    implements _$$_GorushInfoCopyWith<$Res> {
  __$$_GorushInfoCopyWithImpl(
      _$_GorushInfo _value, $Res Function(_$_GorushInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_$_GorushInfo(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_GorushInfo implements _GorushInfo {
  const _$_GorushInfo({this.version});

  factory _$_GorushInfo.fromJson(Map<String, dynamic> json) =>
      _$$_GorushInfoFromJson(json);

  @override
  final String? version;

  @override
  String toString() {
    return 'GorushInfo(version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GorushInfo &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GorushInfoCopyWith<_$_GorushInfo> get copyWith =>
      __$$_GorushInfoCopyWithImpl<_$_GorushInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GorushInfoToJson(
      this,
    );
  }
}

abstract class _GorushInfo implements GorushInfo {
  const factory _GorushInfo({final String? version}) = _$_GorushInfo;

  factory _GorushInfo.fromJson(Map<String, dynamic> json) =
      _$_GorushInfo.fromJson;

  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$_GorushInfoCopyWith<_$_GorushInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

CoreInfo _$CoreInfoFromJson(Map<String, dynamic> json) {
  return _CoreInfo.fromJson(json);
}

/// @nodoc
mixin _$CoreInfo {
  @VersionConverter()
  Version get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoreInfoCopyWith<CoreInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoreInfoCopyWith<$Res> {
  factory $CoreInfoCopyWith(CoreInfo value, $Res Function(CoreInfo) then) =
      _$CoreInfoCopyWithImpl<$Res, CoreInfo>;
  @useResult
  $Res call({@VersionConverter() Version version});
}

/// @nodoc
class _$CoreInfoCopyWithImpl<$Res, $Val extends CoreInfo>
    implements $CoreInfoCopyWith<$Res> {
  _$CoreInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as Version,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CoreInfoCopyWith<$Res> implements $CoreInfoCopyWith<$Res> {
  factory _$$_CoreInfoCopyWith(
          _$_CoreInfo value, $Res Function(_$_CoreInfo) then) =
      __$$_CoreInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@VersionConverter() Version version});
}

/// @nodoc
class __$$_CoreInfoCopyWithImpl<$Res>
    extends _$CoreInfoCopyWithImpl<$Res, _$_CoreInfo>
    implements _$$_CoreInfoCopyWith<$Res> {
  __$$_CoreInfoCopyWithImpl(
      _$_CoreInfo _value, $Res Function(_$_CoreInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
  }) {
    return _then(_$_CoreInfo(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as Version,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_CoreInfo implements _CoreInfo {
  const _$_CoreInfo({@VersionConverter() required this.version});

  factory _$_CoreInfo.fromJson(Map<String, dynamic> json) =>
      _$$_CoreInfoFromJson(json);

  @override
  @VersionConverter()
  final Version version;

  @override
  String toString() {
    return 'CoreInfo(version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CoreInfo &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CoreInfoCopyWith<_$_CoreInfo> get copyWith =>
      __$$_CoreInfoCopyWithImpl<_$_CoreInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CoreInfoToJson(
      this,
    );
  }
}

abstract class _CoreInfo implements CoreInfo {
  const factory _CoreInfo(
      {@VersionConverter() required final Version version}) = _$_CoreInfo;

  factory _CoreInfo.fromJson(Map<String, dynamic> json) = _$_CoreInfo.fromJson;

  @override
  @VersionConverter()
  Version get version;
  @override
  @JsonKey(ignore: true)
  _$$_CoreInfoCopyWith<_$_CoreInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

AdapterInfo _$AdapterInfoFromJson(Map<String, dynamic> json) {
  return _AdapterInfo.fromJson(json);
}

/// @nodoc
mixin _$AdapterInfo {
  String? get name => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  List<String>? get supported => throw _privateConstructorUsedError;
  Map<String, dynamic>? get custom => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdapterInfoCopyWith<AdapterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdapterInfoCopyWith<$Res> {
  factory $AdapterInfoCopyWith(
          AdapterInfo value, $Res Function(AdapterInfo) then) =
      _$AdapterInfoCopyWithImpl<$Res, AdapterInfo>;
  @useResult
  $Res call(
      {String? name,
      String? version,
      List<String>? supported,
      Map<String, dynamic>? custom});
}

/// @nodoc
class _$AdapterInfoCopyWithImpl<$Res, $Val extends AdapterInfo>
    implements $AdapterInfoCopyWith<$Res> {
  _$AdapterInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? version = freezed,
    Object? supported = freezed,
    Object? custom = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      supported: freezed == supported
          ? _value.supported
          : supported // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      custom: freezed == custom
          ? _value.custom
          : custom // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AdapterInfoCopyWith<$Res>
    implements $AdapterInfoCopyWith<$Res> {
  factory _$$_AdapterInfoCopyWith(
          _$_AdapterInfo value, $Res Function(_$_AdapterInfo) then) =
      __$$_AdapterInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? version,
      List<String>? supported,
      Map<String, dynamic>? custom});
}

/// @nodoc
class __$$_AdapterInfoCopyWithImpl<$Res>
    extends _$AdapterInfoCopyWithImpl<$Res, _$_AdapterInfo>
    implements _$$_AdapterInfoCopyWith<$Res> {
  __$$_AdapterInfoCopyWithImpl(
      _$_AdapterInfo _value, $Res Function(_$_AdapterInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? version = freezed,
    Object? supported = freezed,
    Object? custom = freezed,
  }) {
    return _then(_$_AdapterInfo(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      supported: freezed == supported
          ? _value._supported
          : supported // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      custom: freezed == custom
          ? _value._custom
          : custom // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AdapterInfo implements _AdapterInfo {
  const _$_AdapterInfo(
      {this.name,
      this.version,
      final List<String>? supported,
      final Map<String, dynamic>? custom})
      : _supported = supported,
        _custom = custom;

  factory _$_AdapterInfo.fromJson(Map<String, dynamic> json) =>
      _$$_AdapterInfoFromJson(json);

  @override
  final String? name;
  @override
  final String? version;
  final List<String>? _supported;
  @override
  List<String>? get supported {
    final value = _supported;
    if (value == null) return null;
    if (_supported is EqualUnmodifiableListView) return _supported;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _custom;
  @override
  Map<String, dynamic>? get custom {
    final value = _custom;
    if (value == null) return null;
    if (_custom is EqualUnmodifiableMapView) return _custom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AdapterInfo(name: $name, version: $version, supported: $supported, custom: $custom)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdapterInfo &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality()
                .equals(other._supported, _supported) &&
            const DeepCollectionEquality().equals(other._custom, _custom));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      version,
      const DeepCollectionEquality().hash(_supported),
      const DeepCollectionEquality().hash(_custom));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdapterInfoCopyWith<_$_AdapterInfo> get copyWith =>
      __$$_AdapterInfoCopyWithImpl<_$_AdapterInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AdapterInfoToJson(
      this,
    );
  }
}

abstract class _AdapterInfo implements AdapterInfo {
  const factory _AdapterInfo(
      {final String? name,
      final String? version,
      final List<String>? supported,
      final Map<String, dynamic>? custom}) = _$_AdapterInfo;

  factory _AdapterInfo.fromJson(Map<String, dynamic> json) =
      _$_AdapterInfo.fromJson;

  @override
  String? get name;
  @override
  String? get version;
  @override
  List<String>? get supported;
  @override
  Map<String, dynamic>? get custom;
  @override
  @JsonKey(ignore: true)
  _$$_AdapterInfoCopyWith<_$_AdapterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
