// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_action_bloc_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserActionBlocState {
  UiAction? get uiAction => throw _privateConstructorUsedError;
  String? get inviteUrl => throw _privateConstructorUsedError;
  String? get convertPbxUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserActionBlocStateCopyWith<UserActionBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserActionBlocStateCopyWith<$Res> {
  factory $UserActionBlocStateCopyWith(
          UserActionBlocState value, $Res Function(UserActionBlocState) then) =
      _$UserActionBlocStateCopyWithImpl<$Res, UserActionBlocState>;
  @useResult
  $Res call({UiAction? uiAction, String? inviteUrl, String? convertPbxUrl});
}

/// @nodoc
class _$UserActionBlocStateCopyWithImpl<$Res, $Val extends UserActionBlocState>
    implements $UserActionBlocStateCopyWith<$Res> {
  _$UserActionBlocStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uiAction = freezed,
    Object? inviteUrl = freezed,
    Object? convertPbxUrl = freezed,
  }) {
    return _then(_value.copyWith(
      uiAction: freezed == uiAction
          ? _value.uiAction
          : uiAction // ignore: cast_nullable_to_non_nullable
              as UiAction?,
      inviteUrl: freezed == inviteUrl
          ? _value.inviteUrl
          : inviteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      convertPbxUrl: freezed == convertPbxUrl
          ? _value.convertPbxUrl
          : convertPbxUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserActionBlocStateCopyWith<$Res>
    implements $UserActionBlocStateCopyWith<$Res> {
  factory _$$_UserActionBlocStateCopyWith(_$_UserActionBlocState value,
          $Res Function(_$_UserActionBlocState) then) =
      __$$_UserActionBlocStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UiAction? uiAction, String? inviteUrl, String? convertPbxUrl});
}

/// @nodoc
class __$$_UserActionBlocStateCopyWithImpl<$Res>
    extends _$UserActionBlocStateCopyWithImpl<$Res, _$_UserActionBlocState>
    implements _$$_UserActionBlocStateCopyWith<$Res> {
  __$$_UserActionBlocStateCopyWithImpl(_$_UserActionBlocState _value,
      $Res Function(_$_UserActionBlocState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uiAction = freezed,
    Object? inviteUrl = freezed,
    Object? convertPbxUrl = freezed,
  }) {
    return _then(_$_UserActionBlocState(
      uiAction: freezed == uiAction
          ? _value.uiAction
          : uiAction // ignore: cast_nullable_to_non_nullable
              as UiAction?,
      inviteUrl: freezed == inviteUrl
          ? _value.inviteUrl
          : inviteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      convertPbxUrl: freezed == convertPbxUrl
          ? _value.convertPbxUrl
          : convertPbxUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_UserActionBlocState implements _UserActionBlocState {
  const _$_UserActionBlocState(
      {this.uiAction, this.inviteUrl, this.convertPbxUrl});

  @override
  final UiAction? uiAction;
  @override
  final String? inviteUrl;
  @override
  final String? convertPbxUrl;

  @override
  String toString() {
    return 'UserActionBlocState(uiAction: $uiAction, inviteUrl: $inviteUrl, convertPbxUrl: $convertPbxUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserActionBlocState &&
            (identical(other.uiAction, uiAction) ||
                other.uiAction == uiAction) &&
            (identical(other.inviteUrl, inviteUrl) ||
                other.inviteUrl == inviteUrl) &&
            (identical(other.convertPbxUrl, convertPbxUrl) ||
                other.convertPbxUrl == convertPbxUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uiAction, inviteUrl, convertPbxUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserActionBlocStateCopyWith<_$_UserActionBlocState> get copyWith =>
      __$$_UserActionBlocStateCopyWithImpl<_$_UserActionBlocState>(
          this, _$identity);
}

abstract class _UserActionBlocState implements UserActionBlocState {
  const factory _UserActionBlocState(
      {final UiAction? uiAction,
      final String? inviteUrl,
      final String? convertPbxUrl}) = _$_UserActionBlocState;

  @override
  UiAction? get uiAction;
  @override
  String? get inviteUrl;
  @override
  String? get convertPbxUrl;
  @override
  @JsonKey(ignore: true)
  _$$_UserActionBlocStateCopyWith<_$_UserActionBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}
