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
  MainFlavor get flavor => throw _privateConstructorUsedError;
  Locale get locale => throw _privateConstructorUsedError;
  UserInfo? get userInfo => throw _privateConstructorUsedError;
  bool get enable => throw _privateConstructorUsedError;
  Map<MainFlavor, DemoActions> get actions =>
      throw _privateConstructorUsedError;

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
  $Res call(
      {MainFlavor flavor,
      Locale locale,
      UserInfo? userInfo,
      bool enable,
      Map<MainFlavor, DemoActions> actions});
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
    Object? flavor = null,
    Object? locale = null,
    Object? userInfo = freezed,
    Object? enable = null,
    Object? actions = null,
  }) {
    return _then(_value.copyWith(
      flavor: null == flavor
          ? _value.flavor
          : flavor // ignore: cast_nullable_to_non_nullable
              as MainFlavor,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      userInfo: freezed == userInfo
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
      enable: null == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      actions: null == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<MainFlavor, DemoActions>,
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
  $Res call(
      {MainFlavor flavor,
      Locale locale,
      UserInfo? userInfo,
      bool enable,
      Map<MainFlavor, DemoActions> actions});
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
    Object? flavor = null,
    Object? locale = null,
    Object? userInfo = freezed,
    Object? enable = null,
    Object? actions = null,
  }) {
    return _then(_$DemoCubitStateImpl(
      flavor: null == flavor
          ? _value.flavor
          : flavor // ignore: cast_nullable_to_non_nullable
              as MainFlavor,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      userInfo: freezed == userInfo
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
      enable: null == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<MainFlavor, DemoActions>,
    ));
  }
}

/// @nodoc

class _$DemoCubitStateImpl extends _DemoCubitState {
  const _$DemoCubitStateImpl(
      {required this.flavor,
      required this.locale,
      this.userInfo,
      this.enable = true,
      final Map<MainFlavor, DemoActions> actions = const {}})
      : _actions = actions,
        super._();

  @override
  final MainFlavor flavor;
  @override
  final Locale locale;
  @override
  final UserInfo? userInfo;
  @override
  @JsonKey()
  final bool enable;
  final Map<MainFlavor, DemoActions> _actions;
  @override
  @JsonKey()
  Map<MainFlavor, DemoActions> get actions {
    if (_actions is EqualUnmodifiableMapView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_actions);
  }

  @override
  String toString() {
    return 'DemoCubitState(flavor: $flavor, locale: $locale, userInfo: $userInfo, enable: $enable, actions: $actions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoCubitStateImpl &&
            (identical(other.flavor, flavor) || other.flavor == flavor) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            const DeepCollectionEquality().equals(other.userInfo, userInfo) &&
            (identical(other.enable, enable) || other.enable == enable) &&
            const DeepCollectionEquality().equals(other._actions, _actions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      flavor,
      locale,
      const DeepCollectionEquality().hash(userInfo),
      enable,
      const DeepCollectionEquality().hash(_actions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoCubitStateImplCopyWith<_$DemoCubitStateImpl> get copyWith =>
      __$$DemoCubitStateImplCopyWithImpl<_$DemoCubitStateImpl>(
          this, _$identity);
}

abstract class _DemoCubitState extends DemoCubitState {
  const factory _DemoCubitState(
      {required final MainFlavor flavor,
      required final Locale locale,
      final UserInfo? userInfo,
      final bool enable,
      final Map<MainFlavor, DemoActions> actions}) = _$DemoCubitStateImpl;
  const _DemoCubitState._() : super._();

  @override
  MainFlavor get flavor;
  @override
  Locale get locale;
  @override
  UserInfo? get userInfo;
  @override
  bool get enable;
  @override
  Map<MainFlavor, DemoActions> get actions;
  @override
  @JsonKey(ignore: true)
  _$$DemoCubitStateImplCopyWith<_$DemoCubitStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
