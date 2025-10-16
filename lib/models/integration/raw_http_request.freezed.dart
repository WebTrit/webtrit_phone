// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_http_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RawHttpRequest {
  String get method;
  String get url;
  Map<String, String>? get headers;
  Map<String, dynamic>? get data;

  /// Create a copy of RawHttpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RawHttpRequestCopyWith<RawHttpRequest> get copyWith =>
      _$RawHttpRequestCopyWithImpl<RawHttpRequest>(
          this as RawHttpRequest, _$identity);

  /// Serializes this RawHttpRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RawHttpRequest &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other.headers, headers) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      method,
      url,
      const DeepCollectionEquality().hash(headers),
      const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'RawHttpRequest(method: $method, url: $url, headers: $headers, data: $data)';
  }
}

/// @nodoc
abstract mixin class $RawHttpRequestCopyWith<$Res> {
  factory $RawHttpRequestCopyWith(
          RawHttpRequest value, $Res Function(RawHttpRequest) _then) =
      _$RawHttpRequestCopyWithImpl;
  @useResult
  $Res call(
      {String method,
      String url,
      Map<String, String>? headers,
      Map<String, dynamic>? data});
}

/// @nodoc
class _$RawHttpRequestCopyWithImpl<$Res>
    implements $RawHttpRequestCopyWith<$Res> {
  _$RawHttpRequestCopyWithImpl(this._self, this._then);

  final RawHttpRequest _self;
  final $Res Function(RawHttpRequest) _then;

  /// Create a copy of RawHttpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? url = null,
    Object? headers = freezed,
    Object? data = freezed,
  }) {
    return _then(_self.copyWith(
      method: null == method
          ? _self.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      headers: freezed == headers
          ? _self.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [RawHttpRequest].
extension RawHttpRequestPatterns on RawHttpRequest {
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
    TResult Function(_RawHttpRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RawHttpRequest() when $default != null:
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
    TResult Function(_RawHttpRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RawHttpRequest():
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
    TResult? Function(_RawHttpRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RawHttpRequest() when $default != null:
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
    TResult Function(String method, String url, Map<String, String>? headers,
            Map<String, dynamic>? data)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RawHttpRequest() when $default != null:
        return $default(_that.method, _that.url, _that.headers, _that.data);
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
    TResult Function(String method, String url, Map<String, String>? headers,
            Map<String, dynamic>? data)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RawHttpRequest():
        return $default(_that.method, _that.url, _that.headers, _that.data);
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
    TResult? Function(String method, String url, Map<String, String>? headers,
            Map<String, dynamic>? data)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RawHttpRequest() when $default != null:
        return $default(_that.method, _that.url, _that.headers, _that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RawHttpRequest implements RawHttpRequest {
  const _RawHttpRequest(
      {required this.method,
      required this.url,
      final Map<String, String>? headers,
      final Map<String, dynamic>? data})
      : _headers = headers,
        _data = data;
  factory _RawHttpRequest.fromJson(Map<String, dynamic> json) =>
      _$RawHttpRequestFromJson(json);

  @override
  final String method;
  @override
  final String url;
  final Map<String, String>? _headers;
  @override
  Map<String, String>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of RawHttpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RawHttpRequestCopyWith<_RawHttpRequest> get copyWith =>
      __$RawHttpRequestCopyWithImpl<_RawHttpRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RawHttpRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RawHttpRequest &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      method,
      url,
      const DeepCollectionEquality().hash(_headers),
      const DeepCollectionEquality().hash(_data));

  @override
  String toString() {
    return 'RawHttpRequest(method: $method, url: $url, headers: $headers, data: $data)';
  }
}

/// @nodoc
abstract mixin class _$RawHttpRequestCopyWith<$Res>
    implements $RawHttpRequestCopyWith<$Res> {
  factory _$RawHttpRequestCopyWith(
          _RawHttpRequest value, $Res Function(_RawHttpRequest) _then) =
      __$RawHttpRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String method,
      String url,
      Map<String, String>? headers,
      Map<String, dynamic>? data});
}

/// @nodoc
class __$RawHttpRequestCopyWithImpl<$Res>
    implements _$RawHttpRequestCopyWith<$Res> {
  __$RawHttpRequestCopyWithImpl(this._self, this._then);

  final _RawHttpRequest _self;
  final $Res Function(_RawHttpRequest) _then;

  /// Create a copy of RawHttpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? method = null,
    Object? url = null,
    Object? headers = freezed,
    Object? data = freezed,
  }) {
    return _then(_RawHttpRequest(
      method: null == method
          ? _self.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      headers: freezed == headers
          ? _self._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      data: freezed == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

// dart format on
