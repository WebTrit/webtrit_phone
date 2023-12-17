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
mixin _$FavoritesStarted {}

/// @nodoc

class _$FavoritesStartedImpl implements _FavoritesStarted {
  const _$FavoritesStartedImpl();

  @override
  String toString() {
    return 'FavoritesStarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FavoritesStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _FavoritesStarted implements FavoritesStarted {
  const factory _FavoritesStarted() = _$FavoritesStartedImpl;
}

/// @nodoc
mixin _$FavoritesAddedByContactPhoneId {
  int get contactPhoneId => throw _privateConstructorUsedError;
}

/// @nodoc

class _$FavoritesAddedByContactPhoneIdImpl
    implements _FavoritesAddedByContactPhoneId {
  const _$FavoritesAddedByContactPhoneIdImpl({required this.contactPhoneId});

  @override
  final int contactPhoneId;

  @override
  String toString() {
    return 'FavoritesAddedByContactPhoneId(contactPhoneId: $contactPhoneId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesAddedByContactPhoneIdImpl &&
            (identical(other.contactPhoneId, contactPhoneId) ||
                other.contactPhoneId == contactPhoneId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactPhoneId);
}

abstract class _FavoritesAddedByContactPhoneId
    implements FavoritesAddedByContactPhoneId {
  const factory _FavoritesAddedByContactPhoneId(
          {required final int contactPhoneId}) =
      _$FavoritesAddedByContactPhoneIdImpl;

  @override
  int get contactPhoneId;
}

/// @nodoc
mixin _$FavoritesRemovedByContactPhoneId {
  int get contactPhoneId => throw _privateConstructorUsedError;
}

/// @nodoc

class _$FavoritesRemovedByContactPhoneIdImpl
    implements _FavoritesRemovedByContactPhoneId {
  const _$FavoritesRemovedByContactPhoneIdImpl({required this.contactPhoneId});

  @override
  final int contactPhoneId;

  @override
  String toString() {
    return 'FavoritesRemovedByContactPhoneId(contactPhoneId: $contactPhoneId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesRemovedByContactPhoneIdImpl &&
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
      _$FavoritesRemovedByContactPhoneIdImpl;

  @override
  int get contactPhoneId;
}

/// @nodoc
mixin _$FavoritesRemoved {
  Favorite get favorite => throw _privateConstructorUsedError;
}

/// @nodoc

class _$FavoritesRemovedImpl implements _FavoritesRemoved {
  const _$FavoritesRemovedImpl({required this.favorite});

  @override
  final Favorite favorite;

  @override
  String toString() {
    return 'FavoritesRemoved(favorite: $favorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesRemovedImpl &&
            (identical(other.favorite, favorite) ||
                other.favorite == favorite));
  }

  @override
  int get hashCode => Object.hash(runtimeType, favorite);
}

abstract class _FavoritesRemoved implements FavoritesRemoved {
  const factory _FavoritesRemoved({required final Favorite favorite}) =
      _$FavoritesRemovedImpl;

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
abstract class _$$FavoritesStateImplCopyWith<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  factory _$$FavoritesStateImplCopyWith(_$FavoritesStateImpl value,
          $Res Function(_$FavoritesStateImpl) then) =
      __$$FavoritesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Favorite>? favorites});
}

/// @nodoc
class __$$FavoritesStateImplCopyWithImpl<$Res>
    extends _$FavoritesStateCopyWithImpl<$Res, _$FavoritesStateImpl>
    implements _$$FavoritesStateImplCopyWith<$Res> {
  __$$FavoritesStateImplCopyWithImpl(
      _$FavoritesStateImpl _value, $Res Function(_$FavoritesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorites = freezed,
  }) {
    return _then(_$FavoritesStateImpl(
      favorites: freezed == favorites
          ? _value._favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>?,
    ));
  }
}

/// @nodoc

class _$FavoritesStateImpl implements _FavoritesState {
  const _$FavoritesStateImpl({final List<Favorite>? favorites})
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesStateImpl &&
            const DeepCollectionEquality()
                .equals(other._favorites, _favorites));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_favorites));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritesStateImplCopyWith<_$FavoritesStateImpl> get copyWith =>
      __$$FavoritesStateImplCopyWithImpl<_$FavoritesStateImpl>(
          this, _$identity);
}

abstract class _FavoritesState implements FavoritesState {
  const factory _FavoritesState({final List<Favorite>? favorites}) =
      _$FavoritesStateImpl;

  @override
  List<Favorite>? get favorites;
  @override
  @JsonKey(ignore: true)
  _$$FavoritesStateImplCopyWith<_$FavoritesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
