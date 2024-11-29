// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_to_actions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CallToActionsCubitState {
  Locale get locale => throw _privateConstructorUsedError;
  Map<MainFlavor, List<CallToAction>> get actions =>
      throw _privateConstructorUsedError;
  bool get visible => throw _privateConstructorUsedError;
  MainFlavor? get flavor => throw _privateConstructorUsedError;

  /// Create a copy of CallToActionsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallToActionsCubitStateCopyWith<CallToActionsCubitState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallToActionsCubitStateCopyWith<$Res> {
  factory $CallToActionsCubitStateCopyWith(CallToActionsCubitState value,
          $Res Function(CallToActionsCubitState) then) =
      _$CallToActionsCubitStateCopyWithImpl<$Res, CallToActionsCubitState>;
  @useResult
  $Res call(
      {Locale locale,
      Map<MainFlavor, List<CallToAction>> actions,
      bool visible,
      MainFlavor? flavor});
}

/// @nodoc
class _$CallToActionsCubitStateCopyWithImpl<$Res,
        $Val extends CallToActionsCubitState>
    implements $CallToActionsCubitStateCopyWith<$Res> {
  _$CallToActionsCubitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallToActionsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
    Object? actions = null,
    Object? visible = null,
    Object? flavor = freezed,
  }) {
    return _then(_value.copyWith(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      actions: null == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<MainFlavor, List<CallToAction>>,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      flavor: freezed == flavor
          ? _value.flavor
          : flavor // ignore: cast_nullable_to_non_nullable
              as MainFlavor?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallToActionsCubitStateImplCopyWith<$Res>
    implements $CallToActionsCubitStateCopyWith<$Res> {
  factory _$$CallToActionsCubitStateImplCopyWith(
          _$CallToActionsCubitStateImpl value,
          $Res Function(_$CallToActionsCubitStateImpl) then) =
      __$$CallToActionsCubitStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Locale locale,
      Map<MainFlavor, List<CallToAction>> actions,
      bool visible,
      MainFlavor? flavor});
}

/// @nodoc
class __$$CallToActionsCubitStateImplCopyWithImpl<$Res>
    extends _$CallToActionsCubitStateCopyWithImpl<$Res,
        _$CallToActionsCubitStateImpl>
    implements _$$CallToActionsCubitStateImplCopyWith<$Res> {
  __$$CallToActionsCubitStateImplCopyWithImpl(
      _$CallToActionsCubitStateImpl _value,
      $Res Function(_$CallToActionsCubitStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CallToActionsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
    Object? actions = null,
    Object? visible = null,
    Object? flavor = freezed,
  }) {
    return _then(_$CallToActionsCubitStateImpl(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<MainFlavor, List<CallToAction>>,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      flavor: freezed == flavor
          ? _value.flavor
          : flavor // ignore: cast_nullable_to_non_nullable
              as MainFlavor?,
    ));
  }
}

/// @nodoc

class _$CallToActionsCubitStateImpl extends _CallToActionsCubitState {
  const _$CallToActionsCubitStateImpl(
      {required this.locale,
      final Map<MainFlavor, List<CallToAction>> actions = const {},
      this.visible = true,
      this.flavor})
      : _actions = actions,
        super._();

  @override
  final Locale locale;
  final Map<MainFlavor, List<CallToAction>> _actions;
  @override
  @JsonKey()
  Map<MainFlavor, List<CallToAction>> get actions {
    if (_actions is EqualUnmodifiableMapView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_actions);
  }

  @override
  @JsonKey()
  final bool visible;
  @override
  final MainFlavor? flavor;

  @override
  String toString() {
    return 'CallToActionsCubitState(locale: $locale, actions: $actions, visible: $visible, flavor: $flavor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallToActionsCubitStateImpl &&
            (identical(other.locale, locale) || other.locale == locale) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.flavor, flavor) || other.flavor == flavor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locale,
      const DeepCollectionEquality().hash(_actions), visible, flavor);

  /// Create a copy of CallToActionsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallToActionsCubitStateImplCopyWith<_$CallToActionsCubitStateImpl>
      get copyWith => __$$CallToActionsCubitStateImplCopyWithImpl<
          _$CallToActionsCubitStateImpl>(this, _$identity);
}

abstract class _CallToActionsCubitState extends CallToActionsCubitState {
  const factory _CallToActionsCubitState(
      {required final Locale locale,
      final Map<MainFlavor, List<CallToAction>> actions,
      final bool visible,
      final MainFlavor? flavor}) = _$CallToActionsCubitStateImpl;
  const _CallToActionsCubitState._() : super._();

  @override
  Locale get locale;
  @override
  Map<MainFlavor, List<CallToAction>> get actions;
  @override
  bool get visible;
  @override
  MainFlavor? get flavor;

  /// Create a copy of CallToActionsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallToActionsCubitStateImplCopyWith<_$CallToActionsCubitStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
