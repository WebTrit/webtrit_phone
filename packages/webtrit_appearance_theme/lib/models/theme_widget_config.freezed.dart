// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_widget_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ThemeWidgetConfig _$ThemeWidgetConfigFromJson(Map<String, dynamic> json) {
  return _ThemeWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$ThemeWidgetConfig {
  ButtonWidgetConfig? get button => throw _privateConstructorUsedError;
  GroupWidgetConfig? get group => throw _privateConstructorUsedError;
  BarWidgetConfig? get bar => throw _privateConstructorUsedError;
  PictureWidgetConfig? get picture => throw _privateConstructorUsedError;
  InputWidgetConfig? get input => throw _privateConstructorUsedError;
  TextWidgetConfig? get text => throw _privateConstructorUsedError;
  DialogWidgetConfig? get dialog => throw _privateConstructorUsedError;
  ActionPadWidgetConfig? get actionPad => throw _privateConstructorUsedError;
  StatusesWidgetConfig get statuses => throw _privateConstructorUsedError;

  /// Serializes this ThemeWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$ThemeWidgetConfigImpl implements _ThemeWidgetConfig {
  const _$ThemeWidgetConfigImpl(
      {this.button,
      this.group,
      this.bar,
      this.picture,
      this.input,
      this.text,
      this.dialog,
      this.actionPad,
      this.statuses = const StatusesWidgetConfig()});

  factory _$ThemeWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemeWidgetConfigImplFromJson(json);

  @override
  final ButtonWidgetConfig? button;
  @override
  final GroupWidgetConfig? group;
  @override
  final BarWidgetConfig? bar;
  @override
  final PictureWidgetConfig? picture;
  @override
  final InputWidgetConfig? input;
  @override
  final TextWidgetConfig? text;
  @override
  final DialogWidgetConfig? dialog;
  @override
  final ActionPadWidgetConfig? actionPad;
  @override
  @JsonKey()
  final StatusesWidgetConfig statuses;

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemeWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _ThemeWidgetConfig implements ThemeWidgetConfig {
  const factory _ThemeWidgetConfig(
      {final ButtonWidgetConfig? button,
      final GroupWidgetConfig? group,
      final BarWidgetConfig? bar,
      final PictureWidgetConfig? picture,
      final InputWidgetConfig? input,
      final TextWidgetConfig? text,
      final DialogWidgetConfig? dialog,
      final ActionPadWidgetConfig? actionPad,
      final StatusesWidgetConfig statuses}) = _$ThemeWidgetConfigImpl;

  factory _ThemeWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$ThemeWidgetConfigImpl.fromJson;

  @override
  ButtonWidgetConfig? get button;
  @override
  GroupWidgetConfig? get group;
  @override
  BarWidgetConfig? get bar;
  @override
  PictureWidgetConfig? get picture;
  @override
  InputWidgetConfig? get input;
  @override
  TextWidgetConfig? get text;
  @override
  DialogWidgetConfig? get dialog;
  @override
  ActionPadWidgetConfig? get actionPad;
  @override
  StatusesWidgetConfig get statuses;
}

ButtonWidgetConfig _$ButtonWidgetConfigFromJson(Map<String, dynamic> json) {
  return _ButtonWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$ButtonWidgetConfig {
  ElevatedButtonWidgetConfig? get primaryElevatedButton =>
      throw _privateConstructorUsedError;

  /// Serializes this ButtonWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$ButtonWidgetConfigImpl implements _ButtonWidgetConfig {
  const _$ButtonWidgetConfigImpl({this.primaryElevatedButton});

  factory _$ButtonWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ButtonWidgetConfigImplFromJson(json);

  @override
  final ElevatedButtonWidgetConfig? primaryElevatedButton;

  @override
  Map<String, dynamic> toJson() {
    return _$$ButtonWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _ButtonWidgetConfig implements ButtonWidgetConfig {
  const factory _ButtonWidgetConfig(
          {final ElevatedButtonWidgetConfig? primaryElevatedButton}) =
      _$ButtonWidgetConfigImpl;

  factory _ButtonWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$ButtonWidgetConfigImpl.fromJson;

  @override
  ElevatedButtonWidgetConfig? get primaryElevatedButton;
}

ElevatedButtonWidgetConfig _$ElevatedButtonWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _ElevatedButtonWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$ElevatedButtonWidgetConfig {
  String? get backgroundColor => throw _privateConstructorUsedError;
  String? get foregroundColor => throw _privateConstructorUsedError;
  String? get textColor => throw _privateConstructorUsedError;
  String? get iconColor => throw _privateConstructorUsedError;
  String? get disabledIconColor => throw _privateConstructorUsedError;

  /// Serializes this ElevatedButtonWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$ElevatedButtonWidgetConfigImpl implements _ElevatedButtonWidgetConfig {
  const _$ElevatedButtonWidgetConfigImpl(
      {this.backgroundColor,
      this.foregroundColor,
      this.textColor,
      this.iconColor,
      this.disabledIconColor});

  factory _$ElevatedButtonWidgetConfigImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ElevatedButtonWidgetConfigImplFromJson(json);

  @override
  final String? backgroundColor;
  @override
  final String? foregroundColor;
  @override
  final String? textColor;
  @override
  final String? iconColor;
  @override
  final String? disabledIconColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$ElevatedButtonWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _ElevatedButtonWidgetConfig
    implements ElevatedButtonWidgetConfig {
  const factory _ElevatedButtonWidgetConfig(
      {final String? backgroundColor,
      final String? foregroundColor,
      final String? textColor,
      final String? iconColor,
      final String? disabledIconColor}) = _$ElevatedButtonWidgetConfigImpl;

  factory _ElevatedButtonWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$ElevatedButtonWidgetConfigImpl.fromJson;

  @override
  String? get backgroundColor;
  @override
  String? get foregroundColor;
  @override
  String? get textColor;
  @override
  String? get iconColor;
  @override
  String? get disabledIconColor;
}

GroupWidgetConfig _$GroupWidgetConfigFromJson(Map<String, dynamic> json) {
  return _GroupWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$GroupWidgetConfig {
  GroupTitleListTileWidgetConfig? get groupTitleListTile =>
      throw _privateConstructorUsedError;
  CallActionsWidgetConfig? get callActions =>
      throw _privateConstructorUsedError;

  /// Serializes this GroupWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$GroupWidgetConfigImpl implements _GroupWidgetConfig {
  const _$GroupWidgetConfigImpl({this.groupTitleListTile, this.callActions});

  factory _$GroupWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupWidgetConfigImplFromJson(json);

  @override
  final GroupTitleListTileWidgetConfig? groupTitleListTile;
  @override
  final CallActionsWidgetConfig? callActions;

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _GroupWidgetConfig implements GroupWidgetConfig {
  const factory _GroupWidgetConfig(
      {final GroupTitleListTileWidgetConfig? groupTitleListTile,
      final CallActionsWidgetConfig? callActions}) = _$GroupWidgetConfigImpl;

  factory _GroupWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$GroupWidgetConfigImpl.fromJson;

  @override
  GroupTitleListTileWidgetConfig? get groupTitleListTile;
  @override
  CallActionsWidgetConfig? get callActions;
}

BarWidgetConfig _$BarWidgetConfigFromJson(Map<String, dynamic> json) {
  return _BarWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$BarWidgetConfig {
  BottomNavigationBarWidgetConfig? get bottomNavigationBar =>
      throw _privateConstructorUsedError;
  ExtTabBarWidgetConfig? get extTabBar => throw _privateConstructorUsedError;

  /// Serializes this BarWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$BarWidgetConfigImpl implements _BarWidgetConfig {
  const _$BarWidgetConfigImpl({this.bottomNavigationBar, this.extTabBar});

  factory _$BarWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$BarWidgetConfigImplFromJson(json);

  @override
  final BottomNavigationBarWidgetConfig? bottomNavigationBar;
  @override
  final ExtTabBarWidgetConfig? extTabBar;

  @override
  Map<String, dynamic> toJson() {
    return _$$BarWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _BarWidgetConfig implements BarWidgetConfig {
  const factory _BarWidgetConfig(
      {final BottomNavigationBarWidgetConfig? bottomNavigationBar,
      final ExtTabBarWidgetConfig? extTabBar}) = _$BarWidgetConfigImpl;

  factory _BarWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$BarWidgetConfigImpl.fromJson;

  @override
  BottomNavigationBarWidgetConfig? get bottomNavigationBar;
  @override
  ExtTabBarWidgetConfig? get extTabBar;
}

BottomNavigationBarWidgetConfig _$BottomNavigationBarWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _BottomNavigationBarWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$BottomNavigationBarWidgetConfig {
  String? get backgroundColor => throw _privateConstructorUsedError;
  String? get selectedItemColor => throw _privateConstructorUsedError;
  String? get unSelectedItemColor => throw _privateConstructorUsedError;

  /// Serializes this BottomNavigationBarWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$BottomNavigationBarWidgetConfigImpl
    implements _BottomNavigationBarWidgetConfig {
  const _$BottomNavigationBarWidgetConfigImpl(
      {this.backgroundColor, this.selectedItemColor, this.unSelectedItemColor});

  factory _$BottomNavigationBarWidgetConfigImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$BottomNavigationBarWidgetConfigImplFromJson(json);

  @override
  final String? backgroundColor;
  @override
  final String? selectedItemColor;
  @override
  final String? unSelectedItemColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$BottomNavigationBarWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _BottomNavigationBarWidgetConfig
    implements BottomNavigationBarWidgetConfig {
  const factory _BottomNavigationBarWidgetConfig(
          {final String? backgroundColor,
          final String? selectedItemColor,
          final String? unSelectedItemColor}) =
      _$BottomNavigationBarWidgetConfigImpl;

  factory _BottomNavigationBarWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$BottomNavigationBarWidgetConfigImpl.fromJson;

  @override
  String? get backgroundColor;
  @override
  String? get selectedItemColor;
  @override
  String? get unSelectedItemColor;
}

ExtTabBarWidgetConfig _$ExtTabBarWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _ExtTabBarWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$ExtTabBarWidgetConfig {
  String? get foregroundColor => throw _privateConstructorUsedError;
  String? get backgroundColor => throw _privateConstructorUsedError;
  String? get selectedItemColor => throw _privateConstructorUsedError;
  String? get unSelectedItemColor => throw _privateConstructorUsedError;

  /// Serializes this ExtTabBarWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$ExtTabBarWidgetConfigImpl implements _ExtTabBarWidgetConfig {
  const _$ExtTabBarWidgetConfigImpl(
      {this.foregroundColor,
      this.backgroundColor,
      this.selectedItemColor,
      this.unSelectedItemColor});

  factory _$ExtTabBarWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtTabBarWidgetConfigImplFromJson(json);

  @override
  final String? foregroundColor;
  @override
  final String? backgroundColor;
  @override
  final String? selectedItemColor;
  @override
  final String? unSelectedItemColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtTabBarWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _ExtTabBarWidgetConfig implements ExtTabBarWidgetConfig {
  const factory _ExtTabBarWidgetConfig(
      {final String? foregroundColor,
      final String? backgroundColor,
      final String? selectedItemColor,
      final String? unSelectedItemColor}) = _$ExtTabBarWidgetConfigImpl;

  factory _ExtTabBarWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$ExtTabBarWidgetConfigImpl.fromJson;

  @override
  String? get foregroundColor;
  @override
  String? get backgroundColor;
  @override
  String? get selectedItemColor;
  @override
  String? get unSelectedItemColor;
}

GroupTitleListTileWidgetConfig _$GroupTitleListTileWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _GroupTitleListTileWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$GroupTitleListTileWidgetConfig {
  String? get backgroundColor => throw _privateConstructorUsedError;
  String? get textColor => throw _privateConstructorUsedError;

  /// Serializes this GroupTitleListTileWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$GroupTitleListTileWidgetConfigImpl
    implements _GroupTitleListTileWidgetConfig {
  const _$GroupTitleListTileWidgetConfigImpl(
      {this.backgroundColor, this.textColor});

  factory _$GroupTitleListTileWidgetConfigImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GroupTitleListTileWidgetConfigImplFromJson(json);

  @override
  final String? backgroundColor;
  @override
  final String? textColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupTitleListTileWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _GroupTitleListTileWidgetConfig
    implements GroupTitleListTileWidgetConfig {
  const factory _GroupTitleListTileWidgetConfig(
      {final String? backgroundColor,
      final String? textColor}) = _$GroupTitleListTileWidgetConfigImpl;

  factory _GroupTitleListTileWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$GroupTitleListTileWidgetConfigImpl.fromJson;

  @override
  String? get backgroundColor;
  @override
  String? get textColor;
}

CallActionsWidgetConfig _$CallActionsWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _CallActionsWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$CallActionsWidgetConfig {
  String? get callStartBackgroundColor => throw _privateConstructorUsedError;
  String? get hangupBackgroundColor => throw _privateConstructorUsedError;
  String? get transferBackgroundColor => throw _privateConstructorUsedError;
  String? get cameraBackgroundColor => throw _privateConstructorUsedError;
  String? get cameraActiveBackgroundColor => throw _privateConstructorUsedError;
  String? get mutedBackgroundColor => throw _privateConstructorUsedError;
  String? get mutedActiveBackgroundColor => throw _privateConstructorUsedError;
  String? get speakerBackgroundColor => throw _privateConstructorUsedError;
  String? get speakerActiveBackgroundColor =>
      throw _privateConstructorUsedError;
  String? get heldBackgroundColor => throw _privateConstructorUsedError;
  String? get heldActiveBackgroundColor => throw _privateConstructorUsedError;
  String? get swapBackgroundColor => throw _privateConstructorUsedError;
  String? get keyBackgroundColor => throw _privateConstructorUsedError;
  String? get keypadBackgroundColor => throw _privateConstructorUsedError;
  String? get keypadActiveBackgroundColor => throw _privateConstructorUsedError;

  /// Serializes this CallActionsWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$CallActionsWidgetConfigImpl implements _CallActionsWidgetConfig {
  const _$CallActionsWidgetConfigImpl(
      {this.callStartBackgroundColor,
      this.hangupBackgroundColor,
      this.transferBackgroundColor,
      this.cameraBackgroundColor,
      this.cameraActiveBackgroundColor,
      this.mutedBackgroundColor,
      this.mutedActiveBackgroundColor,
      this.speakerBackgroundColor,
      this.speakerActiveBackgroundColor,
      this.heldBackgroundColor,
      this.heldActiveBackgroundColor,
      this.swapBackgroundColor,
      this.keyBackgroundColor,
      this.keypadBackgroundColor,
      this.keypadActiveBackgroundColor});

  factory _$CallActionsWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallActionsWidgetConfigImplFromJson(json);

  @override
  final String? callStartBackgroundColor;
  @override
  final String? hangupBackgroundColor;
  @override
  final String? transferBackgroundColor;
  @override
  final String? cameraBackgroundColor;
  @override
  final String? cameraActiveBackgroundColor;
  @override
  final String? mutedBackgroundColor;
  @override
  final String? mutedActiveBackgroundColor;
  @override
  final String? speakerBackgroundColor;
  @override
  final String? speakerActiveBackgroundColor;
  @override
  final String? heldBackgroundColor;
  @override
  final String? heldActiveBackgroundColor;
  @override
  final String? swapBackgroundColor;
  @override
  final String? keyBackgroundColor;
  @override
  final String? keypadBackgroundColor;
  @override
  final String? keypadActiveBackgroundColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$CallActionsWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _CallActionsWidgetConfig implements CallActionsWidgetConfig {
  const factory _CallActionsWidgetConfig(
          {final String? callStartBackgroundColor,
          final String? hangupBackgroundColor,
          final String? transferBackgroundColor,
          final String? cameraBackgroundColor,
          final String? cameraActiveBackgroundColor,
          final String? mutedBackgroundColor,
          final String? mutedActiveBackgroundColor,
          final String? speakerBackgroundColor,
          final String? speakerActiveBackgroundColor,
          final String? heldBackgroundColor,
          final String? heldActiveBackgroundColor,
          final String? swapBackgroundColor,
          final String? keyBackgroundColor,
          final String? keypadBackgroundColor,
          final String? keypadActiveBackgroundColor}) =
      _$CallActionsWidgetConfigImpl;

  factory _CallActionsWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$CallActionsWidgetConfigImpl.fromJson;

  @override
  String? get callStartBackgroundColor;
  @override
  String? get hangupBackgroundColor;
  @override
  String? get transferBackgroundColor;
  @override
  String? get cameraBackgroundColor;
  @override
  String? get cameraActiveBackgroundColor;
  @override
  String? get mutedBackgroundColor;
  @override
  String? get mutedActiveBackgroundColor;
  @override
  String? get speakerBackgroundColor;
  @override
  String? get speakerActiveBackgroundColor;
  @override
  String? get heldBackgroundColor;
  @override
  String? get heldActiveBackgroundColor;
  @override
  String? get swapBackgroundColor;
  @override
  String? get keyBackgroundColor;
  @override
  String? get keypadBackgroundColor;
  @override
  String? get keypadActiveBackgroundColor;
}

PictureWidgetConfig _$PictureWidgetConfigFromJson(Map<String, dynamic> json) {
  return _PictureWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$PictureWidgetConfig {
  LogoWidgetConfig? get onboardingPictureLogo =>
      throw _privateConstructorUsedError;
  LogoWidgetConfig? get onboardingLogo => throw _privateConstructorUsedError;
  AppIconWidgetConfig? get appIcon => throw _privateConstructorUsedError;

  /// Serializes this PictureWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$PictureWidgetConfigImpl implements _PictureWidgetConfig {
  const _$PictureWidgetConfigImpl(
      {this.onboardingPictureLogo, this.onboardingLogo, this.appIcon});

  factory _$PictureWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$PictureWidgetConfigImplFromJson(json);

  @override
  final LogoWidgetConfig? onboardingPictureLogo;
  @override
  final LogoWidgetConfig? onboardingLogo;
  @override
  final AppIconWidgetConfig? appIcon;

  @override
  Map<String, dynamic> toJson() {
    return _$$PictureWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _PictureWidgetConfig implements PictureWidgetConfig {
  const factory _PictureWidgetConfig(
      {final LogoWidgetConfig? onboardingPictureLogo,
      final LogoWidgetConfig? onboardingLogo,
      final AppIconWidgetConfig? appIcon}) = _$PictureWidgetConfigImpl;

  factory _PictureWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$PictureWidgetConfigImpl.fromJson;

  @override
  LogoWidgetConfig? get onboardingPictureLogo;
  @override
  LogoWidgetConfig? get onboardingLogo;
  @override
  AppIconWidgetConfig? get appIcon;
}

LogoWidgetConfig _$LogoWidgetConfigFromJson(Map<String, dynamic> json) {
  return _LogoWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$LogoWidgetConfig {
  double? get scale => throw _privateConstructorUsedError;
  String? get labelColor => throw _privateConstructorUsedError;

  /// Serializes this LogoWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$LogoWidgetConfigImpl implements _LogoWidgetConfig {
  const _$LogoWidgetConfigImpl({this.scale, this.labelColor});

  factory _$LogoWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogoWidgetConfigImplFromJson(json);

  @override
  final double? scale;
  @override
  final String? labelColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$LogoWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _LogoWidgetConfig implements LogoWidgetConfig {
  const factory _LogoWidgetConfig(
      {final double? scale, final String? labelColor}) = _$LogoWidgetConfigImpl;

  factory _LogoWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$LogoWidgetConfigImpl.fromJson;

  @override
  double? get scale;
  @override
  String? get labelColor;
}

AppIconWidgetConfig _$AppIconWidgetConfigFromJson(Map<String, dynamic> json) {
  return _AppIconWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$AppIconWidgetConfig {
  String? get color => throw _privateConstructorUsedError;

  /// Serializes this AppIconWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$AppIconWidgetConfigImpl implements _AppIconWidgetConfig {
  const _$AppIconWidgetConfigImpl({this.color});

  factory _$AppIconWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppIconWidgetConfigImplFromJson(json);

  @override
  final String? color;

  @override
  Map<String, dynamic> toJson() {
    return _$$AppIconWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _AppIconWidgetConfig implements AppIconWidgetConfig {
  const factory _AppIconWidgetConfig({final String? color}) =
      _$AppIconWidgetConfigImpl;

  factory _AppIconWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$AppIconWidgetConfigImpl.fromJson;

  @override
  String? get color;
}

InputWidgetConfig _$InputWidgetConfigFromJson(Map<String, dynamic> json) {
  return _InputWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$InputWidgetConfig {
  TextFormFieldWidgetConfig? get primary => throw _privateConstructorUsedError;

  /// Serializes this InputWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$InputWidgetConfigImpl implements _InputWidgetConfig {
  const _$InputWidgetConfigImpl({this.primary});

  factory _$InputWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputWidgetConfigImplFromJson(json);

  @override
  final TextFormFieldWidgetConfig? primary;

  @override
  Map<String, dynamic> toJson() {
    return _$$InputWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _InputWidgetConfig implements InputWidgetConfig {
  const factory _InputWidgetConfig({final TextFormFieldWidgetConfig? primary}) =
      _$InputWidgetConfigImpl;

  factory _InputWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$InputWidgetConfigImpl.fromJson;

  @override
  TextFormFieldWidgetConfig? get primary;
}

TextFormFieldWidgetConfig _$TextFormFieldWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _TextFormFieldWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$TextFormFieldWidgetConfig {
  String? get labelColor => throw _privateConstructorUsedError;
  InputBorderWidgetConfig? get border => throw _privateConstructorUsedError;

  /// Serializes this TextFormFieldWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$TextFormFieldWidgetConfigImpl implements _TextFormFieldWidgetConfig {
  const _$TextFormFieldWidgetConfigImpl({this.labelColor, this.border});

  factory _$TextFormFieldWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextFormFieldWidgetConfigImplFromJson(json);

  @override
  final String? labelColor;
  @override
  final InputBorderWidgetConfig? border;

  @override
  Map<String, dynamic> toJson() {
    return _$$TextFormFieldWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _TextFormFieldWidgetConfig implements TextFormFieldWidgetConfig {
  const factory _TextFormFieldWidgetConfig(
      {final String? labelColor,
      final InputBorderWidgetConfig? border}) = _$TextFormFieldWidgetConfigImpl;

  factory _TextFormFieldWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$TextFormFieldWidgetConfigImpl.fromJson;

  @override
  String? get labelColor;
  @override
  InputBorderWidgetConfig? get border;
}

InputBorderWidgetConfig _$InputBorderWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _InputBorderWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$InputBorderWidgetConfig {
  BorderWidgetConfig? get disabled => throw _privateConstructorUsedError;
  BorderWidgetConfig? get focused => throw _privateConstructorUsedError;
  BorderWidgetConfig? get any => throw _privateConstructorUsedError;

  /// Serializes this InputBorderWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$InputBorderWidgetConfigImpl implements _InputBorderWidgetConfig {
  const _$InputBorderWidgetConfigImpl({this.disabled, this.focused, this.any});

  factory _$InputBorderWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputBorderWidgetConfigImplFromJson(json);

  @override
  final BorderWidgetConfig? disabled;
  @override
  final BorderWidgetConfig? focused;
  @override
  final BorderWidgetConfig? any;

  @override
  Map<String, dynamic> toJson() {
    return _$$InputBorderWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _InputBorderWidgetConfig implements InputBorderWidgetConfig {
  const factory _InputBorderWidgetConfig(
      {final BorderWidgetConfig? disabled,
      final BorderWidgetConfig? focused,
      final BorderWidgetConfig? any}) = _$InputBorderWidgetConfigImpl;

  factory _InputBorderWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$InputBorderWidgetConfigImpl.fromJson;

  @override
  BorderWidgetConfig? get disabled;
  @override
  BorderWidgetConfig? get focused;
  @override
  BorderWidgetConfig? get any;
}

BorderWidgetConfig _$BorderWidgetConfigFromJson(Map<String, dynamic> json) {
  return _BorderWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$BorderWidgetConfig {
  String? get typicalColor => throw _privateConstructorUsedError;
  String? get errorColor => throw _privateConstructorUsedError;

  /// Serializes this BorderWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$BorderWidgetConfigImpl implements _BorderWidgetConfig {
  const _$BorderWidgetConfigImpl({this.typicalColor, this.errorColor});

  factory _$BorderWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$BorderWidgetConfigImplFromJson(json);

  @override
  final String? typicalColor;
  @override
  final String? errorColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$BorderWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _BorderWidgetConfig implements BorderWidgetConfig {
  const factory _BorderWidgetConfig(
      {final String? typicalColor,
      final String? errorColor}) = _$BorderWidgetConfigImpl;

  factory _BorderWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$BorderWidgetConfigImpl.fromJson;

  @override
  String? get typicalColor;
  @override
  String? get errorColor;
}

TextWidgetConfig _$TextWidgetConfigFromJson(Map<String, dynamic> json) {
  return _TextWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$TextWidgetConfig {
  TextSelectionWidgetConfig? get selection =>
      throw _privateConstructorUsedError;
  LinkifyWidgetConfig? get linkify => throw _privateConstructorUsedError;

  /// Serializes this TextWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$TextWidgetConfigImpl implements _TextWidgetConfig {
  const _$TextWidgetConfigImpl({this.selection, this.linkify});

  factory _$TextWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextWidgetConfigImplFromJson(json);

  @override
  final TextSelectionWidgetConfig? selection;
  @override
  final LinkifyWidgetConfig? linkify;

  @override
  Map<String, dynamic> toJson() {
    return _$$TextWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _TextWidgetConfig implements TextWidgetConfig {
  const factory _TextWidgetConfig(
      {final TextSelectionWidgetConfig? selection,
      final LinkifyWidgetConfig? linkify}) = _$TextWidgetConfigImpl;

  factory _TextWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$TextWidgetConfigImpl.fromJson;

  @override
  TextSelectionWidgetConfig? get selection;
  @override
  LinkifyWidgetConfig? get linkify;
}

TextSelectionWidgetConfig _$TextSelectionWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _TextSelectionWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$TextSelectionWidgetConfig {
  String? get cursorColor => throw _privateConstructorUsedError;
  String? get selectionColor => throw _privateConstructorUsedError;
  String? get selectionHandleColor => throw _privateConstructorUsedError;

  /// Serializes this TextSelectionWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$TextSelectionWidgetConfigImpl implements _TextSelectionWidgetConfig {
  const _$TextSelectionWidgetConfigImpl(
      {this.cursorColor, this.selectionColor, this.selectionHandleColor});

  factory _$TextSelectionWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextSelectionWidgetConfigImplFromJson(json);

  @override
  final String? cursorColor;
  @override
  final String? selectionColor;
  @override
  final String? selectionHandleColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$TextSelectionWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _TextSelectionWidgetConfig implements TextSelectionWidgetConfig {
  const factory _TextSelectionWidgetConfig(
      {final String? cursorColor,
      final String? selectionColor,
      final String? selectionHandleColor}) = _$TextSelectionWidgetConfigImpl;

  factory _TextSelectionWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$TextSelectionWidgetConfigImpl.fromJson;

  @override
  String? get cursorColor;
  @override
  String? get selectionColor;
  @override
  String? get selectionHandleColor;
}

LinkifyWidgetConfig _$LinkifyWidgetConfigFromJson(Map<String, dynamic> json) {
  return _LinkifyWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$LinkifyWidgetConfig {
  String? get styleColor => throw _privateConstructorUsedError;
  String? get linkifyStyleColor => throw _privateConstructorUsedError;

  /// Serializes this LinkifyWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$LinkifyWidgetConfigImpl implements _LinkifyWidgetConfig {
  const _$LinkifyWidgetConfigImpl({this.styleColor, this.linkifyStyleColor});

  factory _$LinkifyWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkifyWidgetConfigImplFromJson(json);

  @override
  final String? styleColor;
  @override
  final String? linkifyStyleColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkifyWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _LinkifyWidgetConfig implements LinkifyWidgetConfig {
  const factory _LinkifyWidgetConfig(
      {final String? styleColor,
      final String? linkifyStyleColor}) = _$LinkifyWidgetConfigImpl;

  factory _LinkifyWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$LinkifyWidgetConfigImpl.fromJson;

  @override
  String? get styleColor;
  @override
  String? get linkifyStyleColor;
}

DialogWidgetConfig _$DialogWidgetConfigFromJson(Map<String, dynamic> json) {
  return _DialogWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$DialogWidgetConfig {
  ConfirmDialogWidgetConfig? get confirmDialog =>
      throw _privateConstructorUsedError;
  SnackBarWidgetConfig get snackBar => throw _privateConstructorUsedError;

  /// Serializes this DialogWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$DialogWidgetConfigImpl implements _DialogWidgetConfig {
  const _$DialogWidgetConfigImpl(
      {this.confirmDialog, this.snackBar = const SnackBarWidgetConfig()});

  factory _$DialogWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$DialogWidgetConfigImplFromJson(json);

  @override
  final ConfirmDialogWidgetConfig? confirmDialog;
  @override
  @JsonKey()
  final SnackBarWidgetConfig snackBar;

  @override
  Map<String, dynamic> toJson() {
    return _$$DialogWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _DialogWidgetConfig implements DialogWidgetConfig {
  const factory _DialogWidgetConfig(
      {final ConfirmDialogWidgetConfig? confirmDialog,
      final SnackBarWidgetConfig snackBar}) = _$DialogWidgetConfigImpl;

  factory _DialogWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$DialogWidgetConfigImpl.fromJson;

  @override
  ConfirmDialogWidgetConfig? get confirmDialog;
  @override
  SnackBarWidgetConfig get snackBar;
}

ConfirmDialogWidgetConfig _$ConfirmDialogWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _ConfirmDialogWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$ConfirmDialogWidgetConfig {
  String? get activeButtonColor1 => throw _privateConstructorUsedError;
  String? get activeButtonColor2 => throw _privateConstructorUsedError;
  String? get defaultButtonColor => throw _privateConstructorUsedError;

  /// Serializes this ConfirmDialogWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$ConfirmDialogWidgetConfigImpl implements _ConfirmDialogWidgetConfig {
  const _$ConfirmDialogWidgetConfigImpl(
      {this.activeButtonColor1,
      this.activeButtonColor2,
      this.defaultButtonColor});

  factory _$ConfirmDialogWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfirmDialogWidgetConfigImplFromJson(json);

  @override
  final String? activeButtonColor1;
  @override
  final String? activeButtonColor2;
  @override
  final String? defaultButtonColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfirmDialogWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _ConfirmDialogWidgetConfig implements ConfirmDialogWidgetConfig {
  const factory _ConfirmDialogWidgetConfig(
      {final String? activeButtonColor1,
      final String? activeButtonColor2,
      final String? defaultButtonColor}) = _$ConfirmDialogWidgetConfigImpl;

  factory _ConfirmDialogWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$ConfirmDialogWidgetConfigImpl.fromJson;

  @override
  String? get activeButtonColor1;
  @override
  String? get activeButtonColor2;
  @override
  String? get defaultButtonColor;
}

SnackBarWidgetConfig _$SnackBarWidgetConfigFromJson(Map<String, dynamic> json) {
  return _SnackBarWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$SnackBarWidgetConfig {
  String get successBackgroundColor => throw _privateConstructorUsedError;
  String get errorBackgroundColor => throw _privateConstructorUsedError;
  String get infoBackgroundColor => throw _privateConstructorUsedError;
  String get warningBackgroundColor => throw _privateConstructorUsedError;

  /// Serializes this SnackBarWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$SnackBarWidgetConfigImpl implements _SnackBarWidgetConfig {
  const _$SnackBarWidgetConfigImpl(
      {this.successBackgroundColor = '#75B943',
      this.errorBackgroundColor = '#E74C3C',
      this.infoBackgroundColor = '#494949',
      this.warningBackgroundColor = '#F95A14'});

  factory _$SnackBarWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnackBarWidgetConfigImplFromJson(json);

  @override
  @JsonKey()
  final String successBackgroundColor;
  @override
  @JsonKey()
  final String errorBackgroundColor;
  @override
  @JsonKey()
  final String infoBackgroundColor;
  @override
  @JsonKey()
  final String warningBackgroundColor;

  @override
  Map<String, dynamic> toJson() {
    return _$$SnackBarWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _SnackBarWidgetConfig implements SnackBarWidgetConfig {
  const factory _SnackBarWidgetConfig(
      {final String successBackgroundColor,
      final String errorBackgroundColor,
      final String infoBackgroundColor,
      final String warningBackgroundColor}) = _$SnackBarWidgetConfigImpl;

  factory _SnackBarWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$SnackBarWidgetConfigImpl.fromJson;

  @override
  String get successBackgroundColor;
  @override
  String get errorBackgroundColor;
  @override
  String get infoBackgroundColor;
  @override
  String get warningBackgroundColor;
}

ActionPadWidgetConfig _$ActionPadWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _ActionPadWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$ActionPadWidgetConfig {
  ElevatedButtonWidgetConfig? get callStart =>
      throw _privateConstructorUsedError;
  ElevatedButtonWidgetConfig? get callTransfer =>
      throw _privateConstructorUsedError;
  ElevatedButtonWidgetConfig? get backspacePressed =>
      throw _privateConstructorUsedError;

  /// Serializes this ActionPadWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$ActionPadWidgetConfigImpl implements _ActionPadWidgetConfig {
  const _$ActionPadWidgetConfigImpl(
      {this.callStart, this.callTransfer, this.backspacePressed});

  factory _$ActionPadWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActionPadWidgetConfigImplFromJson(json);

  @override
  final ElevatedButtonWidgetConfig? callStart;
  @override
  final ElevatedButtonWidgetConfig? callTransfer;
  @override
  final ElevatedButtonWidgetConfig? backspacePressed;

  @override
  Map<String, dynamic> toJson() {
    return _$$ActionPadWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _ActionPadWidgetConfig implements ActionPadWidgetConfig {
  const factory _ActionPadWidgetConfig(
          {final ElevatedButtonWidgetConfig? callStart,
          final ElevatedButtonWidgetConfig? callTransfer,
          final ElevatedButtonWidgetConfig? backspacePressed}) =
      _$ActionPadWidgetConfigImpl;

  factory _ActionPadWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$ActionPadWidgetConfigImpl.fromJson;

  @override
  ElevatedButtonWidgetConfig? get callStart;
  @override
  ElevatedButtonWidgetConfig? get callTransfer;
  @override
  ElevatedButtonWidgetConfig? get backspacePressed;
}

StatusesWidgetConfig _$StatusesWidgetConfigFromJson(Map<String, dynamic> json) {
  return _StatusesWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$StatusesWidgetConfig {
  RegistrationStatusesWidgetConfig get registrationStatuses =>
      throw _privateConstructorUsedError;
  CallStatusesWidgetConfig get callStatuses =>
      throw _privateConstructorUsedError;

  /// Serializes this StatusesWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$StatusesWidgetConfigImpl implements _StatusesWidgetConfig {
  const _$StatusesWidgetConfigImpl(
      {this.registrationStatuses = const RegistrationStatusesWidgetConfig(),
      this.callStatuses = const CallStatusesWidgetConfig()});

  factory _$StatusesWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusesWidgetConfigImplFromJson(json);

  @override
  @JsonKey()
  final RegistrationStatusesWidgetConfig registrationStatuses;
  @override
  @JsonKey()
  final CallStatusesWidgetConfig callStatuses;

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusesWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _StatusesWidgetConfig implements StatusesWidgetConfig {
  const factory _StatusesWidgetConfig(
          {final RegistrationStatusesWidgetConfig registrationStatuses,
          final CallStatusesWidgetConfig callStatuses}) =
      _$StatusesWidgetConfigImpl;

  factory _StatusesWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$StatusesWidgetConfigImpl.fromJson;

  @override
  RegistrationStatusesWidgetConfig get registrationStatuses;
  @override
  CallStatusesWidgetConfig get callStatuses;
}

RegistrationStatusesWidgetConfig _$RegistrationStatusesWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _RegistrationStatusesWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$RegistrationStatusesWidgetConfig {
  String get online => throw _privateConstructorUsedError;
  String get offline => throw _privateConstructorUsedError;

  /// Serializes this RegistrationStatusesWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$RegistrationStatusesWidgetConfigImpl
    implements _RegistrationStatusesWidgetConfig {
  const _$RegistrationStatusesWidgetConfigImpl(
      {this.online = '#75B943', this.offline = '#EEF3F6'});

  factory _$RegistrationStatusesWidgetConfigImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RegistrationStatusesWidgetConfigImplFromJson(json);

  @override
  @JsonKey()
  final String online;
  @override
  @JsonKey()
  final String offline;

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistrationStatusesWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _RegistrationStatusesWidgetConfig
    implements RegistrationStatusesWidgetConfig {
  const factory _RegistrationStatusesWidgetConfig(
      {final String online,
      final String offline}) = _$RegistrationStatusesWidgetConfigImpl;

  factory _RegistrationStatusesWidgetConfig.fromJson(
          Map<String, dynamic> json) =
      _$RegistrationStatusesWidgetConfigImpl.fromJson;

  @override
  String get online;
  @override
  String get offline;
}

CallStatusesWidgetConfig _$CallStatusesWidgetConfigFromJson(
    Map<String, dynamic> json) {
  return _CallStatusesWidgetConfig.fromJson(json);
}

/// @nodoc
mixin _$CallStatusesWidgetConfig {
  String get connectivityNone => throw _privateConstructorUsedError;
  String get connectError => throw _privateConstructorUsedError;
  String get appUnregistered => throw _privateConstructorUsedError;
  String get connectIssue => throw _privateConstructorUsedError;
  String get inProgress => throw _privateConstructorUsedError;
  String get ready => throw _privateConstructorUsedError;

  /// Serializes this CallStatusesWidgetConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$CallStatusesWidgetConfigImpl implements _CallStatusesWidgetConfig {
  const _$CallStatusesWidgetConfigImpl(
      {this.connectivityNone = '#E74C3C',
      this.connectError = '#E74C3C',
      this.appUnregistered = '#494949',
      this.connectIssue = '#E74C3C',
      this.inProgress = '#123752',
      this.ready = '#75B943'});

  factory _$CallStatusesWidgetConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallStatusesWidgetConfigImplFromJson(json);

  @override
  @JsonKey()
  final String connectivityNone;
  @override
  @JsonKey()
  final String connectError;
  @override
  @JsonKey()
  final String appUnregistered;
  @override
  @JsonKey()
  final String connectIssue;
  @override
  @JsonKey()
  final String inProgress;
  @override
  @JsonKey()
  final String ready;

  @override
  Map<String, dynamic> toJson() {
    return _$$CallStatusesWidgetConfigImplToJson(
      this,
    );
  }
}

abstract class _CallStatusesWidgetConfig implements CallStatusesWidgetConfig {
  const factory _CallStatusesWidgetConfig(
      {final String connectivityNone,
      final String connectError,
      final String appUnregistered,
      final String connectIssue,
      final String inProgress,
      final String ready}) = _$CallStatusesWidgetConfigImpl;

  factory _CallStatusesWidgetConfig.fromJson(Map<String, dynamic> json) =
      _$CallStatusesWidgetConfigImpl.fromJson;

  @override
  String get connectivityNone;
  @override
  String get connectError;
  @override
  String get appUnregistered;
  @override
  String get connectIssue;
  @override
  String get inProgress;
  @override
  String get ready;
}
