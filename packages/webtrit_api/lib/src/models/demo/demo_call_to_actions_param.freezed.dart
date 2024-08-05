// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_call_to_actions_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DemoCallToActionsParam _$DemoCallToActionsParamFromJson(
    Map<String, dynamic> json) {
  return _DemoCallToActionsParam.fromJson(json);
}

/// @nodoc
mixin _$DemoCallToActionsParam {
  String get email => throw _privateConstructorUsedError;
  set email(String value) => throw _privateConstructorUsedError;
  String get tab => throw _privateConstructorUsedError;
  set tab(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DemoCallToActionsParamCopyWith<DemoCallToActionsParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoCallToActionsParamCopyWith<$Res> {
  factory $DemoCallToActionsParamCopyWith(DemoCallToActionsParam value,
          $Res Function(DemoCallToActionsParam) then) =
      _$DemoCallToActionsParamCopyWithImpl<$Res, DemoCallToActionsParam>;
  @useResult
  $Res call({String email, String tab});
}

/// @nodoc
class _$DemoCallToActionsParamCopyWithImpl<$Res,
        $Val extends DemoCallToActionsParam>
    implements $DemoCallToActionsParamCopyWith<$Res> {
  _$DemoCallToActionsParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? tab = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      tab: null == tab
          ? _value.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DemoCallToActionsParamImplCopyWith<$Res>
    implements $DemoCallToActionsParamCopyWith<$Res> {
  factory _$$DemoCallToActionsParamImplCopyWith(
          _$DemoCallToActionsParamImpl value,
          $Res Function(_$DemoCallToActionsParamImpl) then) =
      __$$DemoCallToActionsParamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String tab});
}

/// @nodoc
class __$$DemoCallToActionsParamImplCopyWithImpl<$Res>
    extends _$DemoCallToActionsParamCopyWithImpl<$Res,
        _$DemoCallToActionsParamImpl>
    implements _$$DemoCallToActionsParamImplCopyWith<$Res> {
  __$$DemoCallToActionsParamImplCopyWithImpl(
      _$DemoCallToActionsParamImpl _value,
      $Res Function(_$DemoCallToActionsParamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? tab = null,
  }) {
    return _then(_$DemoCallToActionsParamImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      tab: null == tab
          ? _value.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DemoCallToActionsParamImpl implements _DemoCallToActionsParam {
  _$DemoCallToActionsParamImpl({required this.email, required this.tab});

  factory _$DemoCallToActionsParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$DemoCallToActionsParamImplFromJson(json);

  @override
  String email;
  @override
  String tab;

  @override
  String toString() {
    return 'DemoCallToActionsParam(email: $email, tab: $tab)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoCallToActionsParamImplCopyWith<_$DemoCallToActionsParamImpl>
      get copyWith => __$$DemoCallToActionsParamImplCopyWithImpl<
          _$DemoCallToActionsParamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DemoCallToActionsParamImplToJson(
      this,
    );
  }
}

abstract class _DemoCallToActionsParam implements DemoCallToActionsParam {
  factory _DemoCallToActionsParam(
      {required String email,
      required String tab}) = _$DemoCallToActionsParamImpl;

  factory _DemoCallToActionsParam.fromJson(Map<String, dynamic> json) =
      _$DemoCallToActionsParamImpl.fromJson;

  @override
  String get email;
  set email(String value);
  @override
  String get tab;
  set tab(String value);
  @override
  @JsonKey(ignore: true)
  _$$DemoCallToActionsParamImplCopyWith<_$DemoCallToActionsParamImpl>
      get copyWith => throw _privateConstructorUsedError;
}
