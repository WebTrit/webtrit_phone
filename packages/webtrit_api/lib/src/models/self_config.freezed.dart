// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'self_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SelfConfigResponse _$SelfConfigResponseFromJson(Map<String, dynamic> json) {
  return _SelfConfigResponse.fromJson(json);
}

/// @nodoc
mixin _$SelfConfigResponse {
  Uri get url => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this SelfConfigResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelfConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelfConfigResponseCopyWith<SelfConfigResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelfConfigResponseCopyWith<$Res> {
  factory $SelfConfigResponseCopyWith(
          SelfConfigResponse value, $Res Function(SelfConfigResponse) then) =
      _$SelfConfigResponseCopyWithImpl<$Res, SelfConfigResponse>;
  @useResult
  $Res call({Uri url, DateTime expiresAt});
}

/// @nodoc
class _$SelfConfigResponseCopyWithImpl<$Res, $Val extends SelfConfigResponse>
    implements $SelfConfigResponseCopyWith<$Res> {
  _$SelfConfigResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelfConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? expiresAt = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelfConfigResponseImplCopyWith<$Res>
    implements $SelfConfigResponseCopyWith<$Res> {
  factory _$$SelfConfigResponseImplCopyWith(_$SelfConfigResponseImpl value,
          $Res Function(_$SelfConfigResponseImpl) then) =
      __$$SelfConfigResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uri url, DateTime expiresAt});
}

/// @nodoc
class __$$SelfConfigResponseImplCopyWithImpl<$Res>
    extends _$SelfConfigResponseCopyWithImpl<$Res, _$SelfConfigResponseImpl>
    implements _$$SelfConfigResponseImplCopyWith<$Res> {
  __$$SelfConfigResponseImplCopyWithImpl(_$SelfConfigResponseImpl _value,
      $Res Function(_$SelfConfigResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelfConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? expiresAt = null,
  }) {
    return _then(_$SelfConfigResponseImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SelfConfigResponseImpl implements _SelfConfigResponse {
  const _$SelfConfigResponseImpl({required this.url, required this.expiresAt});

  factory _$SelfConfigResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelfConfigResponseImplFromJson(json);

  @override
  final Uri url;
  @override
  final DateTime expiresAt;

  @override
  String toString() {
    return 'SelfConfigResponse(url: $url, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelfConfigResponseImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, expiresAt);

  /// Create a copy of SelfConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelfConfigResponseImplCopyWith<_$SelfConfigResponseImpl> get copyWith =>
      __$$SelfConfigResponseImplCopyWithImpl<_$SelfConfigResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelfConfigResponseImplToJson(
      this,
    );
  }
}

abstract class _SelfConfigResponse implements SelfConfigResponse {
  const factory _SelfConfigResponse(
      {required final Uri url,
      required final DateTime expiresAt}) = _$SelfConfigResponseImpl;

  factory _SelfConfigResponse.fromJson(Map<String, dynamic> json) =
      _$SelfConfigResponseImpl.fromJson;

  @override
  Uri get url;
  @override
  DateTime get expiresAt;

  /// Create a copy of SelfConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelfConfigResponseImplCopyWith<_$SelfConfigResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
