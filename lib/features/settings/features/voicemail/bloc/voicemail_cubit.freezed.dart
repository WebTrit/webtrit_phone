// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voicemail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoicemailState implements DiagnosticableTreeMixin {
  VoicemailStatus get status;
  List<Voicemail> get items;
  DefaultErrorNotification? get error;

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VoicemailStateCopyWith<VoicemailState> get copyWith =>
      _$VoicemailStateCopyWithImpl<VoicemailState>(
          this as VoicemailState, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'VoicemailState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VoicemailState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(items), error);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VoicemailState(status: $status, items: $items, error: $error)';
  }
}

/// @nodoc
abstract mixin class $VoicemailStateCopyWith<$Res> {
  factory $VoicemailStateCopyWith(
          VoicemailState value, $Res Function(VoicemailState) _then) =
      _$VoicemailStateCopyWithImpl;
  @useResult
  $Res call(
      {VoicemailStatus status,
      List<Voicemail> items,
      DefaultErrorNotification? error});
}

/// @nodoc
class _$VoicemailStateCopyWithImpl<$Res>
    implements $VoicemailStateCopyWith<$Res> {
  _$VoicemailStateCopyWithImpl(this._self, this._then);

  final VoicemailState _self;
  final $Res Function(VoicemailState) _then;

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? items = null,
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as VoicemailStatus,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Voicemail>,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as DefaultErrorNotification?,
    ));
  }
}

/// Adds pattern-matching-related methods to [VoicemailState].
extension VoicemailStatePatterns on VoicemailState {
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
    TResult Function(_VoicemailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VoicemailState() when $default != null:
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
    TResult Function(_VoicemailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VoicemailState():
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
    TResult? Function(_VoicemailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VoicemailState() when $default != null:
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
    TResult Function(VoicemailStatus status, List<Voicemail> items,
            DefaultErrorNotification? error)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VoicemailState() when $default != null:
        return $default(_that.status, _that.items, _that.error);
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
    TResult Function(VoicemailStatus status, List<Voicemail> items,
            DefaultErrorNotification? error)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VoicemailState():
        return $default(_that.status, _that.items, _that.error);
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
    TResult? Function(VoicemailStatus status, List<Voicemail> items,
            DefaultErrorNotification? error)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VoicemailState() when $default != null:
        return $default(_that.status, _that.items, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VoicemailState extends VoicemailState with DiagnosticableTreeMixin {
  const _VoicemailState(
      {this.status = VoicemailStatus.loading,
      final List<Voicemail> items = const [],
      this.error})
      : _items = items,
        super._();

  @override
  @JsonKey()
  final VoicemailStatus status;
  final List<Voicemail> _items;
  @override
  @JsonKey()
  List<Voicemail> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DefaultErrorNotification? error;

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VoicemailStateCopyWith<_VoicemailState> get copyWith =>
      __$VoicemailStateCopyWithImpl<_VoicemailState>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'VoicemailState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VoicemailState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_items), error);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VoicemailState(status: $status, items: $items, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$VoicemailStateCopyWith<$Res>
    implements $VoicemailStateCopyWith<$Res> {
  factory _$VoicemailStateCopyWith(
          _VoicemailState value, $Res Function(_VoicemailState) _then) =
      __$VoicemailStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {VoicemailStatus status,
      List<Voicemail> items,
      DefaultErrorNotification? error});
}

/// @nodoc
class __$VoicemailStateCopyWithImpl<$Res>
    implements _$VoicemailStateCopyWith<$Res> {
  __$VoicemailStateCopyWithImpl(this._self, this._then);

  final _VoicemailState _self;
  final $Res Function(_VoicemailState) _then;

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? items = null,
    Object? error = freezed,
  }) {
    return _then(_VoicemailState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as VoicemailStatus,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Voicemail>,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as DefaultErrorNotification?,
    ));
  }
}

// dart format on
