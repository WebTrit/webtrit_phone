// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DemoData _$DemoDataFromJson(Map<String, dynamic> json) {
  return _UserActionData.fromJson(json);
}

/// @nodoc
mixin _$DemoData {
  String? get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get convertPbxUrl => throw _privateConstructorUsedError;
  String? get apiToken => throw _privateConstructorUsedError;
  String? get tokenExpires => throw _privateConstructorUsedError;
  String? get inviteFriendsUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DemoDataCopyWith<DemoData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoDataCopyWith<$Res> {
  factory $DemoDataCopyWith(DemoData value, $Res Function(DemoData) then) =
      _$DemoDataCopyWithImpl<$Res, DemoData>;
  @useResult
  $Res call(
      {String? status,
      String? message,
      String? tenantId,
      String? userId,
      String? convertPbxUrl,
      String? apiToken,
      String? tokenExpires,
      String? inviteFriendsUrl});
}

/// @nodoc
class _$DemoDataCopyWithImpl<$Res, $Val extends DemoData>
    implements $DemoDataCopyWith<$Res> {
  _$DemoDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? message = freezed,
    Object? tenantId = freezed,
    Object? userId = freezed,
    Object? convertPbxUrl = freezed,
    Object? apiToken = freezed,
    Object? tokenExpires = freezed,
    Object? inviteFriendsUrl = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      convertPbxUrl: freezed == convertPbxUrl
          ? _value.convertPbxUrl
          : convertPbxUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      apiToken: freezed == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenExpires: freezed == tokenExpires
          ? _value.tokenExpires
          : tokenExpires // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteFriendsUrl: freezed == inviteFriendsUrl
          ? _value.inviteFriendsUrl
          : inviteFriendsUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserActionDataImplCopyWith<$Res>
    implements $DemoDataCopyWith<$Res> {
  factory _$$UserActionDataImplCopyWith(_$UserActionDataImpl value,
          $Res Function(_$UserActionDataImpl) then) =
      __$$UserActionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? status,
      String? message,
      String? tenantId,
      String? userId,
      String? convertPbxUrl,
      String? apiToken,
      String? tokenExpires,
      String? inviteFriendsUrl});
}

/// @nodoc
class __$$UserActionDataImplCopyWithImpl<$Res>
    extends _$DemoDataCopyWithImpl<$Res, _$UserActionDataImpl>
    implements _$$UserActionDataImplCopyWith<$Res> {
  __$$UserActionDataImplCopyWithImpl(
      _$UserActionDataImpl _value, $Res Function(_$UserActionDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? message = freezed,
    Object? tenantId = freezed,
    Object? userId = freezed,
    Object? convertPbxUrl = freezed,
    Object? apiToken = freezed,
    Object? tokenExpires = freezed,
    Object? inviteFriendsUrl = freezed,
  }) {
    return _then(_$UserActionDataImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      convertPbxUrl: freezed == convertPbxUrl
          ? _value.convertPbxUrl
          : convertPbxUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      apiToken: freezed == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenExpires: freezed == tokenExpires
          ? _value.tokenExpires
          : tokenExpires // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteFriendsUrl: freezed == inviteFriendsUrl
          ? _value.inviteFriendsUrl
          : inviteFriendsUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$UserActionDataImpl implements _UserActionData {
  const _$UserActionDataImpl(
      {this.status,
      this.message,
      this.tenantId,
      this.userId,
      this.convertPbxUrl,
      this.apiToken,
      this.tokenExpires,
      this.inviteFriendsUrl});

  factory _$UserActionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserActionDataImplFromJson(json);

  @override
  final String? status;
  @override
  final String? message;
  @override
  final String? tenantId;
  @override
  final String? userId;
  @override
  final String? convertPbxUrl;
  @override
  final String? apiToken;
  @override
  final String? tokenExpires;
  @override
  final String? inviteFriendsUrl;

  @override
  String toString() {
    return 'DemoData(status: $status, message: $message, tenantId: $tenantId, userId: $userId, convertPbxUrl: $convertPbxUrl, apiToken: $apiToken, tokenExpires: $tokenExpires, inviteFriendsUrl: $inviteFriendsUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserActionDataImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.convertPbxUrl, convertPbxUrl) ||
                other.convertPbxUrl == convertPbxUrl) &&
            (identical(other.apiToken, apiToken) ||
                other.apiToken == apiToken) &&
            (identical(other.tokenExpires, tokenExpires) ||
                other.tokenExpires == tokenExpires) &&
            (identical(other.inviteFriendsUrl, inviteFriendsUrl) ||
                other.inviteFriendsUrl == inviteFriendsUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, tenantId,
      userId, convertPbxUrl, apiToken, tokenExpires, inviteFriendsUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserActionDataImplCopyWith<_$UserActionDataImpl> get copyWith =>
      __$$UserActionDataImplCopyWithImpl<_$UserActionDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserActionDataImplToJson(
      this,
    );
  }
}

abstract class _UserActionData implements DemoData {
  const factory _UserActionData(
      {final String? status,
      final String? message,
      final String? tenantId,
      final String? userId,
      final String? convertPbxUrl,
      final String? apiToken,
      final String? tokenExpires,
      final String? inviteFriendsUrl}) = _$UserActionDataImpl;

  factory _UserActionData.fromJson(Map<String, dynamic> json) =
      _$UserActionDataImpl.fromJson;

  @override
  String? get status;
  @override
  String? get message;
  @override
  String? get tenantId;
  @override
  String? get userId;
  @override
  String? get convertPbxUrl;
  @override
  String? get apiToken;
  @override
  String? get tokenExpires;
  @override
  String? get inviteFriendsUrl;
  @override
  @JsonKey(ignore: true)
  _$$UserActionDataImplCopyWith<_$UserActionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
