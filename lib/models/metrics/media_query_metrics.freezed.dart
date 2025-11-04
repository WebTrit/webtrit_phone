// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_query_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MediaQueryMetrics _$MediaQueryMetricsFromJson(Map<String, dynamic> json) {
  return _MediaQueryMetrics.fromJson(json);
}

/// @nodoc
mixin _$MediaQueryMetrics {
  String get brightness => throw _privateConstructorUsedError;
  double get devicePixelRatio => throw _privateConstructorUsedError;
  int get topSafeInset => throw _privateConstructorUsedError;
  int get bottomSafeInset => throw _privateConstructorUsedError;

  /// Serializes this MediaQueryMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MediaQueryMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaQueryMetricsCopyWith<MediaQueryMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaQueryMetricsCopyWith<$Res> {
  factory $MediaQueryMetricsCopyWith(
    MediaQueryMetrics value,
    $Res Function(MediaQueryMetrics) then,
  ) = _$MediaQueryMetricsCopyWithImpl<$Res, MediaQueryMetrics>;
  @useResult
  $Res call({
    String brightness,
    double devicePixelRatio,
    int topSafeInset,
    int bottomSafeInset,
  });
}

/// @nodoc
class _$MediaQueryMetricsCopyWithImpl<$Res, $Val extends MediaQueryMetrics>
    implements $MediaQueryMetricsCopyWith<$Res> {
  _$MediaQueryMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaQueryMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brightness = null,
    Object? devicePixelRatio = null,
    Object? topSafeInset = null,
    Object? bottomSafeInset = null,
  }) {
    return _then(
      _value.copyWith(
            brightness: null == brightness
                ? _value.brightness
                : brightness // ignore: cast_nullable_to_non_nullable
                      as String,
            devicePixelRatio: null == devicePixelRatio
                ? _value.devicePixelRatio
                : devicePixelRatio // ignore: cast_nullable_to_non_nullable
                      as double,
            topSafeInset: null == topSafeInset
                ? _value.topSafeInset
                : topSafeInset // ignore: cast_nullable_to_non_nullable
                      as int,
            bottomSafeInset: null == bottomSafeInset
                ? _value.bottomSafeInset
                : bottomSafeInset // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MediaQueryMetricsImplCopyWith<$Res>
    implements $MediaQueryMetricsCopyWith<$Res> {
  factory _$$MediaQueryMetricsImplCopyWith(
    _$MediaQueryMetricsImpl value,
    $Res Function(_$MediaQueryMetricsImpl) then,
  ) = __$$MediaQueryMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String brightness,
    double devicePixelRatio,
    int topSafeInset,
    int bottomSafeInset,
  });
}

/// @nodoc
class __$$MediaQueryMetricsImplCopyWithImpl<$Res>
    extends _$MediaQueryMetricsCopyWithImpl<$Res, _$MediaQueryMetricsImpl>
    implements _$$MediaQueryMetricsImplCopyWith<$Res> {
  __$$MediaQueryMetricsImplCopyWithImpl(
    _$MediaQueryMetricsImpl _value,
    $Res Function(_$MediaQueryMetricsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaQueryMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brightness = null,
    Object? devicePixelRatio = null,
    Object? topSafeInset = null,
    Object? bottomSafeInset = null,
  }) {
    return _then(
      _$MediaQueryMetricsImpl(
        brightness: null == brightness
            ? _value.brightness
            : brightness // ignore: cast_nullable_to_non_nullable
                  as String,
        devicePixelRatio: null == devicePixelRatio
            ? _value.devicePixelRatio
            : devicePixelRatio // ignore: cast_nullable_to_non_nullable
                  as double,
        topSafeInset: null == topSafeInset
            ? _value.topSafeInset
            : topSafeInset // ignore: cast_nullable_to_non_nullable
                  as int,
        bottomSafeInset: null == bottomSafeInset
            ? _value.bottomSafeInset
            : bottomSafeInset // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaQueryMetricsImpl implements _MediaQueryMetrics {
  const _$MediaQueryMetricsImpl({
    required this.brightness,
    required this.devicePixelRatio,
    required this.topSafeInset,
    required this.bottomSafeInset,
  });

  factory _$MediaQueryMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaQueryMetricsImplFromJson(json);

  @override
  final String brightness;
  @override
  final double devicePixelRatio;
  @override
  final int topSafeInset;
  @override
  final int bottomSafeInset;

  @override
  String toString() {
    return 'MediaQueryMetrics(brightness: $brightness, devicePixelRatio: $devicePixelRatio, topSafeInset: $topSafeInset, bottomSafeInset: $bottomSafeInset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaQueryMetricsImpl &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.devicePixelRatio, devicePixelRatio) ||
                other.devicePixelRatio == devicePixelRatio) &&
            (identical(other.topSafeInset, topSafeInset) ||
                other.topSafeInset == topSafeInset) &&
            (identical(other.bottomSafeInset, bottomSafeInset) ||
                other.bottomSafeInset == bottomSafeInset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    brightness,
    devicePixelRatio,
    topSafeInset,
    bottomSafeInset,
  );

  /// Create a copy of MediaQueryMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaQueryMetricsImplCopyWith<_$MediaQueryMetricsImpl> get copyWith =>
      __$$MediaQueryMetricsImplCopyWithImpl<_$MediaQueryMetricsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaQueryMetricsImplToJson(this);
  }
}

abstract class _MediaQueryMetrics implements MediaQueryMetrics {
  const factory _MediaQueryMetrics({
    required final String brightness,
    required final double devicePixelRatio,
    required final int topSafeInset,
    required final int bottomSafeInset,
  }) = _$MediaQueryMetricsImpl;

  factory _MediaQueryMetrics.fromJson(Map<String, dynamic> json) =
      _$MediaQueryMetricsImpl.fromJson;

  @override
  String get brightness;
  @override
  double get devicePixelRatio;
  @override
  int get topSafeInset;
  @override
  int get bottomSafeInset;

  /// Create a copy of MediaQueryMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaQueryMetricsImplCopyWith<_$MediaQueryMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
