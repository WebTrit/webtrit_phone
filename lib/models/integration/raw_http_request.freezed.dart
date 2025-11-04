// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_http_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RawHttpRequest _$RawHttpRequestFromJson(Map<String, dynamic> json) {
  return _RawHttpRequest.fromJson(json);
}

/// @nodoc
mixin _$RawHttpRequest {
  String get method => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  Map<String, String>? get headers => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  /// Serializes this RawHttpRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RawHttpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RawHttpRequestCopyWith<RawHttpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RawHttpRequestCopyWith<$Res> {
  factory $RawHttpRequestCopyWith(
    RawHttpRequest value,
    $Res Function(RawHttpRequest) then,
  ) = _$RawHttpRequestCopyWithImpl<$Res, RawHttpRequest>;
  @useResult
  $Res call({
    String method,
    String url,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  });
}

/// @nodoc
class _$RawHttpRequestCopyWithImpl<$Res, $Val extends RawHttpRequest>
    implements $RawHttpRequestCopyWith<$Res> {
  _$RawHttpRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(
      _value.copyWith(
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            headers: freezed == headers
                ? _value.headers
                : headers // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RawHttpRequestImplCopyWith<$Res>
    implements $RawHttpRequestCopyWith<$Res> {
  factory _$$RawHttpRequestImplCopyWith(
    _$RawHttpRequestImpl value,
    $Res Function(_$RawHttpRequestImpl) then,
  ) = __$$RawHttpRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String method,
    String url,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  });
}

/// @nodoc
class __$$RawHttpRequestImplCopyWithImpl<$Res>
    extends _$RawHttpRequestCopyWithImpl<$Res, _$RawHttpRequestImpl>
    implements _$$RawHttpRequestImplCopyWith<$Res> {
  __$$RawHttpRequestImplCopyWithImpl(
    _$RawHttpRequestImpl _value,
    $Res Function(_$RawHttpRequestImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$RawHttpRequestImpl(
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        headers: freezed == headers
            ? _value._headers
            : headers // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        data: freezed == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RawHttpRequestImpl implements _RawHttpRequest {
  const _$RawHttpRequestImpl({
    required this.method,
    required this.url,
    final Map<String, String>? headers,
    final Map<String, dynamic>? data,
  }) : _headers = headers,
       _data = data;

  factory _$RawHttpRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RawHttpRequestImplFromJson(json);

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

  @override
  String toString() {
    return 'RawHttpRequest(method: $method, url: $url, headers: $headers, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RawHttpRequestImpl &&
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
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of RawHttpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RawHttpRequestImplCopyWith<_$RawHttpRequestImpl> get copyWith =>
      __$$RawHttpRequestImplCopyWithImpl<_$RawHttpRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RawHttpRequestImplToJson(this);
  }
}

abstract class _RawHttpRequest implements RawHttpRequest {
  const factory _RawHttpRequest({
    required final String method,
    required final String url,
    final Map<String, String>? headers,
    final Map<String, dynamic>? data,
  }) = _$RawHttpRequestImpl;

  factory _RawHttpRequest.fromJson(Map<String, dynamic> json) =
      _$RawHttpRequestImpl.fromJson;

  @override
  String get method;
  @override
  String get url;
  @override
  Map<String, String>? get headers;
  @override
  Map<String, dynamic>? get data;

  /// Create a copy of RawHttpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RawHttpRequestImplCopyWith<_$RawHttpRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
