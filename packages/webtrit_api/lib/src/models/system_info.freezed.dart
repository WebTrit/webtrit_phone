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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$SystemInfoImplCopyWith<$Res>
    implements $SystemInfoCopyWith<$Res> {
  factory _$$SystemInfoImplCopyWith(
          _$SystemInfoImpl value, $Res Function(_$SystemInfoImpl) then) =
      __$$SystemInfoImplCopyWithImpl<$Res>;
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
class __$$SystemInfoImplCopyWithImpl<$Res>
    extends _$SystemInfoCopyWithImpl<$Res, _$SystemInfoImpl>
    implements _$$SystemInfoImplCopyWith<$Res> {
  __$$SystemInfoImplCopyWithImpl(
      _$SystemInfoImpl _value, $Res Function(_$SystemInfoImpl) _then)
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
    return _then(_$SystemInfoImpl(
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
class _$SystemInfoImpl implements _SystemInfo {
  const _$SystemInfoImpl(
      {required this.core,
      required this.postgres,
      this.janus,
      this.gorush,
      this.adapter});

  factory _$SystemInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SystemInfoImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemInfoImpl &&
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
  _$$SystemInfoImplCopyWith<_$SystemInfoImpl> get copyWith =>
      __$$SystemInfoImplCopyWithImpl<_$SystemInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemInfoImplToJson(
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
      final AdapterInfo? adapter}) = _$SystemInfoImpl;

  factory _SystemInfo.fromJson(Map<String, dynamic> json) =
      _$SystemInfoImpl.fromJson;

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
  _$$SystemInfoImplCopyWith<_$SystemInfoImpl> get copyWith =>
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
abstract class _$$PostgresInfoImplCopyWith<$Res>
    implements $PostgresInfoCopyWith<$Res> {
  factory _$$PostgresInfoImplCopyWith(
          _$PostgresInfoImpl value, $Res Function(_$PostgresInfoImpl) then) =
      __$$PostgresInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? version});
}

/// @nodoc
class __$$PostgresInfoImplCopyWithImpl<$Res>
    extends _$PostgresInfoCopyWithImpl<$Res, _$PostgresInfoImpl>
    implements _$$PostgresInfoImplCopyWith<$Res> {
  __$$PostgresInfoImplCopyWithImpl(
      _$PostgresInfoImpl _value, $Res Function(_$PostgresInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_$PostgresInfoImpl(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PostgresInfoImpl implements _PostgresInfo {
  const _$PostgresInfoImpl({this.version});

  factory _$PostgresInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostgresInfoImplFromJson(json);

  @override
  final String? version;

  @override
  String toString() {
    return 'PostgresInfo(version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostgresInfoImpl &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostgresInfoImplCopyWith<_$PostgresInfoImpl> get copyWith =>
      __$$PostgresInfoImplCopyWithImpl<_$PostgresInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostgresInfoImplToJson(
      this,
    );
  }
}

abstract class _PostgresInfo implements PostgresInfo {
  const factory _PostgresInfo({final String? version}) = _$PostgresInfoImpl;

  factory _PostgresInfo.fromJson(Map<String, dynamic> json) =
      _$PostgresInfoImpl.fromJson;

  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$PostgresInfoImplCopyWith<_$PostgresInfoImpl> get copyWith =>
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
abstract class _$$JanusInfoImplCopyWith<$Res>
    implements $JanusInfoCopyWith<$Res> {
  factory _$$JanusInfoImplCopyWith(
          _$JanusInfoImpl value, $Res Function(_$JanusInfoImpl) then) =
      __$$JanusInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Plugins? plugins, Transports? transports, String? version});

  @override
  $PluginsCopyWith<$Res>? get plugins;
  @override
  $TransportsCopyWith<$Res>? get transports;
}

/// @nodoc
class __$$JanusInfoImplCopyWithImpl<$Res>
    extends _$JanusInfoCopyWithImpl<$Res, _$JanusInfoImpl>
    implements _$$JanusInfoImplCopyWith<$Res> {
  __$$JanusInfoImplCopyWithImpl(
      _$JanusInfoImpl _value, $Res Function(_$JanusInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plugins = freezed,
    Object? transports = freezed,
    Object? version = freezed,
  }) {
    return _then(_$JanusInfoImpl(
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
class _$JanusInfoImpl implements _JanusInfo {
  const _$JanusInfoImpl({this.plugins, this.transports, this.version});

  factory _$JanusInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$JanusInfoImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JanusInfoImpl &&
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
  _$$JanusInfoImplCopyWith<_$JanusInfoImpl> get copyWith =>
      __$$JanusInfoImplCopyWithImpl<_$JanusInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JanusInfoImplToJson(
      this,
    );
  }
}

abstract class _JanusInfo implements JanusInfo {
  const factory _JanusInfo(
      {final Plugins? plugins,
      final Transports? transports,
      final String? version}) = _$JanusInfoImpl;

  factory _JanusInfo.fromJson(Map<String, dynamic> json) =
      _$JanusInfoImpl.fromJson;

  @override
  Plugins? get plugins;
  @override
  Transports? get transports;
  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$JanusInfoImplCopyWith<_$JanusInfoImpl> get copyWith =>
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
abstract class _$$TransportsImplCopyWith<$Res>
    implements $TransportsCopyWith<$Res> {
  factory _$$TransportsImplCopyWith(
          _$TransportsImpl value, $Res Function(_$TransportsImpl) then) =
      __$$TransportsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Websocket? websocket});

  @override
  $WebsocketCopyWith<$Res>? get websocket;
}

/// @nodoc
class __$$TransportsImplCopyWithImpl<$Res>
    extends _$TransportsCopyWithImpl<$Res, _$TransportsImpl>
    implements _$$TransportsImplCopyWith<$Res> {
  __$$TransportsImplCopyWithImpl(
      _$TransportsImpl _value, $Res Function(_$TransportsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websocket = freezed,
  }) {
    return _then(_$TransportsImpl(
      websocket: freezed == websocket
          ? _value.websocket
          : websocket // ignore: cast_nullable_to_non_nullable
              as Websocket?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TransportsImpl implements _Transports {
  const _$TransportsImpl({this.websocket});

  factory _$TransportsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransportsImplFromJson(json);

  @override
  final Websocket? websocket;

  @override
  String toString() {
    return 'Transports(websocket: $websocket)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransportsImpl &&
            (identical(other.websocket, websocket) ||
                other.websocket == websocket));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, websocket);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransportsImplCopyWith<_$TransportsImpl> get copyWith =>
      __$$TransportsImplCopyWithImpl<_$TransportsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransportsImplToJson(
      this,
    );
  }
}

abstract class _Transports implements Transports {
  const factory _Transports({final Websocket? websocket}) = _$TransportsImpl;

  factory _Transports.fromJson(Map<String, dynamic> json) =
      _$TransportsImpl.fromJson;

  @override
  Websocket? get websocket;
  @override
  @JsonKey(ignore: true)
  _$$TransportsImplCopyWith<_$TransportsImpl> get copyWith =>
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
abstract class _$$WebsocketImplCopyWith<$Res>
    implements $WebsocketCopyWith<$Res> {
  factory _$$WebsocketImplCopyWith(
          _$WebsocketImpl value, $Res Function(_$WebsocketImpl) then) =
      __$$WebsocketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? version});
}

/// @nodoc
class __$$WebsocketImplCopyWithImpl<$Res>
    extends _$WebsocketCopyWithImpl<$Res, _$WebsocketImpl>
    implements _$$WebsocketImplCopyWith<$Res> {
  __$$WebsocketImplCopyWithImpl(
      _$WebsocketImpl _value, $Res Function(_$WebsocketImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_$WebsocketImpl(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$WebsocketImpl implements _Websocket {
  const _$WebsocketImpl({this.version});

  factory _$WebsocketImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebsocketImplFromJson(json);

  @override
  final String? version;

  @override
  String toString() {
    return 'Websocket(version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebsocketImpl &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebsocketImplCopyWith<_$WebsocketImpl> get copyWith =>
      __$$WebsocketImplCopyWithImpl<_$WebsocketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebsocketImplToJson(
      this,
    );
  }
}

abstract class _Websocket implements Websocket {
  const factory _Websocket({final String? version}) = _$WebsocketImpl;

  factory _Websocket.fromJson(Map<String, dynamic> json) =
      _$WebsocketImpl.fromJson;

  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$WebsocketImplCopyWith<_$WebsocketImpl> get copyWith =>
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
abstract class _$$PluginsImplCopyWith<$Res> implements $PluginsCopyWith<$Res> {
  factory _$$PluginsImplCopyWith(
          _$PluginsImpl value, $Res Function(_$PluginsImpl) then) =
      __$$PluginsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SipVersion? sip});

  @override
  $SipVersionCopyWith<$Res>? get sip;
}

/// @nodoc
class __$$PluginsImplCopyWithImpl<$Res>
    extends _$PluginsCopyWithImpl<$Res, _$PluginsImpl>
    implements _$$PluginsImplCopyWith<$Res> {
  __$$PluginsImplCopyWithImpl(
      _$PluginsImpl _value, $Res Function(_$PluginsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sip = freezed,
  }) {
    return _then(_$PluginsImpl(
      sip: freezed == sip
          ? _value.sip
          : sip // ignore: cast_nullable_to_non_nullable
              as SipVersion?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PluginsImpl implements _Plugins {
  const _$PluginsImpl({this.sip});

  factory _$PluginsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PluginsImplFromJson(json);

  @override
  final SipVersion? sip;

  @override
  String toString() {
    return 'Plugins(sip: $sip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PluginsImpl &&
            (identical(other.sip, sip) || other.sip == sip));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sip);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PluginsImplCopyWith<_$PluginsImpl> get copyWith =>
      __$$PluginsImplCopyWithImpl<_$PluginsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PluginsImplToJson(
      this,
    );
  }
}

abstract class _Plugins implements Plugins {
  const factory _Plugins({final SipVersion? sip}) = _$PluginsImpl;

  factory _Plugins.fromJson(Map<String, dynamic> json) = _$PluginsImpl.fromJson;

  @override
  SipVersion? get sip;
  @override
  @JsonKey(ignore: true)
  _$$PluginsImplCopyWith<_$PluginsImpl> get copyWith =>
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
abstract class _$$SipVersionImplCopyWith<$Res>
    implements $SipVersionCopyWith<$Res> {
  factory _$$SipVersionImplCopyWith(
          _$SipVersionImpl value, $Res Function(_$SipVersionImpl) then) =
      __$$SipVersionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? version});
}

/// @nodoc
class __$$SipVersionImplCopyWithImpl<$Res>
    extends _$SipVersionCopyWithImpl<$Res, _$SipVersionImpl>
    implements _$$SipVersionImplCopyWith<$Res> {
  __$$SipVersionImplCopyWithImpl(
      _$SipVersionImpl _value, $Res Function(_$SipVersionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_$SipVersionImpl(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SipVersionImpl implements _SipVersion {
  const _$SipVersionImpl({this.version});

  factory _$SipVersionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SipVersionImplFromJson(json);

  @override
  final String? version;

  @override
  String toString() {
    return 'SipVersion(version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SipVersionImpl &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SipVersionImplCopyWith<_$SipVersionImpl> get copyWith =>
      __$$SipVersionImplCopyWithImpl<_$SipVersionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SipVersionImplToJson(
      this,
    );
  }
}

abstract class _SipVersion implements SipVersion {
  const factory _SipVersion({final String? version}) = _$SipVersionImpl;

  factory _SipVersion.fromJson(Map<String, dynamic> json) =
      _$SipVersionImpl.fromJson;

  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$SipVersionImplCopyWith<_$SipVersionImpl> get copyWith =>
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
abstract class _$$GorushInfoImplCopyWith<$Res>
    implements $GorushInfoCopyWith<$Res> {
  factory _$$GorushInfoImplCopyWith(
          _$GorushInfoImpl value, $Res Function(_$GorushInfoImpl) then) =
      __$$GorushInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? version});
}

/// @nodoc
class __$$GorushInfoImplCopyWithImpl<$Res>
    extends _$GorushInfoCopyWithImpl<$Res, _$GorushInfoImpl>
    implements _$$GorushInfoImplCopyWith<$Res> {
  __$$GorushInfoImplCopyWithImpl(
      _$GorushInfoImpl _value, $Res Function(_$GorushInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_$GorushInfoImpl(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$GorushInfoImpl implements _GorushInfo {
  const _$GorushInfoImpl({this.version});

  factory _$GorushInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GorushInfoImplFromJson(json);

  @override
  final String? version;

  @override
  String toString() {
    return 'GorushInfo(version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GorushInfoImpl &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GorushInfoImplCopyWith<_$GorushInfoImpl> get copyWith =>
      __$$GorushInfoImplCopyWithImpl<_$GorushInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GorushInfoImplToJson(
      this,
    );
  }
}

abstract class _GorushInfo implements GorushInfo {
  const factory _GorushInfo({final String? version}) = _$GorushInfoImpl;

  factory _GorushInfo.fromJson(Map<String, dynamic> json) =
      _$GorushInfoImpl.fromJson;

  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$GorushInfoImplCopyWith<_$GorushInfoImpl> get copyWith =>
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
abstract class _$$CoreInfoImplCopyWith<$Res>
    implements $CoreInfoCopyWith<$Res> {
  factory _$$CoreInfoImplCopyWith(
          _$CoreInfoImpl value, $Res Function(_$CoreInfoImpl) then) =
      __$$CoreInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@VersionConverter() Version version});
}

/// @nodoc
class __$$CoreInfoImplCopyWithImpl<$Res>
    extends _$CoreInfoCopyWithImpl<$Res, _$CoreInfoImpl>
    implements _$$CoreInfoImplCopyWith<$Res> {
  __$$CoreInfoImplCopyWithImpl(
      _$CoreInfoImpl _value, $Res Function(_$CoreInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
  }) {
    return _then(_$CoreInfoImpl(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as Version,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$CoreInfoImpl implements _CoreInfo {
  const _$CoreInfoImpl({@VersionConverter() required this.version});

  factory _$CoreInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoreInfoImplFromJson(json);

  @override
  @VersionConverter()
  final Version version;

  @override
  String toString() {
    return 'CoreInfo(version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoreInfoImpl &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CoreInfoImplCopyWith<_$CoreInfoImpl> get copyWith =>
      __$$CoreInfoImplCopyWithImpl<_$CoreInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoreInfoImplToJson(
      this,
    );
  }
}

abstract class _CoreInfo implements CoreInfo {
  const factory _CoreInfo(
      {@VersionConverter() required final Version version}) = _$CoreInfoImpl;

  factory _CoreInfo.fromJson(Map<String, dynamic> json) =
      _$CoreInfoImpl.fromJson;

  @override
  @VersionConverter()
  Version get version;
  @override
  @JsonKey(ignore: true)
  _$$CoreInfoImplCopyWith<_$CoreInfoImpl> get copyWith =>
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
abstract class _$$AdapterInfoImplCopyWith<$Res>
    implements $AdapterInfoCopyWith<$Res> {
  factory _$$AdapterInfoImplCopyWith(
          _$AdapterInfoImpl value, $Res Function(_$AdapterInfoImpl) then) =
      __$$AdapterInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? version,
      List<String>? supported,
      Map<String, dynamic>? custom});
}

/// @nodoc
class __$$AdapterInfoImplCopyWithImpl<$Res>
    extends _$AdapterInfoCopyWithImpl<$Res, _$AdapterInfoImpl>
    implements _$$AdapterInfoImplCopyWith<$Res> {
  __$$AdapterInfoImplCopyWithImpl(
      _$AdapterInfoImpl _value, $Res Function(_$AdapterInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? version = freezed,
    Object? supported = freezed,
    Object? custom = freezed,
  }) {
    return _then(_$AdapterInfoImpl(
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
class _$AdapterInfoImpl implements _AdapterInfo {
  const _$AdapterInfoImpl(
      {this.name,
      this.version,
      final List<String>? supported,
      final Map<String, dynamic>? custom})
      : _supported = supported,
        _custom = custom;

  factory _$AdapterInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdapterInfoImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdapterInfoImpl &&
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
  _$$AdapterInfoImplCopyWith<_$AdapterInfoImpl> get copyWith =>
      __$$AdapterInfoImplCopyWithImpl<_$AdapterInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdapterInfoImplToJson(
      this,
    );
  }
}

abstract class _AdapterInfo implements AdapterInfo {
  const factory _AdapterInfo(
      {final String? name,
      final String? version,
      final List<String>? supported,
      final Map<String, dynamic>? custom}) = _$AdapterInfoImpl;

  factory _AdapterInfo.fromJson(Map<String, dynamic> json) =
      _$AdapterInfoImpl.fromJson;

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
  _$$AdapterInfoImplCopyWith<_$AdapterInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
