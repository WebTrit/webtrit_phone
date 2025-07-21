// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_style_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TextStyleConfig _$TextStyleConfigFromJson(Map<String, dynamic> json) {
  return _TextStyleConfig.fromJson(json);
}

/// @nodoc
mixin _$TextStyleConfig {
  /// The name of the font family to use (e.g., "Roboto").
  String? get fontFamily => throw _privateConstructorUsedError;

  /// The size of glyphs (e.g., 14.0).
  double? get fontSize => throw _privateConstructorUsedError;

  /// The thickness of the glyphs.
  FontWeightConfig? get fontWeight => throw _privateConstructorUsedError;

  /// Whether the glyphs should be italicized.
  FontStyleConfig? get fontStyle => throw _privateConstructorUsedError;

  /// The text color in hex format (e.g., "#FF0000").
  String? get color => throw _privateConstructorUsedError;

  /// The spacing between letters, in logical pixels.
  double? get letterSpacing => throw _privateConstructorUsedError;

  /// The spacing between words, in logical pixels.
  double? get wordSpacing => throw _privateConstructorUsedError;

  /// The line height, as a multiplier of font size.
  double? get height => throw _privateConstructorUsedError;

  /// Decorations like underline or strikethrough.
  TextDecorationConfig? get decoration => throw _privateConstructorUsedError;

  /// Background color for the text in hex format.
  String? get backgroundColor => throw _privateConstructorUsedError;

  /// Serializes this TextStyleConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TextStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TextStyleConfigCopyWith<TextStyleConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextStyleConfigCopyWith<$Res> {
  factory $TextStyleConfigCopyWith(
          TextStyleConfig value, $Res Function(TextStyleConfig) then) =
      _$TextStyleConfigCopyWithImpl<$Res, TextStyleConfig>;
  @useResult
  $Res call(
      {String? fontFamily,
      double? fontSize,
      FontWeightConfig? fontWeight,
      FontStyleConfig? fontStyle,
      String? color,
      double? letterSpacing,
      double? wordSpacing,
      double? height,
      TextDecorationConfig? decoration,
      String? backgroundColor});

  $FontWeightConfigCopyWith<$Res>? get fontWeight;
  $FontStyleConfigCopyWith<$Res>? get fontStyle;
  $TextDecorationConfigCopyWith<$Res>? get decoration;
}

/// @nodoc
class _$TextStyleConfigCopyWithImpl<$Res, $Val extends TextStyleConfig>
    implements $TextStyleConfigCopyWith<$Res> {
  _$TextStyleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TextStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontFamily = freezed,
    Object? fontSize = freezed,
    Object? fontWeight = freezed,
    Object? fontStyle = freezed,
    Object? color = freezed,
    Object? letterSpacing = freezed,
    Object? wordSpacing = freezed,
    Object? height = freezed,
    Object? decoration = freezed,
    Object? backgroundColor = freezed,
  }) {
    return _then(_value.copyWith(
      fontFamily: freezed == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      fontSize: freezed == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double?,
      fontWeight: freezed == fontWeight
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as FontWeightConfig?,
      fontStyle: freezed == fontStyle
          ? _value.fontStyle
          : fontStyle // ignore: cast_nullable_to_non_nullable
              as FontStyleConfig?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      letterSpacing: freezed == letterSpacing
          ? _value.letterSpacing
          : letterSpacing // ignore: cast_nullable_to_non_nullable
              as double?,
      wordSpacing: freezed == wordSpacing
          ? _value.wordSpacing
          : wordSpacing // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      decoration: freezed == decoration
          ? _value.decoration
          : decoration // ignore: cast_nullable_to_non_nullable
              as TextDecorationConfig?,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of TextStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FontWeightConfigCopyWith<$Res>? get fontWeight {
    if (_value.fontWeight == null) {
      return null;
    }

    return $FontWeightConfigCopyWith<$Res>(_value.fontWeight!, (value) {
      return _then(_value.copyWith(fontWeight: value) as $Val);
    });
  }

  /// Create a copy of TextStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FontStyleConfigCopyWith<$Res>? get fontStyle {
    if (_value.fontStyle == null) {
      return null;
    }

    return $FontStyleConfigCopyWith<$Res>(_value.fontStyle!, (value) {
      return _then(_value.copyWith(fontStyle: value) as $Val);
    });
  }

  /// Create a copy of TextStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextDecorationConfigCopyWith<$Res>? get decoration {
    if (_value.decoration == null) {
      return null;
    }

    return $TextDecorationConfigCopyWith<$Res>(_value.decoration!, (value) {
      return _then(_value.copyWith(decoration: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TextStyleConfigImplCopyWith<$Res>
    implements $TextStyleConfigCopyWith<$Res> {
  factory _$$TextStyleConfigImplCopyWith(_$TextStyleConfigImpl value,
          $Res Function(_$TextStyleConfigImpl) then) =
      __$$TextStyleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? fontFamily,
      double? fontSize,
      FontWeightConfig? fontWeight,
      FontStyleConfig? fontStyle,
      String? color,
      double? letterSpacing,
      double? wordSpacing,
      double? height,
      TextDecorationConfig? decoration,
      String? backgroundColor});

  @override
  $FontWeightConfigCopyWith<$Res>? get fontWeight;
  @override
  $FontStyleConfigCopyWith<$Res>? get fontStyle;
  @override
  $TextDecorationConfigCopyWith<$Res>? get decoration;
}

/// @nodoc
class __$$TextStyleConfigImplCopyWithImpl<$Res>
    extends _$TextStyleConfigCopyWithImpl<$Res, _$TextStyleConfigImpl>
    implements _$$TextStyleConfigImplCopyWith<$Res> {
  __$$TextStyleConfigImplCopyWithImpl(
      _$TextStyleConfigImpl _value, $Res Function(_$TextStyleConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of TextStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontFamily = freezed,
    Object? fontSize = freezed,
    Object? fontWeight = freezed,
    Object? fontStyle = freezed,
    Object? color = freezed,
    Object? letterSpacing = freezed,
    Object? wordSpacing = freezed,
    Object? height = freezed,
    Object? decoration = freezed,
    Object? backgroundColor = freezed,
  }) {
    return _then(_$TextStyleConfigImpl(
      fontFamily: freezed == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      fontSize: freezed == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double?,
      fontWeight: freezed == fontWeight
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as FontWeightConfig?,
      fontStyle: freezed == fontStyle
          ? _value.fontStyle
          : fontStyle // ignore: cast_nullable_to_non_nullable
              as FontStyleConfig?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      letterSpacing: freezed == letterSpacing
          ? _value.letterSpacing
          : letterSpacing // ignore: cast_nullable_to_non_nullable
              as double?,
      wordSpacing: freezed == wordSpacing
          ? _value.wordSpacing
          : wordSpacing // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      decoration: freezed == decoration
          ? _value.decoration
          : decoration // ignore: cast_nullable_to_non_nullable
              as TextDecorationConfig?,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TextStyleConfigImpl implements _TextStyleConfig {
  const _$TextStyleConfigImpl(
      {this.fontFamily,
      this.fontSize,
      this.fontWeight,
      this.fontStyle,
      this.color,
      this.letterSpacing,
      this.wordSpacing,
      this.height,
      this.decoration,
      this.backgroundColor});

  factory _$TextStyleConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextStyleConfigImplFromJson(json);

  /// The name of the font family to use (e.g., "Roboto").
  @override
  final String? fontFamily;

  /// The size of glyphs (e.g., 14.0).
  @override
  final double? fontSize;

  /// The thickness of the glyphs.
  @override
  final FontWeightConfig? fontWeight;

  /// Whether the glyphs should be italicized.
  @override
  final FontStyleConfig? fontStyle;

  /// The text color in hex format (e.g., "#FF0000").
  @override
  final String? color;

  /// The spacing between letters, in logical pixels.
  @override
  final double? letterSpacing;

  /// The spacing between words, in logical pixels.
  @override
  final double? wordSpacing;

  /// The line height, as a multiplier of font size.
  @override
  final double? height;

  /// Decorations like underline or strikethrough.
  @override
  final TextDecorationConfig? decoration;

  /// Background color for the text in hex format.
  @override
  final String? backgroundColor;

  @override
  String toString() {
    return 'TextStyleConfig(fontFamily: $fontFamily, fontSize: $fontSize, fontWeight: $fontWeight, fontStyle: $fontStyle, color: $color, letterSpacing: $letterSpacing, wordSpacing: $wordSpacing, height: $height, decoration: $decoration, backgroundColor: $backgroundColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextStyleConfigImpl &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.fontWeight, fontWeight) ||
                other.fontWeight == fontWeight) &&
            (identical(other.fontStyle, fontStyle) ||
                other.fontStyle == fontStyle) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.letterSpacing, letterSpacing) ||
                other.letterSpacing == letterSpacing) &&
            (identical(other.wordSpacing, wordSpacing) ||
                other.wordSpacing == wordSpacing) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.decoration, decoration) ||
                other.decoration == decoration) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fontFamily,
      fontSize,
      fontWeight,
      fontStyle,
      color,
      letterSpacing,
      wordSpacing,
      height,
      decoration,
      backgroundColor);

  /// Create a copy of TextStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextStyleConfigImplCopyWith<_$TextStyleConfigImpl> get copyWith =>
      __$$TextStyleConfigImplCopyWithImpl<_$TextStyleConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TextStyleConfigImplToJson(
      this,
    );
  }
}

abstract class _TextStyleConfig implements TextStyleConfig {
  const factory _TextStyleConfig(
      {final String? fontFamily,
      final double? fontSize,
      final FontWeightConfig? fontWeight,
      final FontStyleConfig? fontStyle,
      final String? color,
      final double? letterSpacing,
      final double? wordSpacing,
      final double? height,
      final TextDecorationConfig? decoration,
      final String? backgroundColor}) = _$TextStyleConfigImpl;

  factory _TextStyleConfig.fromJson(Map<String, dynamic> json) =
      _$TextStyleConfigImpl.fromJson;

  /// The name of the font family to use (e.g., "Roboto").
  @override
  String? get fontFamily;

  /// The size of glyphs (e.g., 14.0).
  @override
  double? get fontSize;

  /// The thickness of the glyphs.
  @override
  FontWeightConfig? get fontWeight;

  /// Whether the glyphs should be italicized.
  @override
  FontStyleConfig? get fontStyle;

  /// The text color in hex format (e.g., "#FF0000").
  @override
  String? get color;

  /// The spacing between letters, in logical pixels.
  @override
  double? get letterSpacing;

  /// The spacing between words, in logical pixels.
  @override
  double? get wordSpacing;

  /// The line height, as a multiplier of font size.
  @override
  double? get height;

  /// Decorations like underline or strikethrough.
  @override
  TextDecorationConfig? get decoration;

  /// Background color for the text in hex format.
  @override
  String? get backgroundColor;

  /// Create a copy of TextStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextStyleConfigImplCopyWith<_$TextStyleConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FontWeightConfig _$FontWeightConfigFromJson(Map<String, dynamic> json) {
  return _FontWeightConfig.fromJson(json);
}

/// @nodoc
mixin _$FontWeightConfig {
  int get weight => throw _privateConstructorUsedError;

  /// Serializes this FontWeightConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FontWeightConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FontWeightConfigCopyWith<FontWeightConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FontWeightConfigCopyWith<$Res> {
  factory $FontWeightConfigCopyWith(
          FontWeightConfig value, $Res Function(FontWeightConfig) then) =
      _$FontWeightConfigCopyWithImpl<$Res, FontWeightConfig>;
  @useResult
  $Res call({int weight});
}

/// @nodoc
class _$FontWeightConfigCopyWithImpl<$Res, $Val extends FontWeightConfig>
    implements $FontWeightConfigCopyWith<$Res> {
  _$FontWeightConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FontWeightConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FontWeightConfigImplCopyWith<$Res>
    implements $FontWeightConfigCopyWith<$Res> {
  factory _$$FontWeightConfigImplCopyWith(_$FontWeightConfigImpl value,
          $Res Function(_$FontWeightConfigImpl) then) =
      __$$FontWeightConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int weight});
}

/// @nodoc
class __$$FontWeightConfigImplCopyWithImpl<$Res>
    extends _$FontWeightConfigCopyWithImpl<$Res, _$FontWeightConfigImpl>
    implements _$$FontWeightConfigImplCopyWith<$Res> {
  __$$FontWeightConfigImplCopyWithImpl(_$FontWeightConfigImpl _value,
      $Res Function(_$FontWeightConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of FontWeightConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = null,
  }) {
    return _then(_$FontWeightConfigImpl(
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FontWeightConfigImpl implements _FontWeightConfig {
  const _$FontWeightConfigImpl({required this.weight});

  factory _$FontWeightConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$FontWeightConfigImplFromJson(json);

  @override
  final int weight;

  @override
  String toString() {
    return 'FontWeightConfig(weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FontWeightConfigImpl &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, weight);

  /// Create a copy of FontWeightConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FontWeightConfigImplCopyWith<_$FontWeightConfigImpl> get copyWith =>
      __$$FontWeightConfigImplCopyWithImpl<_$FontWeightConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FontWeightConfigImplToJson(
      this,
    );
  }
}

abstract class _FontWeightConfig implements FontWeightConfig {
  const factory _FontWeightConfig({required final int weight}) =
      _$FontWeightConfigImpl;

  factory _FontWeightConfig.fromJson(Map<String, dynamic> json) =
      _$FontWeightConfigImpl.fromJson;

  @override
  int get weight;

  /// Create a copy of FontWeightConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FontWeightConfigImplCopyWith<_$FontWeightConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FontStyleConfig _$FontStyleConfigFromJson(Map<String, dynamic> json) {
  return _FontStyleConfig.fromJson(json);
}

/// @nodoc
mixin _$FontStyleConfig {
  String get value => throw _privateConstructorUsedError;

  /// Serializes this FontStyleConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FontStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FontStyleConfigCopyWith<FontStyleConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FontStyleConfigCopyWith<$Res> {
  factory $FontStyleConfigCopyWith(
          FontStyleConfig value, $Res Function(FontStyleConfig) then) =
      _$FontStyleConfigCopyWithImpl<$Res, FontStyleConfig>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$FontStyleConfigCopyWithImpl<$Res, $Val extends FontStyleConfig>
    implements $FontStyleConfigCopyWith<$Res> {
  _$FontStyleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FontStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FontStyleConfigImplCopyWith<$Res>
    implements $FontStyleConfigCopyWith<$Res> {
  factory _$$FontStyleConfigImplCopyWith(_$FontStyleConfigImpl value,
          $Res Function(_$FontStyleConfigImpl) then) =
      __$$FontStyleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$FontStyleConfigImplCopyWithImpl<$Res>
    extends _$FontStyleConfigCopyWithImpl<$Res, _$FontStyleConfigImpl>
    implements _$$FontStyleConfigImplCopyWith<$Res> {
  __$$FontStyleConfigImplCopyWithImpl(
      _$FontStyleConfigImpl _value, $Res Function(_$FontStyleConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of FontStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$FontStyleConfigImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FontStyleConfigImpl implements _FontStyleConfig {
  const _$FontStyleConfigImpl({this.value = 'normal'});

  factory _$FontStyleConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$FontStyleConfigImplFromJson(json);

  @override
  @JsonKey()
  final String value;

  @override
  String toString() {
    return 'FontStyleConfig(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FontStyleConfigImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of FontStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FontStyleConfigImplCopyWith<_$FontStyleConfigImpl> get copyWith =>
      __$$FontStyleConfigImplCopyWithImpl<_$FontStyleConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FontStyleConfigImplToJson(
      this,
    );
  }
}

abstract class _FontStyleConfig implements FontStyleConfig {
  const factory _FontStyleConfig({final String value}) = _$FontStyleConfigImpl;

  factory _FontStyleConfig.fromJson(Map<String, dynamic> json) =
      _$FontStyleConfigImpl.fromJson;

  @override
  String get value;

  /// Create a copy of FontStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FontStyleConfigImplCopyWith<_$FontStyleConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TextDecorationConfig _$TextDecorationConfigFromJson(Map<String, dynamic> json) {
  return _TextDecorationConfig.fromJson(json);
}

/// @nodoc
mixin _$TextDecorationConfig {
  List<String> get types => throw _privateConstructorUsedError;

  /// Serializes this TextDecorationConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TextDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TextDecorationConfigCopyWith<TextDecorationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextDecorationConfigCopyWith<$Res> {
  factory $TextDecorationConfigCopyWith(TextDecorationConfig value,
          $Res Function(TextDecorationConfig) then) =
      _$TextDecorationConfigCopyWithImpl<$Res, TextDecorationConfig>;
  @useResult
  $Res call({List<String> types});
}

/// @nodoc
class _$TextDecorationConfigCopyWithImpl<$Res,
        $Val extends TextDecorationConfig>
    implements $TextDecorationConfigCopyWith<$Res> {
  _$TextDecorationConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TextDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? types = null,
  }) {
    return _then(_value.copyWith(
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextDecorationConfigImplCopyWith<$Res>
    implements $TextDecorationConfigCopyWith<$Res> {
  factory _$$TextDecorationConfigImplCopyWith(_$TextDecorationConfigImpl value,
          $Res Function(_$TextDecorationConfigImpl) then) =
      __$$TextDecorationConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> types});
}

/// @nodoc
class __$$TextDecorationConfigImplCopyWithImpl<$Res>
    extends _$TextDecorationConfigCopyWithImpl<$Res, _$TextDecorationConfigImpl>
    implements _$$TextDecorationConfigImplCopyWith<$Res> {
  __$$TextDecorationConfigImplCopyWithImpl(_$TextDecorationConfigImpl _value,
      $Res Function(_$TextDecorationConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of TextDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? types = null,
  }) {
    return _then(_$TextDecorationConfigImpl(
      types: null == types
          ? _value._types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TextDecorationConfigImpl implements _TextDecorationConfig {
  const _$TextDecorationConfigImpl({final List<String> types = const []})
      : _types = types;

  factory _$TextDecorationConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextDecorationConfigImplFromJson(json);

  final List<String> _types;
  @override
  @JsonKey()
  List<String> get types {
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_types);
  }

  @override
  String toString() {
    return 'TextDecorationConfig(types: $types)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextDecorationConfigImpl &&
            const DeepCollectionEquality().equals(other._types, _types));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_types));

  /// Create a copy of TextDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextDecorationConfigImplCopyWith<_$TextDecorationConfigImpl>
      get copyWith =>
          __$$TextDecorationConfigImplCopyWithImpl<_$TextDecorationConfigImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TextDecorationConfigImplToJson(
      this,
    );
  }
}

abstract class _TextDecorationConfig implements TextDecorationConfig {
  const factory _TextDecorationConfig({final List<String> types}) =
      _$TextDecorationConfigImpl;

  factory _TextDecorationConfig.fromJson(Map<String, dynamic> json) =
      _$TextDecorationConfigImpl.fromJson;

  @override
  List<String> get types;

  /// Create a copy of TextDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextDecorationConfigImplCopyWith<_$TextDecorationConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}
