// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CallLogEntryDeleted {
  CallLogEntry get callLogEntry => throw _privateConstructorUsedError;
}

/// @nodoc

class _$CallLogEntryDeletedImpl implements _CallLogEntryDeleted {
  const _$CallLogEntryDeletedImpl(this.callLogEntry);

  @override
  final CallLogEntry callLogEntry;

  @override
  String toString() {
    return 'CallLogEntryDeleted(callLogEntry: $callLogEntry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallLogEntryDeletedImpl &&
            (identical(other.callLogEntry, callLogEntry) ||
                other.callLogEntry == callLogEntry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callLogEntry);
}

abstract class _CallLogEntryDeleted implements CallLogEntryDeleted {
  const factory _CallLogEntryDeleted(final CallLogEntry callLogEntry) =
      _$CallLogEntryDeletedImpl;

  @override
  CallLogEntry get callLogEntry;
}

/// @nodoc
mixin _$RecentState {
  Recent? get recent => throw _privateConstructorUsedError;
  List<CallLogEntry>? get callLog => throw _privateConstructorUsedError;

  /// Create a copy of RecentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecentStateCopyWith<RecentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentStateCopyWith<$Res> {
  factory $RecentStateCopyWith(
          RecentState value, $Res Function(RecentState) then) =
      _$RecentStateCopyWithImpl<$Res, RecentState>;
  @useResult
  $Res call({Recent? recent, List<CallLogEntry>? callLog});
}

/// @nodoc
class _$RecentStateCopyWithImpl<$Res, $Val extends RecentState>
    implements $RecentStateCopyWith<$Res> {
  _$RecentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recent = freezed,
    Object? callLog = freezed,
  }) {
    return _then(_value.copyWith(
      recent: freezed == recent
          ? _value.recent
          : recent // ignore: cast_nullable_to_non_nullable
              as Recent?,
      callLog: freezed == callLog
          ? _value.callLog
          : callLog // ignore: cast_nullable_to_non_nullable
              as List<CallLogEntry>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecentStateImplCopyWith<$Res>
    implements $RecentStateCopyWith<$Res> {
  factory _$$RecentStateImplCopyWith(
          _$RecentStateImpl value, $Res Function(_$RecentStateImpl) then) =
      __$$RecentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Recent? recent, List<CallLogEntry>? callLog});
}

/// @nodoc
class __$$RecentStateImplCopyWithImpl<$Res>
    extends _$RecentStateCopyWithImpl<$Res, _$RecentStateImpl>
    implements _$$RecentStateImplCopyWith<$Res> {
  __$$RecentStateImplCopyWithImpl(
      _$RecentStateImpl _value, $Res Function(_$RecentStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recent = freezed,
    Object? callLog = freezed,
  }) {
    return _then(_$RecentStateImpl(
      recent: freezed == recent
          ? _value.recent
          : recent // ignore: cast_nullable_to_non_nullable
              as Recent?,
      callLog: freezed == callLog
          ? _value._callLog
          : callLog // ignore: cast_nullable_to_non_nullable
              as List<CallLogEntry>?,
    ));
  }
}

/// @nodoc

class _$RecentStateImpl implements _RecentState {
  const _$RecentStateImpl({this.recent, final List<CallLogEntry>? callLog})
      : _callLog = callLog;

  @override
  final Recent? recent;
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
  String toString() {
    return 'RecentState(recent: $recent, callLog: $callLog)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentStateImpl &&
            (identical(other.recent, recent) || other.recent == recent) &&
            const DeepCollectionEquality().equals(other._callLog, _callLog));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, recent, const DeepCollectionEquality().hash(_callLog));

  /// Create a copy of RecentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentStateImplCopyWith<_$RecentStateImpl> get copyWith =>
      __$$RecentStateImplCopyWithImpl<_$RecentStateImpl>(this, _$identity);
}

abstract class _RecentState implements RecentState {
  const factory _RecentState(
      {final Recent? recent,
      final List<CallLogEntry>? callLog}) = _$RecentStateImpl;

  @override
  Recent? get recent;
  @override
  List<CallLogEntry>? get callLog;

  /// Create a copy of RecentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecentStateImplCopyWith<_$RecentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
