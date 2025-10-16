// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_records_console_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LogRecordsConsoleState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LogRecordsConsoleState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LogRecordsConsoleState()';
  }
}

/// @nodoc
class $LogRecordsConsoleStateCopyWith<$Res> {
  $LogRecordsConsoleStateCopyWith(
      LogRecordsConsoleState _, $Res Function(LogRecordsConsoleState) __);
}

/// Adds pattern-matching-related methods to [LogRecordsConsoleState].
extension LogRecordsConsoleStatePatterns on LogRecordsConsoleState {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LogRecordsConsoleStateInitial value)? initial,
    TResult Function(LogRecordsConsoleStateLoading value)? loading,
    TResult Function(LogRecordsConsoleStateSuccess value)? success,
    TResult Function(LogRecordsConsoleStateFailure value)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LogRecordsConsoleStateInitial() when initial != null:
        return initial(_that);
      case LogRecordsConsoleStateLoading() when loading != null:
        return loading(_that);
      case LogRecordsConsoleStateSuccess() when success != null:
        return success(_that);
      case LogRecordsConsoleStateFailure() when failure != null:
        return failure(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(LogRecordsConsoleStateInitial value) initial,
    required TResult Function(LogRecordsConsoleStateLoading value) loading,
    required TResult Function(LogRecordsConsoleStateSuccess value) success,
    required TResult Function(LogRecordsConsoleStateFailure value) failure,
  }) {
    final _that = this;
    switch (_that) {
      case LogRecordsConsoleStateInitial():
        return initial(_that);
      case LogRecordsConsoleStateLoading():
        return loading(_that);
      case LogRecordsConsoleStateSuccess():
        return success(_that);
      case LogRecordsConsoleStateFailure():
        return failure(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LogRecordsConsoleStateInitial value)? initial,
    TResult? Function(LogRecordsConsoleStateLoading value)? loading,
    TResult? Function(LogRecordsConsoleStateSuccess value)? success,
    TResult? Function(LogRecordsConsoleStateFailure value)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case LogRecordsConsoleStateInitial() when initial != null:
        return initial(_that);
      case LogRecordsConsoleStateLoading() when loading != null:
        return loading(_that);
      case LogRecordsConsoleStateSuccess() when success != null:
        return success(_that);
      case LogRecordsConsoleStateFailure() when failure != null:
        return failure(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<LogRecord> logRecords)? success,
    TResult Function(Object error)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LogRecordsConsoleStateInitial() when initial != null:
        return initial();
      case LogRecordsConsoleStateLoading() when loading != null:
        return loading();
      case LogRecordsConsoleStateSuccess() when success != null:
        return success(_that.logRecords);
      case LogRecordsConsoleStateFailure() when failure != null:
        return failure(_that.error);
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
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<LogRecord> logRecords) success,
    required TResult Function(Object error) failure,
  }) {
    final _that = this;
    switch (_that) {
      case LogRecordsConsoleStateInitial():
        return initial();
      case LogRecordsConsoleStateLoading():
        return loading();
      case LogRecordsConsoleStateSuccess():
        return success(_that.logRecords);
      case LogRecordsConsoleStateFailure():
        return failure(_that.error);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<LogRecord> logRecords)? success,
    TResult? Function(Object error)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case LogRecordsConsoleStateInitial() when initial != null:
        return initial();
      case LogRecordsConsoleStateLoading() when loading != null:
        return loading();
      case LogRecordsConsoleStateSuccess() when success != null:
        return success(_that.logRecords);
      case LogRecordsConsoleStateFailure() when failure != null:
        return failure(_that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class LogRecordsConsoleStateInitial implements LogRecordsConsoleState {
  const LogRecordsConsoleStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LogRecordsConsoleStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LogRecordsConsoleState.initial()';
  }
}

/// @nodoc

class LogRecordsConsoleStateLoading implements LogRecordsConsoleState {
  const LogRecordsConsoleStateLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LogRecordsConsoleStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LogRecordsConsoleState.loading()';
  }
}

/// @nodoc

class LogRecordsConsoleStateSuccess implements LogRecordsConsoleState {
  const LogRecordsConsoleStateSuccess(final List<LogRecord> logRecords)
      : _logRecords = logRecords;

  final List<LogRecord> _logRecords;
  List<LogRecord> get logRecords {
    if (_logRecords is EqualUnmodifiableListView) return _logRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logRecords);
  }

  /// Create a copy of LogRecordsConsoleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LogRecordsConsoleStateSuccessCopyWith<LogRecordsConsoleStateSuccess>
      get copyWith => _$LogRecordsConsoleStateSuccessCopyWithImpl<
          LogRecordsConsoleStateSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LogRecordsConsoleStateSuccess &&
            const DeepCollectionEquality()
                .equals(other._logRecords, _logRecords));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_logRecords));

  @override
  String toString() {
    return 'LogRecordsConsoleState.success(logRecords: $logRecords)';
  }
}

/// @nodoc
abstract mixin class $LogRecordsConsoleStateSuccessCopyWith<$Res>
    implements $LogRecordsConsoleStateCopyWith<$Res> {
  factory $LogRecordsConsoleStateSuccessCopyWith(
          LogRecordsConsoleStateSuccess value,
          $Res Function(LogRecordsConsoleStateSuccess) _then) =
      _$LogRecordsConsoleStateSuccessCopyWithImpl;
  @useResult
  $Res call({List<LogRecord> logRecords});
}

/// @nodoc
class _$LogRecordsConsoleStateSuccessCopyWithImpl<$Res>
    implements $LogRecordsConsoleStateSuccessCopyWith<$Res> {
  _$LogRecordsConsoleStateSuccessCopyWithImpl(this._self, this._then);

  final LogRecordsConsoleStateSuccess _self;
  final $Res Function(LogRecordsConsoleStateSuccess) _then;

  /// Create a copy of LogRecordsConsoleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? logRecords = null,
  }) {
    return _then(LogRecordsConsoleStateSuccess(
      null == logRecords
          ? _self._logRecords
          : logRecords // ignore: cast_nullable_to_non_nullable
              as List<LogRecord>,
    ));
  }
}

/// @nodoc

class LogRecordsConsoleStateFailure implements LogRecordsConsoleState {
  const LogRecordsConsoleStateFailure(this.error);

  final Object error;

  /// Create a copy of LogRecordsConsoleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LogRecordsConsoleStateFailureCopyWith<LogRecordsConsoleStateFailure>
      get copyWith => _$LogRecordsConsoleStateFailureCopyWithImpl<
          LogRecordsConsoleStateFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LogRecordsConsoleStateFailure &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'LogRecordsConsoleState.failure(error: $error)';
  }
}

/// @nodoc
abstract mixin class $LogRecordsConsoleStateFailureCopyWith<$Res>
    implements $LogRecordsConsoleStateCopyWith<$Res> {
  factory $LogRecordsConsoleStateFailureCopyWith(
          LogRecordsConsoleStateFailure value,
          $Res Function(LogRecordsConsoleStateFailure) _then) =
      _$LogRecordsConsoleStateFailureCopyWithImpl;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class _$LogRecordsConsoleStateFailureCopyWithImpl<$Res>
    implements $LogRecordsConsoleStateFailureCopyWith<$Res> {
  _$LogRecordsConsoleStateFailureCopyWithImpl(this._self, this._then);

  final LogRecordsConsoleStateFailure _self;
  final $Res Function(LogRecordsConsoleStateFailure) _then;

  /// Create a copy of LogRecordsConsoleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(LogRecordsConsoleStateFailure(
      null == error ? _self.error : error,
    ));
  }
}

// dart format on
