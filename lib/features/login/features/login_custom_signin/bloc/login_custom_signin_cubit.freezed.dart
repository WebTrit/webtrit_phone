// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_custom_signin_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginCustomSigninState {
  SessionToken? get sessionToken => throw _privateConstructorUsedError;

  /// Create a copy of LoginCustomSigninState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginCustomSigninStateCopyWith<LoginCustomSigninState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginCustomSigninStateCopyWith<$Res> {
  factory $LoginCustomSigninStateCopyWith(LoginCustomSigninState value,
          $Res Function(LoginCustomSigninState) then) =
      _$LoginCustomSigninStateCopyWithImpl<$Res, LoginCustomSigninState>;
  @useResult
  $Res call({SessionToken? sessionToken});
}

/// @nodoc
class _$LoginCustomSigninStateCopyWithImpl<$Res,
        $Val extends LoginCustomSigninState>
    implements $LoginCustomSigninStateCopyWith<$Res> {
  _$LoginCustomSigninStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginCustomSigninState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionToken = freezed,
  }) {
    return _then(_value.copyWith(
      sessionToken: freezed == sessionToken
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as SessionToken?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginCustomSigninStateImplCopyWith<$Res>
    implements $LoginCustomSigninStateCopyWith<$Res> {
  factory _$$LoginCustomSigninStateImplCopyWith(
          _$LoginCustomSigninStateImpl value,
          $Res Function(_$LoginCustomSigninStateImpl) then) =
      __$$LoginCustomSigninStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SessionToken? sessionToken});
}

/// @nodoc
class __$$LoginCustomSigninStateImplCopyWithImpl<$Res>
    extends _$LoginCustomSigninStateCopyWithImpl<$Res,
        _$LoginCustomSigninStateImpl>
    implements _$$LoginCustomSigninStateImplCopyWith<$Res> {
  __$$LoginCustomSigninStateImplCopyWithImpl(
      _$LoginCustomSigninStateImpl _value,
      $Res Function(_$LoginCustomSigninStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginCustomSigninState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionToken = freezed,
  }) {
    return _then(_$LoginCustomSigninStateImpl(
      sessionToken: freezed == sessionToken
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as SessionToken?,
    ));
  }
}

/// @nodoc

class _$LoginCustomSigninStateImpl implements _LoginCustomSigninState {
  const _$LoginCustomSigninStateImpl({this.sessionToken});

  @override
  final SessionToken? sessionToken;

  @override
  String toString() {
    return 'LoginCustomSigninState(sessionToken: $sessionToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginCustomSigninStateImpl &&
            (identical(other.sessionToken, sessionToken) ||
                other.sessionToken == sessionToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionToken);

  /// Create a copy of LoginCustomSigninState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginCustomSigninStateImplCopyWith<_$LoginCustomSigninStateImpl>
      get copyWith => __$$LoginCustomSigninStateImplCopyWithImpl<
          _$LoginCustomSigninStateImpl>(this, _$identity);
}

abstract class _LoginCustomSigninState implements LoginCustomSigninState {
  const factory _LoginCustomSigninState({final SessionToken? sessionToken}) =
      _$LoginCustomSigninStateImpl;

  @override
  SessionToken? get sessionToken;

  /// Create a copy of LoginCustomSigninState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginCustomSigninStateImplCopyWith<_$LoginCustomSigninStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
