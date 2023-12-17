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

class _$OrientationsChangedImpl implements _OrientationsChanged {
  const _$OrientationsChangedImpl(this.orientation);

  @override
  final PreferredOrientation orientation;

  @override
  String toString() {
    return 'OrientationsChanged(orientation: $orientation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrientationsChangedImpl &&
            (identical(other.orientation, orientation) ||
                other.orientation == orientation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orientation);
}

abstract class _OrientationsChanged implements OrientationsChanged {
  const factory _OrientationsChanged(final PreferredOrientation orientation) =
      _$OrientationsChangedImpl;

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
abstract class _$$OrientationsStateImplCopyWith<$Res>
    implements $OrientationsStateCopyWith<$Res> {
  factory _$$OrientationsStateImplCopyWith(_$OrientationsStateImpl value,
          $Res Function(_$OrientationsStateImpl) then) =
      __$$OrientationsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PreferredOrientation? lastOrientation});
}

/// @nodoc
class __$$OrientationsStateImplCopyWithImpl<$Res>
    extends _$OrientationsStateCopyWithImpl<$Res, _$OrientationsStateImpl>
    implements _$$OrientationsStateImplCopyWith<$Res> {
  __$$OrientationsStateImplCopyWithImpl(_$OrientationsStateImpl _value,
      $Res Function(_$OrientationsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastOrientation = freezed,
  }) {
    return _then(_$OrientationsStateImpl(
      freezed == lastOrientation
          ? _value.lastOrientation
          : lastOrientation // ignore: cast_nullable_to_non_nullable
              as PreferredOrientation?,
    ));
  }
}

/// @nodoc

class _$OrientationsStateImpl implements _OrientationsState {
  const _$OrientationsStateImpl([this.lastOrientation]);

  @override
  final PreferredOrientation? lastOrientation;

  @override
  String toString() {
    return 'OrientationsState(lastOrientation: $lastOrientation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrientationsStateImpl &&
            (identical(other.lastOrientation, lastOrientation) ||
                other.lastOrientation == lastOrientation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastOrientation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrientationsStateImplCopyWith<_$OrientationsStateImpl> get copyWith =>
      __$$OrientationsStateImplCopyWithImpl<_$OrientationsStateImpl>(
          this, _$identity);
}

abstract class _OrientationsState implements OrientationsState {
  const factory _OrientationsState(
      [final PreferredOrientation? lastOrientation]) = _$OrientationsStateImpl;

  @override
  PreferredOrientation? get lastOrientation;
  @override
  @JsonKey(ignore: true)
  _$$OrientationsStateImplCopyWith<_$OrientationsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
