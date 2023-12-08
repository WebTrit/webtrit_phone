// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_types_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginTypesState {
  List<SupportedLoginType> get supportedLogin =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginTypesStateCopyWith<LoginTypesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginTypesStateCopyWith<$Res> {
  factory $LoginTypesStateCopyWith(
          LoginTypesState value, $Res Function(LoginTypesState) then) =
      _$LoginTypesStateCopyWithImpl<$Res, LoginTypesState>;
  @useResult
  $Res call({List<SupportedLoginType> supportedLogin});
}

/// @nodoc
class _$LoginTypesStateCopyWithImpl<$Res, $Val extends LoginTypesState>
    implements $LoginTypesStateCopyWith<$Res> {
  _$LoginTypesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supportedLogin = null,
  }) {
    return _then(_value.copyWith(
      supportedLogin: null == supportedLogin
          ? _value.supportedLogin
          : supportedLogin // ignore: cast_nullable_to_non_nullable
              as List<SupportedLoginType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginTypesStateImplCopyWith<$Res>
    implements $LoginTypesStateCopyWith<$Res> {
  factory _$$LoginTypesStateImplCopyWith(_$LoginTypesStateImpl value,
          $Res Function(_$LoginTypesStateImpl) then) =
      __$$LoginTypesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SupportedLoginType> supportedLogin});
}

/// @nodoc
class __$$LoginTypesStateImplCopyWithImpl<$Res>
    extends _$LoginTypesStateCopyWithImpl<$Res, _$LoginTypesStateImpl>
    implements _$$LoginTypesStateImplCopyWith<$Res> {
  __$$LoginTypesStateImplCopyWithImpl(
      _$LoginTypesStateImpl _value, $Res Function(_$LoginTypesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supportedLogin = null,
  }) {
    return _then(_$LoginTypesStateImpl(
      supportedLogin: null == supportedLogin
          ? _value._supportedLogin
          : supportedLogin // ignore: cast_nullable_to_non_nullable
              as List<SupportedLoginType>,
    ));
  }
}

/// @nodoc

class _$LoginTypesStateImpl implements _LoginTypesState {
  const _$LoginTypesStateImpl(
      {final List<SupportedLoginType> supportedLogin = const []})
      : _supportedLogin = supportedLogin;

  final List<SupportedLoginType> _supportedLogin;
  @override
  @JsonKey()
  List<SupportedLoginType> get supportedLogin {
    if (_supportedLogin is EqualUnmodifiableListView) return _supportedLogin;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedLogin);
  }

  @override
  String toString() {
    return 'LoginTypesState(supportedLogin: $supportedLogin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginTypesStateImpl &&
            const DeepCollectionEquality()
                .equals(other._supportedLogin, _supportedLogin));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_supportedLogin));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginTypesStateImplCopyWith<_$LoginTypesStateImpl> get copyWith =>
      __$$LoginTypesStateImplCopyWithImpl<_$LoginTypesStateImpl>(
          this, _$identity);
}

abstract class _LoginTypesState implements LoginTypesState {
  const factory _LoginTypesState(
      {final List<SupportedLoginType> supportedLogin}) = _$LoginTypesStateImpl;

  @override
  List<SupportedLoginType> get supportedLogin;
  @override
  @JsonKey(ignore: true)
  _$$LoginTypesStateImplCopyWith<_$LoginTypesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
