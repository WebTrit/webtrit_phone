// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FavoritesAddedByContactPhoneId {
  int get contactPhoneId => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_FavoritesAddedByContactPhoneId
    implements _FavoritesAddedByContactPhoneId {
  const _$_FavoritesAddedByContactPhoneId({required this.contactPhoneId});

  @override
  final int contactPhoneId;

  @override
  String toString() {
    return 'FavoritesAddedByContactPhoneId(contactPhoneId: $contactPhoneId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavoritesAddedByContactPhoneId &&
            (identical(other.contactPhoneId, contactPhoneId) ||
                other.contactPhoneId == contactPhoneId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactPhoneId);
}

abstract class _FavoritesAddedByContactPhoneId
    implements FavoritesAddedByContactPhoneId {
  const factory _FavoritesAddedByContactPhoneId(
      {required final int contactPhoneId}) = _$_FavoritesAddedByContactPhoneId;

  @override
  int get contactPhoneId;
}

/// @nodoc
mixin _$FavoritesRemovedByContactPhoneId {
  int get contactPhoneId => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_FavoritesRemovedByContactPhoneId
    implements _FavoritesRemovedByContactPhoneId {
  const _$_FavoritesRemovedByContactPhoneId({required this.contactPhoneId});

  @override
  final int contactPhoneId;

  @override
  String toString() {
    return 'FavoritesRemovedByContactPhoneId(contactPhoneId: $contactPhoneId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavoritesRemovedByContactPhoneId &&
            (identical(other.contactPhoneId, contactPhoneId) ||
                other.contactPhoneId == contactPhoneId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactPhoneId);
}

abstract class _FavoritesRemovedByContactPhoneId
    implements FavoritesRemovedByContactPhoneId {
  const factory _FavoritesRemovedByContactPhoneId(
          {required final int contactPhoneId}) =
      _$_FavoritesRemovedByContactPhoneId;

  @override
  int get contactPhoneId;
}

/// @nodoc
mixin _$FavoritesRemoved {
  Favorite get favorite => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_FavoritesRemoved implements _FavoritesRemoved {
  const _$_FavoritesRemoved({required this.favorite});

  @override
  final Favorite favorite;

  @override
  String toString() {
    return 'FavoritesRemoved(favorite: $favorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavoritesRemoved &&
            (identical(other.favorite, favorite) ||
                other.favorite == favorite));
  }

  @override
  int get hashCode => Object.hash(runtimeType, favorite);
}

abstract class _FavoritesRemoved implements FavoritesRemoved {
  const factory _FavoritesRemoved({required final Favorite favorite}) =
      _$_FavoritesRemoved;

  @override
  Favorite get favorite;
}

/// @nodoc
mixin _$FavoritesState {
  List<Favorite>? get favorites => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FavoritesStateCopyWith<FavoritesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesStateCopyWith<$Res> {
  factory $FavoritesStateCopyWith(
          FavoritesState value, $Res Function(FavoritesState) then) =
      _$FavoritesStateCopyWithImpl<$Res, FavoritesState>;
  @useResult
  $Res call({List<Favorite>? favorites});
}

/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res, $Val extends FavoritesState>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorites = freezed,
  }) {
    return _then(_value.copyWith(
      favorites: freezed == favorites
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavoritesStateCopyWith<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  factory _$$_FavoritesStateCopyWith(
          _$_FavoritesState value, $Res Function(_$_FavoritesState) then) =
      __$$_FavoritesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Favorite>? favorites});
}

/// @nodoc
class __$$_FavoritesStateCopyWithImpl<$Res>
    extends _$FavoritesStateCopyWithImpl<$Res, _$_FavoritesState>
    implements _$$_FavoritesStateCopyWith<$Res> {
  __$$_FavoritesStateCopyWithImpl(
      _$_FavoritesState _value, $Res Function(_$_FavoritesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorites = freezed,
  }) {
    return _then(_$_FavoritesState(
      favorites: freezed == favorites
          ? _value._favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>?,
    ));
  }
}

/// @nodoc

class _$_FavoritesState implements _FavoritesState {
  const _$_FavoritesState({final List<Favorite>? favorites})
      : _favorites = favorites;

  final List<Favorite>? _favorites;
  @override
  List<Favorite>? get favorites {
    final value = _favorites;
    if (value == null) return null;
    if (_favorites is EqualUnmodifiableListView) return _favorites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FavoritesState(favorites: $favorites)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavoritesState &&
            const DeepCollectionEquality()
                .equals(other._favorites, _favorites));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_favorites));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavoritesStateCopyWith<_$_FavoritesState> get copyWith =>
      __$$_FavoritesStateCopyWithImpl<_$_FavoritesState>(this, _$identity);
}

abstract class _FavoritesState implements FavoritesState {
  const factory _FavoritesState({final List<Favorite>? favorites}) =
      _$_FavoritesState;

  @override
  List<Favorite>? get favorites;
  @override
  @JsonKey(ignore: true)
  _$$_FavoritesStateCopyWith<_$_FavoritesState> get copyWith =>
      throw _privateConstructorUsedError;
}
