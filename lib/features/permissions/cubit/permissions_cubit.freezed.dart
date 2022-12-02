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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PermissionsState {
  PermissionsStatus get status => throw _privateConstructorUsedError;

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
  $Res call({PermissionsStatus status});
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
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PermissionsStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PermissionsStateCopyWith<$Res>
    implements $PermissionsStateCopyWith<$Res> {
  factory _$$_PermissionsStateCopyWith(
          _$_PermissionsState value, $Res Function(_$_PermissionsState) then) =
      __$$_PermissionsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PermissionsStatus status});
}

/// @nodoc
class __$$_PermissionsStateCopyWithImpl<$Res>
    extends _$PermissionsStateCopyWithImpl<$Res, _$_PermissionsState>
    implements _$$_PermissionsStateCopyWith<$Res> {
  __$$_PermissionsStateCopyWithImpl(
      _$_PermissionsState _value, $Res Function(_$_PermissionsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$_PermissionsState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PermissionsStatus,
    ));
  }
}

/// @nodoc

class _$_PermissionsState implements _PermissionsState {
  const _$_PermissionsState({this.status = PermissionsStatus.initial});

  @override
  @JsonKey()
  final PermissionsStatus status;

  @override
  String toString() {
    return 'PermissionsState(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PermissionsState &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PermissionsStateCopyWith<_$_PermissionsState> get copyWith =>
      __$$_PermissionsStateCopyWithImpl<_$_PermissionsState>(this, _$identity);
}

abstract class _PermissionsState implements PermissionsState {
  const factory _PermissionsState({final PermissionsStatus status}) =
      _$_PermissionsState;

  @override
  PermissionsStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_PermissionsStateCopyWith<_$_PermissionsState> get copyWith =>
      throw _privateConstructorUsedError;
}
