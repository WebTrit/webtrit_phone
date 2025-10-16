// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recents_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecentsFiltered {
  RecentsVisibilityFilter get filter;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecentsFiltered &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  @override
  String toString() {
    return 'RecentsFiltered(filter: $filter)';
  }
}

/// Adds pattern-matching-related methods to [RecentsFiltered].
extension RecentsFilteredPatterns on RecentsFiltered {
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
    TResult Function(_RecentsFiltered value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecentsFiltered() when $default != null:
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
    TResult Function(_RecentsFiltered value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsFiltered():
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
    TResult? Function(_RecentsFiltered value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsFiltered() when $default != null:
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
    TResult Function(RecentsVisibilityFilter filter)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecentsFiltered() when $default != null:
        return $default(_that.filter);
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
    TResult Function(RecentsVisibilityFilter filter) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsFiltered():
        return $default(_that.filter);
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
    TResult? Function(RecentsVisibilityFilter filter)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsFiltered() when $default != null:
        return $default(_that.filter);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RecentsFiltered implements RecentsFiltered {
  const _RecentsFiltered(this.filter);

  @override
  final RecentsVisibilityFilter filter;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecentsFiltered &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  @override
  String toString() {
    return 'RecentsFiltered(filter: $filter)';
  }
}

/// @nodoc
mixin _$RecentsDeleted {
  Recent get recent;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecentsDeleted &&
            (identical(other.recent, recent) || other.recent == recent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recent);

  @override
  String toString() {
    return 'RecentsDeleted(recent: $recent)';
  }
}

/// Adds pattern-matching-related methods to [RecentsDeleted].
extension RecentsDeletedPatterns on RecentsDeleted {
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
    TResult Function(_RecentsDeleted value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecentsDeleted() when $default != null:
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
    TResult Function(_RecentsDeleted value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsDeleted():
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
    TResult? Function(_RecentsDeleted value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsDeleted() when $default != null:
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
    TResult Function(Recent recent)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecentsDeleted() when $default != null:
        return $default(_that.recent);
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
    TResult Function(Recent recent) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsDeleted():
        return $default(_that.recent);
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
    TResult? Function(Recent recent)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsDeleted() when $default != null:
        return $default(_that.recent);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RecentsDeleted implements RecentsDeleted {
  const _RecentsDeleted(this.recent);

  @override
  final Recent recent;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecentsDeleted &&
            (identical(other.recent, recent) || other.recent == recent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recent);

  @override
  String toString() {
    return 'RecentsDeleted(recent: $recent)';
  }
}

/// @nodoc
mixin _$RecentsState {
  List<Recent>? get recents;
  RecentsVisibilityFilter get filter;

  /// Create a copy of RecentsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecentsStateCopyWith<RecentsState> get copyWith =>
      _$RecentsStateCopyWithImpl<RecentsState>(
          this as RecentsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecentsState &&
            const DeepCollectionEquality().equals(other.recents, recents) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(recents), filter);
}

/// @nodoc
abstract mixin class $RecentsStateCopyWith<$Res> {
  factory $RecentsStateCopyWith(
          RecentsState value, $Res Function(RecentsState) _then) =
      _$RecentsStateCopyWithImpl;
  @useResult
  $Res call({List<Recent>? recents, RecentsVisibilityFilter filter});
}

/// @nodoc
class _$RecentsStateCopyWithImpl<$Res> implements $RecentsStateCopyWith<$Res> {
  _$RecentsStateCopyWithImpl(this._self, this._then);

  final RecentsState _self;
  final $Res Function(RecentsState) _then;

  /// Create a copy of RecentsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recents = freezed,
    Object? filter = null,
  }) {
    return _then(_self.copyWith(
      recents: freezed == recents
          ? _self.recents
          : recents // ignore: cast_nullable_to_non_nullable
              as List<Recent>?,
      filter: null == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as RecentsVisibilityFilter,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecentsState].
extension RecentsStatePatterns on RecentsState {
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
    TResult Function(_RecentsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecentsState() when $default != null:
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
    TResult Function(_RecentsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsState():
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
    TResult? Function(_RecentsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsState() when $default != null:
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
    TResult Function(List<Recent>? recents, RecentsVisibilityFilter filter)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecentsState() when $default != null:
        return $default(_that.recents, _that.filter);
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
    TResult Function(List<Recent>? recents, RecentsVisibilityFilter filter)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsState():
        return $default(_that.recents, _that.filter);
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
    TResult? Function(List<Recent>? recents, RecentsVisibilityFilter filter)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentsState() when $default != null:
        return $default(_that.recents, _that.filter);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RecentsState extends RecentsState {
  const _RecentsState({final List<Recent>? recents, required this.filter})
      : _recents = recents,
        super._();

  final List<Recent>? _recents;
  @override
  List<Recent>? get recents {
    final value = _recents;
    if (value == null) return null;
    if (_recents is EqualUnmodifiableListView) return _recents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final RecentsVisibilityFilter filter;

  /// Create a copy of RecentsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecentsStateCopyWith<_RecentsState> get copyWith =>
      __$RecentsStateCopyWithImpl<_RecentsState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecentsState &&
            const DeepCollectionEquality().equals(other._recents, _recents) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_recents), filter);
}

/// @nodoc
abstract mixin class _$RecentsStateCopyWith<$Res>
    implements $RecentsStateCopyWith<$Res> {
  factory _$RecentsStateCopyWith(
          _RecentsState value, $Res Function(_RecentsState) _then) =
      __$RecentsStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<Recent>? recents, RecentsVisibilityFilter filter});
}

/// @nodoc
class __$RecentsStateCopyWithImpl<$Res>
    implements _$RecentsStateCopyWith<$Res> {
  __$RecentsStateCopyWithImpl(this._self, this._then);

  final _RecentsState _self;
  final $Res Function(_RecentsState) _then;

  /// Create a copy of RecentsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? recents = freezed,
    Object? filter = null,
  }) {
    return _then(_RecentsState(
      recents: freezed == recents
          ? _self._recents
          : recents // ignore: cast_nullable_to_non_nullable
              as List<Recent>?,
      filter: null == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as RecentsVisibilityFilter,
    ));
  }
}

// dart format on
