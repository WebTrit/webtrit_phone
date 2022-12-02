// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
            (identical(other.orientation, orientation) ||
                other.orientation == orientation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orientation);
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
      _$OrientationsStateCopyWithImpl<$Res, OrientationsState>;
  @useResult
  $Res call({PreferredOrientation? lastOrientation});
}

/// @nodoc
class _$OrientationsStateCopyWithImpl<$Res, $Val extends OrientationsState>
    implements $OrientationsStateCopyWith<$Res> {
  _$OrientationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastOrientation = freezed,
  }) {
    return _then(_value.copyWith(
      lastOrientation: freezed == lastOrientation
          ? _value.lastOrientation
          : lastOrientation // ignore: cast_nullable_to_non_nullable
              as PreferredOrientation?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrientationsStateCopyWith<$Res>
    implements $OrientationsStateCopyWith<$Res> {
  factory _$$_OrientationsStateCopyWith(_$_OrientationsState value,
          $Res Function(_$_OrientationsState) then) =
      __$$_OrientationsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PreferredOrientation? lastOrientation});
}

/// @nodoc
class __$$_OrientationsStateCopyWithImpl<$Res>
    extends _$OrientationsStateCopyWithImpl<$Res, _$_OrientationsState>
    implements _$$_OrientationsStateCopyWith<$Res> {
  __$$_OrientationsStateCopyWithImpl(
      _$_OrientationsState _value, $Res Function(_$_OrientationsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastOrientation = freezed,
  }) {
    return _then(_$_OrientationsState(
      freezed == lastOrientation
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
            (identical(other.lastOrientation, lastOrientation) ||
                other.lastOrientation == lastOrientation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastOrientation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
