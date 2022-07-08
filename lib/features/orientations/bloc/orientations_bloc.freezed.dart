// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'orientations_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OrientationsChanged {
  PreferredOrientation get orientation => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_OrientationsChanged implements _OrientationsChanged {
  const _$_OrientationsChanged(this.orientation);

  @override
  final PreferredOrientation orientation;

  @override
  String toString() {
    return 'OrientationsChanged(orientation: $orientation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrientationsChanged &&
            const DeepCollectionEquality()
                .equals(other.orientation, orientation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(orientation));
}

abstract class _OrientationsChanged implements OrientationsChanged {
  const factory _OrientationsChanged(final PreferredOrientation orientation) =
      _$_OrientationsChanged;

  @override
  PreferredOrientation get orientation;
}

/// @nodoc
mixin _$OrientationsState {
  PreferredOrientation? get lastOrientation =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrientationsStateCopyWith<OrientationsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrientationsStateCopyWith<$Res> {
  factory $OrientationsStateCopyWith(
          OrientationsState value, $Res Function(OrientationsState) then) =
      _$OrientationsStateCopyWithImpl<$Res>;
  $Res call({PreferredOrientation? lastOrientation});
}

/// @nodoc
class _$OrientationsStateCopyWithImpl<$Res>
    implements $OrientationsStateCopyWith<$Res> {
  _$OrientationsStateCopyWithImpl(this._value, this._then);

  final OrientationsState _value;
  // ignore: unused_field
  final $Res Function(OrientationsState) _then;

  @override
  $Res call({
    Object? lastOrientation = freezed,
  }) {
    return _then(_value.copyWith(
      lastOrientation: lastOrientation == freezed
          ? _value.lastOrientation
          : lastOrientation // ignore: cast_nullable_to_non_nullable
              as PreferredOrientation?,
    ));
  }
}

/// @nodoc
abstract class _$$_OrientationsStateCopyWith<$Res>
    implements $OrientationsStateCopyWith<$Res> {
  factory _$$_OrientationsStateCopyWith(_$_OrientationsState value,
          $Res Function(_$_OrientationsState) then) =
      __$$_OrientationsStateCopyWithImpl<$Res>;
  @override
  $Res call({PreferredOrientation? lastOrientation});
}

/// @nodoc
class __$$_OrientationsStateCopyWithImpl<$Res>
    extends _$OrientationsStateCopyWithImpl<$Res>
    implements _$$_OrientationsStateCopyWith<$Res> {
  __$$_OrientationsStateCopyWithImpl(
      _$_OrientationsState _value, $Res Function(_$_OrientationsState) _then)
      : super(_value, (v) => _then(v as _$_OrientationsState));

  @override
  _$_OrientationsState get _value => super._value as _$_OrientationsState;

  @override
  $Res call({
    Object? lastOrientation = freezed,
  }) {
    return _then(_$_OrientationsState(
      lastOrientation == freezed
          ? _value.lastOrientation
          : lastOrientation // ignore: cast_nullable_to_non_nullable
              as PreferredOrientation?,
    ));
  }
}

/// @nodoc

class _$_OrientationsState implements _OrientationsState {
  const _$_OrientationsState([this.lastOrientation]);

  @override
  final PreferredOrientation? lastOrientation;

  @override
  String toString() {
    return 'OrientationsState(lastOrientation: $lastOrientation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrientationsState &&
            const DeepCollectionEquality()
                .equals(other.lastOrientation, lastOrientation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(lastOrientation));

  @JsonKey(ignore: true)
  @override
  _$$_OrientationsStateCopyWith<_$_OrientationsState> get copyWith =>
      __$$_OrientationsStateCopyWithImpl<_$_OrientationsState>(
          this, _$identity);
}

abstract class _OrientationsState implements OrientationsState {
  const factory _OrientationsState(
      [final PreferredOrientation? lastOrientation]) = _$_OrientationsState;

  @override
  PreferredOrientation? get lastOrientation;
  @override
  @JsonKey(ignore: true)
  _$$_OrientationsStateCopyWith<_$_OrientationsState> get copyWith =>
      throw _privateConstructorUsedError;
}
