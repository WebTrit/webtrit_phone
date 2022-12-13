// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecentDeleted {
  Recent get recent => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_RecentDeleted implements _RecentDeleted {
  const _$_RecentDeleted(this.recent);

  @override
  final Recent recent;

  @override
  String toString() {
    return 'RecentDeleted(recent: $recent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecentDeleted &&
            (identical(other.recent, recent) || other.recent == recent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recent);
}

abstract class _RecentDeleted implements RecentDeleted {
  const factory _RecentDeleted(final Recent recent) = _$_RecentDeleted;

  @override
  Recent get recent;
}

/// @nodoc
mixin _$RecentState {
  Recent? get recent => throw _privateConstructorUsedError;
  List<Recent>? get recents => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecentStateCopyWith<RecentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentStateCopyWith<$Res> {
  factory $RecentStateCopyWith(
          RecentState value, $Res Function(RecentState) then) =
      _$RecentStateCopyWithImpl<$Res, RecentState>;
  @useResult
  $Res call({Recent? recent, List<Recent>? recents});
}

/// @nodoc
class _$RecentStateCopyWithImpl<$Res, $Val extends RecentState>
    implements $RecentStateCopyWith<$Res> {
  _$RecentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recent = freezed,
    Object? recents = freezed,
  }) {
    return _then(_value.copyWith(
      recent: freezed == recent
          ? _value.recent
          : recent // ignore: cast_nullable_to_non_nullable
              as Recent?,
      recents: freezed == recents
          ? _value.recents
          : recents // ignore: cast_nullable_to_non_nullable
              as List<Recent>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecentStateCopyWith<$Res>
    implements $RecentStateCopyWith<$Res> {
  factory _$$_RecentStateCopyWith(
          _$_RecentState value, $Res Function(_$_RecentState) then) =
      __$$_RecentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Recent? recent, List<Recent>? recents});
}

/// @nodoc
class __$$_RecentStateCopyWithImpl<$Res>
    extends _$RecentStateCopyWithImpl<$Res, _$_RecentState>
    implements _$$_RecentStateCopyWith<$Res> {
  __$$_RecentStateCopyWithImpl(
      _$_RecentState _value, $Res Function(_$_RecentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recent = freezed,
    Object? recents = freezed,
  }) {
    return _then(_$_RecentState(
      recent: freezed == recent
          ? _value.recent
          : recent // ignore: cast_nullable_to_non_nullable
              as Recent?,
      recents: freezed == recents
          ? _value._recents
          : recents // ignore: cast_nullable_to_non_nullable
              as List<Recent>?,
    ));
  }
}

/// @nodoc

class _$_RecentState implements _RecentState {
  const _$_RecentState({this.recent, final List<Recent>? recents})
      : _recents = recents;

  @override
  final Recent? recent;
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
    return 'RecentState(recent: $recent, recents: $recents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecentState &&
            (identical(other.recent, recent) || other.recent == recent) &&
            const DeepCollectionEquality().equals(other._recents, _recents));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, recent, const DeepCollectionEquality().hash(_recents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecentStateCopyWith<_$_RecentState> get copyWith =>
      __$$_RecentStateCopyWithImpl<_$_RecentState>(this, _$identity);
}

abstract class _RecentState implements RecentState {
  const factory _RecentState(
      {final Recent? recent, final List<Recent>? recents}) = _$_RecentState;

  @override
  Recent? get recent;
  @override
  List<Recent>? get recents;
  @override
  @JsonKey(ignore: true)
  _$$_RecentStateCopyWith<_$_RecentState> get copyWith =>
      throw _privateConstructorUsedError;
}
