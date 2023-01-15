// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Info _$InfoFromJson(Map<String, dynamic> json) {
  return _Info.fromJson(json);
}

/// @nodoc
mixin _$Info {
  CoreInfo get core => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InfoCopyWith<Info> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoCopyWith<$Res> {
  factory $InfoCopyWith(Info value, $Res Function(Info) then) =
      _$InfoCopyWithImpl<$Res, Info>;
  @useResult
  $Res call({CoreInfo core});

  $CoreInfoCopyWith<$Res> get core;
}

/// @nodoc
class _$InfoCopyWithImpl<$Res, $Val extends Info>
    implements $InfoCopyWith<$Res> {
  _$InfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? core = null,
  }) {
    return _then(_value.copyWith(
      core: null == core
          ? _value.core
          : core // ignore: cast_nullable_to_non_nullable
              as CoreInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CoreInfoCopyWith<$Res> get core {
    return $CoreInfoCopyWith<$Res>(_value.core, (value) {
      return _then(_value.copyWith(core: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_InfoCopyWith<$Res> implements $InfoCopyWith<$Res> {
  factory _$$_InfoCopyWith(_$_Info value, $Res Function(_$_Info) then) =
      __$$_InfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CoreInfo core});

  @override
  $CoreInfoCopyWith<$Res> get core;
}

/// @nodoc
class __$$_InfoCopyWithImpl<$Res> extends _$InfoCopyWithImpl<$Res, _$_Info>
    implements _$$_InfoCopyWith<$Res> {
  __$$_InfoCopyWithImpl(_$_Info _value, $Res Function(_$_Info) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? core = null,
  }) {
    return _then(_$_Info(
      core: null == core
          ? _value.core
          : core // ignore: cast_nullable_to_non_nullable
              as CoreInfo,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Info implements _Info {
  const _$_Info({required this.core});

  factory _$_Info.fromJson(Map<String, dynamic> json) => _$$_InfoFromJson(json);

  @override
  final CoreInfo core;

  @override
  String toString() {
    return 'Info(core: $core)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Info &&
            (identical(other.core, core) || other.core == core));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, core);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InfoCopyWith<_$_Info> get copyWith =>
      __$$_InfoCopyWithImpl<_$_Info>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InfoToJson(
      this,
    );
  }
}

abstract class _Info implements Info {
  const factory _Info({required final CoreInfo core}) = _$_Info;

  factory _Info.fromJson(Map<String, dynamic> json) = _$_Info.fromJson;

  @override
  CoreInfo get core;
  @override
  @JsonKey(ignore: true)
  _$$_InfoCopyWith<_$_Info> get copyWith => throw _privateConstructorUsedError;
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
