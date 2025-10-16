// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permissions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PermissionsState {
  bool get hasRequestedPermissions;
  List<CallkeepSpecialPermissions> get pendingSpecialPermissions;
  ManufacturerTip? get manufacturerTip;
  Object? get failure;

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PermissionsStateCopyWith<PermissionsState> get copyWith =>
      _$PermissionsStateCopyWithImpl<PermissionsState>(
          this as PermissionsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PermissionsState &&
            (identical(
                    other.hasRequestedPermissions, hasRequestedPermissions) ||
                other.hasRequestedPermissions == hasRequestedPermissions) &&
            const DeepCollectionEquality().equals(
                other.pendingSpecialPermissions, pendingSpecialPermissions) &&
            (identical(other.manufacturerTip, manufacturerTip) ||
                other.manufacturerTip == manufacturerTip) &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      hasRequestedPermissions,
      const DeepCollectionEquality().hash(pendingSpecialPermissions),
      manufacturerTip,
      const DeepCollectionEquality().hash(failure));

  @override
  String toString() {
    return 'PermissionsState(hasRequestedPermissions: $hasRequestedPermissions, pendingSpecialPermissions: $pendingSpecialPermissions, manufacturerTip: $manufacturerTip, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class $PermissionsStateCopyWith<$Res> {
  factory $PermissionsStateCopyWith(
          PermissionsState value, $Res Function(PermissionsState) _then) =
      _$PermissionsStateCopyWithImpl;
  @useResult
  $Res call(
      {bool hasRequestedPermissions,
      List<CallkeepSpecialPermissions> pendingSpecialPermissions,
      ManufacturerTip? manufacturerTip,
      Object? failure});

  $ManufacturerTipCopyWith<$Res>? get manufacturerTip;
}

/// @nodoc
class _$PermissionsStateCopyWithImpl<$Res>
    implements $PermissionsStateCopyWith<$Res> {
  _$PermissionsStateCopyWithImpl(this._self, this._then);

  final PermissionsState _self;
  final $Res Function(PermissionsState) _then;

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasRequestedPermissions = null,
    Object? pendingSpecialPermissions = null,
    Object? manufacturerTip = freezed,
    Object? failure = freezed,
  }) {
    return _then(_self.copyWith(
      hasRequestedPermissions: null == hasRequestedPermissions
          ? _self.hasRequestedPermissions
          : hasRequestedPermissions // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingSpecialPermissions: null == pendingSpecialPermissions
          ? _self.pendingSpecialPermissions
          : pendingSpecialPermissions // ignore: cast_nullable_to_non_nullable
              as List<CallkeepSpecialPermissions>,
      manufacturerTip: freezed == manufacturerTip
          ? _self.manufacturerTip
          : manufacturerTip // ignore: cast_nullable_to_non_nullable
              as ManufacturerTip?,
      failure: freezed == failure ? _self.failure : failure,
    ));
  }

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ManufacturerTipCopyWith<$Res>? get manufacturerTip {
    if (_self.manufacturerTip == null) {
      return null;
    }

    return $ManufacturerTipCopyWith<$Res>(_self.manufacturerTip!, (value) {
      return _then(_self.copyWith(manufacturerTip: value));
    });
  }
}

/// Adds pattern-matching-related methods to [PermissionsState].
extension PermissionsStatePatterns on PermissionsState {
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
    TResult Function(_PermissionsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PermissionsState() when $default != null:
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
    TResult Function(_PermissionsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PermissionsState():
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
    TResult? Function(_PermissionsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PermissionsState() when $default != null:
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
            bool hasRequestedPermissions,
            List<CallkeepSpecialPermissions> pendingSpecialPermissions,
            ManufacturerTip? manufacturerTip,
            Object? failure)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PermissionsState() when $default != null:
        return $default(
            _that.hasRequestedPermissions,
            _that.pendingSpecialPermissions,
            _that.manufacturerTip,
            _that.failure);
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
            bool hasRequestedPermissions,
            List<CallkeepSpecialPermissions> pendingSpecialPermissions,
            ManufacturerTip? manufacturerTip,
            Object? failure)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PermissionsState():
        return $default(
            _that.hasRequestedPermissions,
            _that.pendingSpecialPermissions,
            _that.manufacturerTip,
            _that.failure);
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
            bool hasRequestedPermissions,
            List<CallkeepSpecialPermissions> pendingSpecialPermissions,
            ManufacturerTip? manufacturerTip,
            Object? failure)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PermissionsState() when $default != null:
        return $default(
            _that.hasRequestedPermissions,
            _that.pendingSpecialPermissions,
            _that.manufacturerTip,
            _that.failure);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PermissionsState extends PermissionsState {
  const _PermissionsState(
      {this.hasRequestedPermissions = false,
      final List<CallkeepSpecialPermissions> pendingSpecialPermissions =
          const [],
      this.manufacturerTip,
      this.failure})
      : _pendingSpecialPermissions = pendingSpecialPermissions,
        super._();

  @override
  @JsonKey()
  final bool hasRequestedPermissions;
  final List<CallkeepSpecialPermissions> _pendingSpecialPermissions;
  @override
  @JsonKey()
  List<CallkeepSpecialPermissions> get pendingSpecialPermissions {
    if (_pendingSpecialPermissions is EqualUnmodifiableListView)
      return _pendingSpecialPermissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingSpecialPermissions);
  }

  @override
  final ManufacturerTip? manufacturerTip;
  @override
  final Object? failure;

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PermissionsStateCopyWith<_PermissionsState> get copyWith =>
      __$PermissionsStateCopyWithImpl<_PermissionsState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PermissionsState &&
            (identical(
                    other.hasRequestedPermissions, hasRequestedPermissions) ||
                other.hasRequestedPermissions == hasRequestedPermissions) &&
            const DeepCollectionEquality().equals(
                other._pendingSpecialPermissions, _pendingSpecialPermissions) &&
            (identical(other.manufacturerTip, manufacturerTip) ||
                other.manufacturerTip == manufacturerTip) &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      hasRequestedPermissions,
      const DeepCollectionEquality().hash(_pendingSpecialPermissions),
      manufacturerTip,
      const DeepCollectionEquality().hash(failure));

  @override
  String toString() {
    return 'PermissionsState(hasRequestedPermissions: $hasRequestedPermissions, pendingSpecialPermissions: $pendingSpecialPermissions, manufacturerTip: $manufacturerTip, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$PermissionsStateCopyWith<$Res>
    implements $PermissionsStateCopyWith<$Res> {
  factory _$PermissionsStateCopyWith(
          _PermissionsState value, $Res Function(_PermissionsState) _then) =
      __$PermissionsStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool hasRequestedPermissions,
      List<CallkeepSpecialPermissions> pendingSpecialPermissions,
      ManufacturerTip? manufacturerTip,
      Object? failure});

  @override
  $ManufacturerTipCopyWith<$Res>? get manufacturerTip;
}

/// @nodoc
class __$PermissionsStateCopyWithImpl<$Res>
    implements _$PermissionsStateCopyWith<$Res> {
  __$PermissionsStateCopyWithImpl(this._self, this._then);

  final _PermissionsState _self;
  final $Res Function(_PermissionsState) _then;

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hasRequestedPermissions = null,
    Object? pendingSpecialPermissions = null,
    Object? manufacturerTip = freezed,
    Object? failure = freezed,
  }) {
    return _then(_PermissionsState(
      hasRequestedPermissions: null == hasRequestedPermissions
          ? _self.hasRequestedPermissions
          : hasRequestedPermissions // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingSpecialPermissions: null == pendingSpecialPermissions
          ? _self._pendingSpecialPermissions
          : pendingSpecialPermissions // ignore: cast_nullable_to_non_nullable
              as List<CallkeepSpecialPermissions>,
      manufacturerTip: freezed == manufacturerTip
          ? _self.manufacturerTip
          : manufacturerTip // ignore: cast_nullable_to_non_nullable
              as ManufacturerTip?,
      failure: freezed == failure ? _self.failure : failure,
    ));
  }

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ManufacturerTipCopyWith<$Res>? get manufacturerTip {
    if (_self.manufacturerTip == null) {
      return null;
    }

    return $ManufacturerTipCopyWith<$Res>(_self.manufacturerTip!, (value) {
      return _then(_self.copyWith(manufacturerTip: value));
    });
  }
}

/// @nodoc
mixin _$ManufacturerTip {
  Manufacturer get manufacturer;
  bool get shown;

  /// Create a copy of ManufacturerTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ManufacturerTipCopyWith<ManufacturerTip> get copyWith =>
      _$ManufacturerTipCopyWithImpl<ManufacturerTip>(
          this as ManufacturerTip, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ManufacturerTip &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.shown, shown) || other.shown == shown));
  }

  @override
  int get hashCode => Object.hash(runtimeType, manufacturer, shown);

  @override
  String toString() {
    return 'ManufacturerTip(manufacturer: $manufacturer, shown: $shown)';
  }
}

/// @nodoc
abstract mixin class $ManufacturerTipCopyWith<$Res> {
  factory $ManufacturerTipCopyWith(
          ManufacturerTip value, $Res Function(ManufacturerTip) _then) =
      _$ManufacturerTipCopyWithImpl;
  @useResult
  $Res call({Manufacturer manufacturer, bool shown});
}

/// @nodoc
class _$ManufacturerTipCopyWithImpl<$Res>
    implements $ManufacturerTipCopyWith<$Res> {
  _$ManufacturerTipCopyWithImpl(this._self, this._then);

  final ManufacturerTip _self;
  final $Res Function(ManufacturerTip) _then;

  /// Create a copy of ManufacturerTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manufacturer = null,
    Object? shown = null,
  }) {
    return _then(_self.copyWith(
      manufacturer: null == manufacturer
          ? _self.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as Manufacturer,
      shown: null == shown
          ? _self.shown
          : shown // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ManufacturerTip].
extension ManufacturerTipPatterns on ManufacturerTip {
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
    TResult Function(_ManufacturerTip value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManufacturerTip() when $default != null:
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
    TResult Function(_ManufacturerTip value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManufacturerTip():
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
    TResult? Function(_ManufacturerTip value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManufacturerTip() when $default != null:
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
    TResult Function(Manufacturer manufacturer, bool shown)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManufacturerTip() when $default != null:
        return $default(_that.manufacturer, _that.shown);
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
    TResult Function(Manufacturer manufacturer, bool shown) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManufacturerTip():
        return $default(_that.manufacturer, _that.shown);
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
    TResult? Function(Manufacturer manufacturer, bool shown)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManufacturerTip() when $default != null:
        return $default(_that.manufacturer, _that.shown);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ManufacturerTip implements ManufacturerTip {
  const _ManufacturerTip({required this.manufacturer, this.shown = false});

  @override
  final Manufacturer manufacturer;
  @override
  @JsonKey()
  final bool shown;

  /// Create a copy of ManufacturerTip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ManufacturerTipCopyWith<_ManufacturerTip> get copyWith =>
      __$ManufacturerTipCopyWithImpl<_ManufacturerTip>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ManufacturerTip &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.shown, shown) || other.shown == shown));
  }

  @override
  int get hashCode => Object.hash(runtimeType, manufacturer, shown);

  @override
  String toString() {
    return 'ManufacturerTip(manufacturer: $manufacturer, shown: $shown)';
  }
}

/// @nodoc
abstract mixin class _$ManufacturerTipCopyWith<$Res>
    implements $ManufacturerTipCopyWith<$Res> {
  factory _$ManufacturerTipCopyWith(
          _ManufacturerTip value, $Res Function(_ManufacturerTip) _then) =
      __$ManufacturerTipCopyWithImpl;
  @override
  @useResult
  $Res call({Manufacturer manufacturer, bool shown});
}

/// @nodoc
class __$ManufacturerTipCopyWithImpl<$Res>
    implements _$ManufacturerTipCopyWith<$Res> {
  __$ManufacturerTipCopyWithImpl(this._self, this._then);

  final _ManufacturerTip _self;
  final $Res Function(_ManufacturerTip) _then;

  /// Create a copy of ManufacturerTip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? manufacturer = null,
    Object? shown = null,
  }) {
    return _then(_ManufacturerTip(
      manufacturer: null == manufacturer
          ? _self.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as Manufacturer,
      shown: null == shown
          ? _self.shown
          : shown // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
