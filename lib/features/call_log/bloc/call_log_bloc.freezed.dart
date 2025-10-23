// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_log_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CallLogState {
  String get number => throw _privateConstructorUsedError;
  Contact? get contact => throw _privateConstructorUsedError;
  List<CallLogEntry>? get callLog => throw _privateConstructorUsedError;

  /// Create a copy of CallLogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallLogStateCopyWith<CallLogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallLogStateCopyWith<$Res> {
  factory $CallLogStateCopyWith(
          CallLogState value, $Res Function(CallLogState) then) =
      _$CallLogStateCopyWithImpl<$Res, CallLogState>;
  @useResult
  $Res call({String number, Contact? contact, List<CallLogEntry>? callLog});
}

/// @nodoc
class _$CallLogStateCopyWithImpl<$Res, $Val extends CallLogState>
    implements $CallLogStateCopyWith<$Res> {
  _$CallLogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallLogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? contact = freezed,
    Object? callLog = freezed,
  }) {
    return _then(_value.copyWith(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
      callLog: freezed == callLog
          ? _value.callLog
          : callLog // ignore: cast_nullable_to_non_nullable
              as List<CallLogEntry>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallLogStateImplCopyWith<$Res>
    implements $CallLogStateCopyWith<$Res> {
  factory _$$CallLogStateImplCopyWith(
          _$CallLogStateImpl value, $Res Function(_$CallLogStateImpl) then) =
      __$$CallLogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String number, Contact? contact, List<CallLogEntry>? callLog});
}

/// @nodoc
class __$$CallLogStateImplCopyWithImpl<$Res>
    extends _$CallLogStateCopyWithImpl<$Res, _$CallLogStateImpl>
    implements _$$CallLogStateImplCopyWith<$Res> {
  __$$CallLogStateImplCopyWithImpl(
      _$CallLogStateImpl _value, $Res Function(_$CallLogStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CallLogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? contact = freezed,
    Object? callLog = freezed,
  }) {
    return _then(_$CallLogStateImpl(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
      callLog: freezed == callLog
          ? _value._callLog
          : callLog // ignore: cast_nullable_to_non_nullable
              as List<CallLogEntry>?,
    ));
  }
}

/// @nodoc

class _$CallLogStateImpl implements _CallLogState {
  const _$CallLogStateImpl(
      {required this.number, this.contact, final List<CallLogEntry>? callLog})
      : _callLog = callLog;

  @override
  final String number;
  @override
  final Contact? contact;
  final List<CallLogEntry>? _callLog;
  @override
  List<CallLogEntry>? get callLog {
    final value = _callLog;
    if (value == null) return null;
    if (_callLog is EqualUnmodifiableListView) return _callLog;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallLogStateImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            const DeepCollectionEquality().equals(other._callLog, _callLog));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number, contact,
      const DeepCollectionEquality().hash(_callLog));

  /// Create a copy of CallLogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallLogStateImplCopyWith<_$CallLogStateImpl> get copyWith =>
      __$$CallLogStateImplCopyWithImpl<_$CallLogStateImpl>(this, _$identity);
}

abstract class _CallLogState implements CallLogState {
  const factory _CallLogState(
      {required final String number,
      final Contact? contact,
      final List<CallLogEntry>? callLog}) = _$CallLogStateImpl;

  @override
  String get number;
  @override
  Contact? get contact;
  @override
  List<CallLogEntry>? get callLog;

  /// Create a copy of CallLogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallLogStateImplCopyWith<_$CallLogStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
