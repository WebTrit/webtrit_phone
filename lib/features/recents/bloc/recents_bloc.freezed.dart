// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recents_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecentsDeleted {
  Recent get recent => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_RecentsDeleted implements _RecentsDeleted {
  const _$_RecentsDeleted(this.recent);

  @override
  final Recent recent;

  @override
  String toString() {
    return 'RecentsDeleted(recent: $recent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecentsDeleted &&
            (identical(other.recent, recent) || other.recent == recent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recent);
}

abstract class _RecentsDeleted implements RecentsDeleted {
  const factory _RecentsDeleted(final Recent recent) = _$_RecentsDeleted;

  @override
  Recent get recent;
}

/// @nodoc
mixin _$RecentsState {
  List<Recent>? get recents => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecentsStateCopyWith<RecentsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentsStateCopyWith<$Res> {
  factory $RecentsStateCopyWith(
          RecentsState value, $Res Function(RecentsState) then) =
      _$RecentsStateCopyWithImpl<$Res, RecentsState>;
  @useResult
  $Res call({List<Recent>? recents});
}

/// @nodoc
class _$RecentsStateCopyWithImpl<$Res, $Val extends RecentsState>
    implements $RecentsStateCopyWith<$Res> {
  _$RecentsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recents = freezed,
  }) {
    return _then(_value.copyWith(
      recents: freezed == recents
          ? _value.recents
          : recents // ignore: cast_nullable_to_non_nullable
              as List<Recent>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecentsStateCopyWith<$Res>
    implements $RecentsStateCopyWith<$Res> {
  factory _$$_RecentsStateCopyWith(
          _$_RecentsState value, $Res Function(_$_RecentsState) then) =
      __$$_RecentsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Recent>? recents});
}

/// @nodoc
class __$$_RecentsStateCopyWithImpl<$Res>
    extends _$RecentsStateCopyWithImpl<$Res, _$_RecentsState>
    implements _$$_RecentsStateCopyWith<$Res> {
  __$$_RecentsStateCopyWithImpl(
      _$_RecentsState _value, $Res Function(_$_RecentsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recents = freezed,
  }) {
    return _then(_$_RecentsState(
      recents: freezed == recents
          ? _value._recents
          : recents // ignore: cast_nullable_to_non_nullable
              as List<Recent>?,
    ));
  }
}

/// @nodoc

class _$_RecentsState implements _RecentsState {
  const _$_RecentsState({final List<Recent>? recents}) : _recents = recents;

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
  String toString() {
    return 'RecentsState(recents: $recents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecentsState &&
            const DeepCollectionEquality().equals(other._recents, _recents));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_recents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecentsStateCopyWith<_$_RecentsState> get copyWith =>
      __$$_RecentsStateCopyWithImpl<_$_RecentsState>(this, _$identity);
}

abstract class _RecentsState implements RecentsState {
  const factory _RecentsState({final List<Recent>? recents}) = _$_RecentsState;

  @override
  List<Recent>? get recents;
  @override
  @JsonKey(ignore: true)
  _$$_RecentsStateCopyWith<_$_RecentsState> get copyWith =>
      throw _privateConstructorUsedError;
}
