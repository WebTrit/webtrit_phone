// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_tokens_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PushTokensEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PushTokensEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PushTokensEvent()';
  }
}

/// @nodoc
class $PushTokensEventCopyWith<$Res> {
  $PushTokensEventCopyWith(
      PushTokensEvent _, $Res Function(PushTokensEvent) __);
}

/// Adds pattern-matching-related methods to [PushTokensEvent].
extension PushTokensEventPatterns on PushTokensEvent {
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
    TResult Function(PushTokensStarted value)? started,
    TResult Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult Function(_PushTokensError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case PushTokensStarted() when started != null:
        return started(_that);
      case PushTokensInsertedOrUpdated() when insertedOrUpdated != null:
        return insertedOrUpdated(_that);
      case _PushTokensError() when error != null:
        return error(_that);
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
    required TResult Function(PushTokensStarted value) started,
    required TResult Function(PushTokensInsertedOrUpdated value)
        insertedOrUpdated,
    required TResult Function(_PushTokensError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case PushTokensStarted():
        return started(_that);
      case PushTokensInsertedOrUpdated():
        return insertedOrUpdated(_that);
      case _PushTokensError():
        return error(_that);
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
    TResult? Function(PushTokensStarted value)? started,
    TResult? Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult? Function(_PushTokensError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case PushTokensStarted() when started != null:
        return started(_that);
      case PushTokensInsertedOrUpdated() when insertedOrUpdated != null:
        return insertedOrUpdated(_that);
      case _PushTokensError() when error != null:
        return error(_that);
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
    TResult Function()? started,
    TResult Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case PushTokensStarted() when started != null:
        return started();
      case PushTokensInsertedOrUpdated() when insertedOrUpdated != null:
        return insertedOrUpdated(_that.type, _that.value);
      case _PushTokensError() when error != null:
        return error(_that.errorMessage);
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
    required TResult Function() started,
    required TResult Function(AppPushTokenType type, String value)
        insertedOrUpdated,
    required TResult Function(String errorMessage) error,
  }) {
    final _that = this;
    switch (_that) {
      case PushTokensStarted():
        return started();
      case PushTokensInsertedOrUpdated():
        return insertedOrUpdated(_that.type, _that.value);
      case _PushTokensError():
        return error(_that.errorMessage);
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
    TResult? Function()? started,
    TResult? Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult? Function(String errorMessage)? error,
  }) {
    final _that = this;
    switch (_that) {
      case PushTokensStarted() when started != null:
        return started();
      case PushTokensInsertedOrUpdated() when insertedOrUpdated != null:
        return insertedOrUpdated(_that.type, _that.value);
      case _PushTokensError() when error != null:
        return error(_that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class PushTokensStarted implements PushTokensEvent {
  const PushTokensStarted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PushTokensStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PushTokensEvent.started()';
  }
}

/// @nodoc

class PushTokensInsertedOrUpdated implements PushTokensEvent {
  const PushTokensInsertedOrUpdated(this.type, this.value);

  final AppPushTokenType type;
  final String value;

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PushTokensInsertedOrUpdatedCopyWith<PushTokensInsertedOrUpdated>
      get copyWith => _$PushTokensInsertedOrUpdatedCopyWithImpl<
          PushTokensInsertedOrUpdated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PushTokensInsertedOrUpdated &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, value);

  @override
  String toString() {
    return 'PushTokensEvent.insertedOrUpdated(type: $type, value: $value)';
  }
}

/// @nodoc
abstract mixin class $PushTokensInsertedOrUpdatedCopyWith<$Res>
    implements $PushTokensEventCopyWith<$Res> {
  factory $PushTokensInsertedOrUpdatedCopyWith(
          PushTokensInsertedOrUpdated value,
          $Res Function(PushTokensInsertedOrUpdated) _then) =
      _$PushTokensInsertedOrUpdatedCopyWithImpl;
  @useResult
  $Res call({AppPushTokenType type, String value});
}

/// @nodoc
class _$PushTokensInsertedOrUpdatedCopyWithImpl<$Res>
    implements $PushTokensInsertedOrUpdatedCopyWith<$Res> {
  _$PushTokensInsertedOrUpdatedCopyWithImpl(this._self, this._then);

  final PushTokensInsertedOrUpdated _self;
  final $Res Function(PushTokensInsertedOrUpdated) _then;

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? value = null,
  }) {
    return _then(PushTokensInsertedOrUpdated(
      null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppPushTokenType,
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _PushTokensError implements PushTokensEvent {
  const _PushTokensError(this.errorMessage);

  final String errorMessage;

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PushTokensErrorCopyWith<_PushTokensError> get copyWith =>
      __$PushTokensErrorCopyWithImpl<_PushTokensError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PushTokensError &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'PushTokensEvent.error(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$PushTokensErrorCopyWith<$Res>
    implements $PushTokensEventCopyWith<$Res> {
  factory _$PushTokensErrorCopyWith(
          _PushTokensError value, $Res Function(_PushTokensError) _then) =
      __$PushTokensErrorCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$PushTokensErrorCopyWithImpl<$Res>
    implements _$PushTokensErrorCopyWith<$Res> {
  __$PushTokensErrorCopyWithImpl(this._self, this._then);

  final _PushTokensError _self;
  final $Res Function(_PushTokensError) _then;

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_PushTokensError(
      null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$PushTokensState {
  String? get pushToken;
  String? get errorMessage;

  /// Create a copy of PushTokensState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PushTokensStateCopyWith<PushTokensState> get copyWith =>
      _$PushTokensStateCopyWithImpl<PushTokensState>(
          this as PushTokensState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PushTokensState &&
            (identical(other.pushToken, pushToken) ||
                other.pushToken == pushToken) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pushToken, errorMessage);

  @override
  String toString() {
    return 'PushTokensState(pushToken: $pushToken, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $PushTokensStateCopyWith<$Res> {
  factory $PushTokensStateCopyWith(
          PushTokensState value, $Res Function(PushTokensState) _then) =
      _$PushTokensStateCopyWithImpl;
  @useResult
  $Res call({String? pushToken, String? errorMessage});
}

/// @nodoc
class _$PushTokensStateCopyWithImpl<$Res>
    implements $PushTokensStateCopyWith<$Res> {
  _$PushTokensStateCopyWithImpl(this._self, this._then);

  final PushTokensState _self;
  final $Res Function(PushTokensState) _then;

  /// Create a copy of PushTokensState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushToken = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      pushToken: freezed == pushToken
          ? _self.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PushTokensState].
extension PushTokensStatePatterns on PushTokensState {
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
    TResult Function(_PushTokensState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PushTokensState() when $default != null:
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
    TResult Function(_PushTokensState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PushTokensState():
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
    TResult? Function(_PushTokensState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PushTokensState() when $default != null:
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
    TResult Function(String? pushToken, String? errorMessage)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PushTokensState() when $default != null:
        return $default(_that.pushToken, _that.errorMessage);
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
    TResult Function(String? pushToken, String? errorMessage) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PushTokensState():
        return $default(_that.pushToken, _that.errorMessage);
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
    TResult? Function(String? pushToken, String? errorMessage)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PushTokensState() when $default != null:
        return $default(_that.pushToken, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PushTokensState implements PushTokensState {
  const _PushTokensState({this.pushToken, this.errorMessage});

  @override
  final String? pushToken;
  @override
  final String? errorMessage;

  /// Create a copy of PushTokensState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PushTokensStateCopyWith<_PushTokensState> get copyWith =>
      __$PushTokensStateCopyWithImpl<_PushTokensState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PushTokensState &&
            (identical(other.pushToken, pushToken) ||
                other.pushToken == pushToken) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pushToken, errorMessage);

  @override
  String toString() {
    return 'PushTokensState(pushToken: $pushToken, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$PushTokensStateCopyWith<$Res>
    implements $PushTokensStateCopyWith<$Res> {
  factory _$PushTokensStateCopyWith(
          _PushTokensState value, $Res Function(_PushTokensState) _then) =
      __$PushTokensStateCopyWithImpl;
  @override
  @useResult
  $Res call({String? pushToken, String? errorMessage});
}

/// @nodoc
class __$PushTokensStateCopyWithImpl<$Res>
    implements _$PushTokensStateCopyWith<$Res> {
  __$PushTokensStateCopyWithImpl(this._self, this._then);

  final _PushTokensState _self;
  final $Res Function(_PushTokensState) _then;

  /// Create a copy of PushTokensState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pushToken = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_PushTokensState(
      pushToken: freezed == pushToken
          ? _self.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
