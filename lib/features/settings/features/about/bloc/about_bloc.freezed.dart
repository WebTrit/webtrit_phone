// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'about_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AboutState {
  bool get progress => throw _privateConstructorUsedError;
  String get appName => throw _privateConstructorUsedError;
  String get packageName => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get buildNumber => throw _privateConstructorUsedError;
  Uri get coreUrl => throw _privateConstructorUsedError;
  Version? get coreVersion => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AboutStateCopyWith<AboutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AboutStateCopyWith<$Res> {
  factory $AboutStateCopyWith(
          AboutState value, $Res Function(AboutState) then) =
      _$AboutStateCopyWithImpl<$Res, AboutState>;
  @useResult
  $Res call(
      {bool progress,
      String appName,
      String packageName,
      String version,
      String buildNumber,
      Uri coreUrl,
      Version? coreVersion,
      Object? error});
}

/// @nodoc
class _$AboutStateCopyWithImpl<$Res, $Val extends AboutState>
    implements $AboutStateCopyWith<$Res> {
  _$AboutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? appName = null,
    Object? packageName = null,
    Object? version = null,
    Object? buildNumber = null,
    Object? coreUrl = null,
    Object? coreVersion = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as bool,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      buildNumber: null == buildNumber
          ? _value.buildNumber
          : buildNumber // ignore: cast_nullable_to_non_nullable
              as String,
      coreUrl: null == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as Uri,
      coreVersion: freezed == coreVersion
          ? _value.coreVersion
          : coreVersion // ignore: cast_nullable_to_non_nullable
              as Version?,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AboutStateCopyWith<$Res>
    implements $AboutStateCopyWith<$Res> {
  factory _$$_AboutStateCopyWith(
          _$_AboutState value, $Res Function(_$_AboutState) then) =
      __$$_AboutStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool progress,
      String appName,
      String packageName,
      String version,
      String buildNumber,
      Uri coreUrl,
      Version? coreVersion,
      Object? error});
}

/// @nodoc
class __$$_AboutStateCopyWithImpl<$Res>
    extends _$AboutStateCopyWithImpl<$Res, _$_AboutState>
    implements _$$_AboutStateCopyWith<$Res> {
  __$$_AboutStateCopyWithImpl(
      _$_AboutState _value, $Res Function(_$_AboutState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? appName = null,
    Object? packageName = null,
    Object? version = null,
    Object? buildNumber = null,
    Object? coreUrl = null,
    Object? coreVersion = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_AboutState(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as bool,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      buildNumber: null == buildNumber
          ? _value.buildNumber
          : buildNumber // ignore: cast_nullable_to_non_nullable
              as String,
      coreUrl: null == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as Uri,
      coreVersion: freezed == coreVersion
          ? _value.coreVersion
          : coreVersion // ignore: cast_nullable_to_non_nullable
              as Version?,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$_AboutState extends _AboutState {
  const _$_AboutState(
      {this.progress = false,
      required this.appName,
      required this.packageName,
      required this.version,
      required this.buildNumber,
      required this.coreUrl,
      this.coreVersion,
      this.error})
      : super._();

  @override
  @JsonKey()
  final bool progress;
  @override
  final String appName;
  @override
  final String packageName;
  @override
  final String version;
  @override
  final String buildNumber;
  @override
  final Uri coreUrl;
  @override
  final Version? coreVersion;
  @override
  final Object? error;

  @override
  String toString() {
    return 'AboutState(progress: $progress, appName: $appName, packageName: $packageName, version: $version, buildNumber: $buildNumber, coreUrl: $coreUrl, coreVersion: $coreVersion, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AboutState &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.buildNumber, buildNumber) ||
                other.buildNumber == buildNumber) &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.coreVersion, coreVersion) ||
                other.coreVersion == coreVersion) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      progress,
      appName,
      packageName,
      version,
      buildNumber,
      coreUrl,
      coreVersion,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AboutStateCopyWith<_$_AboutState> get copyWith =>
      __$$_AboutStateCopyWithImpl<_$_AboutState>(this, _$identity);
}

abstract class _AboutState extends AboutState {
  const factory _AboutState(
      {final bool progress,
      required final String appName,
      required final String packageName,
      required final String version,
      required final String buildNumber,
      required final Uri coreUrl,
      final Version? coreVersion,
      final Object? error}) = _$_AboutState;
  const _AboutState._() : super._();

  @override
  bool get progress;
  @override
  String get appName;
  @override
  String get packageName;
  @override
  String get version;
  @override
  String get buildNumber;
  @override
  Uri get coreUrl;
  @override
  Version? get coreVersion;
  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$_AboutStateCopyWith<_$_AboutState> get copyWith =>
      throw _privateConstructorUsedError;
}
