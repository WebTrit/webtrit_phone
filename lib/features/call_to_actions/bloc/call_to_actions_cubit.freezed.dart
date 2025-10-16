// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_to_actions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallToActionsCubitState {
  Locale get locale;
  Map<MainFlavor, List<CallToAction>> get actions;
  bool get visible;
  MainFlavor? get flavor;

  /// Create a copy of CallToActionsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CallToActionsCubitStateCopyWith<CallToActionsCubitState> get copyWith =>
      _$CallToActionsCubitStateCopyWithImpl<CallToActionsCubitState>(
          this as CallToActionsCubitState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallToActionsCubitState &&
            (identical(other.locale, locale) || other.locale == locale) &&
            const DeepCollectionEquality().equals(other.actions, actions) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.flavor, flavor) || other.flavor == flavor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locale,
      const DeepCollectionEquality().hash(actions), visible, flavor);

  @override
  String toString() {
    return 'CallToActionsCubitState(locale: $locale, actions: $actions, visible: $visible, flavor: $flavor)';
  }
}

/// @nodoc
abstract mixin class $CallToActionsCubitStateCopyWith<$Res> {
  factory $CallToActionsCubitStateCopyWith(CallToActionsCubitState value,
          $Res Function(CallToActionsCubitState) _then) =
      _$CallToActionsCubitStateCopyWithImpl;
  @useResult
  $Res call(
      {Locale locale,
      Map<MainFlavor, List<CallToAction>> actions,
      bool visible,
      MainFlavor? flavor});
}

/// @nodoc
class _$CallToActionsCubitStateCopyWithImpl<$Res>
    implements $CallToActionsCubitStateCopyWith<$Res> {
  _$CallToActionsCubitStateCopyWithImpl(this._self, this._then);

  final CallToActionsCubitState _self;
  final $Res Function(CallToActionsCubitState) _then;

  /// Create a copy of CallToActionsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
    Object? actions = null,
    Object? visible = null,
    Object? flavor = freezed,
  }) {
    return _then(_self.copyWith(
      locale: null == locale
          ? _self.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      actions: null == actions
          ? _self.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<MainFlavor, List<CallToAction>>,
      visible: null == visible
          ? _self.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      flavor: freezed == flavor
          ? _self.flavor
          : flavor // ignore: cast_nullable_to_non_nullable
              as MainFlavor?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CallToActionsCubitState].
extension CallToActionsCubitStatePatterns on CallToActionsCubitState {
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
    TResult Function(_CallToActionsCubitState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallToActionsCubitState() when $default != null:
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
    TResult Function(_CallToActionsCubitState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallToActionsCubitState():
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
    TResult? Function(_CallToActionsCubitState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallToActionsCubitState() when $default != null:
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
    TResult Function(Locale locale, Map<MainFlavor, List<CallToAction>> actions,
            bool visible, MainFlavor? flavor)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallToActionsCubitState() when $default != null:
        return $default(
            _that.locale, _that.actions, _that.visible, _that.flavor);
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
    TResult Function(Locale locale, Map<MainFlavor, List<CallToAction>> actions,
            bool visible, MainFlavor? flavor)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallToActionsCubitState():
        return $default(
            _that.locale, _that.actions, _that.visible, _that.flavor);
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
            Locale locale,
            Map<MainFlavor, List<CallToAction>> actions,
            bool visible,
            MainFlavor? flavor)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallToActionsCubitState() when $default != null:
        return $default(
            _that.locale, _that.actions, _that.visible, _that.flavor);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallToActionsCubitState extends CallToActionsCubitState {
  const _CallToActionsCubitState(
      {required this.locale,
      final Map<MainFlavor, List<CallToAction>> actions = const {},
      this.visible = true,
      this.flavor})
      : _actions = actions,
        super._();

  @override
  final Locale locale;
  final Map<MainFlavor, List<CallToAction>> _actions;
  @override
  @JsonKey()
  Map<MainFlavor, List<CallToAction>> get actions {
    if (_actions is EqualUnmodifiableMapView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_actions);
  }

  @override
  @JsonKey()
  final bool visible;
  @override
  final MainFlavor? flavor;

  /// Create a copy of CallToActionsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CallToActionsCubitStateCopyWith<_CallToActionsCubitState> get copyWith =>
      __$CallToActionsCubitStateCopyWithImpl<_CallToActionsCubitState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallToActionsCubitState &&
            (identical(other.locale, locale) || other.locale == locale) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.flavor, flavor) || other.flavor == flavor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locale,
      const DeepCollectionEquality().hash(_actions), visible, flavor);

  @override
  String toString() {
    return 'CallToActionsCubitState(locale: $locale, actions: $actions, visible: $visible, flavor: $flavor)';
  }
}

/// @nodoc
abstract mixin class _$CallToActionsCubitStateCopyWith<$Res>
    implements $CallToActionsCubitStateCopyWith<$Res> {
  factory _$CallToActionsCubitStateCopyWith(_CallToActionsCubitState value,
          $Res Function(_CallToActionsCubitState) _then) =
      __$CallToActionsCubitStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Locale locale,
      Map<MainFlavor, List<CallToAction>> actions,
      bool visible,
      MainFlavor? flavor});
}

/// @nodoc
class __$CallToActionsCubitStateCopyWithImpl<$Res>
    implements _$CallToActionsCubitStateCopyWith<$Res> {
  __$CallToActionsCubitStateCopyWithImpl(this._self, this._then);

  final _CallToActionsCubitState _self;
  final $Res Function(_CallToActionsCubitState) _then;

  /// Create a copy of CallToActionsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? locale = null,
    Object? actions = null,
    Object? visible = null,
    Object? flavor = freezed,
  }) {
    return _then(_CallToActionsCubitState(
      locale: null == locale
          ? _self.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      actions: null == actions
          ? _self._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<MainFlavor, List<CallToAction>>,
      visible: null == visible
          ? _self.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      flavor: freezed == flavor
          ? _self.flavor
          : flavor // ignore: cast_nullable_to_non_nullable
              as MainFlavor?,
    ));
  }
}

// dart format on
