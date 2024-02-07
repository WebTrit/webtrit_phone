// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_core_url_assign_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginCoreUrlAssignState {
  LoginCoreStatus? get status => throw _privateConstructorUsedError;
  String get defaultTenantId => throw _privateConstructorUsedError;
  UrlInput get coreUrlInput => throw _privateConstructorUsedError;
  List<SupportedLoginType> get supportedLogin =>
      throw _privateConstructorUsedError;
  Exception? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginCoreUrlAssignStateCopyWith<LoginCoreUrlAssignState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginCoreUrlAssignStateCopyWith<$Res> {
  factory $LoginCoreUrlAssignStateCopyWith(LoginCoreUrlAssignState value,
          $Res Function(LoginCoreUrlAssignState) then) =
      _$LoginCoreUrlAssignStateCopyWithImpl<$Res, LoginCoreUrlAssignState>;
  @useResult
  $Res call(
      {LoginCoreStatus? status,
      String defaultTenantId,
      UrlInput coreUrlInput,
      List<SupportedLoginType> supportedLogin,
      Exception? error});
}

/// @nodoc
class _$LoginCoreUrlAssignStateCopyWithImpl<$Res,
        $Val extends LoginCoreUrlAssignState>
    implements $LoginCoreUrlAssignStateCopyWith<$Res> {
  _$LoginCoreUrlAssignStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? defaultTenantId = null,
    Object? coreUrlInput = null,
    Object? supportedLogin = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoginCoreStatus?,
      defaultTenantId: null == defaultTenantId
          ? _value.defaultTenantId
          : defaultTenantId // ignore: cast_nullable_to_non_nullable
              as String,
      coreUrlInput: null == coreUrlInput
          ? _value.coreUrlInput
          : coreUrlInput // ignore: cast_nullable_to_non_nullable
              as UrlInput,
      supportedLogin: null == supportedLogin
          ? _value.supportedLogin
          : supportedLogin // ignore: cast_nullable_to_non_nullable
              as List<SupportedLoginType>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginCoreUrlAssignStateImplCopyWith<$Res>
    implements $LoginCoreUrlAssignStateCopyWith<$Res> {
  factory _$$LoginCoreUrlAssignStateImplCopyWith(
          _$LoginCoreUrlAssignStateImpl value,
          $Res Function(_$LoginCoreUrlAssignStateImpl) then) =
      __$$LoginCoreUrlAssignStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoginCoreStatus? status,
      String defaultTenantId,
      UrlInput coreUrlInput,
      List<SupportedLoginType> supportedLogin,
      Exception? error});
}

/// @nodoc
class __$$LoginCoreUrlAssignStateImplCopyWithImpl<$Res>
    extends _$LoginCoreUrlAssignStateCopyWithImpl<$Res,
        _$LoginCoreUrlAssignStateImpl>
    implements _$$LoginCoreUrlAssignStateImplCopyWith<$Res> {
  __$$LoginCoreUrlAssignStateImplCopyWithImpl(
      _$LoginCoreUrlAssignStateImpl _value,
      $Res Function(_$LoginCoreUrlAssignStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? defaultTenantId = null,
    Object? coreUrlInput = null,
    Object? supportedLogin = null,
    Object? error = freezed,
  }) {
    return _then(_$LoginCoreUrlAssignStateImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoginCoreStatus?,
      defaultTenantId: null == defaultTenantId
          ? _value.defaultTenantId
          : defaultTenantId // ignore: cast_nullable_to_non_nullable
              as String,
      coreUrlInput: null == coreUrlInput
          ? _value.coreUrlInput
          : coreUrlInput // ignore: cast_nullable_to_non_nullable
              as UrlInput,
      supportedLogin: null == supportedLogin
          ? _value._supportedLogin
          : supportedLogin // ignore: cast_nullable_to_non_nullable
              as List<SupportedLoginType>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc

class _$LoginCoreUrlAssignStateImpl extends _LoginCoreUrlAssignState {
  const _$LoginCoreUrlAssignStateImpl(
      {this.status,
      required this.defaultTenantId,
      this.coreUrlInput = const UrlInput.pure(),
      final List<SupportedLoginType> supportedLogin = const [],
      this.error})
      : _supportedLogin = supportedLogin,
        super._();

  @override
  final LoginCoreStatus? status;
  @override
  final String defaultTenantId;
  @override
  @JsonKey()
  final UrlInput coreUrlInput;
  final List<SupportedLoginType> _supportedLogin;
  @override
  @JsonKey()
  List<SupportedLoginType> get supportedLogin {
    if (_supportedLogin is EqualUnmodifiableListView) return _supportedLogin;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedLogin);
  }

  @override
  final Exception? error;

  @override
  String toString() {
    return 'LoginCoreUrlAssignState(status: $status, defaultTenantId: $defaultTenantId, coreUrlInput: $coreUrlInput, supportedLogin: $supportedLogin, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginCoreUrlAssignStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.defaultTenantId, defaultTenantId) ||
                other.defaultTenantId == defaultTenantId) &&
            (identical(other.coreUrlInput, coreUrlInput) ||
                other.coreUrlInput == coreUrlInput) &&
            const DeepCollectionEquality()
                .equals(other._supportedLogin, _supportedLogin) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      defaultTenantId,
      coreUrlInput,
      const DeepCollectionEquality().hash(_supportedLogin),
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginCoreUrlAssignStateImplCopyWith<_$LoginCoreUrlAssignStateImpl>
      get copyWith => __$$LoginCoreUrlAssignStateImplCopyWithImpl<
          _$LoginCoreUrlAssignStateImpl>(this, _$identity);
}

abstract class _LoginCoreUrlAssignState extends LoginCoreUrlAssignState {
  const factory _LoginCoreUrlAssignState(
      {final LoginCoreStatus? status,
      required final String defaultTenantId,
      final UrlInput coreUrlInput,
      final List<SupportedLoginType> supportedLogin,
      final Exception? error}) = _$LoginCoreUrlAssignStateImpl;
  const _LoginCoreUrlAssignState._() : super._();

  @override
  LoginCoreStatus? get status;
  @override
  String get defaultTenantId;
  @override
  UrlInput get coreUrlInput;
  @override
  List<SupportedLoginType> get supportedLogin;
  @override
  Exception? get error;
  @override
  @JsonKey(ignore: true)
  _$$LoginCoreUrlAssignStateImplCopyWith<_$LoginCoreUrlAssignStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
