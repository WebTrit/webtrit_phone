// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_query_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MediaQueryMetrics {
  String get brightness;
  double get devicePixelRatio;
  int get topSafeInset;
  int get bottomSafeInset;

  /// Create a copy of MediaQueryMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MediaQueryMetricsCopyWith<MediaQueryMetrics> get copyWith =>
      _$MediaQueryMetricsCopyWithImpl<MediaQueryMetrics>(
          this as MediaQueryMetrics, _$identity);

  /// Serializes this MediaQueryMetrics to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MediaQueryMetrics &&
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
      runtimeType, brightness, devicePixelRatio, topSafeInset, bottomSafeInset);

  @override
  String toString() {
    return 'MediaQueryMetrics(brightness: $brightness, devicePixelRatio: $devicePixelRatio, topSafeInset: $topSafeInset, bottomSafeInset: $bottomSafeInset)';
  }
}

/// @nodoc
abstract mixin class $MediaQueryMetricsCopyWith<$Res> {
  factory $MediaQueryMetricsCopyWith(
          MediaQueryMetrics value, $Res Function(MediaQueryMetrics) _then) =
      _$MediaQueryMetricsCopyWithImpl;
  @useResult
  $Res call(
      {String brightness,
      double devicePixelRatio,
      int topSafeInset,
      int bottomSafeInset});
}

/// @nodoc
class _$MediaQueryMetricsCopyWithImpl<$Res>
    implements $MediaQueryMetricsCopyWith<$Res> {
  _$MediaQueryMetricsCopyWithImpl(this._self, this._then);

  final MediaQueryMetrics _self;
  final $Res Function(MediaQueryMetrics) _then;

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
    return _then(_self.copyWith(
      brightness: null == brightness
          ? _self.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as String,
      devicePixelRatio: null == devicePixelRatio
          ? _self.devicePixelRatio
          : devicePixelRatio // ignore: cast_nullable_to_non_nullable
              as double,
      topSafeInset: null == topSafeInset
          ? _self.topSafeInset
          : topSafeInset // ignore: cast_nullable_to_non_nullable
              as int,
      bottomSafeInset: null == bottomSafeInset
          ? _self.bottomSafeInset
          : bottomSafeInset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [MediaQueryMetrics].
extension MediaQueryMetricsPatterns on MediaQueryMetrics {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MediaQueryMetrics value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MediaQueryMetrics() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MediaQueryMetrics value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaQueryMetrics():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MediaQueryMetrics value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaQueryMetrics() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String brightness, double devicePixelRatio,
            int topSafeInset, int bottomSafeInset)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MediaQueryMetrics() when $default != null:
        return $default(_that.brightness, _that.devicePixelRatio,
            _that.topSafeInset, _that.bottomSafeInset);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String brightness, double devicePixelRatio,
            int topSafeInset, int bottomSafeInset)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaQueryMetrics():
        return $default(_that.brightness, _that.devicePixelRatio,
            _that.topSafeInset, _that.bottomSafeInset);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String brightness, double devicePixelRatio,
            int topSafeInset, int bottomSafeInset)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaQueryMetrics() when $default != null:
        return $default(_that.brightness, _that.devicePixelRatio,
            _that.topSafeInset, _that.bottomSafeInset);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MediaQueryMetrics implements MediaQueryMetrics {
  const _MediaQueryMetrics(
      {required this.brightness,
      required this.devicePixelRatio,
      required this.topSafeInset,
      required this.bottomSafeInset});
  factory _MediaQueryMetrics.fromJson(Map<String, dynamic> json) =>
      _$MediaQueryMetricsFromJson(json);

  @override
  final String brightness;
  @override
  final double devicePixelRatio;
  @override
  final int topSafeInset;
  @override
  final int bottomSafeInset;

  /// Create a copy of MediaQueryMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MediaQueryMetricsCopyWith<_MediaQueryMetrics> get copyWith =>
      __$MediaQueryMetricsCopyWithImpl<_MediaQueryMetrics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MediaQueryMetricsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MediaQueryMetrics &&
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
      runtimeType, brightness, devicePixelRatio, topSafeInset, bottomSafeInset);

  @override
  String toString() {
    return 'MediaQueryMetrics(brightness: $brightness, devicePixelRatio: $devicePixelRatio, topSafeInset: $topSafeInset, bottomSafeInset: $bottomSafeInset)';
  }
}

/// @nodoc
abstract mixin class _$MediaQueryMetricsCopyWith<$Res>
    implements $MediaQueryMetricsCopyWith<$Res> {
  factory _$MediaQueryMetricsCopyWith(
          _MediaQueryMetrics value, $Res Function(_MediaQueryMetrics) _then) =
      __$MediaQueryMetricsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String brightness,
      double devicePixelRatio,
      int topSafeInset,
      int bottomSafeInset});
}

/// @nodoc
class __$MediaQueryMetricsCopyWithImpl<$Res>
    implements _$MediaQueryMetricsCopyWith<$Res> {
  __$MediaQueryMetricsCopyWithImpl(this._self, this._then);

  final _MediaQueryMetrics _self;
  final $Res Function(_MediaQueryMetrics) _then;

  /// Create a copy of MediaQueryMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? brightness = null,
    Object? devicePixelRatio = null,
    Object? topSafeInset = null,
    Object? bottomSafeInset = null,
  }) {
    return _then(_MediaQueryMetrics(
      brightness: null == brightness
          ? _self.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as String,
      devicePixelRatio: null == devicePixelRatio
          ? _self.devicePixelRatio
          : devicePixelRatio // ignore: cast_nullable_to_non_nullable
              as double,
      topSafeInset: null == topSafeInset
          ? _self.topSafeInset
          : topSafeInset // ignore: cast_nullable_to_non_nullable
              as int,
      bottomSafeInset: null == bottomSafeInset
          ? _self.bottomSafeInset
          : bottomSafeInset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
