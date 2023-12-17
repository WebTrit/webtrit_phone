// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MainCompatibilityVerified {}

/// @nodoc

class _$MainCompatibilityVerifiedImpl implements _MainCompatibilityVerified {
  const _$MainCompatibilityVerifiedImpl();

  @override
  String toString() {
    return 'MainCompatibilityVerified()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainCompatibilityVerifiedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _MainCompatibilityVerified implements MainCompatibilityVerified {
  const factory _MainCompatibilityVerified() = _$MainCompatibilityVerifiedImpl;
}

/// @nodoc
mixin _$MainAppUpdated {
  Uri get storeViewUrl => throw _privateConstructorUsedError;
}

/// @nodoc

class _$MainAppUpdatedImpl implements _MainAppUpdated {
  const _$MainAppUpdatedImpl(this.storeViewUrl);

  @override
  final Uri storeViewUrl;

  @override
  String toString() {
    return 'MainAppUpdated(storeViewUrl: $storeViewUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainAppUpdatedImpl &&
            (identical(other.storeViewUrl, storeViewUrl) ||
                other.storeViewUrl == storeViewUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, storeViewUrl);
}

abstract class _MainAppUpdated implements MainAppUpdated {
  const factory _MainAppUpdated(final Uri storeViewUrl) = _$MainAppUpdatedImpl;

  @override
  Uri get storeViewUrl;
}

/// @nodoc
mixin _$MainState {
  Object? get error => throw _privateConstructorUsedError;
  Uri? get updateStoreViewUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainStateCopyWith<MainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainStateCopyWith<$Res> {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) then) =
      _$MainStateCopyWithImpl<$Res, MainState>;
  @useResult
  $Res call({Object? error, Uri? updateStoreViewUrl});
}

/// @nodoc
class _$MainStateCopyWithImpl<$Res, $Val extends MainState>
    implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? updateStoreViewUrl = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error ? _value.error : error,
      updateStoreViewUrl: freezed == updateStoreViewUrl
          ? _value.updateStoreViewUrl
          : updateStoreViewUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainStateImplCopyWith<$Res>
    implements $MainStateCopyWith<$Res> {
  factory _$$MainStateImplCopyWith(
          _$MainStateImpl value, $Res Function(_$MainStateImpl) then) =
      __$$MainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Object? error, Uri? updateStoreViewUrl});
}

/// @nodoc
class __$$MainStateImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainStateImpl>
    implements _$$MainStateImplCopyWith<$Res> {
  __$$MainStateImplCopyWithImpl(
      _$MainStateImpl _value, $Res Function(_$MainStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? updateStoreViewUrl = freezed,
  }) {
    return _then(_$MainStateImpl(
      error: freezed == error ? _value.error : error,
      updateStoreViewUrl: freezed == updateStoreViewUrl
          ? _value.updateStoreViewUrl
          : updateStoreViewUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc

class _$MainStateImpl implements _MainState {
  const _$MainStateImpl({this.error, this.updateStoreViewUrl});

  @override
  final Object? error;
  @override
  final Uri? updateStoreViewUrl;

  @override
  String toString() {
    return 'MainState(error: $error, updateStoreViewUrl: $updateStoreViewUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainStateImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.updateStoreViewUrl, updateStoreViewUrl) ||
                other.updateStoreViewUrl == updateStoreViewUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(error), updateStoreViewUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainStateImplCopyWith<_$MainStateImpl> get copyWith =>
      __$$MainStateImplCopyWithImpl<_$MainStateImpl>(this, _$identity);
}

abstract class _MainState implements MainState {
  const factory _MainState(
      {final Object? error, final Uri? updateStoreViewUrl}) = _$MainStateImpl;

  @override
  Object? get error;
  @override
  Uri? get updateStoreViewUrl;
  @override
  @JsonKey(ignore: true)
  _$$MainStateImplCopyWith<_$MainStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
