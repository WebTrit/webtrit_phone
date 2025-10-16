// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keypad_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeypadState {
  Contact? get contact;

  /// Create a copy of KeypadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KeypadStateCopyWith<KeypadState> get copyWith =>
      _$KeypadStateCopyWithImpl<KeypadState>(this as KeypadState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KeypadState &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contact);

  @override
  String toString() {
    return 'KeypadState(contact: $contact)';
  }
}

/// @nodoc
abstract mixin class $KeypadStateCopyWith<$Res> {
  factory $KeypadStateCopyWith(
          KeypadState value, $Res Function(KeypadState) _then) =
      _$KeypadStateCopyWithImpl;
  @useResult
  $Res call({Contact? contact});
}

/// @nodoc
class _$KeypadStateCopyWithImpl<$Res> implements $KeypadStateCopyWith<$Res> {
  _$KeypadStateCopyWithImpl(this._self, this._then);

  final KeypadState _self;
  final $Res Function(KeypadState) _then;

  /// Create a copy of KeypadState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = freezed,
  }) {
    return _then(_self.copyWith(
      contact: freezed == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
    ));
  }
}

/// Adds pattern-matching-related methods to [KeypadState].
extension KeypadStatePatterns on KeypadState {
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
    TResult Function(_KeypadState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KeypadState() when $default != null:
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
    TResult Function(_KeypadState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeypadState():
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
    TResult? Function(_KeypadState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeypadState() when $default != null:
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
    TResult Function(Contact? contact)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KeypadState() when $default != null:
        return $default(_that.contact);
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
    TResult Function(Contact? contact) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeypadState():
        return $default(_that.contact);
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
    TResult? Function(Contact? contact)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeypadState() when $default != null:
        return $default(_that.contact);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _KeypadState implements KeypadState {
  const _KeypadState({this.contact});

  @override
  final Contact? contact;

  /// Create a copy of KeypadState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KeypadStateCopyWith<_KeypadState> get copyWith =>
      __$KeypadStateCopyWithImpl<_KeypadState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KeypadState &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contact);

  @override
  String toString() {
    return 'KeypadState(contact: $contact)';
  }
}

/// @nodoc
abstract mixin class _$KeypadStateCopyWith<$Res>
    implements $KeypadStateCopyWith<$Res> {
  factory _$KeypadStateCopyWith(
          _KeypadState value, $Res Function(_KeypadState) _then) =
      __$KeypadStateCopyWithImpl;
  @override
  @useResult
  $Res call({Contact? contact});
}

/// @nodoc
class __$KeypadStateCopyWithImpl<$Res> implements _$KeypadStateCopyWith<$Res> {
  __$KeypadStateCopyWithImpl(this._self, this._then);

  final _KeypadState _self;
  final $Res Function(_KeypadState) _then;

  /// Create a copy of KeypadState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? contact = freezed,
  }) {
    return _then(_KeypadState(
      contact: freezed == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
    ));
  }
}

// dart format on
