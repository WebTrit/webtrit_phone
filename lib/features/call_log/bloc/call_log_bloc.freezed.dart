// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_log_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallLogEntryDeleted {
  CallLogEntry get callLogEntry;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallLogEntryDeleted &&
            (identical(other.callLogEntry, callLogEntry) ||
                other.callLogEntry == callLogEntry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callLogEntry);

  @override
  String toString() {
    return 'CallLogEntryDeleted(callLogEntry: $callLogEntry)';
  }
}

/// Adds pattern-matching-related methods to [CallLogEntryDeleted].
extension CallLogEntryDeletedPatterns on CallLogEntryDeleted {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CallLogEntryDeleted value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallLogEntryDeleted() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CallLogEntryDeleted value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallLogEntryDeleted():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CallLogEntryDeleted value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallLogEntryDeleted() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(CallLogEntry callLogEntry)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallLogEntryDeleted() when $default != null:
        return $default(_that.callLogEntry);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(CallLogEntry callLogEntry) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallLogEntryDeleted():
        return $default(_that.callLogEntry);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(CallLogEntry callLogEntry)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallLogEntryDeleted() when $default != null:
        return $default(_that.callLogEntry);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallLogEntryDeleted implements CallLogEntryDeleted {
  const _CallLogEntryDeleted(this.callLogEntry);

  @override
  final CallLogEntry callLogEntry;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallLogEntryDeleted &&
            (identical(other.callLogEntry, callLogEntry) ||
                other.callLogEntry == callLogEntry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callLogEntry);

  @override
  String toString() {
    return 'CallLogEntryDeleted(callLogEntry: $callLogEntry)';
  }
}

/// @nodoc
mixin _$CallLogState {
  String get number;
  Contact? get contact;
  List<CallLogEntry>? get callLog;

  /// Create a copy of CallLogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CallLogStateCopyWith<CallLogState> get copyWith =>
      _$CallLogStateCopyWithImpl<CallLogState>(
          this as CallLogState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallLogState &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            const DeepCollectionEquality().equals(other.callLog, callLog));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number, contact,
      const DeepCollectionEquality().hash(callLog));
}

/// @nodoc
abstract mixin class $CallLogStateCopyWith<$Res> {
  factory $CallLogStateCopyWith(
          CallLogState value, $Res Function(CallLogState) _then) =
      _$CallLogStateCopyWithImpl;
  @useResult
  $Res call({String number, Contact? contact, List<CallLogEntry>? callLog});
}

/// @nodoc
class _$CallLogStateCopyWithImpl<$Res> implements $CallLogStateCopyWith<$Res> {
  _$CallLogStateCopyWithImpl(this._self, this._then);

  final CallLogState _self;
  final $Res Function(CallLogState) _then;

  /// Create a copy of CallLogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? contact = freezed,
    Object? callLog = freezed,
  }) {
    return _then(_self.copyWith(
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      contact: freezed == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
      callLog: freezed == callLog
          ? _self.callLog
          : callLog // ignore: cast_nullable_to_non_nullable
              as List<CallLogEntry>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CallLogState].
extension CallLogStatePatterns on CallLogState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CallLogState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallLogState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CallLogState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallLogState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CallLogState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallLogState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String number, Contact? contact, List<CallLogEntry>? callLog)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallLogState() when $default != null:
        return $default(_that.number, _that.contact, _that.callLog);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String number, Contact? contact, List<CallLogEntry>? callLog)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallLogState():
        return $default(_that.number, _that.contact, _that.callLog);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String number, Contact? contact, List<CallLogEntry>? callLog)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallLogState() when $default != null:
        return $default(_that.number, _that.contact, _that.callLog);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallLogState implements CallLogState {
  const _CallLogState(
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

  /// Create a copy of CallLogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CallLogStateCopyWith<_CallLogState> get copyWith =>
      __$CallLogStateCopyWithImpl<_CallLogState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallLogState &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            const DeepCollectionEquality().equals(other._callLog, _callLog));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number, contact,
      const DeepCollectionEquality().hash(_callLog));
}

/// @nodoc
abstract mixin class _$CallLogStateCopyWith<$Res>
    implements $CallLogStateCopyWith<$Res> {
  factory _$CallLogStateCopyWith(
          _CallLogState value, $Res Function(_CallLogState) _then) =
      __$CallLogStateCopyWithImpl;
  @override
  @useResult
  $Res call({String number, Contact? contact, List<CallLogEntry>? callLog});
}

/// @nodoc
class __$CallLogStateCopyWithImpl<$Res>
    implements _$CallLogStateCopyWith<$Res> {
  __$CallLogStateCopyWithImpl(this._self, this._then);

  final _CallLogState _self;
  final $Res Function(_CallLogState) _then;

  /// Create a copy of CallLogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? number = null,
    Object? contact = freezed,
    Object? callLog = freezed,
  }) {
    return _then(_CallLogState(
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      contact: freezed == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
      callLog: freezed == callLog
          ? _self._callLog
          : callLog // ignore: cast_nullable_to_non_nullable
              as List<CallLogEntry>?,
    ));
  }
}

// dart format on
