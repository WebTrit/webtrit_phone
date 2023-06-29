// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_invite_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserInviteData _$UserInviteDataFromJson(Map<String, dynamic> json) {
  return _UserInviteData.fromJson(json);
}

/// @nodoc
mixin _$UserInviteData {
  String get inviteFriendsUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInviteDataCopyWith<UserInviteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInviteDataCopyWith<$Res> {
  factory $UserInviteDataCopyWith(
          UserInviteData value, $Res Function(UserInviteData) then) =
      _$UserInviteDataCopyWithImpl<$Res, UserInviteData>;
  @useResult
  $Res call({String inviteFriendsUrl});
}

/// @nodoc
class _$UserInviteDataCopyWithImpl<$Res, $Val extends UserInviteData>
    implements $UserInviteDataCopyWith<$Res> {
  _$UserInviteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteFriendsUrl = null,
  }) {
    return _then(_value.copyWith(
      inviteFriendsUrl: null == inviteFriendsUrl
          ? _value.inviteFriendsUrl
          : inviteFriendsUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserInviteDataCopyWith<$Res>
    implements $UserInviteDataCopyWith<$Res> {
  factory _$$_UserInviteDataCopyWith(
          _$_UserInviteData value, $Res Function(_$_UserInviteData) then) =
      __$$_UserInviteDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String inviteFriendsUrl});
}

/// @nodoc
class __$$_UserInviteDataCopyWithImpl<$Res>
    extends _$UserInviteDataCopyWithImpl<$Res, _$_UserInviteData>
    implements _$$_UserInviteDataCopyWith<$Res> {
  __$$_UserInviteDataCopyWithImpl(
      _$_UserInviteData _value, $Res Function(_$_UserInviteData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteFriendsUrl = null,
  }) {
    return _then(_$_UserInviteData(
      inviteFriendsUrl: null == inviteFriendsUrl
          ? _value.inviteFriendsUrl
          : inviteFriendsUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_UserInviteData implements _UserInviteData {
  const _$_UserInviteData({required this.inviteFriendsUrl});

  factory _$_UserInviteData.fromJson(Map<String, dynamic> json) =>
      _$$_UserInviteDataFromJson(json);

  @override
  final String inviteFriendsUrl;

  @override
  String toString() {
    return 'UserInviteData(inviteFriendsUrl: $inviteFriendsUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserInviteData &&
            (identical(other.inviteFriendsUrl, inviteFriendsUrl) ||
                other.inviteFriendsUrl == inviteFriendsUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, inviteFriendsUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserInviteDataCopyWith<_$_UserInviteData> get copyWith =>
      __$$_UserInviteDataCopyWithImpl<_$_UserInviteData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserInviteDataToJson(
      this,
    );
  }
}

abstract class _UserInviteData implements UserInviteData {
  const factory _UserInviteData({required final String inviteFriendsUrl}) =
      _$_UserInviteData;

  factory _UserInviteData.fromJson(Map<String, dynamic> json) =
      _$_UserInviteData.fromJson;

  @override
  String get inviteFriendsUrl;
  @override
  @JsonKey(ignore: true)
  _$$_UserInviteDataCopyWith<_$_UserInviteData> get copyWith =>
      throw _privateConstructorUsedError;
}
