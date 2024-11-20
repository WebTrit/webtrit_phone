// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_user_credential_number.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionUserCredentialNumber _$SessionUserCredentialNumberFromJson(
    Map<String, dynamic> json) {
  return _SessionUserCredentialNumber.fromJson(json);
}

/// @nodoc
mixin _$SessionUserCredentialNumber {
  String? get bundleId => throw _privateConstructorUsedError;
  AppType get type => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;

  /// Serializes this SessionUserCredentialNumber to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionUserCredentialNumber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionUserCredentialNumberCopyWith<SessionUserCredentialNumber>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionUserCredentialNumberCopyWith<$Res> {
  factory $SessionUserCredentialNumberCopyWith(
          SessionUserCredentialNumber value,
          $Res Function(SessionUserCredentialNumber) then) =
      _$SessionUserCredentialNumberCopyWithImpl<$Res,
          SessionUserCredentialNumber>;
  @useResult
  $Res call(
      {String? bundleId, AppType type, String identifier, String phoneNumber});
}

/// @nodoc
class _$SessionUserCredentialNumberCopyWithImpl<$Res,
        $Val extends SessionUserCredentialNumber>
    implements $SessionUserCredentialNumberCopyWith<$Res> {
  _$SessionUserCredentialNumberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionUserCredentialNumber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? phoneNumber = null,
  }) {
    return _then(_value.copyWith(
      bundleId: freezed == bundleId
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppType,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionUserCredentialNumberImplCopyWith<$Res>
    implements $SessionUserCredentialNumberCopyWith<$Res> {
  factory _$$SessionUserCredentialNumberImplCopyWith(
          _$SessionUserCredentialNumberImpl value,
          $Res Function(_$SessionUserCredentialNumberImpl) then) =
      __$$SessionUserCredentialNumberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? bundleId, AppType type, String identifier, String phoneNumber});
}

/// @nodoc
class __$$SessionUserCredentialNumberImplCopyWithImpl<$Res>
    extends _$SessionUserCredentialNumberCopyWithImpl<$Res,
        _$SessionUserCredentialNumberImpl>
    implements _$$SessionUserCredentialNumberImplCopyWith<$Res> {
  __$$SessionUserCredentialNumberImplCopyWithImpl(
      _$SessionUserCredentialNumberImpl _value,
      $Res Function(_$SessionUserCredentialNumberImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionUserCredentialNumber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? phoneNumber = null,
  }) {
    return _then(_$SessionUserCredentialNumberImpl(
      bundleId: freezed == bundleId
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppType,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SessionUserCredentialNumberImpl
    implements _SessionUserCredentialNumber {
  const _$SessionUserCredentialNumberImpl(
      {this.bundleId,
      required this.type,
      required this.identifier,
      required this.phoneNumber});

  factory _$SessionUserCredentialNumberImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SessionUserCredentialNumberImplFromJson(json);

  @override
  final String? bundleId;
  @override
  final AppType type;
  @override
  final String identifier;
  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'SessionUserCredentialNumber(bundleId: $bundleId, type: $type, identifier: $identifier, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionUserCredentialNumberImpl &&
            (identical(other.bundleId, bundleId) ||
                other.bundleId == bundleId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bundleId, type, identifier, phoneNumber);

  /// Create a copy of SessionUserCredentialNumber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionUserCredentialNumberImplCopyWith<_$SessionUserCredentialNumberImpl>
      get copyWith => __$$SessionUserCredentialNumberImplCopyWithImpl<
          _$SessionUserCredentialNumberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionUserCredentialNumberImplToJson(
      this,
    );
  }
}

abstract class _SessionUserCredentialNumber
    implements SessionUserCredentialNumber {
  const factory _SessionUserCredentialNumber(
      {final String? bundleId,
      required final AppType type,
      required final String identifier,
      required final String phoneNumber}) = _$SessionUserCredentialNumberImpl;

  factory _SessionUserCredentialNumber.fromJson(Map<String, dynamic> json) =
      _$SessionUserCredentialNumberImpl.fromJson;

  @override
  String? get bundleId;
  @override
  AppType get type;
  @override
  String get identifier;
  @override
  String get phoneNumber;

  /// Create a copy of SessionUserCredentialNumber
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionUserCredentialNumberImplCopyWith<_$SessionUserCredentialNumberImpl>
      get copyWith => throw _privateConstructorUsedError;
}
