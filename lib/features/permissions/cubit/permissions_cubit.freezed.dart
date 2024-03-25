// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permissions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PermissionsState {
  PermissionsStatus get status => throw _privateConstructorUsedError;
  bool get userAgreementAccepted => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PermissionsStateCopyWith<PermissionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionsStateCopyWith<$Res> {
  factory $PermissionsStateCopyWith(
          PermissionsState value, $Res Function(PermissionsState) then) =
      _$PermissionsStateCopyWithImpl<$Res, PermissionsState>;
  @useResult
  $Res call(
      {PermissionsStatus status, bool userAgreementAccepted, Object? error});
}

/// @nodoc
class _$PermissionsStateCopyWithImpl<$Res, $Val extends PermissionsState>
    implements $PermissionsStateCopyWith<$Res> {
  _$PermissionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? userAgreementAccepted = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PermissionsStatus,
      userAgreementAccepted: null == userAgreementAccepted
          ? _value.userAgreementAccepted
          : userAgreementAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PermissionsStateImplCopyWith<$Res>
    implements $PermissionsStateCopyWith<$Res> {
  factory _$$PermissionsStateImplCopyWith(_$PermissionsStateImpl value,
          $Res Function(_$PermissionsStateImpl) then) =
      __$$PermissionsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PermissionsStatus status, bool userAgreementAccepted, Object? error});
}

/// @nodoc
class __$$PermissionsStateImplCopyWithImpl<$Res>
    extends _$PermissionsStateCopyWithImpl<$Res, _$PermissionsStateImpl>
    implements _$$PermissionsStateImplCopyWith<$Res> {
  __$$PermissionsStateImplCopyWithImpl(_$PermissionsStateImpl _value,
      $Res Function(_$PermissionsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? userAgreementAccepted = null,
    Object? error = freezed,
  }) {
    return _then(_$PermissionsStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PermissionsStatus,
      userAgreementAccepted: null == userAgreementAccepted
          ? _value.userAgreementAccepted
          : userAgreementAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$PermissionsStateImpl implements _PermissionsState {
  const _$PermissionsStateImpl(
      {this.status = PermissionsStatus.initial,
      this.userAgreementAccepted = false,
      this.error});

  @override
  @JsonKey()
  final PermissionsStatus status;
  @override
  @JsonKey()
  final bool userAgreementAccepted;
  @override
  final Object? error;

  @override
  String toString() {
    return 'PermissionsState(status: $status, userAgreementAccepted: $userAgreementAccepted, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.userAgreementAccepted, userAgreementAccepted) ||
                other.userAgreementAccepted == userAgreementAccepted) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, userAgreementAccepted,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionsStateImplCopyWith<_$PermissionsStateImpl> get copyWith =>
      __$$PermissionsStateImplCopyWithImpl<_$PermissionsStateImpl>(
          this, _$identity);
}

abstract class _PermissionsState implements PermissionsState {
  const factory _PermissionsState(
      {final PermissionsStatus status,
      final bool userAgreementAccepted,
      final Object? error}) = _$PermissionsStateImpl;

  @override
  PermissionsStatus get status;
  @override
  bool get userAgreementAccepted;
  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$PermissionsStateImplCopyWith<_$PermissionsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
