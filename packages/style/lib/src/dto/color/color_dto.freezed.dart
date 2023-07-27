// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ColorDTO _$ColorDTOFromJson(Map<String, dynamic> json) {
  return _ColorDTO.fromJson(json);
}

/// @nodoc
mixin _$ColorDTO {
  String? get primary => throw _privateConstructorUsedError;
  String? get onPrimary => throw _privateConstructorUsedError;
  String? get secondary => throw _privateConstructorUsedError;
  String? get secondaryContainer => throw _privateConstructorUsedError;
  String? get onSecondaryContainer => throw _privateConstructorUsedError;
  String? get tertiary => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get outline => throw _privateConstructorUsedError;
  String? get background => throw _privateConstructorUsedError;
  String? get onBackground => throw _privateConstructorUsedError;
  String? get surface => throw _privateConstructorUsedError;
  String? get onSurface => throw _privateConstructorUsedError;
  List<String>? get gradientTabColor => throw _privateConstructorUsedError;
  LaunchDTO? get launch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ColorDTOCopyWith<ColorDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColorDTOCopyWith<$Res> {
  factory $ColorDTOCopyWith(ColorDTO value, $Res Function(ColorDTO) then) =
      _$ColorDTOCopyWithImpl<$Res, ColorDTO>;
  @useResult
  $Res call(
      {String? primary,
      String? onPrimary,
      String? secondary,
      String? secondaryContainer,
      String? onSecondaryContainer,
      String? tertiary,
      String? error,
      String? outline,
      String? background,
      String? onBackground,
      String? surface,
      String? onSurface,
      List<String>? gradientTabColor,
      LaunchDTO? launch});

  $LaunchDTOCopyWith<$Res>? get launch;
}

/// @nodoc
class _$ColorDTOCopyWithImpl<$Res, $Val extends ColorDTO>
    implements $ColorDTOCopyWith<$Res> {
  _$ColorDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = freezed,
    Object? onPrimary = freezed,
    Object? secondary = freezed,
    Object? secondaryContainer = freezed,
    Object? onSecondaryContainer = freezed,
    Object? tertiary = freezed,
    Object? error = freezed,
    Object? outline = freezed,
    Object? background = freezed,
    Object? onBackground = freezed,
    Object? surface = freezed,
    Object? onSurface = freezed,
    Object? gradientTabColor = freezed,
    Object? launch = freezed,
  }) {
    return _then(_value.copyWith(
      primary: freezed == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as String?,
      onPrimary: freezed == onPrimary
          ? _value.onPrimary
          : onPrimary // ignore: cast_nullable_to_non_nullable
              as String?,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryContainer: freezed == secondaryContainer
          ? _value.secondaryContainer
          : secondaryContainer // ignore: cast_nullable_to_non_nullable
              as String?,
      onSecondaryContainer: freezed == onSecondaryContainer
          ? _value.onSecondaryContainer
          : onSecondaryContainer // ignore: cast_nullable_to_non_nullable
              as String?,
      tertiary: freezed == tertiary
          ? _value.tertiary
          : tertiary // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      outline: freezed == outline
          ? _value.outline
          : outline // ignore: cast_nullable_to_non_nullable
              as String?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      onBackground: freezed == onBackground
          ? _value.onBackground
          : onBackground // ignore: cast_nullable_to_non_nullable
              as String?,
      surface: freezed == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as String?,
      onSurface: freezed == onSurface
          ? _value.onSurface
          : onSurface // ignore: cast_nullable_to_non_nullable
              as String?,
      gradientTabColor: freezed == gradientTabColor
          ? _value.gradientTabColor
          : gradientTabColor // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      launch: freezed == launch
          ? _value.launch
          : launch // ignore: cast_nullable_to_non_nullable
              as LaunchDTO?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LaunchDTOCopyWith<$Res>? get launch {
    if (_value.launch == null) {
      return null;
    }

    return $LaunchDTOCopyWith<$Res>(_value.launch!, (value) {
      return _then(_value.copyWith(launch: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ColorDTOCopyWith<$Res> implements $ColorDTOCopyWith<$Res> {
  factory _$$_ColorDTOCopyWith(
          _$_ColorDTO value, $Res Function(_$_ColorDTO) then) =
      __$$_ColorDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? primary,
      String? onPrimary,
      String? secondary,
      String? secondaryContainer,
      String? onSecondaryContainer,
      String? tertiary,
      String? error,
      String? outline,
      String? background,
      String? onBackground,
      String? surface,
      String? onSurface,
      List<String>? gradientTabColor,
      LaunchDTO? launch});

  @override
  $LaunchDTOCopyWith<$Res>? get launch;
}

/// @nodoc
class __$$_ColorDTOCopyWithImpl<$Res>
    extends _$ColorDTOCopyWithImpl<$Res, _$_ColorDTO>
    implements _$$_ColorDTOCopyWith<$Res> {
  __$$_ColorDTOCopyWithImpl(
      _$_ColorDTO _value, $Res Function(_$_ColorDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = freezed,
    Object? onPrimary = freezed,
    Object? secondary = freezed,
    Object? secondaryContainer = freezed,
    Object? onSecondaryContainer = freezed,
    Object? tertiary = freezed,
    Object? error = freezed,
    Object? outline = freezed,
    Object? background = freezed,
    Object? onBackground = freezed,
    Object? surface = freezed,
    Object? onSurface = freezed,
    Object? gradientTabColor = freezed,
    Object? launch = freezed,
  }) {
    return _then(_$_ColorDTO(
      primary: freezed == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as String?,
      onPrimary: freezed == onPrimary
          ? _value.onPrimary
          : onPrimary // ignore: cast_nullable_to_non_nullable
              as String?,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryContainer: freezed == secondaryContainer
          ? _value.secondaryContainer
          : secondaryContainer // ignore: cast_nullable_to_non_nullable
              as String?,
      onSecondaryContainer: freezed == onSecondaryContainer
          ? _value.onSecondaryContainer
          : onSecondaryContainer // ignore: cast_nullable_to_non_nullable
              as String?,
      tertiary: freezed == tertiary
          ? _value.tertiary
          : tertiary // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      outline: freezed == outline
          ? _value.outline
          : outline // ignore: cast_nullable_to_non_nullable
              as String?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      onBackground: freezed == onBackground
          ? _value.onBackground
          : onBackground // ignore: cast_nullable_to_non_nullable
              as String?,
      surface: freezed == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as String?,
      onSurface: freezed == onSurface
          ? _value.onSurface
          : onSurface // ignore: cast_nullable_to_non_nullable
              as String?,
      gradientTabColor: freezed == gradientTabColor
          ? _value.gradientTabColor
          : gradientTabColor // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      launch: freezed == launch
          ? _value.launch
          : launch // ignore: cast_nullable_to_non_nullable
              as LaunchDTO?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ColorDTO implements _ColorDTO {
  const _$_ColorDTO(
      {this.primary,
      this.onPrimary,
      this.secondary,
      this.secondaryContainer,
      this.onSecondaryContainer,
      this.tertiary,
      this.error,
      this.outline,
      this.background,
      this.onBackground,
      this.surface,
      this.onSurface,
      this.gradientTabColor,
      this.launch});

  factory _$_ColorDTO.fromJson(Map<String, dynamic> json) =>
      _$$_ColorDTOFromJson(json);

  @override
  final String? primary;
  @override
  final String? onPrimary;
  @override
  final String? secondary;
  @override
  final String? secondaryContainer;
  @override
  final String? onSecondaryContainer;
  @override
  final String? tertiary;
  @override
  final String? error;
  @override
  final String? outline;
  @override
  final String? background;
  @override
  final String? onBackground;
  @override
  final String? surface;
  @override
  final String? onSurface;
  @override
  final List<String>? gradientTabColor;
  @override
  final LaunchDTO? launch;

  @override
  String toString() {
    return 'ColorDTO(primary: $primary, onPrimary: $onPrimary, secondary: $secondary, secondaryContainer: $secondaryContainer, onSecondaryContainer: $onSecondaryContainer, tertiary: $tertiary, error: $error, outline: $outline, background: $background, onBackground: $onBackground, surface: $surface, onSurface: $onSurface, gradientTabColor: $gradientTabColor, launch: $launch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ColorDTO &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.onPrimary, onPrimary) ||
                other.onPrimary == onPrimary) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary) &&
            (identical(other.secondaryContainer, secondaryContainer) ||
                other.secondaryContainer == secondaryContainer) &&
            (identical(other.onSecondaryContainer, onSecondaryContainer) ||
                other.onSecondaryContainer == onSecondaryContainer) &&
            (identical(other.tertiary, tertiary) ||
                other.tertiary == tertiary) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.outline, outline) || other.outline == outline) &&
            (identical(other.background, background) ||
                other.background == background) &&
            (identical(other.onBackground, onBackground) ||
                other.onBackground == onBackground) &&
            (identical(other.surface, surface) || other.surface == surface) &&
            (identical(other.onSurface, onSurface) ||
                other.onSurface == onSurface) &&
            const DeepCollectionEquality()
                .equals(other.gradientTabColor, gradientTabColor) &&
            (identical(other.launch, launch) || other.launch == launch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      primary,
      onPrimary,
      secondary,
      secondaryContainer,
      onSecondaryContainer,
      tertiary,
      error,
      outline,
      background,
      onBackground,
      surface,
      onSurface,
      const DeepCollectionEquality().hash(gradientTabColor),
      launch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ColorDTOCopyWith<_$_ColorDTO> get copyWith =>
      __$$_ColorDTOCopyWithImpl<_$_ColorDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ColorDTOToJson(
      this,
    );
  }
}

abstract class _ColorDTO implements ColorDTO {
  const factory _ColorDTO(
      {final String? primary,
      final String? onPrimary,
      final String? secondary,
      final String? secondaryContainer,
      final String? onSecondaryContainer,
      final String? tertiary,
      final String? error,
      final String? outline,
      final String? background,
      final String? onBackground,
      final String? surface,
      final String? onSurface,
      final List<String>? gradientTabColor,
      final LaunchDTO? launch}) = _$_ColorDTO;

  factory _ColorDTO.fromJson(Map<String, dynamic> json) = _$_ColorDTO.fromJson;

  @override
  String? get primary;
  @override
  String? get onPrimary;
  @override
  String? get secondary;
  @override
  String? get secondaryContainer;
  @override
  String? get onSecondaryContainer;
  @override
  String? get tertiary;
  @override
  String? get error;
  @override
  String? get outline;
  @override
  String? get background;
  @override
  String? get onBackground;
  @override
  String? get surface;
  @override
  String? get onSurface;
  @override
  List<String>? get gradientTabColor;
  @override
  LaunchDTO? get launch;
  @override
  @JsonKey(ignore: true)
  _$$_ColorDTOCopyWith<_$_ColorDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

LaunchDTO _$LaunchDTOFromJson(Map<String, dynamic> json) {
  return _LaunchDTO.fromJson(json);
}

/// @nodoc
mixin _$LaunchDTO {
  String? get adaptiveIconBackground => throw _privateConstructorUsedError;
  String? get splashBackground => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LaunchDTOCopyWith<LaunchDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaunchDTOCopyWith<$Res> {
  factory $LaunchDTOCopyWith(LaunchDTO value, $Res Function(LaunchDTO) then) =
      _$LaunchDTOCopyWithImpl<$Res, LaunchDTO>;
  @useResult
  $Res call({String? adaptiveIconBackground, String? splashBackground});
}

/// @nodoc
class _$LaunchDTOCopyWithImpl<$Res, $Val extends LaunchDTO>
    implements $LaunchDTOCopyWith<$Res> {
  _$LaunchDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adaptiveIconBackground = freezed,
    Object? splashBackground = freezed,
  }) {
    return _then(_value.copyWith(
      adaptiveIconBackground: freezed == adaptiveIconBackground
          ? _value.adaptiveIconBackground
          : adaptiveIconBackground // ignore: cast_nullable_to_non_nullable
              as String?,
      splashBackground: freezed == splashBackground
          ? _value.splashBackground
          : splashBackground // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LaunchDTOCopyWith<$Res> implements $LaunchDTOCopyWith<$Res> {
  factory _$$_LaunchDTOCopyWith(
          _$_LaunchDTO value, $Res Function(_$_LaunchDTO) then) =
      __$$_LaunchDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? adaptiveIconBackground, String? splashBackground});
}

/// @nodoc
class __$$_LaunchDTOCopyWithImpl<$Res>
    extends _$LaunchDTOCopyWithImpl<$Res, _$_LaunchDTO>
    implements _$$_LaunchDTOCopyWith<$Res> {
  __$$_LaunchDTOCopyWithImpl(
      _$_LaunchDTO _value, $Res Function(_$_LaunchDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adaptiveIconBackground = freezed,
    Object? splashBackground = freezed,
  }) {
    return _then(_$_LaunchDTO(
      adaptiveIconBackground: freezed == adaptiveIconBackground
          ? _value.adaptiveIconBackground
          : adaptiveIconBackground // ignore: cast_nullable_to_non_nullable
              as String?,
      splashBackground: freezed == splashBackground
          ? _value.splashBackground
          : splashBackground // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_LaunchDTO implements _LaunchDTO {
  const _$_LaunchDTO({this.adaptiveIconBackground, this.splashBackground});

  factory _$_LaunchDTO.fromJson(Map<String, dynamic> json) =>
      _$$_LaunchDTOFromJson(json);

  @override
  final String? adaptiveIconBackground;
  @override
  final String? splashBackground;

  @override
  String toString() {
    return 'LaunchDTO(adaptiveIconBackground: $adaptiveIconBackground, splashBackground: $splashBackground)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LaunchDTO &&
            (identical(other.adaptiveIconBackground, adaptiveIconBackground) ||
                other.adaptiveIconBackground == adaptiveIconBackground) &&
            (identical(other.splashBackground, splashBackground) ||
                other.splashBackground == splashBackground));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, adaptiveIconBackground, splashBackground);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LaunchDTOCopyWith<_$_LaunchDTO> get copyWith =>
      __$$_LaunchDTOCopyWithImpl<_$_LaunchDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LaunchDTOToJson(
      this,
    );
  }
}

abstract class _LaunchDTO implements LaunchDTO {
  const factory _LaunchDTO(
      {final String? adaptiveIconBackground,
      final String? splashBackground}) = _$_LaunchDTO;

  factory _LaunchDTO.fromJson(Map<String, dynamic> json) =
      _$_LaunchDTO.fromJson;

  @override
  String? get adaptiveIconBackground;
  @override
  String? get splashBackground;
  @override
  @JsonKey(ignore: true)
  _$$_LaunchDTOCopyWith<_$_LaunchDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
