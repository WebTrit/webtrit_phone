// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DemoCubitState {
  DemoAction? get uiAction => throw _privateConstructorUsedError;
  String? get inviteUrl => throw _privateConstructorUsedError;
  String? get convertPbxUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DemoCubitStateCopyWith<DemoCubitState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoCubitStateCopyWith<$Res> {
  factory $DemoCubitStateCopyWith(
          DemoCubitState value, $Res Function(DemoCubitState) then) =
      _$DemoCubitStateCopyWithImpl<$Res, DemoCubitState>;
  @useResult
  $Res call({DemoAction? uiAction, String? inviteUrl, String? convertPbxUrl});
}

/// @nodoc
class _$DemoCubitStateCopyWithImpl<$Res, $Val extends DemoCubitState>
    implements $DemoCubitStateCopyWith<$Res> {
  _$DemoCubitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uiAction = freezed,
    Object? inviteUrl = freezed,
    Object? convertPbxUrl = freezed,
  }) {
    return _then(_value.copyWith(
      uiAction: freezed == uiAction
          ? _value.uiAction
          : uiAction // ignore: cast_nullable_to_non_nullable
              as DemoAction?,
      inviteUrl: freezed == inviteUrl
          ? _value.inviteUrl
          : inviteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      convertPbxUrl: freezed == convertPbxUrl
          ? _value.convertPbxUrl
          : convertPbxUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DemoCubitStateImplCopyWith<$Res>
    implements $DemoCubitStateCopyWith<$Res> {
  factory _$$DemoCubitStateImplCopyWith(_$DemoCubitStateImpl value,
          $Res Function(_$DemoCubitStateImpl) then) =
      __$$DemoCubitStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DemoAction? uiAction, String? inviteUrl, String? convertPbxUrl});
}

/// @nodoc
class __$$DemoCubitStateImplCopyWithImpl<$Res>
    extends _$DemoCubitStateCopyWithImpl<$Res, _$DemoCubitStateImpl>
    implements _$$DemoCubitStateImplCopyWith<$Res> {
  __$$DemoCubitStateImplCopyWithImpl(
      _$DemoCubitStateImpl _value, $Res Function(_$DemoCubitStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uiAction = freezed,
    Object? inviteUrl = freezed,
    Object? convertPbxUrl = freezed,
  }) {
    return _then(_$DemoCubitStateImpl(
      uiAction: freezed == uiAction
          ? _value.uiAction
          : uiAction // ignore: cast_nullable_to_non_nullable
              as DemoAction?,
      inviteUrl: freezed == inviteUrl
          ? _value.inviteUrl
          : inviteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      convertPbxUrl: freezed == convertPbxUrl
          ? _value.convertPbxUrl
          : convertPbxUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DemoCubitStateImpl implements _DemoCubitState {
  const _$DemoCubitStateImpl(
      {this.uiAction, this.inviteUrl, this.convertPbxUrl});

  @override
  final DemoAction? uiAction;
  @override
  final String? inviteUrl;
  @override
  final String? convertPbxUrl;

  @override
  String toString() {
    return 'DemoCubitState(uiAction: $uiAction, inviteUrl: $inviteUrl, convertPbxUrl: $convertPbxUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoCubitStateImpl &&
            (identical(other.uiAction, uiAction) ||
                other.uiAction == uiAction) &&
            (identical(other.inviteUrl, inviteUrl) ||
                other.inviteUrl == inviteUrl) &&
            (identical(other.convertPbxUrl, convertPbxUrl) ||
                other.convertPbxUrl == convertPbxUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uiAction, inviteUrl, convertPbxUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoCubitStateImplCopyWith<_$DemoCubitStateImpl> get copyWith =>
      __$$DemoCubitStateImplCopyWithImpl<_$DemoCubitStateImpl>(
          this, _$identity);
}

abstract class _DemoCubitState implements DemoCubitState {
  const factory _DemoCubitState(
      {final DemoAction? uiAction,
      final String? inviteUrl,
      final String? convertPbxUrl}) = _$DemoCubitStateImpl;

  @override
  DemoAction? get uiAction;
  @override
  String? get inviteUrl;
  @override
  String? get convertPbxUrl;
  @override
  @JsonKey(ignore: true)
  _$$DemoCubitStateImplCopyWith<_$DemoCubitStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
