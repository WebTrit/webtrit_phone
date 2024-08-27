// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_actions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DemoActions {
  List<DemoCallToActionsResponseActions> get action =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<DemoCallToActionsResponseActions> action)
        complete,
    required TResult Function(List<DemoCallToActionsResponseActions> action)
        incomplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<DemoCallToActionsResponseActions> action)? complete,
    TResult? Function(List<DemoCallToActionsResponseActions> action)?
        incomplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<DemoCallToActionsResponseActions> action)? complete,
    TResult Function(List<DemoCallToActionsResponseActions> action)? incomplete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DemoActionsComplete value) complete,
    required TResult Function(_DemoActionsIncomplete value) incomplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DemoActionsComplete value)? complete,
    TResult? Function(_DemoActionsIncomplete value)? incomplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DemoActionsComplete value)? complete,
    TResult Function(_DemoActionsIncomplete value)? incomplete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$DemoActionsCompleteImpl extends _DemoActionsComplete {
  _$DemoActionsCompleteImpl(final List<DemoCallToActionsResponseActions> action)
      : _action = action,
        super._();

  final List<DemoCallToActionsResponseActions> _action;
  @override
  List<DemoCallToActionsResponseActions> get action {
    if (_action is EqualUnmodifiableListView) return _action;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_action);
  }

  @override
  String toString() {
    return 'DemoActions.complete(action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoActionsCompleteImpl &&
            const DeepCollectionEquality().equals(other._action, _action));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_action));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<DemoCallToActionsResponseActions> action)
        complete,
    required TResult Function(List<DemoCallToActionsResponseActions> action)
        incomplete,
  }) {
    return complete(action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<DemoCallToActionsResponseActions> action)? complete,
    TResult? Function(List<DemoCallToActionsResponseActions> action)?
        incomplete,
  }) {
    return complete?.call(action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<DemoCallToActionsResponseActions> action)? complete,
    TResult Function(List<DemoCallToActionsResponseActions> action)? incomplete,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DemoActionsComplete value) complete,
    required TResult Function(_DemoActionsIncomplete value) incomplete,
  }) {
    return complete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DemoActionsComplete value)? complete,
    TResult? Function(_DemoActionsIncomplete value)? incomplete,
  }) {
    return complete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DemoActionsComplete value)? complete,
    TResult Function(_DemoActionsIncomplete value)? incomplete,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(this);
    }
    return orElse();
  }
}

abstract class _DemoActionsComplete extends DemoActions {
  factory _DemoActionsComplete(
          final List<DemoCallToActionsResponseActions> action) =
      _$DemoActionsCompleteImpl;
  _DemoActionsComplete._() : super._();

  @override
  List<DemoCallToActionsResponseActions> get action;
}

/// @nodoc

class _$DemoActionsIncompleteImpl extends _DemoActionsIncomplete {
  _$DemoActionsIncompleteImpl(
      final List<DemoCallToActionsResponseActions> action)
      : _action = action,
        super._();

  final List<DemoCallToActionsResponseActions> _action;
  @override
  List<DemoCallToActionsResponseActions> get action {
    if (_action is EqualUnmodifiableListView) return _action;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_action);
  }

  @override
  String toString() {
    return 'DemoActions.incomplete(action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoActionsIncompleteImpl &&
            const DeepCollectionEquality().equals(other._action, _action));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_action));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<DemoCallToActionsResponseActions> action)
        complete,
    required TResult Function(List<DemoCallToActionsResponseActions> action)
        incomplete,
  }) {
    return incomplete(action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<DemoCallToActionsResponseActions> action)? complete,
    TResult? Function(List<DemoCallToActionsResponseActions> action)?
        incomplete,
  }) {
    return incomplete?.call(action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<DemoCallToActionsResponseActions> action)? complete,
    TResult Function(List<DemoCallToActionsResponseActions> action)? incomplete,
    required TResult orElse(),
  }) {
    if (incomplete != null) {
      return incomplete(action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DemoActionsComplete value) complete,
    required TResult Function(_DemoActionsIncomplete value) incomplete,
  }) {
    return incomplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DemoActionsComplete value)? complete,
    TResult? Function(_DemoActionsIncomplete value)? incomplete,
  }) {
    return incomplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DemoActionsComplete value)? complete,
    TResult Function(_DemoActionsIncomplete value)? incomplete,
    required TResult orElse(),
  }) {
    if (incomplete != null) {
      return incomplete(this);
    }
    return orElse();
  }
}

abstract class _DemoActionsIncomplete extends DemoActions {
  factory _DemoActionsIncomplete(
          final List<DemoCallToActionsResponseActions> action) =
      _$DemoActionsIncompleteImpl;
  _DemoActionsIncomplete._() : super._();

  @override
  List<DemoCallToActionsResponseActions> get action;
}
