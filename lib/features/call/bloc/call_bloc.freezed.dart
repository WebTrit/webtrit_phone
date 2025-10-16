// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppLifecycleStateChanged implements DiagnosticableTreeMixin {
  AppLifecycleState get state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_AppLifecycleStateChanged'))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppLifecycleStateChanged &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_AppLifecycleStateChanged(state: $state)';
  }
}

/// Adds pattern-matching-related methods to [_AppLifecycleStateChanged].
extension _AppLifecycleStateChangedPatterns on _AppLifecycleStateChanged {
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
    TResult Function(__AppLifecycleStateChanged value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __AppLifecycleStateChanged() when $default != null:
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
    TResult Function(__AppLifecycleStateChanged value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __AppLifecycleStateChanged():
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
    TResult? Function(__AppLifecycleStateChanged value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __AppLifecycleStateChanged() when $default != null:
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
    TResult Function(AppLifecycleState state)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __AppLifecycleStateChanged() when $default != null:
        return $default(_that.state);
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
    TResult Function(AppLifecycleState state) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __AppLifecycleStateChanged():
        return $default(_that.state);
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
    TResult? Function(AppLifecycleState state)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __AppLifecycleStateChanged() when $default != null:
        return $default(_that.state);
      case _:
        return null;
    }
  }
}

/// @nodoc

class __AppLifecycleStateChanged
    with DiagnosticableTreeMixin
    implements _AppLifecycleStateChanged {
  const __AppLifecycleStateChanged(this.state);

  @override
  final AppLifecycleState state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_AppLifecycleStateChanged'))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is __AppLifecycleStateChanged &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_AppLifecycleStateChanged(state: $state)';
  }
}

/// @nodoc
mixin _$ConnectivityResultChanged implements DiagnosticableTreeMixin {
  ConnectivityResult get result;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_ConnectivityResultChanged'))
      ..add(DiagnosticsProperty('result', result));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectivityResultChanged &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_ConnectivityResultChanged(result: $result)';
  }
}

/// Adds pattern-matching-related methods to [_ConnectivityResultChanged].
extension _ConnectivityResultChangedPatterns on _ConnectivityResultChanged {
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
    TResult Function(__ConnectivityResultChanged value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __ConnectivityResultChanged() when $default != null:
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
    TResult Function(__ConnectivityResultChanged value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __ConnectivityResultChanged():
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
    TResult? Function(__ConnectivityResultChanged value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __ConnectivityResultChanged() when $default != null:
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
    TResult Function(ConnectivityResult result)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __ConnectivityResultChanged() when $default != null:
        return $default(_that.result);
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
    TResult Function(ConnectivityResult result) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __ConnectivityResultChanged():
        return $default(_that.result);
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
    TResult? Function(ConnectivityResult result)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __ConnectivityResultChanged() when $default != null:
        return $default(_that.result);
      case _:
        return null;
    }
  }
}

/// @nodoc

class __ConnectivityResultChanged
    with DiagnosticableTreeMixin
    implements _ConnectivityResultChanged {
  const __ConnectivityResultChanged(this.result);

  @override
  final ConnectivityResult result;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_ConnectivityResultChanged'))
      ..add(DiagnosticsProperty('result', result));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is __ConnectivityResultChanged &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_ConnectivityResultChanged(result: $result)';
  }
}

/// @nodoc
mixin _$NavigatorMediaDevicesChange implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_NavigatorMediaDevicesChange'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NavigatorMediaDevicesChange);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_NavigatorMediaDevicesChange()';
  }
}

/// Adds pattern-matching-related methods to [_NavigatorMediaDevicesChange].
extension _NavigatorMediaDevicesChangePatterns on _NavigatorMediaDevicesChange {
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
    TResult Function(__NavigatorMediaDevicesChange value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __NavigatorMediaDevicesChange() when $default != null:
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
    TResult Function(__NavigatorMediaDevicesChange value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __NavigatorMediaDevicesChange():
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
    TResult? Function(__NavigatorMediaDevicesChange value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __NavigatorMediaDevicesChange() when $default != null:
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
    TResult Function()? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __NavigatorMediaDevicesChange() when $default != null:
        return $default();
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
    TResult Function() $default,
  ) {
    final _that = this;
    switch (_that) {
      case __NavigatorMediaDevicesChange():
        return $default();
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
    TResult? Function()? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __NavigatorMediaDevicesChange() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class __NavigatorMediaDevicesChange
    with DiagnosticableTreeMixin
    implements _NavigatorMediaDevicesChange {
  const __NavigatorMediaDevicesChange();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_NavigatorMediaDevicesChange'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is __NavigatorMediaDevicesChange);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_NavigatorMediaDevicesChange()';
  }
}

/// @nodoc
mixin _$RegistrationChange implements DiagnosticableTreeMixin {
  Registration get registration;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_RegistrationChange'))
      ..add(DiagnosticsProperty('registration', registration));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegistrationChange &&
            (identical(other.registration, registration) ||
                other.registration == registration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, registration);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_RegistrationChange(registration: $registration)';
  }
}

/// Adds pattern-matching-related methods to [_RegistrationChange].
extension _RegistrationChangePatterns on _RegistrationChange {
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
    TResult Function(__RegistrationChange value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __RegistrationChange() when $default != null:
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
    TResult Function(__RegistrationChange value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __RegistrationChange():
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
    TResult? Function(__RegistrationChange value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __RegistrationChange() when $default != null:
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
    TResult Function(Registration registration)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __RegistrationChange() when $default != null:
        return $default(_that.registration);
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
    TResult Function(Registration registration) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __RegistrationChange():
        return $default(_that.registration);
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
    TResult? Function(Registration registration)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __RegistrationChange() when $default != null:
        return $default(_that.registration);
      case _:
        return null;
    }
  }
}

/// @nodoc

class __RegistrationChange
    with DiagnosticableTreeMixin
    implements _RegistrationChange {
  const __RegistrationChange({required this.registration});

  @override
  final Registration registration;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_RegistrationChange'))
      ..add(DiagnosticsProperty('registration', registration));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is __RegistrationChange &&
            (identical(other.registration, registration) ||
                other.registration == registration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, registration);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_RegistrationChange(registration: $registration)';
  }
}

/// @nodoc
mixin _$ResetStateEvent implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', '_ResetStateEvent'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ResetStateEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_ResetStateEvent()';
  }
}

/// Adds pattern-matching-related methods to [_ResetStateEvent].
extension _ResetStateEventPatterns on _ResetStateEvent {
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
    TResult Function(_ResetStateEventCompleteCalls value)? completeCalls,
    TResult Function(_ResetStateEventCompleteCall value)? completeCall,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ResetStateEventCompleteCalls() when completeCalls != null:
        return completeCalls(_that);
      case _ResetStateEventCompleteCall() when completeCall != null:
        return completeCall(_that);
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
    required TResult Function(_ResetStateEventCompleteCalls value)
        completeCalls,
    required TResult Function(_ResetStateEventCompleteCall value) completeCall,
  }) {
    final _that = this;
    switch (_that) {
      case _ResetStateEventCompleteCalls():
        return completeCalls(_that);
      case _ResetStateEventCompleteCall():
        return completeCall(_that);
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
    TResult? Function(_ResetStateEventCompleteCalls value)? completeCalls,
    TResult? Function(_ResetStateEventCompleteCall value)? completeCall,
  }) {
    final _that = this;
    switch (_that) {
      case _ResetStateEventCompleteCalls() when completeCalls != null:
        return completeCalls(_that);
      case _ResetStateEventCompleteCall() when completeCall != null:
        return completeCall(_that);
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
    TResult Function()? completeCalls,
    TResult Function(String callId)? completeCall,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ResetStateEventCompleteCalls() when completeCalls != null:
        return completeCalls();
      case _ResetStateEventCompleteCall() when completeCall != null:
        return completeCall(_that.callId);
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
    required TResult Function() completeCalls,
    required TResult Function(String callId) completeCall,
  }) {
    final _that = this;
    switch (_that) {
      case _ResetStateEventCompleteCalls():
        return completeCalls();
      case _ResetStateEventCompleteCall():
        return completeCall(_that.callId);
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
    TResult? Function()? completeCalls,
    TResult? Function(String callId)? completeCall,
  }) {
    final _that = this;
    switch (_that) {
      case _ResetStateEventCompleteCalls() when completeCalls != null:
        return completeCalls();
      case _ResetStateEventCompleteCall() when completeCall != null:
        return completeCall(_that.callId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ResetStateEventCompleteCalls
    with DiagnosticableTreeMixin
    implements _ResetStateEvent {
  const _ResetStateEventCompleteCalls();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_ResetStateEvent.completeCalls'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ResetStateEventCompleteCalls);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_ResetStateEvent.completeCalls()';
  }
}

/// @nodoc

class _ResetStateEventCompleteCall
    with DiagnosticableTreeMixin
    implements _ResetStateEvent {
  const _ResetStateEventCompleteCall(this.callId);

  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_ResetStateEvent.completeCall'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ResetStateEventCompleteCall &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_ResetStateEvent.completeCall(callId: $callId)';
  }
}

/// @nodoc
mixin _$SignalingClientEvent implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', '_SignalingClientEvent'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SignalingClientEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_SignalingClientEvent()';
  }
}

/// Adds pattern-matching-related methods to [_SignalingClientEvent].
extension _SignalingClientEventPatterns on _SignalingClientEvent {
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
    TResult Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult Function(_SignalingClientEventDisconnected value)? disconnected,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignalingClientEventConnectInitiated()
          when connectInitiated != null:
        return connectInitiated(_that);
      case _SignalingClientEventDisconnectInitiated()
          when disconnectInitiated != null:
        return disconnectInitiated(_that);
      case _SignalingClientEventDisconnected() when disconnected != null:
        return disconnected(_that);
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
    required TResult Function(_SignalingClientEventConnectInitiated value)
        connectInitiated,
    required TResult Function(_SignalingClientEventDisconnectInitiated value)
        disconnectInitiated,
    required TResult Function(_SignalingClientEventDisconnected value)
        disconnected,
  }) {
    final _that = this;
    switch (_that) {
      case _SignalingClientEventConnectInitiated():
        return connectInitiated(_that);
      case _SignalingClientEventDisconnectInitiated():
        return disconnectInitiated(_that);
      case _SignalingClientEventDisconnected():
        return disconnected(_that);
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
    TResult? Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult? Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult? Function(_SignalingClientEventDisconnected value)? disconnected,
  }) {
    final _that = this;
    switch (_that) {
      case _SignalingClientEventConnectInitiated()
          when connectInitiated != null:
        return connectInitiated(_that);
      case _SignalingClientEventDisconnectInitiated()
          when disconnectInitiated != null:
        return disconnectInitiated(_that);
      case _SignalingClientEventDisconnected() when disconnected != null:
        return disconnected(_that);
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
    TResult Function()? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason)? disconnected,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignalingClientEventConnectInitiated()
          when connectInitiated != null:
        return connectInitiated();
      case _SignalingClientEventDisconnectInitiated()
          when disconnectInitiated != null:
        return disconnectInitiated();
      case _SignalingClientEventDisconnected() when disconnected != null:
        return disconnected(_that.code, _that.reason);
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
    required TResult Function() connectInitiated,
    required TResult Function() disconnectInitiated,
    required TResult Function(int? code, String? reason) disconnected,
  }) {
    final _that = this;
    switch (_that) {
      case _SignalingClientEventConnectInitiated():
        return connectInitiated();
      case _SignalingClientEventDisconnectInitiated():
        return disconnectInitiated();
      case _SignalingClientEventDisconnected():
        return disconnected(_that.code, _that.reason);
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
    TResult? Function()? connectInitiated,
    TResult? Function()? disconnectInitiated,
    TResult? Function(int? code, String? reason)? disconnected,
  }) {
    final _that = this;
    switch (_that) {
      case _SignalingClientEventConnectInitiated()
          when connectInitiated != null:
        return connectInitiated();
      case _SignalingClientEventDisconnectInitiated()
          when disconnectInitiated != null:
        return disconnectInitiated();
      case _SignalingClientEventDisconnected() when disconnected != null:
        return disconnected(_that.code, _that.reason);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SignalingClientEventConnectInitiated
    with DiagnosticableTreeMixin
    implements _SignalingClientEvent {
  const _SignalingClientEventConnectInitiated();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', '_SignalingClientEvent.connectInitiated'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignalingClientEventConnectInitiated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_SignalingClientEvent.connectInitiated()';
  }
}

/// @nodoc

class _SignalingClientEventDisconnectInitiated
    with DiagnosticableTreeMixin
    implements _SignalingClientEvent {
  const _SignalingClientEventDisconnectInitiated();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', '_SignalingClientEvent.disconnectInitiated'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignalingClientEventDisconnectInitiated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_SignalingClientEvent.disconnectInitiated()';
  }
}

/// @nodoc

class _SignalingClientEventDisconnected
    with DiagnosticableTreeMixin
    implements _SignalingClientEvent {
  const _SignalingClientEventDisconnected(this.code, this.reason);

  final int? code;
  final String? reason;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_SignalingClientEvent.disconnected'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('reason', reason));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignalingClientEventDisconnected &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, reason);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_SignalingClientEvent.disconnected(code: $code, reason: $reason)';
  }
}

/// @nodoc
mixin _$HandshakeSignalingEvent implements DiagnosticableTreeMixin {
  Registration get registration;
  int get linesCount;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_HandshakeSignalingEvent'))
      ..add(DiagnosticsProperty('registration', registration))
      ..add(DiagnosticsProperty('linesCount', linesCount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HandshakeSignalingEvent &&
            (identical(other.registration, registration) ||
                other.registration == registration) &&
            (identical(other.linesCount, linesCount) ||
                other.linesCount == linesCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, registration, linesCount);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_HandshakeSignalingEvent(registration: $registration, linesCount: $linesCount)';
  }
}

/// Adds pattern-matching-related methods to [_HandshakeSignalingEvent].
extension _HandshakeSignalingEventPatterns on _HandshakeSignalingEvent {
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
    TResult Function(_HandshakeSignalingEventState value)? state,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HandshakeSignalingEventState() when state != null:
        return state(_that);
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
    required TResult Function(_HandshakeSignalingEventState value) state,
  }) {
    final _that = this;
    switch (_that) {
      case _HandshakeSignalingEventState():
        return state(_that);
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
    TResult? Function(_HandshakeSignalingEventState value)? state,
  }) {
    final _that = this;
    switch (_that) {
      case _HandshakeSignalingEventState() when state != null:
        return state(_that);
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
    TResult Function(Registration registration, int linesCount)? state,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HandshakeSignalingEventState() when state != null:
        return state(_that.registration, _that.linesCount);
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
    required TResult Function(Registration registration, int linesCount) state,
  }) {
    final _that = this;
    switch (_that) {
      case _HandshakeSignalingEventState():
        return state(_that.registration, _that.linesCount);
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
    TResult? Function(Registration registration, int linesCount)? state,
  }) {
    final _that = this;
    switch (_that) {
      case _HandshakeSignalingEventState() when state != null:
        return state(_that.registration, _that.linesCount);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HandshakeSignalingEventState
    with DiagnosticableTreeMixin
    implements _HandshakeSignalingEvent {
  const _HandshakeSignalingEventState(
      {required this.registration, required this.linesCount});

  @override
  final Registration registration;
  @override
  final int linesCount;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_HandshakeSignalingEvent.state'))
      ..add(DiagnosticsProperty('registration', registration))
      ..add(DiagnosticsProperty('linesCount', linesCount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HandshakeSignalingEventState &&
            (identical(other.registration, registration) ||
                other.registration == registration) &&
            (identical(other.linesCount, linesCount) ||
                other.linesCount == linesCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, registration, linesCount);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_HandshakeSignalingEvent.state(registration: $registration, linesCount: $linesCount)';
  }
}

/// @nodoc
mixin _$CallSignalingEvent implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', '_CallSignalingEvent'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _CallSignalingEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent()';
  }
}

/// Adds pattern-matching-related methods to [_CallSignalingEvent].
extension _CallSignalingEventPatterns on _CallSignalingEvent {
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
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventRinging value)? ringing,
    TResult Function(_CallSignalingEventProgress value)? progress,
    TResult Function(_CallSignalingEventAccepted value)? accepted,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    TResult Function(_CallSignalingEventUpdating value)? updating,
    TResult Function(_CallSignalingEventUpdated value)? updated,
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventTransferring value)? transferring,
    TResult Function(_CallSignalingEventNotifyDialog value)? notifyDialog,
    TResult Function(_CallSignalingEventNotifyRefer value)? notifyRefer,
    TResult Function(_CallSignalingEventNotifyUnknown value)? notifyUnknown,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallSignalingEventIncoming() when incoming != null:
        return incoming(_that);
      case _CallSignalingEventRinging() when ringing != null:
        return ringing(_that);
      case _CallSignalingEventProgress() when progress != null:
        return progress(_that);
      case _CallSignalingEventAccepted() when accepted != null:
        return accepted(_that);
      case _CallSignalingEventHangup() when hangup != null:
        return hangup(_that);
      case _CallSignalingEventUpdating() when updating != null:
        return updating(_that);
      case _CallSignalingEventUpdated() when updated != null:
        return updated(_that);
      case _CallSignalingEventTransfer() when transfer != null:
        return transfer(_that);
      case _CallSignalingEventTransferring() when transferring != null:
        return transferring(_that);
      case _CallSignalingEventNotifyDialog() when notifyDialog != null:
        return notifyDialog(_that);
      case _CallSignalingEventNotifyRefer() when notifyRefer != null:
        return notifyRefer(_that);
      case _CallSignalingEventNotifyUnknown() when notifyUnknown != null:
        return notifyUnknown(_that);
      case _CallSignalingEventRegistering() when registering != null:
        return registering(_that);
      case _CallSignalingEventRegistered() when registered != null:
        return registered(_that);
      case _CallSignalingEventRegisterationFailed()
          when registrationFailed != null:
        return registrationFailed(_that);
      case _CallSignalingEventUnregistering() when unregistering != null:
        return unregistering(_that);
      case _CallSignalingEventUnregistered() when unregistered != null:
        return unregistered(_that);
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
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventRinging value) ringing,
    required TResult Function(_CallSignalingEventProgress value) progress,
    required TResult Function(_CallSignalingEventAccepted value) accepted,
    required TResult Function(_CallSignalingEventHangup value) hangup,
    required TResult Function(_CallSignalingEventUpdating value) updating,
    required TResult Function(_CallSignalingEventUpdated value) updated,
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventTransferring value)
        transferring,
    required TResult Function(_CallSignalingEventNotifyDialog value)
        notifyDialog,
    required TResult Function(_CallSignalingEventNotifyRefer value) notifyRefer,
    required TResult Function(_CallSignalingEventNotifyUnknown value)
        notifyUnknown,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
  }) {
    final _that = this;
    switch (_that) {
      case _CallSignalingEventIncoming():
        return incoming(_that);
      case _CallSignalingEventRinging():
        return ringing(_that);
      case _CallSignalingEventProgress():
        return progress(_that);
      case _CallSignalingEventAccepted():
        return accepted(_that);
      case _CallSignalingEventHangup():
        return hangup(_that);
      case _CallSignalingEventUpdating():
        return updating(_that);
      case _CallSignalingEventUpdated():
        return updated(_that);
      case _CallSignalingEventTransfer():
        return transfer(_that);
      case _CallSignalingEventTransferring():
        return transferring(_that);
      case _CallSignalingEventNotifyDialog():
        return notifyDialog(_that);
      case _CallSignalingEventNotifyRefer():
        return notifyRefer(_that);
      case _CallSignalingEventNotifyUnknown():
        return notifyUnknown(_that);
      case _CallSignalingEventRegistering():
        return registering(_that);
      case _CallSignalingEventRegistered():
        return registered(_that);
      case _CallSignalingEventRegisterationFailed():
        return registrationFailed(_that);
      case _CallSignalingEventUnregistering():
        return unregistering(_that);
      case _CallSignalingEventUnregistered():
        return unregistered(_that);
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
    TResult? Function(_CallSignalingEventIncoming value)? incoming,
    TResult? Function(_CallSignalingEventRinging value)? ringing,
    TResult? Function(_CallSignalingEventProgress value)? progress,
    TResult? Function(_CallSignalingEventAccepted value)? accepted,
    TResult? Function(_CallSignalingEventHangup value)? hangup,
    TResult? Function(_CallSignalingEventUpdating value)? updating,
    TResult? Function(_CallSignalingEventUpdated value)? updated,
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventTransferring value)? transferring,
    TResult? Function(_CallSignalingEventNotifyDialog value)? notifyDialog,
    TResult? Function(_CallSignalingEventNotifyRefer value)? notifyRefer,
    TResult? Function(_CallSignalingEventNotifyUnknown value)? notifyUnknown,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
  }) {
    final _that = this;
    switch (_that) {
      case _CallSignalingEventIncoming() when incoming != null:
        return incoming(_that);
      case _CallSignalingEventRinging() when ringing != null:
        return ringing(_that);
      case _CallSignalingEventProgress() when progress != null:
        return progress(_that);
      case _CallSignalingEventAccepted() when accepted != null:
        return accepted(_that);
      case _CallSignalingEventHangup() when hangup != null:
        return hangup(_that);
      case _CallSignalingEventUpdating() when updating != null:
        return updating(_that);
      case _CallSignalingEventUpdated() when updated != null:
        return updated(_that);
      case _CallSignalingEventTransfer() when transfer != null:
        return transfer(_that);
      case _CallSignalingEventTransferring() when transferring != null:
        return transferring(_that);
      case _CallSignalingEventNotifyDialog() when notifyDialog != null:
        return notifyDialog(_that);
      case _CallSignalingEventNotifyRefer() when notifyRefer != null:
        return notifyRefer(_that);
      case _CallSignalingEventNotifyUnknown() when notifyUnknown != null:
        return notifyUnknown(_that);
      case _CallSignalingEventRegistering() when registering != null:
        return registering(_that);
      case _CallSignalingEventRegistered() when registered != null:
        return registered(_that);
      case _CallSignalingEventRegisterationFailed()
          when registrationFailed != null:
        return registrationFailed(_that);
      case _CallSignalingEventUnregistering() when unregistering != null:
        return unregistering(_that);
      case _CallSignalingEventUnregistered() when unregistered != null:
        return unregistered(_that);
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
    TResult Function(
            int? line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult Function(int? line, String callId)? ringing,
    TResult Function(int? line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(int? line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int? line, String callId, int code, String reason)? hangup,
    TResult Function(
            int? line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult Function(int? line, String callId)? updated,
    TResult Function(int? line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(int? line, String callId)? transferring,
    TResult Function(
            int? line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            List<UserActiveCall> userActiveCalls)?
        notifyDialog,
    TResult Function(int? line, String callId, String? notify,
            SubscriptionState? subscriptionState, ReferNotifyState state)?
        notifyRefer,
    TResult Function(
            int? line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notifyUnknown,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallSignalingEventIncoming() when incoming != null:
        return incoming(
            _that.line,
            _that.callId,
            _that.callee,
            _that.caller,
            _that.callerDisplayName,
            _that.referredBy,
            _that.replaceCallId,
            _that.isFocus,
            _that.jsep);
      case _CallSignalingEventRinging() when ringing != null:
        return ringing(_that.line, _that.callId);
      case _CallSignalingEventProgress() when progress != null:
        return progress(_that.line, _that.callId, _that.callee, _that.jsep);
      case _CallSignalingEventAccepted() when accepted != null:
        return accepted(_that.line, _that.callId, _that.callee, _that.jsep);
      case _CallSignalingEventHangup() when hangup != null:
        return hangup(_that.line, _that.callId, _that.code, _that.reason);
      case _CallSignalingEventUpdating() when updating != null:
        return updating(
            _that.line,
            _that.callId,
            _that.callee,
            _that.caller,
            _that.callerDisplayName,
            _that.referredBy,
            _that.replaceCallId,
            _that.isFocus,
            _that.jsep);
      case _CallSignalingEventUpdated() when updated != null:
        return updated(_that.line, _that.callId);
      case _CallSignalingEventTransfer() when transfer != null:
        return transfer(_that.line, _that.referId, _that.referTo,
            _that.referredBy, _that.replaceCallId);
      case _CallSignalingEventTransferring() when transferring != null:
        return transferring(_that.line, _that.callId);
      case _CallSignalingEventNotifyDialog() when notifyDialog != null:
        return notifyDialog(_that.line, _that.callId, _that.notify,
            _that.subscriptionState, _that.userActiveCalls);
      case _CallSignalingEventNotifyRefer() when notifyRefer != null:
        return notifyRefer(_that.line, _that.callId, _that.notify,
            _that.subscriptionState, _that.state);
      case _CallSignalingEventNotifyUnknown() when notifyUnknown != null:
        return notifyUnknown(_that.line, _that.callId, _that.notify,
            _that.subscriptionState, _that.contentType, _that.content);
      case _CallSignalingEventRegistering() when registering != null:
        return registering();
      case _CallSignalingEventRegistered() when registered != null:
        return registered();
      case _CallSignalingEventRegisterationFailed()
          when registrationFailed != null:
        return registrationFailed(_that.code, _that.reason);
      case _CallSignalingEventUnregistering() when unregistering != null:
        return unregistering();
      case _CallSignalingEventUnregistered() when unregistered != null:
        return unregistered();
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
    required TResult Function(
            int? line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        incoming,
    required TResult Function(int? line, String callId) ringing,
    required TResult Function(
            int? line, String callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int? line, String callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(int? line, String callId, int code, String reason)
        hangup,
    required TResult Function(
            int? line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        updating,
    required TResult Function(int? line, String callId) updated,
    required TResult Function(int? line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(int? line, String callId) transferring,
    required TResult Function(
            int? line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            List<UserActiveCall> userActiveCalls)
        notifyDialog,
    required TResult Function(int? line, String callId, String? notify,
            SubscriptionState? subscriptionState, ReferNotifyState state)
        notifyRefer,
    required TResult Function(
            int? line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notifyUnknown,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
  }) {
    final _that = this;
    switch (_that) {
      case _CallSignalingEventIncoming():
        return incoming(
            _that.line,
            _that.callId,
            _that.callee,
            _that.caller,
            _that.callerDisplayName,
            _that.referredBy,
            _that.replaceCallId,
            _that.isFocus,
            _that.jsep);
      case _CallSignalingEventRinging():
        return ringing(_that.line, _that.callId);
      case _CallSignalingEventProgress():
        return progress(_that.line, _that.callId, _that.callee, _that.jsep);
      case _CallSignalingEventAccepted():
        return accepted(_that.line, _that.callId, _that.callee, _that.jsep);
      case _CallSignalingEventHangup():
        return hangup(_that.line, _that.callId, _that.code, _that.reason);
      case _CallSignalingEventUpdating():
        return updating(
            _that.line,
            _that.callId,
            _that.callee,
            _that.caller,
            _that.callerDisplayName,
            _that.referredBy,
            _that.replaceCallId,
            _that.isFocus,
            _that.jsep);
      case _CallSignalingEventUpdated():
        return updated(_that.line, _that.callId);
      case _CallSignalingEventTransfer():
        return transfer(_that.line, _that.referId, _that.referTo,
            _that.referredBy, _that.replaceCallId);
      case _CallSignalingEventTransferring():
        return transferring(_that.line, _that.callId);
      case _CallSignalingEventNotifyDialog():
        return notifyDialog(_that.line, _that.callId, _that.notify,
            _that.subscriptionState, _that.userActiveCalls);
      case _CallSignalingEventNotifyRefer():
        return notifyRefer(_that.line, _that.callId, _that.notify,
            _that.subscriptionState, _that.state);
      case _CallSignalingEventNotifyUnknown():
        return notifyUnknown(_that.line, _that.callId, _that.notify,
            _that.subscriptionState, _that.contentType, _that.content);
      case _CallSignalingEventRegistering():
        return registering();
      case _CallSignalingEventRegistered():
        return registered();
      case _CallSignalingEventRegisterationFailed():
        return registrationFailed(_that.code, _that.reason);
      case _CallSignalingEventUnregistering():
        return unregistering();
      case _CallSignalingEventUnregistered():
        return unregistered();
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
    TResult? Function(
            int? line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult? Function(int? line, String callId)? ringing,
    TResult? Function(int? line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(
            int? line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int? line, String callId, int code, String reason)?
        hangup,
    TResult? Function(
            int? line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult? Function(int? line, String callId)? updated,
    TResult? Function(int? line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(int? line, String callId)? transferring,
    TResult? Function(
            int? line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            List<UserActiveCall> userActiveCalls)?
        notifyDialog,
    TResult? Function(int? line, String callId, String? notify,
            SubscriptionState? subscriptionState, ReferNotifyState state)?
        notifyRefer,
    TResult? Function(
            int? line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notifyUnknown,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
  }) {
    final _that = this;
    switch (_that) {
      case _CallSignalingEventIncoming() when incoming != null:
        return incoming(
            _that.line,
            _that.callId,
            _that.callee,
            _that.caller,
            _that.callerDisplayName,
            _that.referredBy,
            _that.replaceCallId,
            _that.isFocus,
            _that.jsep);
      case _CallSignalingEventRinging() when ringing != null:
        return ringing(_that.line, _that.callId);
      case _CallSignalingEventProgress() when progress != null:
        return progress(_that.line, _that.callId, _that.callee, _that.jsep);
      case _CallSignalingEventAccepted() when accepted != null:
        return accepted(_that.line, _that.callId, _that.callee, _that.jsep);
      case _CallSignalingEventHangup() when hangup != null:
        return hangup(_that.line, _that.callId, _that.code, _that.reason);
      case _CallSignalingEventUpdating() when updating != null:
        return updating(
            _that.line,
            _that.callId,
            _that.callee,
            _that.caller,
            _that.callerDisplayName,
            _that.referredBy,
            _that.replaceCallId,
            _that.isFocus,
            _that.jsep);
      case _CallSignalingEventUpdated() when updated != null:
        return updated(_that.line, _that.callId);
      case _CallSignalingEventTransfer() when transfer != null:
        return transfer(_that.line, _that.referId, _that.referTo,
            _that.referredBy, _that.replaceCallId);
      case _CallSignalingEventTransferring() when transferring != null:
        return transferring(_that.line, _that.callId);
      case _CallSignalingEventNotifyDialog() when notifyDialog != null:
        return notifyDialog(_that.line, _that.callId, _that.notify,
            _that.subscriptionState, _that.userActiveCalls);
      case _CallSignalingEventNotifyRefer() when notifyRefer != null:
        return notifyRefer(_that.line, _that.callId, _that.notify,
            _that.subscriptionState, _that.state);
      case _CallSignalingEventNotifyUnknown() when notifyUnknown != null:
        return notifyUnknown(_that.line, _that.callId, _that.notify,
            _that.subscriptionState, _that.contentType, _that.content);
      case _CallSignalingEventRegistering() when registering != null:
        return registering();
      case _CallSignalingEventRegistered() when registered != null:
        return registered();
      case _CallSignalingEventRegisterationFailed()
          when registrationFailed != null:
        return registrationFailed(_that.code, _that.reason);
      case _CallSignalingEventUnregistering() when unregistering != null:
        return unregistering();
      case _CallSignalingEventUnregistered() when unregistered != null:
        return unregistered();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallSignalingEventIncoming
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventIncoming(
      {required this.line,
      required this.callId,
      required this.callee,
      required this.caller,
      this.callerDisplayName,
      this.referredBy,
      this.replaceCallId,
      this.isFocus,
      this.jsep});

  final int? line;
  final String callId;
  final String callee;
  final String caller;
  final String? callerDisplayName;
  final String? referredBy;
  final String? replaceCallId;
  final bool? isFocus;
  final JsepValue? jsep;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.incoming'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('callee', callee))
      ..add(DiagnosticsProperty('caller', caller))
      ..add(DiagnosticsProperty('callerDisplayName', callerDisplayName))
      ..add(DiagnosticsProperty('referredBy', referredBy))
      ..add(DiagnosticsProperty('replaceCallId', replaceCallId))
      ..add(DiagnosticsProperty('isFocus', isFocus))
      ..add(DiagnosticsProperty('jsep', jsep));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventIncoming &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callee, callee) || other.callee == callee) &&
            (identical(other.caller, caller) || other.caller == caller) &&
            (identical(other.callerDisplayName, callerDisplayName) ||
                other.callerDisplayName == callerDisplayName) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy) &&
            (identical(other.replaceCallId, replaceCallId) ||
                other.replaceCallId == replaceCallId) &&
            (identical(other.isFocus, isFocus) || other.isFocus == isFocus) &&
            (identical(other.jsep, jsep) || other.jsep == jsep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, callee, caller,
      callerDisplayName, referredBy, replaceCallId, isFocus, jsep);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.incoming(line: $line, callId: $callId, callee: $callee, caller: $caller, callerDisplayName: $callerDisplayName, referredBy: $referredBy, replaceCallId: $replaceCallId, isFocus: $isFocus, jsep: $jsep)';
  }
}

/// @nodoc

class _CallSignalingEventRinging
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventRinging({required this.line, required this.callId});

  final int? line;
  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.ringing'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventRinging &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.ringing(line: $line, callId: $callId)';
  }
}

/// @nodoc

class _CallSignalingEventProgress
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventProgress(
      {required this.line,
      required this.callId,
      required this.callee,
      this.jsep});

  final int? line;
  final String callId;
  final String callee;
  final JsepValue? jsep;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.progress'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('callee', callee))
      ..add(DiagnosticsProperty('jsep', jsep));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventProgress &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callee, callee) || other.callee == callee) &&
            (identical(other.jsep, jsep) || other.jsep == jsep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, callee, jsep);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.progress(line: $line, callId: $callId, callee: $callee, jsep: $jsep)';
  }
}

/// @nodoc

class _CallSignalingEventAccepted
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventAccepted(
      {required this.line, required this.callId, this.callee, this.jsep});

  final int? line;
  final String callId;
  final String? callee;
  final JsepValue? jsep;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.accepted'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('callee', callee))
      ..add(DiagnosticsProperty('jsep', jsep));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventAccepted &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callee, callee) || other.callee == callee) &&
            (identical(other.jsep, jsep) || other.jsep == jsep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, callee, jsep);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.accepted(line: $line, callId: $callId, callee: $callee, jsep: $jsep)';
  }
}

/// @nodoc

class _CallSignalingEventHangup
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventHangup(
      {required this.line,
      required this.callId,
      required this.code,
      required this.reason});

  final int? line;
  final String callId;
  final int code;
  final String reason;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.hangup'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('reason', reason));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventHangup &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, code, reason);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.hangup(line: $line, callId: $callId, code: $code, reason: $reason)';
  }
}

/// @nodoc

class _CallSignalingEventUpdating
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventUpdating(
      {required this.line,
      required this.callId,
      required this.callee,
      required this.caller,
      this.callerDisplayName,
      this.referredBy,
      this.replaceCallId,
      this.isFocus,
      this.jsep});

  final int? line;
  final String callId;
  final String callee;
  final String caller;
  final String? callerDisplayName;
  final String? referredBy;
  final String? replaceCallId;
  final bool? isFocus;
  final JsepValue? jsep;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.updating'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('callee', callee))
      ..add(DiagnosticsProperty('caller', caller))
      ..add(DiagnosticsProperty('callerDisplayName', callerDisplayName))
      ..add(DiagnosticsProperty('referredBy', referredBy))
      ..add(DiagnosticsProperty('replaceCallId', replaceCallId))
      ..add(DiagnosticsProperty('isFocus', isFocus))
      ..add(DiagnosticsProperty('jsep', jsep));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventUpdating &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callee, callee) || other.callee == callee) &&
            (identical(other.caller, caller) || other.caller == caller) &&
            (identical(other.callerDisplayName, callerDisplayName) ||
                other.callerDisplayName == callerDisplayName) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy) &&
            (identical(other.replaceCallId, replaceCallId) ||
                other.replaceCallId == replaceCallId) &&
            (identical(other.isFocus, isFocus) || other.isFocus == isFocus) &&
            (identical(other.jsep, jsep) || other.jsep == jsep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, callee, caller,
      callerDisplayName, referredBy, replaceCallId, isFocus, jsep);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.updating(line: $line, callId: $callId, callee: $callee, caller: $caller, callerDisplayName: $callerDisplayName, referredBy: $referredBy, replaceCallId: $replaceCallId, isFocus: $isFocus, jsep: $jsep)';
  }
}

/// @nodoc

class _CallSignalingEventUpdated
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventUpdated({required this.line, required this.callId});

  final int? line;
  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.updated'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventUpdated &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.updated(line: $line, callId: $callId)';
  }
}

/// @nodoc

class _CallSignalingEventTransfer
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventTransfer(
      {required this.line,
      required this.referId,
      required this.referTo,
      required this.referredBy,
      required this.replaceCallId});

  final int? line;
  final String referId;
  final String referTo;
  final String? referredBy;
  final String? replaceCallId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.transfer'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('referId', referId))
      ..add(DiagnosticsProperty('referTo', referTo))
      ..add(DiagnosticsProperty('referredBy', referredBy))
      ..add(DiagnosticsProperty('replaceCallId', replaceCallId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventTransfer &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.referId, referId) || other.referId == referId) &&
            (identical(other.referTo, referTo) || other.referTo == referTo) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy) &&
            (identical(other.replaceCallId, replaceCallId) ||
                other.replaceCallId == replaceCallId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, line, referId, referTo, referredBy, replaceCallId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.transfer(line: $line, referId: $referId, referTo: $referTo, referredBy: $referredBy, replaceCallId: $replaceCallId)';
  }
}

/// @nodoc

class _CallSignalingEventTransferring
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventTransferring(
      {required this.line, required this.callId});

  final int? line;
  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.transferring'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventTransferring &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.transferring(line: $line, callId: $callId)';
  }
}

/// @nodoc

class _CallSignalingEventNotifyDialog
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventNotifyDialog(
      {required this.line,
      required this.callId,
      required this.notify,
      required this.subscriptionState,
      required final List<UserActiveCall> userActiveCalls})
      : _userActiveCalls = userActiveCalls;

  final int? line;
  final String callId;
  final String? notify;
  final SubscriptionState? subscriptionState;
  final List<UserActiveCall> _userActiveCalls;
  List<UserActiveCall> get userActiveCalls {
    if (_userActiveCalls is EqualUnmodifiableListView) return _userActiveCalls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userActiveCalls);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.notifyDialog'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('notify', notify))
      ..add(DiagnosticsProperty('subscriptionState', subscriptionState))
      ..add(DiagnosticsProperty('userActiveCalls', userActiveCalls));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventNotifyDialog &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.notify, notify) || other.notify == notify) &&
            (identical(other.subscriptionState, subscriptionState) ||
                other.subscriptionState == subscriptionState) &&
            const DeepCollectionEquality()
                .equals(other._userActiveCalls, _userActiveCalls));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, notify,
      subscriptionState, const DeepCollectionEquality().hash(_userActiveCalls));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.notifyDialog(line: $line, callId: $callId, notify: $notify, subscriptionState: $subscriptionState, userActiveCalls: $userActiveCalls)';
  }
}

/// @nodoc

class _CallSignalingEventNotifyRefer
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventNotifyRefer(
      {required this.line,
      required this.callId,
      required this.notify,
      required this.subscriptionState,
      required this.state});

  final int? line;
  final String callId;
  final String? notify;
  final SubscriptionState? subscriptionState;
  final ReferNotifyState state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.notifyRefer'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('notify', notify))
      ..add(DiagnosticsProperty('subscriptionState', subscriptionState))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventNotifyRefer &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.notify, notify) || other.notify == notify) &&
            (identical(other.subscriptionState, subscriptionState) ||
                other.subscriptionState == subscriptionState) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, line, callId, notify, subscriptionState, state);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.notifyRefer(line: $line, callId: $callId, notify: $notify, subscriptionState: $subscriptionState, state: $state)';
  }
}

/// @nodoc

class _CallSignalingEventNotifyUnknown
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventNotifyUnknown(
      {required this.line,
      required this.callId,
      required this.notify,
      required this.subscriptionState,
      required this.contentType,
      required this.content});

  final int? line;
  final String callId;
  final String? notify;
  final SubscriptionState? subscriptionState;
  final String? contentType;
  final String content;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.notifyUnknown'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('notify', notify))
      ..add(DiagnosticsProperty('subscriptionState', subscriptionState))
      ..add(DiagnosticsProperty('contentType', contentType))
      ..add(DiagnosticsProperty('content', content));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventNotifyUnknown &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.notify, notify) || other.notify == notify) &&
            (identical(other.subscriptionState, subscriptionState) ||
                other.subscriptionState == subscriptionState) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, notify,
      subscriptionState, contentType, content);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.notifyUnknown(line: $line, callId: $callId, notify: $notify, subscriptionState: $subscriptionState, contentType: $contentType, content: $content)';
  }
}

/// @nodoc

class _CallSignalingEventRegistering
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventRegistering();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.registering'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventRegistering);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.registering()';
  }
}

/// @nodoc

class _CallSignalingEventRegistered
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventRegistered();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.registered'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventRegistered);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.registered()';
  }
}

/// @nodoc

class _CallSignalingEventRegisterationFailed
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventRegisterationFailed(this.code, this.reason);

  final int code;
  final String reason;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(
          DiagnosticsProperty('type', '_CallSignalingEvent.registrationFailed'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('reason', reason));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventRegisterationFailed &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, reason);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.registrationFailed(code: $code, reason: $reason)';
  }
}

/// @nodoc

class _CallSignalingEventUnregistering
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventUnregistering();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.unregistering'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventUnregistering);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.unregistering()';
  }
}

/// @nodoc

class _CallSignalingEventUnregistered
    with DiagnosticableTreeMixin
    implements _CallSignalingEvent {
  const _CallSignalingEventUnregistered();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.unregistered'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallSignalingEventUnregistered);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.unregistered()';
  }
}

/// @nodoc
mixin _$CallPushEvent implements DiagnosticableTreeMixin {
  String get callId;
  CallkeepHandle get handle;
  String? get displayName;
  bool get video;
  CallkeepIncomingCallError? get error;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPushEvent'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('video', video))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPushEvent &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, callId, handle, displayName, video, error);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPushEvent(callId: $callId, handle: $handle, displayName: $displayName, video: $video, error: $error)';
  }
}

/// Adds pattern-matching-related methods to [_CallPushEvent].
extension _CallPushEventPatterns on _CallPushEvent {
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
    TResult Function(_CallPushEventIncoming value)? incoming,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallPushEventIncoming() when incoming != null:
        return incoming(_that);
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
    required TResult Function(_CallPushEventIncoming value) incoming,
  }) {
    final _that = this;
    switch (_that) {
      case _CallPushEventIncoming():
        return incoming(_that);
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
    TResult? Function(_CallPushEventIncoming value)? incoming,
  }) {
    final _that = this;
    switch (_that) {
      case _CallPushEventIncoming() when incoming != null:
        return incoming(_that);
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
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video, CallkeepIncomingCallError? error)?
        incoming,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallPushEventIncoming() when incoming != null:
        return incoming(_that.callId, _that.handle, _that.displayName,
            _that.video, _that.error);
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
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video, CallkeepIncomingCallError? error)
        incoming,
  }) {
    final _that = this;
    switch (_that) {
      case _CallPushEventIncoming():
        return incoming(_that.callId, _that.handle, _that.displayName,
            _that.video, _that.error);
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
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video, CallkeepIncomingCallError? error)?
        incoming,
  }) {
    final _that = this;
    switch (_that) {
      case _CallPushEventIncoming() when incoming != null:
        return incoming(_that.callId, _that.handle, _that.displayName,
            _that.video, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallPushEventIncoming
    with DiagnosticableTreeMixin
    implements _CallPushEvent {
  const _CallPushEventIncoming(
      {required this.callId,
      required this.handle,
      this.displayName,
      required this.video,
      this.error});

  @override
  final String callId;
  @override
  final CallkeepHandle handle;
  @override
  final String? displayName;
  @override
  final bool video;
  @override
  final CallkeepIncomingCallError? error;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPushEvent.incoming'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('video', video))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPushEventIncoming &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, callId, handle, displayName, video, error);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPushEvent.incoming(callId: $callId, handle: $handle, displayName: $displayName, video: $video, error: $error)';
  }
}

/// @nodoc
mixin _$CallControlEvent implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'CallControlEvent'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CallControlEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent()';
  }
}

/// Adds pattern-matching-related methods to [CallControlEvent].
extension CallControlEventPatterns on CallControlEvent {
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
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventAudioDeviceSet value)? audioDeviceSet,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallControlEventStarted() when started != null:
        return started(_that);
      case _CallControlEventAnswered() when answered != null:
        return answered(_that);
      case _CallControlEventEnded() when ended != null:
        return ended(_that);
      case _CallControlEventSetHeld() when setHeld != null:
        return setHeld(_that);
      case _CallControlEventSetMuted() when setMuted != null:
        return setMuted(_that);
      case _CallControlEventSentDTMF() when sentDTMF != null:
        return sentDTMF(_that);
      case _CallControlEventCameraSwitched() when cameraSwitched != null:
        return cameraSwitched(_that);
      case _CallControlEventCameraEnabled() when cameraEnabled != null:
        return cameraEnabled(_that);
      case _CallControlEventAudioDeviceSet() when audioDeviceSet != null:
        return audioDeviceSet(_that);
      case _CallControlEventFailureApproved() when failureApproved != null:
        return failureApproved(_that);
      case _CallControlEventBlindTransferInitiated()
          when blindTransferInitiated != null:
        return blindTransferInitiated(_that);
      case _CallControlEventAttendedTransferInitiated()
          when attendedTransferInitiated != null:
        return attendedTransferInitiated(_that);
      case _CallControlEventBlindTransferSubmitted()
          when blindTransferSubmitted != null:
        return blindTransferSubmitted(_that);
      case _CallControlEventAttendedTransferSubmitted()
          when attendedTransferSubmitted != null:
        return attendedTransferSubmitted(_that);
      case _CallControlEventAttendedRequestDeclined()
          when attendedRequestDeclined != null:
        return attendedRequestDeclined(_that);
      case _CallControlEventAttendedRequestApproved()
          when attendedRequestApproved != null:
        return attendedRequestApproved(_that);
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
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventAudioDeviceSet value)
        audioDeviceSet,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
  }) {
    final _that = this;
    switch (_that) {
      case _CallControlEventStarted():
        return started(_that);
      case _CallControlEventAnswered():
        return answered(_that);
      case _CallControlEventEnded():
        return ended(_that);
      case _CallControlEventSetHeld():
        return setHeld(_that);
      case _CallControlEventSetMuted():
        return setMuted(_that);
      case _CallControlEventSentDTMF():
        return sentDTMF(_that);
      case _CallControlEventCameraSwitched():
        return cameraSwitched(_that);
      case _CallControlEventCameraEnabled():
        return cameraEnabled(_that);
      case _CallControlEventAudioDeviceSet():
        return audioDeviceSet(_that);
      case _CallControlEventFailureApproved():
        return failureApproved(_that);
      case _CallControlEventBlindTransferInitiated():
        return blindTransferInitiated(_that);
      case _CallControlEventAttendedTransferInitiated():
        return attendedTransferInitiated(_that);
      case _CallControlEventBlindTransferSubmitted():
        return blindTransferSubmitted(_that);
      case _CallControlEventAttendedTransferSubmitted():
        return attendedTransferSubmitted(_that);
      case _CallControlEventAttendedRequestDeclined():
        return attendedRequestDeclined(_that);
      case _CallControlEventAttendedRequestApproved():
        return attendedRequestApproved(_that);
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
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventAudioDeviceSet value)? audioDeviceSet,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
  }) {
    final _that = this;
    switch (_that) {
      case _CallControlEventStarted() when started != null:
        return started(_that);
      case _CallControlEventAnswered() when answered != null:
        return answered(_that);
      case _CallControlEventEnded() when ended != null:
        return ended(_that);
      case _CallControlEventSetHeld() when setHeld != null:
        return setHeld(_that);
      case _CallControlEventSetMuted() when setMuted != null:
        return setMuted(_that);
      case _CallControlEventSentDTMF() when sentDTMF != null:
        return sentDTMF(_that);
      case _CallControlEventCameraSwitched() when cameraSwitched != null:
        return cameraSwitched(_that);
      case _CallControlEventCameraEnabled() when cameraEnabled != null:
        return cameraEnabled(_that);
      case _CallControlEventAudioDeviceSet() when audioDeviceSet != null:
        return audioDeviceSet(_that);
      case _CallControlEventFailureApproved() when failureApproved != null:
        return failureApproved(_that);
      case _CallControlEventBlindTransferInitiated()
          when blindTransferInitiated != null:
        return blindTransferInitiated(_that);
      case _CallControlEventAttendedTransferInitiated()
          when attendedTransferInitiated != null:
        return attendedTransferInitiated(_that);
      case _CallControlEventBlindTransferSubmitted()
          when blindTransferSubmitted != null:
        return blindTransferSubmitted(_that);
      case _CallControlEventAttendedTransferSubmitted()
          when attendedTransferSubmitted != null:
        return attendedTransferSubmitted(_that);
      case _CallControlEventAttendedRequestDeclined()
          when attendedRequestDeclined != null:
        return attendedRequestDeclined(_that);
      case _CallControlEventAttendedRequestApproved()
          when attendedRequestApproved != null:
        return attendedRequestApproved(_that);
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
    TResult Function(
            int? line,
            String? generic,
            String? number,
            String? email,
            String? displayName,
            String? replaces,
            String? fromNumber,
            bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, CallAudioDevice device)? audioDeviceSet,
    TResult Function(String callId)? failureApproved,
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallControlEventStarted() when started != null:
        return started(_that.line, _that.generic, _that.number, _that.email,
            _that.displayName, _that.replaces, _that.fromNumber, _that.video);
      case _CallControlEventAnswered() when answered != null:
        return answered(_that.callId);
      case _CallControlEventEnded() when ended != null:
        return ended(_that.callId);
      case _CallControlEventSetHeld() when setHeld != null:
        return setHeld(_that.callId, _that.onHold);
      case _CallControlEventSetMuted() when setMuted != null:
        return setMuted(_that.callId, _that.muted);
      case _CallControlEventSentDTMF() when sentDTMF != null:
        return sentDTMF(_that.callId, _that.key);
      case _CallControlEventCameraSwitched() when cameraSwitched != null:
        return cameraSwitched(_that.callId);
      case _CallControlEventCameraEnabled() when cameraEnabled != null:
        return cameraEnabled(_that.callId, _that.enabled);
      case _CallControlEventAudioDeviceSet() when audioDeviceSet != null:
        return audioDeviceSet(_that.callId, _that.device);
      case _CallControlEventFailureApproved() when failureApproved != null:
        return failureApproved(_that.callId);
      case _CallControlEventBlindTransferInitiated()
          when blindTransferInitiated != null:
        return blindTransferInitiated(_that.callId);
      case _CallControlEventAttendedTransferInitiated()
          when attendedTransferInitiated != null:
        return attendedTransferInitiated(_that.callId);
      case _CallControlEventBlindTransferSubmitted()
          when blindTransferSubmitted != null:
        return blindTransferSubmitted(_that.number);
      case _CallControlEventAttendedTransferSubmitted()
          when attendedTransferSubmitted != null:
        return attendedTransferSubmitted(_that.referorCall, _that.replaceCall);
      case _CallControlEventAttendedRequestDeclined()
          when attendedRequestDeclined != null:
        return attendedRequestDeclined(_that.callId, _that.referId);
      case _CallControlEventAttendedRequestApproved()
          when attendedRequestApproved != null:
        return attendedRequestApproved(_that.referId, _that.referTo);
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
    required TResult Function(
            int? line,
            String? generic,
            String? number,
            String? email,
            String? displayName,
            String? replaces,
            String? fromNumber,
            bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, CallAudioDevice device)
        audioDeviceSet,
    required TResult Function(String callId) failureApproved,
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
  }) {
    final _that = this;
    switch (_that) {
      case _CallControlEventStarted():
        return started(_that.line, _that.generic, _that.number, _that.email,
            _that.displayName, _that.replaces, _that.fromNumber, _that.video);
      case _CallControlEventAnswered():
        return answered(_that.callId);
      case _CallControlEventEnded():
        return ended(_that.callId);
      case _CallControlEventSetHeld():
        return setHeld(_that.callId, _that.onHold);
      case _CallControlEventSetMuted():
        return setMuted(_that.callId, _that.muted);
      case _CallControlEventSentDTMF():
        return sentDTMF(_that.callId, _that.key);
      case _CallControlEventCameraSwitched():
        return cameraSwitched(_that.callId);
      case _CallControlEventCameraEnabled():
        return cameraEnabled(_that.callId, _that.enabled);
      case _CallControlEventAudioDeviceSet():
        return audioDeviceSet(_that.callId, _that.device);
      case _CallControlEventFailureApproved():
        return failureApproved(_that.callId);
      case _CallControlEventBlindTransferInitiated():
        return blindTransferInitiated(_that.callId);
      case _CallControlEventAttendedTransferInitiated():
        return attendedTransferInitiated(_that.callId);
      case _CallControlEventBlindTransferSubmitted():
        return blindTransferSubmitted(_that.number);
      case _CallControlEventAttendedTransferSubmitted():
        return attendedTransferSubmitted(_that.referorCall, _that.replaceCall);
      case _CallControlEventAttendedRequestDeclined():
        return attendedRequestDeclined(_that.callId, _that.referId);
      case _CallControlEventAttendedRequestApproved():
        return attendedRequestApproved(_that.referId, _that.referTo);
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
    TResult? Function(
            int? line,
            String? generic,
            String? number,
            String? email,
            String? displayName,
            String? replaces,
            String? fromNumber,
            bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, CallAudioDevice device)? audioDeviceSet,
    TResult? Function(String callId)? failureApproved,
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
  }) {
    final _that = this;
    switch (_that) {
      case _CallControlEventStarted() when started != null:
        return started(_that.line, _that.generic, _that.number, _that.email,
            _that.displayName, _that.replaces, _that.fromNumber, _that.video);
      case _CallControlEventAnswered() when answered != null:
        return answered(_that.callId);
      case _CallControlEventEnded() when ended != null:
        return ended(_that.callId);
      case _CallControlEventSetHeld() when setHeld != null:
        return setHeld(_that.callId, _that.onHold);
      case _CallControlEventSetMuted() when setMuted != null:
        return setMuted(_that.callId, _that.muted);
      case _CallControlEventSentDTMF() when sentDTMF != null:
        return sentDTMF(_that.callId, _that.key);
      case _CallControlEventCameraSwitched() when cameraSwitched != null:
        return cameraSwitched(_that.callId);
      case _CallControlEventCameraEnabled() when cameraEnabled != null:
        return cameraEnabled(_that.callId, _that.enabled);
      case _CallControlEventAudioDeviceSet() when audioDeviceSet != null:
        return audioDeviceSet(_that.callId, _that.device);
      case _CallControlEventFailureApproved() when failureApproved != null:
        return failureApproved(_that.callId);
      case _CallControlEventBlindTransferInitiated()
          when blindTransferInitiated != null:
        return blindTransferInitiated(_that.callId);
      case _CallControlEventAttendedTransferInitiated()
          when attendedTransferInitiated != null:
        return attendedTransferInitiated(_that.callId);
      case _CallControlEventBlindTransferSubmitted()
          when blindTransferSubmitted != null:
        return blindTransferSubmitted(_that.number);
      case _CallControlEventAttendedTransferSubmitted()
          when attendedTransferSubmitted != null:
        return attendedTransferSubmitted(_that.referorCall, _that.replaceCall);
      case _CallControlEventAttendedRequestDeclined()
          when attendedRequestDeclined != null:
        return attendedRequestDeclined(_that.callId, _that.referId);
      case _CallControlEventAttendedRequestApproved()
          when attendedRequestApproved != null:
        return attendedRequestApproved(_that.referId, _that.referTo);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallControlEventStarted
    with DiagnosticableTreeMixin, CallControlEventStartedMixin
    implements CallControlEvent {
  const _CallControlEventStarted(
      {this.line,
      this.generic,
      this.number,
      this.email,
      this.displayName,
      this.replaces,
      this.fromNumber,
      required this.video})
      : assert(!(generic == null && number == null && email == null),
            'one of generic, number or email parameters must be assign'),
        assert(
            (generic != null && number == null && email == null) ||
                (generic == null && number != null && email == null) ||
                (generic == null && number == null && email != null),
            'only one of generic, number or email parameters must be assign');

  final int? line;
  final String? generic;
  final String? number;
  final String? email;
  final String? displayName;
  final String? replaces;
  final String? fromNumber;
  final bool video;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.started'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('generic', generic))
      ..add(DiagnosticsProperty('number', number))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('replaces', replaces))
      ..add(DiagnosticsProperty('fromNumber', fromNumber))
      ..add(DiagnosticsProperty('video', video));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventStarted &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.generic, generic) || other.generic == generic) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.replaces, replaces) ||
                other.replaces == replaces) &&
            (identical(other.fromNumber, fromNumber) ||
                other.fromNumber == fromNumber) &&
            (identical(other.video, video) || other.video == video));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, generic, number, email,
      displayName, replaces, fromNumber, video);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.started(line: $line, generic: $generic, number: $number, email: $email, displayName: $displayName, replaces: $replaces, fromNumber: $fromNumber, video: $video)';
  }
}

/// @nodoc

class _CallControlEventAnswered
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventAnswered(this.callId);

  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.answered'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventAnswered &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.answered(callId: $callId)';
  }
}

/// @nodoc

class _CallControlEventEnded
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventEnded(this.callId);

  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.ended'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventEnded &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.ended(callId: $callId)';
  }
}

/// @nodoc

class _CallControlEventSetHeld
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventSetHeld(this.callId, this.onHold);

  final String callId;
  final bool onHold;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.setHeld'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('onHold', onHold));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventSetHeld &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.onHold, onHold) || other.onHold == onHold));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, onHold);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.setHeld(callId: $callId, onHold: $onHold)';
  }
}

/// @nodoc

class _CallControlEventSetMuted
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventSetMuted(this.callId, this.muted);

  final String callId;
  final bool muted;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.setMuted'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('muted', muted));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventSetMuted &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.muted, muted) || other.muted == muted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, muted);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.setMuted(callId: $callId, muted: $muted)';
  }
}

/// @nodoc

class _CallControlEventSentDTMF
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventSentDTMF(this.callId, this.key);

  final String callId;
  final String key;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.sentDTMF'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('key', key));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventSentDTMF &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, key);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.sentDTMF(callId: $callId, key: $key)';
  }
}

/// @nodoc

class _CallControlEventCameraSwitched
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventCameraSwitched(this.callId);

  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.cameraSwitched'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventCameraSwitched &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.cameraSwitched(callId: $callId)';
  }
}

/// @nodoc

class _CallControlEventCameraEnabled
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventCameraEnabled(this.callId, this.enabled);

  final String callId;
  final bool enabled;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.cameraEnabled'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventCameraEnabled &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, enabled);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.cameraEnabled(callId: $callId, enabled: $enabled)';
  }
}

/// @nodoc

class _CallControlEventAudioDeviceSet
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventAudioDeviceSet(this.callId, this.device);

  final String callId;
  final CallAudioDevice device;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.audioDeviceSet'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('device', device));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventAudioDeviceSet &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.device, device) || other.device == device));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, device);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.audioDeviceSet(callId: $callId, device: $device)';
  }
}

/// @nodoc

class _CallControlEventFailureApproved
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventFailureApproved(this.callId);

  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.failureApproved'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventFailureApproved &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.failureApproved(callId: $callId)';
  }
}

/// @nodoc

class _CallControlEventBlindTransferInitiated
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventBlindTransferInitiated(this.callId);

  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.blindTransferInitiated'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventBlindTransferInitiated &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.blindTransferInitiated(callId: $callId)';
  }
}

/// @nodoc

class _CallControlEventAttendedTransferInitiated
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventAttendedTransferInitiated(this.callId);

  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.attendedTransferInitiated'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventAttendedTransferInitiated &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.attendedTransferInitiated(callId: $callId)';
  }
}

/// @nodoc

class _CallControlEventBlindTransferSubmitted
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventBlindTransferSubmitted({required this.number});

  final String number;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.blindTransferSubmitted'))
      ..add(DiagnosticsProperty('number', number));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventBlindTransferSubmitted &&
            (identical(other.number, number) || other.number == number));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.blindTransferSubmitted(number: $number)';
  }
}

/// @nodoc

class _CallControlEventAttendedTransferSubmitted
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventAttendedTransferSubmitted(
      {required this.referorCall, required this.replaceCall});

  final ActiveCall referorCall;
  final ActiveCall replaceCall;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.attendedTransferSubmitted'))
      ..add(DiagnosticsProperty('referorCall', referorCall))
      ..add(DiagnosticsProperty('replaceCall', replaceCall));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventAttendedTransferSubmitted &&
            (identical(other.referorCall, referorCall) ||
                other.referorCall == referorCall) &&
            (identical(other.replaceCall, replaceCall) ||
                other.replaceCall == replaceCall));
  }

  @override
  int get hashCode => Object.hash(runtimeType, referorCall, replaceCall);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.attendedTransferSubmitted(referorCall: $referorCall, replaceCall: $replaceCall)';
  }
}

/// @nodoc

class _CallControlEventAttendedRequestDeclined
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventAttendedRequestDeclined(
      {required this.callId, required this.referId});

  final String callId;
  final String referId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.attendedRequestDeclined'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('referId', referId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventAttendedRequestDeclined &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.referId, referId) || other.referId == referId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, referId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.attendedRequestDeclined(callId: $callId, referId: $referId)';
  }
}

/// @nodoc

class _CallControlEventAttendedRequestApproved
    with DiagnosticableTreeMixin
    implements CallControlEvent {
  const _CallControlEventAttendedRequestApproved(
      {required this.referId, required this.referTo});

  final String referId;
  final String referTo;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.attendedRequestApproved'))
      ..add(DiagnosticsProperty('referId', referId))
      ..add(DiagnosticsProperty('referTo', referTo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallControlEventAttendedRequestApproved &&
            (identical(other.referId, referId) || other.referId == referId) &&
            (identical(other.referTo, referTo) || other.referTo == referTo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, referId, referTo);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.attendedRequestApproved(referId: $referId, referTo: $referTo)';
  }
}

/// @nodoc
mixin _$CallPerformEvent implements DiagnosticableTreeMixin {
  dynamic get _performCompleter;
  String get callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent'))
      ..add(DiagnosticsProperty('_performCompleter', _performCompleter))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPerformEvent &&
            const DeepCollectionEquality()
                .equals(other._performCompleter, _performCompleter) &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_performCompleter), callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent(_performCompleter: $_performCompleter, callId: $callId)';
  }
}

/// Adds pattern-matching-related methods to [_CallPerformEvent].
extension _CallPerformEventPatterns on _CallPerformEvent {
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
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
    TResult Function(_CallPerformEventAudioDeviceSet value)? audioDeviceSet,
    TResult Function(_CallPerformEventAudioDevicesUpdate value)?
        audioDevicesUpdate,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallPerformEventStarted() when started != null:
        return started(_that);
      case _CallPerformEventAnswered() when answered != null:
        return answered(_that);
      case _CallPerformEventEnded() when ended != null:
        return ended(_that);
      case _CallPerformEventSetHeld() when setHeld != null:
        return setHeld(_that);
      case _CallPerformEventSetMuted() when setMuted != null:
        return setMuted(_that);
      case _CallPerformEventSentDTMF() when sentDTMF != null:
        return sentDTMF(_that);
      case _CallPerformEventAudioDeviceSet() when audioDeviceSet != null:
        return audioDeviceSet(_that);
      case _CallPerformEventAudioDevicesUpdate()
          when audioDevicesUpdate != null:
        return audioDevicesUpdate(_that);
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
    required TResult Function(_CallPerformEventStarted value) started,
    required TResult Function(_CallPerformEventAnswered value) answered,
    required TResult Function(_CallPerformEventEnded value) ended,
    required TResult Function(_CallPerformEventSetHeld value) setHeld,
    required TResult Function(_CallPerformEventSetMuted value) setMuted,
    required TResult Function(_CallPerformEventSentDTMF value) sentDTMF,
    required TResult Function(_CallPerformEventAudioDeviceSet value)
        audioDeviceSet,
    required TResult Function(_CallPerformEventAudioDevicesUpdate value)
        audioDevicesUpdate,
  }) {
    final _that = this;
    switch (_that) {
      case _CallPerformEventStarted():
        return started(_that);
      case _CallPerformEventAnswered():
        return answered(_that);
      case _CallPerformEventEnded():
        return ended(_that);
      case _CallPerformEventSetHeld():
        return setHeld(_that);
      case _CallPerformEventSetMuted():
        return setMuted(_that);
      case _CallPerformEventSentDTMF():
        return sentDTMF(_that);
      case _CallPerformEventAudioDeviceSet():
        return audioDeviceSet(_that);
      case _CallPerformEventAudioDevicesUpdate():
        return audioDevicesUpdate(_that);
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
    TResult? Function(_CallPerformEventStarted value)? started,
    TResult? Function(_CallPerformEventAnswered value)? answered,
    TResult? Function(_CallPerformEventEnded value)? ended,
    TResult? Function(_CallPerformEventSetHeld value)? setHeld,
    TResult? Function(_CallPerformEventSetMuted value)? setMuted,
    TResult? Function(_CallPerformEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallPerformEventAudioDeviceSet value)? audioDeviceSet,
    TResult? Function(_CallPerformEventAudioDevicesUpdate value)?
        audioDevicesUpdate,
  }) {
    final _that = this;
    switch (_that) {
      case _CallPerformEventStarted() when started != null:
        return started(_that);
      case _CallPerformEventAnswered() when answered != null:
        return answered(_that);
      case _CallPerformEventEnded() when ended != null:
        return ended(_that);
      case _CallPerformEventSetHeld() when setHeld != null:
        return setHeld(_that);
      case _CallPerformEventSetMuted() when setMuted != null:
        return setMuted(_that);
      case _CallPerformEventSentDTMF() when sentDTMF != null:
        return sentDTMF(_that);
      case _CallPerformEventAudioDeviceSet() when audioDeviceSet != null:
        return audioDeviceSet(_that);
      case _CallPerformEventAudioDevicesUpdate()
          when audioDevicesUpdate != null:
        return audioDevicesUpdate(_that);
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
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId, CallAudioDevice device)? audioDeviceSet,
    TResult Function(String callId, List<CallAudioDevice> devices)?
        audioDevicesUpdate,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallPerformEventStarted() when started != null:
        return started(
            _that.callId, _that.handle, _that.displayName, _that.video);
      case _CallPerformEventAnswered() when answered != null:
        return answered(_that.callId);
      case _CallPerformEventEnded() when ended != null:
        return ended(_that.callId);
      case _CallPerformEventSetHeld() when setHeld != null:
        return setHeld(_that.callId, _that.onHold);
      case _CallPerformEventSetMuted() when setMuted != null:
        return setMuted(_that.callId, _that.muted);
      case _CallPerformEventSentDTMF() when sentDTMF != null:
        return sentDTMF(_that.callId, _that.key);
      case _CallPerformEventAudioDeviceSet() when audioDeviceSet != null:
        return audioDeviceSet(_that.callId, _that.device);
      case _CallPerformEventAudioDevicesUpdate()
          when audioDevicesUpdate != null:
        return audioDevicesUpdate(_that.callId, _that.devices);
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
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId, CallAudioDevice device)
        audioDeviceSet,
    required TResult Function(String callId, List<CallAudioDevice> devices)
        audioDevicesUpdate,
  }) {
    final _that = this;
    switch (_that) {
      case _CallPerformEventStarted():
        return started(
            _that.callId, _that.handle, _that.displayName, _that.video);
      case _CallPerformEventAnswered():
        return answered(_that.callId);
      case _CallPerformEventEnded():
        return ended(_that.callId);
      case _CallPerformEventSetHeld():
        return setHeld(_that.callId, _that.onHold);
      case _CallPerformEventSetMuted():
        return setMuted(_that.callId, _that.muted);
      case _CallPerformEventSentDTMF():
        return sentDTMF(_that.callId, _that.key);
      case _CallPerformEventAudioDeviceSet():
        return audioDeviceSet(_that.callId, _that.device);
      case _CallPerformEventAudioDevicesUpdate():
        return audioDevicesUpdate(_that.callId, _that.devices);
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
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId, CallAudioDevice device)? audioDeviceSet,
    TResult? Function(String callId, List<CallAudioDevice> devices)?
        audioDevicesUpdate,
  }) {
    final _that = this;
    switch (_that) {
      case _CallPerformEventStarted() when started != null:
        return started(
            _that.callId, _that.handle, _that.displayName, _that.video);
      case _CallPerformEventAnswered() when answered != null:
        return answered(_that.callId);
      case _CallPerformEventEnded() when ended != null:
        return ended(_that.callId);
      case _CallPerformEventSetHeld() when setHeld != null:
        return setHeld(_that.callId, _that.onHold);
      case _CallPerformEventSetMuted() when setMuted != null:
        return setMuted(_that.callId, _that.muted);
      case _CallPerformEventSentDTMF() when sentDTMF != null:
        return sentDTMF(_that.callId, _that.key);
      case _CallPerformEventAudioDeviceSet() when audioDeviceSet != null:
        return audioDeviceSet(_that.callId, _that.device);
      case _CallPerformEventAudioDevicesUpdate()
          when audioDevicesUpdate != null:
        return audioDevicesUpdate(_that.callId, _that.devices);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallPerformEventStarted extends _CallPerformEvent
    with DiagnosticableTreeMixin {
  _CallPerformEventStarted(this.callId,
      {required this.handle, this.displayName, required this.video})
      : super._();

  @override
  final String callId;
  final CallkeepHandle handle;
  final String? displayName;
  final bool video;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.started'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('video', video));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPerformEventStarted &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.video, video) || other.video == video));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, callId, handle, displayName, video);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.started(callId: $callId, handle: $handle, displayName: $displayName, video: $video)';
  }
}

/// @nodoc

class _CallPerformEventAnswered extends _CallPerformEvent
    with DiagnosticableTreeMixin {
  _CallPerformEventAnswered(this.callId) : super._();

  @override
  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.answered'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPerformEventAnswered &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.answered(callId: $callId)';
  }
}

/// @nodoc

class _CallPerformEventEnded extends _CallPerformEvent
    with DiagnosticableTreeMixin {
  _CallPerformEventEnded(this.callId) : super._();

  @override
  final String callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.ended'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPerformEventEnded &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.ended(callId: $callId)';
  }
}

/// @nodoc

class _CallPerformEventSetHeld extends _CallPerformEvent
    with DiagnosticableTreeMixin {
  _CallPerformEventSetHeld(this.callId, this.onHold) : super._();

  @override
  final String callId;
  final bool onHold;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.setHeld'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('onHold', onHold));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPerformEventSetHeld &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.onHold, onHold) || other.onHold == onHold));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, onHold);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.setHeld(callId: $callId, onHold: $onHold)';
  }
}

/// @nodoc

class _CallPerformEventSetMuted extends _CallPerformEvent
    with DiagnosticableTreeMixin {
  _CallPerformEventSetMuted(this.callId, this.muted) : super._();

  @override
  final String callId;
  final bool muted;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.setMuted'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('muted', muted));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPerformEventSetMuted &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.muted, muted) || other.muted == muted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, muted);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.setMuted(callId: $callId, muted: $muted)';
  }
}

/// @nodoc

class _CallPerformEventSentDTMF extends _CallPerformEvent
    with DiagnosticableTreeMixin {
  _CallPerformEventSentDTMF(this.callId, this.key) : super._();

  @override
  final String callId;
  final String key;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.sentDTMF'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('key', key));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPerformEventSentDTMF &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, key);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.sentDTMF(callId: $callId, key: $key)';
  }
}

/// @nodoc

class _CallPerformEventAudioDeviceSet extends _CallPerformEvent
    with DiagnosticableTreeMixin {
  _CallPerformEventAudioDeviceSet(this.callId, this.device) : super._();

  @override
  final String callId;
  final CallAudioDevice device;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.audioDeviceSet'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('device', device));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPerformEventAudioDeviceSet &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.device, device) || other.device == device));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, device);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.audioDeviceSet(callId: $callId, device: $device)';
  }
}

/// @nodoc

class _CallPerformEventAudioDevicesUpdate extends _CallPerformEvent
    with DiagnosticableTreeMixin {
  _CallPerformEventAudioDevicesUpdate(
      this.callId, final List<CallAudioDevice> devices)
      : _devices = devices,
        super._();

  @override
  final String callId;
  final List<CallAudioDevice> _devices;
  List<CallAudioDevice> get devices {
    if (_devices is EqualUnmodifiableListView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.audioDevicesUpdate'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('devices', devices));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallPerformEventAudioDevicesUpdate &&
            (identical(other.callId, callId) || other.callId == callId) &&
            const DeepCollectionEquality().equals(other._devices, _devices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, callId, const DeepCollectionEquality().hash(_devices));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.audioDevicesUpdate(callId: $callId, devices: $devices)';
  }
}

/// @nodoc
mixin _$PeerConnectionEvent implements DiagnosticableTreeMixin {
  String get callId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_PeerConnectionEvent'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PeerConnectionEvent &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent(callId: $callId)';
  }
}

/// Adds pattern-matching-related methods to [_PeerConnectionEvent].
extension _PeerConnectionEventPatterns on _PeerConnectionEvent {
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
    TResult Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PeerConnectionEventSignalingStateChanged()
          when signalingStateChanged != null:
        return signalingStateChanged(_that);
      case _PeerConnectionEventConnectionStateChanged()
          when connectionStateChanged != null:
        return connectionStateChanged(_that);
      case _PeerConnectionEventIceGatheringStateChanged()
          when iceGatheringStateChanged != null:
        return iceGatheringStateChanged(_that);
      case _PeerConnectionEventIceConnectionStateChanged()
          when iceConnectionStateChanged != null:
        return iceConnectionStateChanged(_that);
      case _PeerConnectionEventIceCandidateIdentified()
          when iceCandidateIdentified != null:
        return iceCandidateIdentified(_that);
      case _PeerConnectionEventStreamAdded() when streamAdded != null:
        return streamAdded(_that);
      case _PeerConnectionEventStreamRemoved() when streamRemoved != null:
        return streamRemoved(_that);
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
    required TResult Function(_PeerConnectionEventSignalingStateChanged value)
        signalingStateChanged,
    required TResult Function(_PeerConnectionEventConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
    required TResult Function(
            _PeerConnectionEventIceConnectionStateChanged value)
        iceConnectionStateChanged,
    required TResult Function(_PeerConnectionEventIceCandidateIdentified value)
        iceCandidateIdentified,
    required TResult Function(_PeerConnectionEventStreamAdded value)
        streamAdded,
    required TResult Function(_PeerConnectionEventStreamRemoved value)
        streamRemoved,
  }) {
    final _that = this;
    switch (_that) {
      case _PeerConnectionEventSignalingStateChanged():
        return signalingStateChanged(_that);
      case _PeerConnectionEventConnectionStateChanged():
        return connectionStateChanged(_that);
      case _PeerConnectionEventIceGatheringStateChanged():
        return iceGatheringStateChanged(_that);
      case _PeerConnectionEventIceConnectionStateChanged():
        return iceConnectionStateChanged(_that);
      case _PeerConnectionEventIceCandidateIdentified():
        return iceCandidateIdentified(_that);
      case _PeerConnectionEventStreamAdded():
        return streamAdded(_that);
      case _PeerConnectionEventStreamRemoved():
        return streamRemoved(_that);
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
    TResult? Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult? Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult? Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult? Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult? Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult? Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
  }) {
    final _that = this;
    switch (_that) {
      case _PeerConnectionEventSignalingStateChanged()
          when signalingStateChanged != null:
        return signalingStateChanged(_that);
      case _PeerConnectionEventConnectionStateChanged()
          when connectionStateChanged != null:
        return connectionStateChanged(_that);
      case _PeerConnectionEventIceGatheringStateChanged()
          when iceGatheringStateChanged != null:
        return iceGatheringStateChanged(_that);
      case _PeerConnectionEventIceConnectionStateChanged()
          when iceConnectionStateChanged != null:
        return iceConnectionStateChanged(_that);
      case _PeerConnectionEventIceCandidateIdentified()
          when iceCandidateIdentified != null:
        return iceCandidateIdentified(_that);
      case _PeerConnectionEventStreamAdded() when streamAdded != null:
        return streamAdded(_that);
      case _PeerConnectionEventStreamRemoved() when streamRemoved != null:
        return streamRemoved(_that);
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
    TResult Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(String callId, MediaStream stream)? streamAdded,
    TResult Function(String callId, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PeerConnectionEventSignalingStateChanged()
          when signalingStateChanged != null:
        return signalingStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventConnectionStateChanged()
          when connectionStateChanged != null:
        return connectionStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventIceGatheringStateChanged()
          when iceGatheringStateChanged != null:
        return iceGatheringStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventIceConnectionStateChanged()
          when iceConnectionStateChanged != null:
        return iceConnectionStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventIceCandidateIdentified()
          when iceCandidateIdentified != null:
        return iceCandidateIdentified(_that.callId, _that.candidate);
      case _PeerConnectionEventStreamAdded() when streamAdded != null:
        return streamAdded(_that.callId, _that.stream);
      case _PeerConnectionEventStreamRemoved() when streamRemoved != null:
        return streamRemoved(_that.callId, _that.stream);
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
    required TResult Function(String callId, RTCSignalingState state)
        signalingStateChanged,
    required TResult Function(String callId, RTCPeerConnectionState state)
        connectionStateChanged,
    required TResult Function(String callId, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(String callId, RTCIceConnectionState state)
        iceConnectionStateChanged,
    required TResult Function(String callId, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(String callId, MediaStream stream) streamAdded,
    required TResult Function(String callId, MediaStream stream) streamRemoved,
  }) {
    final _that = this;
    switch (_that) {
      case _PeerConnectionEventSignalingStateChanged():
        return signalingStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventConnectionStateChanged():
        return connectionStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventIceGatheringStateChanged():
        return iceGatheringStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventIceConnectionStateChanged():
        return iceConnectionStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventIceCandidateIdentified():
        return iceCandidateIdentified(_that.callId, _that.candidate);
      case _PeerConnectionEventStreamAdded():
        return streamAdded(_that.callId, _that.stream);
      case _PeerConnectionEventStreamRemoved():
        return streamRemoved(_that.callId, _that.stream);
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
    TResult? Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult? Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult? Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult? Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(String callId, MediaStream stream)? streamAdded,
    TResult? Function(String callId, MediaStream stream)? streamRemoved,
  }) {
    final _that = this;
    switch (_that) {
      case _PeerConnectionEventSignalingStateChanged()
          when signalingStateChanged != null:
        return signalingStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventConnectionStateChanged()
          when connectionStateChanged != null:
        return connectionStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventIceGatheringStateChanged()
          when iceGatheringStateChanged != null:
        return iceGatheringStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventIceConnectionStateChanged()
          when iceConnectionStateChanged != null:
        return iceConnectionStateChanged(_that.callId, _that.state);
      case _PeerConnectionEventIceCandidateIdentified()
          when iceCandidateIdentified != null:
        return iceCandidateIdentified(_that.callId, _that.candidate);
      case _PeerConnectionEventStreamAdded() when streamAdded != null:
        return streamAdded(_that.callId, _that.stream);
      case _PeerConnectionEventStreamRemoved() when streamRemoved != null:
        return streamRemoved(_that.callId, _that.stream);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PeerConnectionEventSignalingStateChanged
    with DiagnosticableTreeMixin
    implements _PeerConnectionEvent {
  const _PeerConnectionEventSignalingStateChanged(this.callId, this.state);

  @override
  final String callId;
  final RTCSignalingState state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.signalingStateChanged'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PeerConnectionEventSignalingStateChanged &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, state);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.signalingStateChanged(callId: $callId, state: $state)';
  }
}

/// @nodoc

class _PeerConnectionEventConnectionStateChanged
    with DiagnosticableTreeMixin
    implements _PeerConnectionEvent {
  const _PeerConnectionEventConnectionStateChanged(this.callId, this.state);

  @override
  final String callId;
  final RTCPeerConnectionState state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.connectionStateChanged'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PeerConnectionEventConnectionStateChanged &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, state);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.connectionStateChanged(callId: $callId, state: $state)';
  }
}

/// @nodoc

class _PeerConnectionEventIceGatheringStateChanged
    with DiagnosticableTreeMixin
    implements _PeerConnectionEvent {
  const _PeerConnectionEventIceGatheringStateChanged(this.callId, this.state);

  @override
  final String callId;
  final RTCIceGatheringState state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.iceGatheringStateChanged'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PeerConnectionEventIceGatheringStateChanged &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, state);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.iceGatheringStateChanged(callId: $callId, state: $state)';
  }
}

/// @nodoc

class _PeerConnectionEventIceConnectionStateChanged
    with DiagnosticableTreeMixin
    implements _PeerConnectionEvent {
  const _PeerConnectionEventIceConnectionStateChanged(this.callId, this.state);

  @override
  final String callId;
  final RTCIceConnectionState state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.iceConnectionStateChanged'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PeerConnectionEventIceConnectionStateChanged &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, state);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.iceConnectionStateChanged(callId: $callId, state: $state)';
  }
}

/// @nodoc

class _PeerConnectionEventIceCandidateIdentified
    with DiagnosticableTreeMixin
    implements _PeerConnectionEvent {
  const _PeerConnectionEventIceCandidateIdentified(this.callId, this.candidate);

  @override
  final String callId;
  final RTCIceCandidate candidate;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.iceCandidateIdentified'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('candidate', candidate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PeerConnectionEventIceCandidateIdentified &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.candidate, candidate) ||
                other.candidate == candidate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, candidate);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.iceCandidateIdentified(callId: $callId, candidate: $candidate)';
  }
}

/// @nodoc

class _PeerConnectionEventStreamAdded
    with DiagnosticableTreeMixin
    implements _PeerConnectionEvent {
  const _PeerConnectionEventStreamAdded(this.callId, this.stream);

  @override
  final String callId;
  final MediaStream stream;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_PeerConnectionEvent.streamAdded'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('stream', stream));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PeerConnectionEventStreamAdded &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.stream, stream) || other.stream == stream));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, stream);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.streamAdded(callId: $callId, stream: $stream)';
  }
}

/// @nodoc

class _PeerConnectionEventStreamRemoved
    with DiagnosticableTreeMixin
    implements _PeerConnectionEvent {
  const _PeerConnectionEventStreamRemoved(this.callId, this.stream);

  @override
  final String callId;
  final MediaStream stream;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', '_PeerConnectionEvent.streamRemoved'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('stream', stream));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PeerConnectionEventStreamRemoved &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.stream, stream) || other.stream == stream));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, stream);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.streamRemoved(callId: $callId, stream: $stream)';
  }
}

/// @nodoc
mixin _$CallScreenEvent implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'CallScreenEvent'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CallScreenEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallScreenEvent()';
  }
}

/// Adds pattern-matching-related methods to [CallScreenEvent].
extension CallScreenEventPatterns on CallScreenEvent {
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
    TResult Function(_CallScreenEventDidPush value)? didPush,
    TResult Function(_CallScreenEventDidPop value)? didPop,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallScreenEventDidPush() when didPush != null:
        return didPush(_that);
      case _CallScreenEventDidPop() when didPop != null:
        return didPop(_that);
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
    required TResult Function(_CallScreenEventDidPush value) didPush,
    required TResult Function(_CallScreenEventDidPop value) didPop,
  }) {
    final _that = this;
    switch (_that) {
      case _CallScreenEventDidPush():
        return didPush(_that);
      case _CallScreenEventDidPop():
        return didPop(_that);
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
    TResult? Function(_CallScreenEventDidPush value)? didPush,
    TResult? Function(_CallScreenEventDidPop value)? didPop,
  }) {
    final _that = this;
    switch (_that) {
      case _CallScreenEventDidPush() when didPush != null:
        return didPush(_that);
      case _CallScreenEventDidPop() when didPop != null:
        return didPop(_that);
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
    TResult Function()? didPush,
    TResult Function()? didPop,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallScreenEventDidPush() when didPush != null:
        return didPush();
      case _CallScreenEventDidPop() when didPop != null:
        return didPop();
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
    required TResult Function() didPush,
    required TResult Function() didPop,
  }) {
    final _that = this;
    switch (_that) {
      case _CallScreenEventDidPush():
        return didPush();
      case _CallScreenEventDidPop():
        return didPop();
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
    TResult? Function()? didPush,
    TResult? Function()? didPop,
  }) {
    final _that = this;
    switch (_that) {
      case _CallScreenEventDidPush() when didPush != null:
        return didPush();
      case _CallScreenEventDidPop() when didPop != null:
        return didPop();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallScreenEventDidPush
    with DiagnosticableTreeMixin
    implements CallScreenEvent {
  _CallScreenEventDidPush();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'CallScreenEvent.didPush'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _CallScreenEventDidPush);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallScreenEvent.didPush()';
  }
}

/// @nodoc

class _CallScreenEventDidPop
    with DiagnosticableTreeMixin
    implements CallScreenEvent {
  _CallScreenEventDidPop();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'CallScreenEvent.didPop'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _CallScreenEventDidPop);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallScreenEvent.didPop()';
  }
}

/// @nodoc
mixin _$CallState implements DiagnosticableTreeMixin {
  CallServiceState get callServiceState;
  AppLifecycleState? get currentAppLifecycleState;
  int get linesCount;
  List<ActiveCall> get activeCalls;
  bool? get minimized;
  bool? get speakerOnBeforeMinimize;
  CallAudioDevice? get audioDevice;
  List<CallAudioDevice> get availableAudioDevices;

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CallStateCopyWith<CallState> get copyWith =>
      _$CallStateCopyWithImpl<CallState>(this as CallState, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallState'))
      ..add(DiagnosticsProperty('callServiceState', callServiceState))
      ..add(DiagnosticsProperty(
          'currentAppLifecycleState', currentAppLifecycleState))
      ..add(DiagnosticsProperty('linesCount', linesCount))
      ..add(DiagnosticsProperty('activeCalls', activeCalls))
      ..add(DiagnosticsProperty('minimized', minimized))
      ..add(DiagnosticsProperty(
          'speakerOnBeforeMinimize', speakerOnBeforeMinimize))
      ..add(DiagnosticsProperty('audioDevice', audioDevice))
      ..add(
          DiagnosticsProperty('availableAudioDevices', availableAudioDevices));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallState &&
            (identical(other.callServiceState, callServiceState) ||
                other.callServiceState == callServiceState) &&
            (identical(
                    other.currentAppLifecycleState, currentAppLifecycleState) ||
                other.currentAppLifecycleState == currentAppLifecycleState) &&
            (identical(other.linesCount, linesCount) ||
                other.linesCount == linesCount) &&
            const DeepCollectionEquality()
                .equals(other.activeCalls, activeCalls) &&
            (identical(other.minimized, minimized) ||
                other.minimized == minimized) &&
            (identical(
                    other.speakerOnBeforeMinimize, speakerOnBeforeMinimize) ||
                other.speakerOnBeforeMinimize == speakerOnBeforeMinimize) &&
            (identical(other.audioDevice, audioDevice) ||
                other.audioDevice == audioDevice) &&
            const DeepCollectionEquality()
                .equals(other.availableAudioDevices, availableAudioDevices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      callServiceState,
      currentAppLifecycleState,
      linesCount,
      const DeepCollectionEquality().hash(activeCalls),
      minimized,
      speakerOnBeforeMinimize,
      audioDevice,
      const DeepCollectionEquality().hash(availableAudioDevices));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallState(callServiceState: $callServiceState, currentAppLifecycleState: $currentAppLifecycleState, linesCount: $linesCount, activeCalls: $activeCalls, minimized: $minimized, speakerOnBeforeMinimize: $speakerOnBeforeMinimize, audioDevice: $audioDevice, availableAudioDevices: $availableAudioDevices)';
  }
}

/// @nodoc
abstract mixin class $CallStateCopyWith<$Res> {
  factory $CallStateCopyWith(CallState value, $Res Function(CallState) _then) =
      _$CallStateCopyWithImpl;
  @useResult
  $Res call(
      {CallServiceState callServiceState,
      AppLifecycleState? currentAppLifecycleState,
      int linesCount,
      List<ActiveCall> activeCalls,
      bool? minimized,
      bool? speakerOnBeforeMinimize,
      CallAudioDevice? audioDevice,
      List<CallAudioDevice> availableAudioDevices});

  $CallServiceStateCopyWith<$Res> get callServiceState;
  $CallAudioDeviceCopyWith<$Res>? get audioDevice;
}

/// @nodoc
class _$CallStateCopyWithImpl<$Res> implements $CallStateCopyWith<$Res> {
  _$CallStateCopyWithImpl(this._self, this._then);

  final CallState _self;
  final $Res Function(CallState) _then;

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callServiceState = null,
    Object? currentAppLifecycleState = freezed,
    Object? linesCount = null,
    Object? activeCalls = null,
    Object? minimized = freezed,
    Object? speakerOnBeforeMinimize = freezed,
    Object? audioDevice = freezed,
    Object? availableAudioDevices = null,
  }) {
    return _then(_self.copyWith(
      callServiceState: null == callServiceState
          ? _self.callServiceState
          : callServiceState // ignore: cast_nullable_to_non_nullable
              as CallServiceState,
      currentAppLifecycleState: freezed == currentAppLifecycleState
          ? _self.currentAppLifecycleState
          : currentAppLifecycleState // ignore: cast_nullable_to_non_nullable
              as AppLifecycleState?,
      linesCount: null == linesCount
          ? _self.linesCount
          : linesCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeCalls: null == activeCalls
          ? _self.activeCalls
          : activeCalls // ignore: cast_nullable_to_non_nullable
              as List<ActiveCall>,
      minimized: freezed == minimized
          ? _self.minimized
          : minimized // ignore: cast_nullable_to_non_nullable
              as bool?,
      speakerOnBeforeMinimize: freezed == speakerOnBeforeMinimize
          ? _self.speakerOnBeforeMinimize
          : speakerOnBeforeMinimize // ignore: cast_nullable_to_non_nullable
              as bool?,
      audioDevice: freezed == audioDevice
          ? _self.audioDevice
          : audioDevice // ignore: cast_nullable_to_non_nullable
              as CallAudioDevice?,
      availableAudioDevices: null == availableAudioDevices
          ? _self.availableAudioDevices
          : availableAudioDevices // ignore: cast_nullable_to_non_nullable
              as List<CallAudioDevice>,
    ));
  }

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CallServiceStateCopyWith<$Res> get callServiceState {
    return $CallServiceStateCopyWith<$Res>(_self.callServiceState, (value) {
      return _then(_self.copyWith(callServiceState: value));
    });
  }

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CallAudioDeviceCopyWith<$Res>? get audioDevice {
    if (_self.audioDevice == null) {
      return null;
    }

    return $CallAudioDeviceCopyWith<$Res>(_self.audioDevice!, (value) {
      return _then(_self.copyWith(audioDevice: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CallState].
extension CallStatePatterns on CallState {
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
    TResult Function(_CallState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallState() when $default != null:
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
    TResult Function(_CallState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallState():
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
    TResult? Function(_CallState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallState() when $default != null:
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
            CallServiceState callServiceState,
            AppLifecycleState? currentAppLifecycleState,
            int linesCount,
            List<ActiveCall> activeCalls,
            bool? minimized,
            bool? speakerOnBeforeMinimize,
            CallAudioDevice? audioDevice,
            List<CallAudioDevice> availableAudioDevices)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallState() when $default != null:
        return $default(
            _that.callServiceState,
            _that.currentAppLifecycleState,
            _that.linesCount,
            _that.activeCalls,
            _that.minimized,
            _that.speakerOnBeforeMinimize,
            _that.audioDevice,
            _that.availableAudioDevices);
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
            CallServiceState callServiceState,
            AppLifecycleState? currentAppLifecycleState,
            int linesCount,
            List<ActiveCall> activeCalls,
            bool? minimized,
            bool? speakerOnBeforeMinimize,
            CallAudioDevice? audioDevice,
            List<CallAudioDevice> availableAudioDevices)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallState():
        return $default(
            _that.callServiceState,
            _that.currentAppLifecycleState,
            _that.linesCount,
            _that.activeCalls,
            _that.minimized,
            _that.speakerOnBeforeMinimize,
            _that.audioDevice,
            _that.availableAudioDevices);
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
            CallServiceState callServiceState,
            AppLifecycleState? currentAppLifecycleState,
            int linesCount,
            List<ActiveCall> activeCalls,
            bool? minimized,
            bool? speakerOnBeforeMinimize,
            CallAudioDevice? audioDevice,
            List<CallAudioDevice> availableAudioDevices)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallState() when $default != null:
        return $default(
            _that.callServiceState,
            _that.currentAppLifecycleState,
            _that.linesCount,
            _that.activeCalls,
            _that.minimized,
            _that.speakerOnBeforeMinimize,
            _that.audioDevice,
            _that.availableAudioDevices);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallState extends CallState with DiagnosticableTreeMixin {
  const _CallState(
      {this.callServiceState = const CallServiceState(),
      this.currentAppLifecycleState,
      this.linesCount = 0,
      final List<ActiveCall> activeCalls = const [],
      this.minimized,
      this.speakerOnBeforeMinimize,
      this.audioDevice,
      final List<CallAudioDevice> availableAudioDevices = const []})
      : _activeCalls = activeCalls,
        _availableAudioDevices = availableAudioDevices,
        super._();

  @override
  @JsonKey()
  final CallServiceState callServiceState;
  @override
  final AppLifecycleState? currentAppLifecycleState;
  @override
  @JsonKey()
  final int linesCount;
  final List<ActiveCall> _activeCalls;
  @override
  @JsonKey()
  List<ActiveCall> get activeCalls {
    if (_activeCalls is EqualUnmodifiableListView) return _activeCalls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeCalls);
  }

  @override
  final bool? minimized;
  @override
  final bool? speakerOnBeforeMinimize;
  @override
  final CallAudioDevice? audioDevice;
  final List<CallAudioDevice> _availableAudioDevices;
  @override
  @JsonKey()
  List<CallAudioDevice> get availableAudioDevices {
    if (_availableAudioDevices is EqualUnmodifiableListView)
      return _availableAudioDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableAudioDevices);
  }

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CallStateCopyWith<_CallState> get copyWith =>
      __$CallStateCopyWithImpl<_CallState>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallState'))
      ..add(DiagnosticsProperty('callServiceState', callServiceState))
      ..add(DiagnosticsProperty(
          'currentAppLifecycleState', currentAppLifecycleState))
      ..add(DiagnosticsProperty('linesCount', linesCount))
      ..add(DiagnosticsProperty('activeCalls', activeCalls))
      ..add(DiagnosticsProperty('minimized', minimized))
      ..add(DiagnosticsProperty(
          'speakerOnBeforeMinimize', speakerOnBeforeMinimize))
      ..add(DiagnosticsProperty('audioDevice', audioDevice))
      ..add(
          DiagnosticsProperty('availableAudioDevices', availableAudioDevices));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallState &&
            (identical(other.callServiceState, callServiceState) ||
                other.callServiceState == callServiceState) &&
            (identical(
                    other.currentAppLifecycleState, currentAppLifecycleState) ||
                other.currentAppLifecycleState == currentAppLifecycleState) &&
            (identical(other.linesCount, linesCount) ||
                other.linesCount == linesCount) &&
            const DeepCollectionEquality()
                .equals(other._activeCalls, _activeCalls) &&
            (identical(other.minimized, minimized) ||
                other.minimized == minimized) &&
            (identical(
                    other.speakerOnBeforeMinimize, speakerOnBeforeMinimize) ||
                other.speakerOnBeforeMinimize == speakerOnBeforeMinimize) &&
            (identical(other.audioDevice, audioDevice) ||
                other.audioDevice == audioDevice) &&
            const DeepCollectionEquality()
                .equals(other._availableAudioDevices, _availableAudioDevices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      callServiceState,
      currentAppLifecycleState,
      linesCount,
      const DeepCollectionEquality().hash(_activeCalls),
      minimized,
      speakerOnBeforeMinimize,
      audioDevice,
      const DeepCollectionEquality().hash(_availableAudioDevices));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallState(callServiceState: $callServiceState, currentAppLifecycleState: $currentAppLifecycleState, linesCount: $linesCount, activeCalls: $activeCalls, minimized: $minimized, speakerOnBeforeMinimize: $speakerOnBeforeMinimize, audioDevice: $audioDevice, availableAudioDevices: $availableAudioDevices)';
  }
}

/// @nodoc
abstract mixin class _$CallStateCopyWith<$Res>
    implements $CallStateCopyWith<$Res> {
  factory _$CallStateCopyWith(
          _CallState value, $Res Function(_CallState) _then) =
      __$CallStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {CallServiceState callServiceState,
      AppLifecycleState? currentAppLifecycleState,
      int linesCount,
      List<ActiveCall> activeCalls,
      bool? minimized,
      bool? speakerOnBeforeMinimize,
      CallAudioDevice? audioDevice,
      List<CallAudioDevice> availableAudioDevices});

  @override
  $CallServiceStateCopyWith<$Res> get callServiceState;
  @override
  $CallAudioDeviceCopyWith<$Res>? get audioDevice;
}

/// @nodoc
class __$CallStateCopyWithImpl<$Res> implements _$CallStateCopyWith<$Res> {
  __$CallStateCopyWithImpl(this._self, this._then);

  final _CallState _self;
  final $Res Function(_CallState) _then;

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? callServiceState = null,
    Object? currentAppLifecycleState = freezed,
    Object? linesCount = null,
    Object? activeCalls = null,
    Object? minimized = freezed,
    Object? speakerOnBeforeMinimize = freezed,
    Object? audioDevice = freezed,
    Object? availableAudioDevices = null,
  }) {
    return _then(_CallState(
      callServiceState: null == callServiceState
          ? _self.callServiceState
          : callServiceState // ignore: cast_nullable_to_non_nullable
              as CallServiceState,
      currentAppLifecycleState: freezed == currentAppLifecycleState
          ? _self.currentAppLifecycleState
          : currentAppLifecycleState // ignore: cast_nullable_to_non_nullable
              as AppLifecycleState?,
      linesCount: null == linesCount
          ? _self.linesCount
          : linesCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeCalls: null == activeCalls
          ? _self._activeCalls
          : activeCalls // ignore: cast_nullable_to_non_nullable
              as List<ActiveCall>,
      minimized: freezed == minimized
          ? _self.minimized
          : minimized // ignore: cast_nullable_to_non_nullable
              as bool?,
      speakerOnBeforeMinimize: freezed == speakerOnBeforeMinimize
          ? _self.speakerOnBeforeMinimize
          : speakerOnBeforeMinimize // ignore: cast_nullable_to_non_nullable
              as bool?,
      audioDevice: freezed == audioDevice
          ? _self.audioDevice
          : audioDevice // ignore: cast_nullable_to_non_nullable
              as CallAudioDevice?,
      availableAudioDevices: null == availableAudioDevices
          ? _self._availableAudioDevices
          : availableAudioDevices // ignore: cast_nullable_to_non_nullable
              as List<CallAudioDevice>,
    ));
  }

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CallServiceStateCopyWith<$Res> get callServiceState {
    return $CallServiceStateCopyWith<$Res>(_self.callServiceState, (value) {
      return _then(_self.copyWith(callServiceState: value));
    });
  }

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CallAudioDeviceCopyWith<$Res>? get audioDevice {
    if (_self.audioDevice == null) {
      return null;
    }

    return $CallAudioDeviceCopyWith<$Res>(_self.audioDevice!, (value) {
      return _then(_self.copyWith(audioDevice: value));
    });
  }
}

/// @nodoc
mixin _$ActiveCall implements DiagnosticableTreeMixin {
  CallDirection get direction;
  int? get line;
  String get callId;
  CallkeepHandle get handle;
  DateTime get createdTime;
  bool get video;
  CallProcessingStatus get processingStatus;
  bool? get frontCamera;
  bool get held;
  bool get muted;
  bool get updating;
  JsepValue? get incomingOffer;
  String? get displayName;
  String? get fromReferId;
  String? get fromReplaces;
  String? get fromNumber;
  DateTime? get acceptedTime;
  DateTime? get hungUpTime;
  Transfer? get transfer;
  Object? get failure;
  MediaStream? get localStream;
  MediaStream? get remoteStream;

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActiveCallCopyWith<ActiveCall> get copyWith =>
      _$ActiveCallCopyWithImpl<ActiveCall>(this as ActiveCall, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ActiveCall'))
      ..add(DiagnosticsProperty('direction', direction))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('createdTime', createdTime))
      ..add(DiagnosticsProperty('video', video))
      ..add(DiagnosticsProperty('processingStatus', processingStatus))
      ..add(DiagnosticsProperty('frontCamera', frontCamera))
      ..add(DiagnosticsProperty('held', held))
      ..add(DiagnosticsProperty('muted', muted))
      ..add(DiagnosticsProperty('updating', updating))
      ..add(DiagnosticsProperty('incomingOffer', incomingOffer))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('fromReferId', fromReferId))
      ..add(DiagnosticsProperty('fromReplaces', fromReplaces))
      ..add(DiagnosticsProperty('fromNumber', fromNumber))
      ..add(DiagnosticsProperty('acceptedTime', acceptedTime))
      ..add(DiagnosticsProperty('hungUpTime', hungUpTime))
      ..add(DiagnosticsProperty('transfer', transfer))
      ..add(DiagnosticsProperty('failure', failure))
      ..add(DiagnosticsProperty('localStream', localStream))
      ..add(DiagnosticsProperty('remoteStream', remoteStream));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActiveCall &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.processingStatus, processingStatus) ||
                other.processingStatus == processingStatus) &&
            (identical(other.frontCamera, frontCamera) ||
                other.frontCamera == frontCamera) &&
            (identical(other.held, held) || other.held == held) &&
            (identical(other.muted, muted) || other.muted == muted) &&
            (identical(other.updating, updating) ||
                other.updating == updating) &&
            (identical(other.incomingOffer, incomingOffer) ||
                other.incomingOffer == incomingOffer) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.fromReferId, fromReferId) ||
                other.fromReferId == fromReferId) &&
            (identical(other.fromReplaces, fromReplaces) ||
                other.fromReplaces == fromReplaces) &&
            (identical(other.fromNumber, fromNumber) ||
                other.fromNumber == fromNumber) &&
            (identical(other.acceptedTime, acceptedTime) ||
                other.acceptedTime == acceptedTime) &&
            (identical(other.hungUpTime, hungUpTime) ||
                other.hungUpTime == hungUpTime) &&
            (identical(other.transfer, transfer) ||
                other.transfer == transfer) &&
            const DeepCollectionEquality().equals(other.failure, failure) &&
            (identical(other.localStream, localStream) ||
                other.localStream == localStream) &&
            (identical(other.remoteStream, remoteStream) ||
                other.remoteStream == remoteStream));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        direction,
        line,
        callId,
        handle,
        createdTime,
        video,
        processingStatus,
        frontCamera,
        held,
        muted,
        updating,
        incomingOffer,
        displayName,
        fromReferId,
        fromReplaces,
        fromNumber,
        acceptedTime,
        hungUpTime,
        transfer,
        const DeepCollectionEquality().hash(failure),
        localStream,
        remoteStream
      ]);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ActiveCall(direction: $direction, line: $line, callId: $callId, handle: $handle, createdTime: $createdTime, video: $video, processingStatus: $processingStatus, frontCamera: $frontCamera, held: $held, muted: $muted, updating: $updating, incomingOffer: $incomingOffer, displayName: $displayName, fromReferId: $fromReferId, fromReplaces: $fromReplaces, fromNumber: $fromNumber, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime, transfer: $transfer, failure: $failure, localStream: $localStream, remoteStream: $remoteStream)';
  }
}

/// @nodoc
abstract mixin class $ActiveCallCopyWith<$Res> {
  factory $ActiveCallCopyWith(
          ActiveCall value, $Res Function(ActiveCall) _then) =
      _$ActiveCallCopyWithImpl;
  @useResult
  $Res call(
      {CallDirection direction,
      int? line,
      String callId,
      CallkeepHandle handle,
      DateTime createdTime,
      bool video,
      CallProcessingStatus processingStatus,
      bool? frontCamera,
      bool held,
      bool muted,
      bool updating,
      JsepValue? incomingOffer,
      String? displayName,
      String? fromReferId,
      String? fromReplaces,
      String? fromNumber,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      Transfer? transfer,
      Object? failure,
      MediaStream? localStream,
      MediaStream? remoteStream});

  $TransferCopyWith<$Res>? get transfer;
}

/// @nodoc
class _$ActiveCallCopyWithImpl<$Res> implements $ActiveCallCopyWith<$Res> {
  _$ActiveCallCopyWithImpl(this._self, this._then);

  final ActiveCall _self;
  final $Res Function(ActiveCall) _then;

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? line = freezed,
    Object? callId = null,
    Object? handle = null,
    Object? createdTime = null,
    Object? video = null,
    Object? processingStatus = null,
    Object? frontCamera = freezed,
    Object? held = null,
    Object? muted = null,
    Object? updating = null,
    Object? incomingOffer = freezed,
    Object? displayName = freezed,
    Object? fromReferId = freezed,
    Object? fromReplaces = freezed,
    Object? fromNumber = freezed,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? transfer = freezed,
    Object? failure = freezed,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
  }) {
    return _then(_self.copyWith(
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as CallDirection,
      line: freezed == line
          ? _self.line
          : line // ignore: cast_nullable_to_non_nullable
              as int?,
      callId: null == callId
          ? _self.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String,
      handle: null == handle
          ? _self.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as CallkeepHandle,
      createdTime: null == createdTime
          ? _self.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      video: null == video
          ? _self.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool,
      processingStatus: null == processingStatus
          ? _self.processingStatus
          : processingStatus // ignore: cast_nullable_to_non_nullable
              as CallProcessingStatus,
      frontCamera: freezed == frontCamera
          ? _self.frontCamera
          : frontCamera // ignore: cast_nullable_to_non_nullable
              as bool?,
      held: null == held
          ? _self.held
          : held // ignore: cast_nullable_to_non_nullable
              as bool,
      muted: null == muted
          ? _self.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      updating: null == updating
          ? _self.updating
          : updating // ignore: cast_nullable_to_non_nullable
              as bool,
      incomingOffer: freezed == incomingOffer
          ? _self.incomingOffer
          : incomingOffer // ignore: cast_nullable_to_non_nullable
              as JsepValue?,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      fromReferId: freezed == fromReferId
          ? _self.fromReferId
          : fromReferId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromReplaces: freezed == fromReplaces
          ? _self.fromReplaces
          : fromReplaces // ignore: cast_nullable_to_non_nullable
              as String?,
      fromNumber: freezed == fromNumber
          ? _self.fromNumber
          : fromNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptedTime: freezed == acceptedTime
          ? _self.acceptedTime
          : acceptedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hungUpTime: freezed == hungUpTime
          ? _self.hungUpTime
          : hungUpTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transfer: freezed == transfer
          ? _self.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as Transfer?,
      failure: freezed == failure ? _self.failure : failure,
      localStream: freezed == localStream
          ? _self.localStream
          : localStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      remoteStream: freezed == remoteStream
          ? _self.remoteStream
          : remoteStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
    ));
  }

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferCopyWith<$Res>? get transfer {
    if (_self.transfer == null) {
      return null;
    }

    return $TransferCopyWith<$Res>(_self.transfer!, (value) {
      return _then(_self.copyWith(transfer: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ActiveCall].
extension ActiveCallPatterns on ActiveCall {
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
    TResult Function(_ActiveCall value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActiveCall() when $default != null:
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
    TResult Function(_ActiveCall value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveCall():
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
    TResult? Function(_ActiveCall value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveCall() when $default != null:
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
            CallDirection direction,
            int? line,
            String callId,
            CallkeepHandle handle,
            DateTime createdTime,
            bool video,
            CallProcessingStatus processingStatus,
            bool? frontCamera,
            bool held,
            bool muted,
            bool updating,
            JsepValue? incomingOffer,
            String? displayName,
            String? fromReferId,
            String? fromReplaces,
            String? fromNumber,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            Transfer? transfer,
            Object? failure,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActiveCall() when $default != null:
        return $default(
            _that.direction,
            _that.line,
            _that.callId,
            _that.handle,
            _that.createdTime,
            _that.video,
            _that.processingStatus,
            _that.frontCamera,
            _that.held,
            _that.muted,
            _that.updating,
            _that.incomingOffer,
            _that.displayName,
            _that.fromReferId,
            _that.fromReplaces,
            _that.fromNumber,
            _that.acceptedTime,
            _that.hungUpTime,
            _that.transfer,
            _that.failure,
            _that.localStream,
            _that.remoteStream);
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
            CallDirection direction,
            int? line,
            String callId,
            CallkeepHandle handle,
            DateTime createdTime,
            bool video,
            CallProcessingStatus processingStatus,
            bool? frontCamera,
            bool held,
            bool muted,
            bool updating,
            JsepValue? incomingOffer,
            String? displayName,
            String? fromReferId,
            String? fromReplaces,
            String? fromNumber,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            Transfer? transfer,
            Object? failure,
            MediaStream? localStream,
            MediaStream? remoteStream)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveCall():
        return $default(
            _that.direction,
            _that.line,
            _that.callId,
            _that.handle,
            _that.createdTime,
            _that.video,
            _that.processingStatus,
            _that.frontCamera,
            _that.held,
            _that.muted,
            _that.updating,
            _that.incomingOffer,
            _that.displayName,
            _that.fromReferId,
            _that.fromReplaces,
            _that.fromNumber,
            _that.acceptedTime,
            _that.hungUpTime,
            _that.transfer,
            _that.failure,
            _that.localStream,
            _that.remoteStream);
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
            CallDirection direction,
            int? line,
            String callId,
            CallkeepHandle handle,
            DateTime createdTime,
            bool video,
            CallProcessingStatus processingStatus,
            bool? frontCamera,
            bool held,
            bool muted,
            bool updating,
            JsepValue? incomingOffer,
            String? displayName,
            String? fromReferId,
            String? fromReplaces,
            String? fromNumber,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            Transfer? transfer,
            Object? failure,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActiveCall() when $default != null:
        return $default(
            _that.direction,
            _that.line,
            _that.callId,
            _that.handle,
            _that.createdTime,
            _that.video,
            _that.processingStatus,
            _that.frontCamera,
            _that.held,
            _that.muted,
            _that.updating,
            _that.incomingOffer,
            _that.displayName,
            _that.fromReferId,
            _that.fromReplaces,
            _that.fromNumber,
            _that.acceptedTime,
            _that.hungUpTime,
            _that.transfer,
            _that.failure,
            _that.localStream,
            _that.remoteStream);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ActiveCall extends ActiveCall with DiagnosticableTreeMixin {
  _ActiveCall(
      {required this.direction,
      required this.line,
      required this.callId,
      required this.handle,
      required this.createdTime,
      required this.video,
      required this.processingStatus,
      this.frontCamera = true,
      this.held = false,
      this.muted = false,
      this.updating = false,
      this.incomingOffer,
      this.displayName,
      this.fromReferId,
      this.fromReplaces,
      this.fromNumber,
      this.acceptedTime,
      this.hungUpTime,
      this.transfer,
      this.failure,
      this.localStream,
      this.remoteStream})
      : super._();

  @override
  final CallDirection direction;
  @override
  final int? line;
  @override
  final String callId;
  @override
  final CallkeepHandle handle;
  @override
  final DateTime createdTime;
  @override
  final bool video;
  @override
  final CallProcessingStatus processingStatus;
  @override
  @JsonKey()
  final bool? frontCamera;
  @override
  @JsonKey()
  final bool held;
  @override
  @JsonKey()
  final bool muted;
  @override
  @JsonKey()
  final bool updating;
  @override
  final JsepValue? incomingOffer;
  @override
  final String? displayName;
  @override
  final String? fromReferId;
  @override
  final String? fromReplaces;
  @override
  final String? fromNumber;
  @override
  final DateTime? acceptedTime;
  @override
  final DateTime? hungUpTime;
  @override
  final Transfer? transfer;
  @override
  final Object? failure;
  @override
  final MediaStream? localStream;
  @override
  final MediaStream? remoteStream;

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActiveCallCopyWith<_ActiveCall> get copyWith =>
      __$ActiveCallCopyWithImpl<_ActiveCall>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ActiveCall'))
      ..add(DiagnosticsProperty('direction', direction))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('createdTime', createdTime))
      ..add(DiagnosticsProperty('video', video))
      ..add(DiagnosticsProperty('processingStatus', processingStatus))
      ..add(DiagnosticsProperty('frontCamera', frontCamera))
      ..add(DiagnosticsProperty('held', held))
      ..add(DiagnosticsProperty('muted', muted))
      ..add(DiagnosticsProperty('updating', updating))
      ..add(DiagnosticsProperty('incomingOffer', incomingOffer))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('fromReferId', fromReferId))
      ..add(DiagnosticsProperty('fromReplaces', fromReplaces))
      ..add(DiagnosticsProperty('fromNumber', fromNumber))
      ..add(DiagnosticsProperty('acceptedTime', acceptedTime))
      ..add(DiagnosticsProperty('hungUpTime', hungUpTime))
      ..add(DiagnosticsProperty('transfer', transfer))
      ..add(DiagnosticsProperty('failure', failure))
      ..add(DiagnosticsProperty('localStream', localStream))
      ..add(DiagnosticsProperty('remoteStream', remoteStream));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ActiveCall &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.processingStatus, processingStatus) ||
                other.processingStatus == processingStatus) &&
            (identical(other.frontCamera, frontCamera) ||
                other.frontCamera == frontCamera) &&
            (identical(other.held, held) || other.held == held) &&
            (identical(other.muted, muted) || other.muted == muted) &&
            (identical(other.updating, updating) ||
                other.updating == updating) &&
            (identical(other.incomingOffer, incomingOffer) ||
                other.incomingOffer == incomingOffer) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.fromReferId, fromReferId) ||
                other.fromReferId == fromReferId) &&
            (identical(other.fromReplaces, fromReplaces) ||
                other.fromReplaces == fromReplaces) &&
            (identical(other.fromNumber, fromNumber) ||
                other.fromNumber == fromNumber) &&
            (identical(other.acceptedTime, acceptedTime) ||
                other.acceptedTime == acceptedTime) &&
            (identical(other.hungUpTime, hungUpTime) ||
                other.hungUpTime == hungUpTime) &&
            (identical(other.transfer, transfer) ||
                other.transfer == transfer) &&
            const DeepCollectionEquality().equals(other.failure, failure) &&
            (identical(other.localStream, localStream) ||
                other.localStream == localStream) &&
            (identical(other.remoteStream, remoteStream) ||
                other.remoteStream == remoteStream));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        direction,
        line,
        callId,
        handle,
        createdTime,
        video,
        processingStatus,
        frontCamera,
        held,
        muted,
        updating,
        incomingOffer,
        displayName,
        fromReferId,
        fromReplaces,
        fromNumber,
        acceptedTime,
        hungUpTime,
        transfer,
        const DeepCollectionEquality().hash(failure),
        localStream,
        remoteStream
      ]);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ActiveCall(direction: $direction, line: $line, callId: $callId, handle: $handle, createdTime: $createdTime, video: $video, processingStatus: $processingStatus, frontCamera: $frontCamera, held: $held, muted: $muted, updating: $updating, incomingOffer: $incomingOffer, displayName: $displayName, fromReferId: $fromReferId, fromReplaces: $fromReplaces, fromNumber: $fromNumber, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime, transfer: $transfer, failure: $failure, localStream: $localStream, remoteStream: $remoteStream)';
  }
}

/// @nodoc
abstract mixin class _$ActiveCallCopyWith<$Res>
    implements $ActiveCallCopyWith<$Res> {
  factory _$ActiveCallCopyWith(
          _ActiveCall value, $Res Function(_ActiveCall) _then) =
      __$ActiveCallCopyWithImpl;
  @override
  @useResult
  $Res call(
      {CallDirection direction,
      int? line,
      String callId,
      CallkeepHandle handle,
      DateTime createdTime,
      bool video,
      CallProcessingStatus processingStatus,
      bool? frontCamera,
      bool held,
      bool muted,
      bool updating,
      JsepValue? incomingOffer,
      String? displayName,
      String? fromReferId,
      String? fromReplaces,
      String? fromNumber,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      Transfer? transfer,
      Object? failure,
      MediaStream? localStream,
      MediaStream? remoteStream});

  @override
  $TransferCopyWith<$Res>? get transfer;
}

/// @nodoc
class __$ActiveCallCopyWithImpl<$Res> implements _$ActiveCallCopyWith<$Res> {
  __$ActiveCallCopyWithImpl(this._self, this._then);

  final _ActiveCall _self;
  final $Res Function(_ActiveCall) _then;

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? direction = null,
    Object? line = freezed,
    Object? callId = null,
    Object? handle = null,
    Object? createdTime = null,
    Object? video = null,
    Object? processingStatus = null,
    Object? frontCamera = freezed,
    Object? held = null,
    Object? muted = null,
    Object? updating = null,
    Object? incomingOffer = freezed,
    Object? displayName = freezed,
    Object? fromReferId = freezed,
    Object? fromReplaces = freezed,
    Object? fromNumber = freezed,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? transfer = freezed,
    Object? failure = freezed,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
  }) {
    return _then(_ActiveCall(
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as CallDirection,
      line: freezed == line
          ? _self.line
          : line // ignore: cast_nullable_to_non_nullable
              as int?,
      callId: null == callId
          ? _self.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String,
      handle: null == handle
          ? _self.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as CallkeepHandle,
      createdTime: null == createdTime
          ? _self.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      video: null == video
          ? _self.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool,
      processingStatus: null == processingStatus
          ? _self.processingStatus
          : processingStatus // ignore: cast_nullable_to_non_nullable
              as CallProcessingStatus,
      frontCamera: freezed == frontCamera
          ? _self.frontCamera
          : frontCamera // ignore: cast_nullable_to_non_nullable
              as bool?,
      held: null == held
          ? _self.held
          : held // ignore: cast_nullable_to_non_nullable
              as bool,
      muted: null == muted
          ? _self.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      updating: null == updating
          ? _self.updating
          : updating // ignore: cast_nullable_to_non_nullable
              as bool,
      incomingOffer: freezed == incomingOffer
          ? _self.incomingOffer
          : incomingOffer // ignore: cast_nullable_to_non_nullable
              as JsepValue?,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      fromReferId: freezed == fromReferId
          ? _self.fromReferId
          : fromReferId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromReplaces: freezed == fromReplaces
          ? _self.fromReplaces
          : fromReplaces // ignore: cast_nullable_to_non_nullable
              as String?,
      fromNumber: freezed == fromNumber
          ? _self.fromNumber
          : fromNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptedTime: freezed == acceptedTime
          ? _self.acceptedTime
          : acceptedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hungUpTime: freezed == hungUpTime
          ? _self.hungUpTime
          : hungUpTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transfer: freezed == transfer
          ? _self.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as Transfer?,
      failure: freezed == failure ? _self.failure : failure,
      localStream: freezed == localStream
          ? _self.localStream
          : localStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      remoteStream: freezed == remoteStream
          ? _self.remoteStream
          : remoteStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
    ));
  }

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferCopyWith<$Res>? get transfer {
    if (_self.transfer == null) {
      return null;
    }

    return $TransferCopyWith<$Res>(_self.transfer!, (value) {
      return _then(_self.copyWith(transfer: value));
    });
  }
}

/// @nodoc
mixin _$CallAudioDevice implements DiagnosticableTreeMixin {
  CallAudioDeviceType get type;
  String? get id;
  String? get name;

  /// Create a copy of CallAudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CallAudioDeviceCopyWith<CallAudioDevice> get copyWith =>
      _$CallAudioDeviceCopyWithImpl<CallAudioDevice>(
          this as CallAudioDevice, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallAudioDevice'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallAudioDevice &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, id, name);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallAudioDevice(type: $type, id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $CallAudioDeviceCopyWith<$Res> {
  factory $CallAudioDeviceCopyWith(
          CallAudioDevice value, $Res Function(CallAudioDevice) _then) =
      _$CallAudioDeviceCopyWithImpl;
  @useResult
  $Res call({CallAudioDeviceType type, String? id, String? name});
}

/// @nodoc
class _$CallAudioDeviceCopyWithImpl<$Res>
    implements $CallAudioDeviceCopyWith<$Res> {
  _$CallAudioDeviceCopyWithImpl(this._self, this._then);

  final CallAudioDevice _self;
  final $Res Function(CallAudioDevice) _then;

  /// Create a copy of CallAudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as CallAudioDeviceType,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CallAudioDevice].
extension CallAudioDevicePatterns on CallAudioDevice {
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
    TResult Function(_CallAudioDevice value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallAudioDevice() when $default != null:
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
    TResult Function(_CallAudioDevice value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallAudioDevice():
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
    TResult? Function(_CallAudioDevice value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallAudioDevice() when $default != null:
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
    TResult Function(CallAudioDeviceType type, String? id, String? name)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallAudioDevice() when $default != null:
        return $default(_that.type, _that.id, _that.name);
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
    TResult Function(CallAudioDeviceType type, String? id, String? name)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallAudioDevice():
        return $default(_that.type, _that.id, _that.name);
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
    TResult? Function(CallAudioDeviceType type, String? id, String? name)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallAudioDevice() when $default != null:
        return $default(_that.type, _that.id, _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallAudioDevice extends CallAudioDevice with DiagnosticableTreeMixin {
  _CallAudioDevice({required this.type, this.id, this.name}) : super._();

  @override
  final CallAudioDeviceType type;
  @override
  final String? id;
  @override
  final String? name;

  /// Create a copy of CallAudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CallAudioDeviceCopyWith<_CallAudioDevice> get copyWith =>
      __$CallAudioDeviceCopyWithImpl<_CallAudioDevice>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CallAudioDevice'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallAudioDevice &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, id, name);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallAudioDevice(type: $type, id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$CallAudioDeviceCopyWith<$Res>
    implements $CallAudioDeviceCopyWith<$Res> {
  factory _$CallAudioDeviceCopyWith(
          _CallAudioDevice value, $Res Function(_CallAudioDevice) _then) =
      __$CallAudioDeviceCopyWithImpl;
  @override
  @useResult
  $Res call({CallAudioDeviceType type, String? id, String? name});
}

/// @nodoc
class __$CallAudioDeviceCopyWithImpl<$Res>
    implements _$CallAudioDeviceCopyWith<$Res> {
  __$CallAudioDeviceCopyWithImpl(this._self, this._then);

  final _CallAudioDevice _self;
  final $Res Function(_CallAudioDevice) _then;

  /// Create a copy of CallAudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_CallAudioDevice(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as CallAudioDeviceType,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
