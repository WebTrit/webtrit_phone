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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DemoCallToActionsParam _$DemoCallToActionsParamFromJson(
  Map<String, dynamic> json,
) {
  return _DemoCallToActionsParam.fromJson(json);
}

/// @nodoc
mixin _$DemoCallToActionsParam {
  String get email => throw _privateConstructorUsedError;
  String get tab => throw _privateConstructorUsedError;

  /// Serializes this DemoCallToActionsParam to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DemoCallToActionsParam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DemoCallToActionsParamCopyWith<DemoCallToActionsParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoCallToActionsParamCopyWith<$Res> {
  factory $DemoCallToActionsParamCopyWith(
    DemoCallToActionsParam value,
    $Res Function(DemoCallToActionsParam) then,
  ) = _$DemoCallToActionsParamCopyWithImpl<$Res, DemoCallToActionsParam>;
  @useResult
  $Res call({String email, String tab});
}

/// @nodoc
class _$DemoCallToActionsParamCopyWithImpl<
  $Res,
  $Val extends DemoCallToActionsParam
>
    implements $DemoCallToActionsParamCopyWith<$Res> {
  _$DemoCallToActionsParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DemoCallToActionsParam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? tab = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            tab: null == tab
                ? _value.tab
                : tab // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DemoCallToActionsParamImplCopyWith<$Res>
    implements $DemoCallToActionsParamCopyWith<$Res> {
  factory _$$DemoCallToActionsParamImplCopyWith(
    _$DemoCallToActionsParamImpl value,
    $Res Function(_$DemoCallToActionsParamImpl) then,
  ) = __$$DemoCallToActionsParamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String tab});
}

/// @nodoc
class __$$DemoCallToActionsParamImplCopyWithImpl<$Res>
    extends
        _$DemoCallToActionsParamCopyWithImpl<$Res, _$DemoCallToActionsParamImpl>
    implements _$$DemoCallToActionsParamImplCopyWith<$Res> {
  __$$DemoCallToActionsParamImplCopyWithImpl(
    _$DemoCallToActionsParamImpl _value,
    $Res Function(_$DemoCallToActionsParamImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DemoCallToActionsParam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? tab = null}) {
    return _then(
      _$DemoCallToActionsParamImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        tab: null == tab
            ? _value.tab
            : tab // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DemoCallToActionsParamImpl implements _DemoCallToActionsParam {
  _$DemoCallToActionsParamImpl({required this.email, required this.tab});

  factory _$DemoCallToActionsParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$DemoCallToActionsParamImplFromJson(json);

  @override
  final String email;
  @override
  final String tab;

  @override
  String toString() {
    return 'DemoCallToActionsParam(email: $email, tab: $tab)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoCallToActionsParamImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.tab, tab) || other.tab == tab));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, tab);

  /// Create a copy of DemoCallToActionsParam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoCallToActionsParamImplCopyWith<_$DemoCallToActionsParamImpl>
  get copyWith =>
      __$$DemoCallToActionsParamImplCopyWithImpl<_$DemoCallToActionsParamImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DemoCallToActionsParamImplToJson(this);
  }
}

abstract class _DemoCallToActionsParam implements DemoCallToActionsParam {
  factory _DemoCallToActionsParam({
    required final String email,
    required final String tab,
  }) = _$DemoCallToActionsParamImpl;

  factory _DemoCallToActionsParam.fromJson(Map<String, dynamic> json) =
      _$DemoCallToActionsParamImpl.fromJson;

  @override
  String get email;
  @override
  String get tab;

  /// Create a copy of DemoCallToActionsParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DemoCallToActionsParamImplCopyWith<_$DemoCallToActionsParamImpl>
  get copyWith => throw _privateConstructorUsedError;
}
