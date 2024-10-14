// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keypad_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KeypadState {
  Contact? get contact => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KeypadStateCopyWith<KeypadState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeypadStateCopyWith<$Res> {
  factory $KeypadStateCopyWith(
          KeypadState value, $Res Function(KeypadState) then) =
      _$KeypadStateCopyWithImpl<$Res, KeypadState>;
  @useResult
  $Res call({Contact? contact});
}

/// @nodoc
class _$KeypadStateCopyWithImpl<$Res, $Val extends KeypadState>
    implements $KeypadStateCopyWith<$Res> {
  _$KeypadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = freezed,
  }) {
    return _then(_value.copyWith(
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KeypadStateImplCopyWith<$Res>
    implements $KeypadStateCopyWith<$Res> {
  factory _$$KeypadStateImplCopyWith(
          _$KeypadStateImpl value, $Res Function(_$KeypadStateImpl) then) =
      __$$KeypadStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Contact? contact});
}

/// @nodoc
class __$$KeypadStateImplCopyWithImpl<$Res>
    extends _$KeypadStateCopyWithImpl<$Res, _$KeypadStateImpl>
    implements _$$KeypadStateImplCopyWith<$Res> {
  __$$KeypadStateImplCopyWithImpl(
      _$KeypadStateImpl _value, $Res Function(_$KeypadStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = freezed,
  }) {
    return _then(_$KeypadStateImpl(
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
    ));
  }
}

/// @nodoc

class _$KeypadStateImpl implements _KeypadState {
  const _$KeypadStateImpl({this.contact});

  @override
  final Contact? contact;

  @override
  String toString() {
    return 'KeypadState(contact: $contact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeypadStateImpl &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KeypadStateImplCopyWith<_$KeypadStateImpl> get copyWith =>
      __$$KeypadStateImplCopyWithImpl<_$KeypadStateImpl>(this, _$identity);
}

abstract class _KeypadState implements KeypadState {
  const factory _KeypadState({final Contact? contact}) = _$KeypadStateImpl;

  @override
  Contact? get contact;
  @override
  @JsonKey(ignore: true)
  _$$KeypadStateImplCopyWith<_$KeypadStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
