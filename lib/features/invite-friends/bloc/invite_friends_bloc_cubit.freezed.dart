// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_friends_bloc_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InviteFriendsBlocState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? inviteUrl) display,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? inviteUrl)? display,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? inviteUrl)? display,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(DisplayInviteFriendsDialog value) display,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(DisplayInviteFriendsDialog value)? display,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(DisplayInviteFriendsDialog value)? display,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InviteFriendsBlocStateCopyWith<$Res> {
  factory $InviteFriendsBlocStateCopyWith(InviteFriendsBlocState value,
          $Res Function(InviteFriendsBlocState) then) =
      _$InviteFriendsBlocStateCopyWithImpl<$Res, InviteFriendsBlocState>;
}

/// @nodoc
class _$InviteFriendsBlocStateCopyWithImpl<$Res,
        $Val extends InviteFriendsBlocState>
    implements $InviteFriendsBlocStateCopyWith<$Res> {
  _$InviteFriendsBlocStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialCopyWith<$Res> {
  factory _$$InitialCopyWith(_$Initial value, $Res Function(_$Initial) then) =
      __$$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialCopyWithImpl<$Res>
    extends _$InviteFriendsBlocStateCopyWithImpl<$Res, _$Initial>
    implements _$$InitialCopyWith<$Res> {
  __$$InitialCopyWithImpl(_$Initial _value, $Res Function(_$Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Initial implements Initial {
  const _$Initial();

  @override
  String toString() {
    return 'InviteFriendsBlocState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? inviteUrl) display,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? inviteUrl)? display,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? inviteUrl)? display,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(DisplayInviteFriendsDialog value) display,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(DisplayInviteFriendsDialog value)? display,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(DisplayInviteFriendsDialog value)? display,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements InviteFriendsBlocState {
  const factory Initial() = _$Initial;
}

/// @nodoc
abstract class _$$DisplayInviteFriendsDialogCopyWith<$Res> {
  factory _$$DisplayInviteFriendsDialogCopyWith(
          _$DisplayInviteFriendsDialog value,
          $Res Function(_$DisplayInviteFriendsDialog) then) =
      __$$DisplayInviteFriendsDialogCopyWithImpl<$Res>;
  @useResult
  $Res call({String? inviteUrl});
}

/// @nodoc
class __$$DisplayInviteFriendsDialogCopyWithImpl<$Res>
    extends _$InviteFriendsBlocStateCopyWithImpl<$Res,
        _$DisplayInviteFriendsDialog>
    implements _$$DisplayInviteFriendsDialogCopyWith<$Res> {
  __$$DisplayInviteFriendsDialogCopyWithImpl(
      _$DisplayInviteFriendsDialog _value,
      $Res Function(_$DisplayInviteFriendsDialog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteUrl = freezed,
  }) {
    return _then(_$DisplayInviteFriendsDialog(
      inviteUrl: freezed == inviteUrl
          ? _value.inviteUrl
          : inviteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DisplayInviteFriendsDialog implements DisplayInviteFriendsDialog {
  const _$DisplayInviteFriendsDialog({this.inviteUrl});

  @override
  final String? inviteUrl;

  @override
  String toString() {
    return 'InviteFriendsBlocState.display(inviteUrl: $inviteUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisplayInviteFriendsDialog &&
            (identical(other.inviteUrl, inviteUrl) ||
                other.inviteUrl == inviteUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, inviteUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DisplayInviteFriendsDialogCopyWith<_$DisplayInviteFriendsDialog>
      get copyWith => __$$DisplayInviteFriendsDialogCopyWithImpl<
          _$DisplayInviteFriendsDialog>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? inviteUrl) display,
  }) {
    return display(inviteUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? inviteUrl)? display,
  }) {
    return display?.call(inviteUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? inviteUrl)? display,
    required TResult orElse(),
  }) {
    if (display != null) {
      return display(inviteUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(DisplayInviteFriendsDialog value) display,
  }) {
    return display(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(DisplayInviteFriendsDialog value)? display,
  }) {
    return display?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(DisplayInviteFriendsDialog value)? display,
    required TResult orElse(),
  }) {
    if (display != null) {
      return display(this);
    }
    return orElse();
  }
}

abstract class DisplayInviteFriendsDialog implements InviteFriendsBlocState {
  const factory DisplayInviteFriendsDialog({final String? inviteUrl}) =
      _$DisplayInviteFriendsDialog;

  String? get inviteUrl;
  @JsonKey(ignore: true)
  _$$DisplayInviteFriendsDialogCopyWith<_$DisplayInviteFriendsDialog>
      get copyWith => throw _privateConstructorUsedError;
}
