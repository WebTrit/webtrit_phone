// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_request_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OtpRequestState {
  OtpRequestStatus? get status => throw _privateConstructorUsedError;
  bool get demo => throw _privateConstructorUsedError;
  EmailInput get emailInput => throw _privateConstructorUsedError;
  PhoneInput get phoneInput => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OtpRequestStateCopyWith<OtpRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpRequestStateCopyWith<$Res> {
  factory $OtpRequestStateCopyWith(
          OtpRequestState value, $Res Function(OtpRequestState) then) =
      _$OtpRequestStateCopyWithImpl<$Res, OtpRequestState>;
  @useResult
  $Res call(
      {OtpRequestStatus? status,
      bool demo,
      EmailInput emailInput,
      PhoneInput phoneInput});
}

/// @nodoc
class _$OtpRequestStateCopyWithImpl<$Res, $Val extends OtpRequestState>
    implements $OtpRequestStateCopyWith<$Res> {
  _$OtpRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? demo = null,
    Object? emailInput = null,
    Object? phoneInput = null,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OtpRequestStatus?,
      demo: null == demo
          ? _value.demo
          : demo // ignore: cast_nullable_to_non_nullable
              as bool,
      emailInput: null == emailInput
          ? _value.emailInput
          : emailInput // ignore: cast_nullable_to_non_nullable
              as EmailInput,
      phoneInput: null == phoneInput
          ? _value.phoneInput
          : phoneInput // ignore: cast_nullable_to_non_nullable
              as PhoneInput,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OtpRequestStateCopyWith<$Res>
    implements $OtpRequestStateCopyWith<$Res> {
  factory _$$_OtpRequestStateCopyWith(
          _$_OtpRequestState value, $Res Function(_$_OtpRequestState) then) =
      __$$_OtpRequestStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OtpRequestStatus? status,
      bool demo,
      EmailInput emailInput,
      PhoneInput phoneInput});
}

/// @nodoc
class __$$_OtpRequestStateCopyWithImpl<$Res>
    extends _$OtpRequestStateCopyWithImpl<$Res, _$_OtpRequestState>
    implements _$$_OtpRequestStateCopyWith<$Res> {
  __$$_OtpRequestStateCopyWithImpl(
      _$_OtpRequestState _value, $Res Function(_$_OtpRequestState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? demo = null,
    Object? emailInput = null,
    Object? phoneInput = null,
  }) {
    return _then(_$_OtpRequestState(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OtpRequestStatus?,
      demo: null == demo
          ? _value.demo
          : demo // ignore: cast_nullable_to_non_nullable
              as bool,
      emailInput: null == emailInput
          ? _value.emailInput
          : emailInput // ignore: cast_nullable_to_non_nullable
              as EmailInput,
      phoneInput: null == phoneInput
          ? _value.phoneInput
          : phoneInput // ignore: cast_nullable_to_non_nullable
              as PhoneInput,
    ));
  }
}

/// @nodoc

class _$_OtpRequestState extends _OtpRequestState {
  const _$_OtpRequestState(
      {this.status,
      required this.demo,
      this.emailInput = const EmailInput.pure(),
      this.phoneInput = const PhoneInput.pure()})
      : super._();

  @override
  final OtpRequestStatus? status;
  @override
  final bool demo;
  @override
  @JsonKey()
  final EmailInput emailInput;
  @override
  @JsonKey()
  final PhoneInput phoneInput;

  @override
  String toString() {
    return 'OtpRequestState(status: $status, demo: $demo, emailInput: $emailInput, phoneInput: $phoneInput)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OtpRequestState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.demo, demo) || other.demo == demo) &&
            (identical(other.emailInput, emailInput) ||
                other.emailInput == emailInput) &&
            (identical(other.phoneInput, phoneInput) ||
                other.phoneInput == phoneInput));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, demo, emailInput, phoneInput);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OtpRequestStateCopyWith<_$_OtpRequestState> get copyWith =>
      __$$_OtpRequestStateCopyWithImpl<_$_OtpRequestState>(this, _$identity);
}

abstract class _OtpRequestState extends OtpRequestState {
  const factory _OtpRequestState(
      {final OtpRequestStatus? status,
      required final bool demo,
      final EmailInput emailInput,
      final PhoneInput phoneInput}) = _$_OtpRequestState;
  const _OtpRequestState._() : super._();

  @override
  OtpRequestStatus? get status;
  @override
  bool get demo;
  @override
  EmailInput get emailInput;
  @override
  PhoneInput get phoneInput;
  @override
  @JsonKey(ignore: true)
  _$$_OtpRequestStateCopyWith<_$_OtpRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}
