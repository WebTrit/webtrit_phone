// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orientations_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrientationsChanged {
  PreferredOrientation get orientation;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrientationsChanged &&
            (identical(other.orientation, orientation) ||
                other.orientation == orientation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orientation);

  @override
  String toString() {
    return 'OrientationsChanged(orientation: $orientation)';
  }
}

/// Adds pattern-matching-related methods to [OrientationsChanged].
extension OrientationsChangedPatterns on OrientationsChanged {
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
    TResult Function(_OrientationsChanged value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrientationsChanged() when $default != null:
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
    TResult Function(_OrientationsChanged value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrientationsChanged():
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
    TResult? Function(_OrientationsChanged value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrientationsChanged() when $default != null:
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
    TResult Function(PreferredOrientation orientation)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrientationsChanged() when $default != null:
        return $default(_that.orientation);
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
    TResult Function(PreferredOrientation orientation) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrientationsChanged():
        return $default(_that.orientation);
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
    TResult? Function(PreferredOrientation orientation)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrientationsChanged() when $default != null:
        return $default(_that.orientation);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OrientationsChanged implements OrientationsChanged {
  const _OrientationsChanged(this.orientation);

  @override
  final PreferredOrientation orientation;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrientationsChanged &&
            (identical(other.orientation, orientation) ||
                other.orientation == orientation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orientation);

  @override
  String toString() {
    return 'OrientationsChanged(orientation: $orientation)';
  }
}

/// @nodoc
mixin _$OrientationsState {
  PreferredOrientation? get lastOrientation;

  /// Create a copy of OrientationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrientationsStateCopyWith<OrientationsState> get copyWith =>
      _$OrientationsStateCopyWithImpl<OrientationsState>(
          this as OrientationsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrientationsState &&
            (identical(other.lastOrientation, lastOrientation) ||
                other.lastOrientation == lastOrientation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastOrientation);

  @override
  String toString() {
    return 'OrientationsState(lastOrientation: $lastOrientation)';
  }
}

/// @nodoc
abstract mixin class $OrientationsStateCopyWith<$Res> {
  factory $OrientationsStateCopyWith(
          OrientationsState value, $Res Function(OrientationsState) _then) =
      _$OrientationsStateCopyWithImpl;
  @useResult
  $Res call({PreferredOrientation? lastOrientation});
}

/// @nodoc
class _$OrientationsStateCopyWithImpl<$Res>
    implements $OrientationsStateCopyWith<$Res> {
  _$OrientationsStateCopyWithImpl(this._self, this._then);

  final OrientationsState _self;
  final $Res Function(OrientationsState) _then;

  /// Create a copy of OrientationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastOrientation = freezed,
  }) {
    return _then(_self.copyWith(
      lastOrientation: freezed == lastOrientation
          ? _self.lastOrientation
          : lastOrientation // ignore: cast_nullable_to_non_nullable
              as PreferredOrientation?,
    ));
  }
}

/// Adds pattern-matching-related methods to [OrientationsState].
extension OrientationsStatePatterns on OrientationsState {
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
    TResult Function(_OrientationsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrientationsState() when $default != null:
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
    TResult Function(_OrientationsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrientationsState():
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
    TResult? Function(_OrientationsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrientationsState() when $default != null:
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
    TResult Function(PreferredOrientation? lastOrientation)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrientationsState() when $default != null:
        return $default(_that.lastOrientation);
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
    TResult Function(PreferredOrientation? lastOrientation) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrientationsState():
        return $default(_that.lastOrientation);
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
    TResult? Function(PreferredOrientation? lastOrientation)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrientationsState() when $default != null:
        return $default(_that.lastOrientation);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OrientationsState implements OrientationsState {
  const _OrientationsState([this.lastOrientation]);

  @override
  final PreferredOrientation? lastOrientation;

  /// Create a copy of OrientationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrientationsStateCopyWith<_OrientationsState> get copyWith =>
      __$OrientationsStateCopyWithImpl<_OrientationsState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrientationsState &&
            (identical(other.lastOrientation, lastOrientation) ||
                other.lastOrientation == lastOrientation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastOrientation);

  @override
  String toString() {
    return 'OrientationsState(lastOrientation: $lastOrientation)';
  }
}

/// @nodoc
abstract mixin class _$OrientationsStateCopyWith<$Res>
    implements $OrientationsStateCopyWith<$Res> {
  factory _$OrientationsStateCopyWith(
          _OrientationsState value, $Res Function(_OrientationsState) _then) =
      __$OrientationsStateCopyWithImpl;
  @override
  @useResult
  $Res call({PreferredOrientation? lastOrientation});
}

/// @nodoc
class __$OrientationsStateCopyWithImpl<$Res>
    implements _$OrientationsStateCopyWith<$Res> {
  __$OrientationsStateCopyWithImpl(this._self, this._then);

  final _OrientationsState _self;
  final $Res Function(_OrientationsState) _then;

  /// Create a copy of OrientationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lastOrientation = freezed,
  }) {
    return _then(_OrientationsState(
      freezed == lastOrientation
          ? _self.lastOrientation
          : lastOrientation // ignore: cast_nullable_to_non_nullable
              as PreferredOrientation?,
    ));
  }
}

// dart format on
