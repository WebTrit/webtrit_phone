// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_field_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TextFieldConfig _$TextFieldConfigFromJson(Map<String, dynamic> json) {
  return _TextFieldConfig.fromJson(json);
}

/// @nodoc
mixin _$TextFieldConfig {
  /// Input decoration (borders, hints, labels, etc.).
  ///
  /// Use `border.type = "none"` (or `enabledBorder/focusedBorder/... = "none"`)
  /// to completely remove the underline/outline.
  InputDecorationConfig? get decoration => throw _privateConstructorUsedError;

  /// Style for the text inside the field.
  TextStyleConfig? get style => throw _privateConstructorUsedError;

  /// Text alignment inside the field.
  ///
  /// Supported values: `"left" | "right" | "center"`.
  String get textAlign => throw _privateConstructorUsedError;

  /// Whether the blinking cursor is visible.
  bool get showCursor => throw _privateConstructorUsedError;

  /// Keyboard type for this field.
  ///
  /// Supported values: `"none" | "number" | "text" | "phone" | "email" | "multiline"`.
  String get keyboardType => throw _privateConstructorUsedError;

  /// Serializes this TextFieldConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TextFieldConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TextFieldConfigCopyWith<TextFieldConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextFieldConfigCopyWith<$Res> {
  factory $TextFieldConfigCopyWith(
          TextFieldConfig value, $Res Function(TextFieldConfig) then) =
      _$TextFieldConfigCopyWithImpl<$Res, TextFieldConfig>;
  @useResult
  $Res call(
      {InputDecorationConfig? decoration,
      TextStyleConfig? style,
      String textAlign,
      bool showCursor,
      String keyboardType});

  $InputDecorationConfigCopyWith<$Res>? get decoration;
  $TextStyleConfigCopyWith<$Res>? get style;
}

/// @nodoc
class _$TextFieldConfigCopyWithImpl<$Res, $Val extends TextFieldConfig>
    implements $TextFieldConfigCopyWith<$Res> {
  _$TextFieldConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TextFieldConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decoration = freezed,
    Object? style = freezed,
    Object? textAlign = null,
    Object? showCursor = null,
    Object? keyboardType = null,
  }) {
    return _then(_value.copyWith(
      decoration: freezed == decoration
          ? _value.decoration
          : decoration // ignore: cast_nullable_to_non_nullable
              as InputDecorationConfig?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      textAlign: null == textAlign
          ? _value.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as String,
      showCursor: null == showCursor
          ? _value.showCursor
          : showCursor // ignore: cast_nullable_to_non_nullable
              as bool,
      keyboardType: null == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of TextFieldConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InputDecorationConfigCopyWith<$Res>? get decoration {
    if (_value.decoration == null) {
      return null;
    }

    return $InputDecorationConfigCopyWith<$Res>(_value.decoration!, (value) {
      return _then(_value.copyWith(decoration: value) as $Val);
    });
  }

  /// Create a copy of TextFieldConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleConfigCopyWith<$Res>? get style {
    if (_value.style == null) {
      return null;
    }

    return $TextStyleConfigCopyWith<$Res>(_value.style!, (value) {
      return _then(_value.copyWith(style: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TextFieldConfigImplCopyWith<$Res>
    implements $TextFieldConfigCopyWith<$Res> {
  factory _$$TextFieldConfigImplCopyWith(_$TextFieldConfigImpl value,
          $Res Function(_$TextFieldConfigImpl) then) =
      __$$TextFieldConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {InputDecorationConfig? decoration,
      TextStyleConfig? style,
      String textAlign,
      bool showCursor,
      String keyboardType});

  @override
  $InputDecorationConfigCopyWith<$Res>? get decoration;
  @override
  $TextStyleConfigCopyWith<$Res>? get style;
}

/// @nodoc
class __$$TextFieldConfigImplCopyWithImpl<$Res>
    extends _$TextFieldConfigCopyWithImpl<$Res, _$TextFieldConfigImpl>
    implements _$$TextFieldConfigImplCopyWith<$Res> {
  __$$TextFieldConfigImplCopyWithImpl(
      _$TextFieldConfigImpl _value, $Res Function(_$TextFieldConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of TextFieldConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decoration = freezed,
    Object? style = freezed,
    Object? textAlign = null,
    Object? showCursor = null,
    Object? keyboardType = null,
  }) {
    return _then(_$TextFieldConfigImpl(
      decoration: freezed == decoration
          ? _value.decoration
          : decoration // ignore: cast_nullable_to_non_nullable
              as InputDecorationConfig?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      textAlign: null == textAlign
          ? _value.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as String,
      showCursor: null == showCursor
          ? _value.showCursor
          : showCursor // ignore: cast_nullable_to_non_nullable
              as bool,
      keyboardType: null == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TextFieldConfigImpl implements _TextFieldConfig {
  const _$TextFieldConfigImpl(
      {this.decoration,
      this.style,
      this.textAlign = 'center',
      this.showCursor = true,
      this.keyboardType = 'none'});

  factory _$TextFieldConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextFieldConfigImplFromJson(json);

  /// Input decoration (borders, hints, labels, etc.).
  ///
  /// Use `border.type = "none"` (or `enabledBorder/focusedBorder/... = "none"`)
  /// to completely remove the underline/outline.
  @override
  final InputDecorationConfig? decoration;

  /// Style for the text inside the field.
  @override
  final TextStyleConfig? style;

  /// Text alignment inside the field.
  ///
  /// Supported values: `"left" | "right" | "center"`.
  @override
  @JsonKey()
  final String textAlign;

  /// Whether the blinking cursor is visible.
  @override
  @JsonKey()
  final bool showCursor;

  /// Keyboard type for this field.
  ///
  /// Supported values: `"none" | "number" | "text" | "phone" | "email" | "multiline"`.
  @override
  @JsonKey()
  final String keyboardType;

  @override
  String toString() {
    return 'TextFieldConfig(decoration: $decoration, style: $style, textAlign: $textAlign, showCursor: $showCursor, keyboardType: $keyboardType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextFieldConfigImpl &&
            (identical(other.decoration, decoration) ||
                other.decoration == decoration) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.textAlign, textAlign) ||
                other.textAlign == textAlign) &&
            (identical(other.showCursor, showCursor) ||
                other.showCursor == showCursor) &&
            (identical(other.keyboardType, keyboardType) ||
                other.keyboardType == keyboardType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, decoration, style, textAlign, showCursor, keyboardType);

  /// Create a copy of TextFieldConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextFieldConfigImplCopyWith<_$TextFieldConfigImpl> get copyWith =>
      __$$TextFieldConfigImplCopyWithImpl<_$TextFieldConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TextFieldConfigImplToJson(
      this,
    );
  }
}

abstract class _TextFieldConfig implements TextFieldConfig {
  const factory _TextFieldConfig(
      {final InputDecorationConfig? decoration,
      final TextStyleConfig? style,
      final String textAlign,
      final bool showCursor,
      final String keyboardType}) = _$TextFieldConfigImpl;

  factory _TextFieldConfig.fromJson(Map<String, dynamic> json) =
      _$TextFieldConfigImpl.fromJson;

  /// Input decoration (borders, hints, labels, etc.).
  ///
  /// Use `border.type = "none"` (or `enabledBorder/focusedBorder/... = "none"`)
  /// to completely remove the underline/outline.
  @override
  InputDecorationConfig? get decoration;

  /// Style for the text inside the field.
  @override
  TextStyleConfig? get style;

  /// Text alignment inside the field.
  ///
  /// Supported values: `"left" | "right" | "center"`.
  @override
  String get textAlign;

  /// Whether the blinking cursor is visible.
  @override
  bool get showCursor;

  /// Keyboard type for this field.
  ///
  /// Supported values: `"none" | "number" | "text" | "phone" | "email" | "multiline"`.
  @override
  String get keyboardType;

  /// Create a copy of TextFieldConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextFieldConfigImplCopyWith<_$TextFieldConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
