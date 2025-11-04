// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keypad_style_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KeypadStyleConfig _$KeypadStyleConfigFromJson(Map<String, dynamic> json) {
  return _KeypadStyleConfig.fromJson(json);
}

/// @nodoc
mixin _$KeypadStyleConfig {
  /// Text style for the primary digit label on each key.
  TextStyleConfig? get textStyle => throw _privateConstructorUsedError;

  /// Text style for the secondary/subtext label under the digit.
  TextStyleConfig? get subtextStyle => throw _privateConstructorUsedError;

  /// Spacing between keys, in logical pixels (dp).
  double? get spacing => throw _privateConstructorUsedError;

  /// Inner padding applied to each key, in logical pixels (dp).
  double? get padding => throw _privateConstructorUsedError;

  /// Serializes this KeypadStyleConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeypadStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeypadStyleConfigCopyWith<KeypadStyleConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeypadStyleConfigCopyWith<$Res> {
  factory $KeypadStyleConfigCopyWith(
    KeypadStyleConfig value,
    $Res Function(KeypadStyleConfig) then,
  ) = _$KeypadStyleConfigCopyWithImpl<$Res, KeypadStyleConfig>;
  @useResult
  $Res call({
    TextStyleConfig? textStyle,
    TextStyleConfig? subtextStyle,
    double? spacing,
    double? padding,
  });

  $TextStyleConfigCopyWith<$Res>? get textStyle;
  $TextStyleConfigCopyWith<$Res>? get subtextStyle;
}

/// @nodoc
class _$KeypadStyleConfigCopyWithImpl<$Res, $Val extends KeypadStyleConfig>
    implements $KeypadStyleConfigCopyWith<$Res> {
  _$KeypadStyleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeypadStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textStyle = freezed,
    Object? subtextStyle = freezed,
    Object? spacing = freezed,
    Object? padding = freezed,
  }) {
    return _then(
      _value.copyWith(
            textStyle: freezed == textStyle
                ? _value.textStyle
                : textStyle // ignore: cast_nullable_to_non_nullable
                      as TextStyleConfig?,
            subtextStyle: freezed == subtextStyle
                ? _value.subtextStyle
                : subtextStyle // ignore: cast_nullable_to_non_nullable
                      as TextStyleConfig?,
            spacing: freezed == spacing
                ? _value.spacing
                : spacing // ignore: cast_nullable_to_non_nullable
                      as double?,
            padding: freezed == padding
                ? _value.padding
                : padding // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }

  /// Create a copy of KeypadStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleConfigCopyWith<$Res>? get textStyle {
    if (_value.textStyle == null) {
      return null;
    }

    return $TextStyleConfigCopyWith<$Res>(_value.textStyle!, (value) {
      return _then(_value.copyWith(textStyle: value) as $Val);
    });
  }

  /// Create a copy of KeypadStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleConfigCopyWith<$Res>? get subtextStyle {
    if (_value.subtextStyle == null) {
      return null;
    }

    return $TextStyleConfigCopyWith<$Res>(_value.subtextStyle!, (value) {
      return _then(_value.copyWith(subtextStyle: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KeypadStyleConfigImplCopyWith<$Res>
    implements $KeypadStyleConfigCopyWith<$Res> {
  factory _$$KeypadStyleConfigImplCopyWith(
    _$KeypadStyleConfigImpl value,
    $Res Function(_$KeypadStyleConfigImpl) then,
  ) = __$$KeypadStyleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TextStyleConfig? textStyle,
    TextStyleConfig? subtextStyle,
    double? spacing,
    double? padding,
  });

  @override
  $TextStyleConfigCopyWith<$Res>? get textStyle;
  @override
  $TextStyleConfigCopyWith<$Res>? get subtextStyle;
}

/// @nodoc
class __$$KeypadStyleConfigImplCopyWithImpl<$Res>
    extends _$KeypadStyleConfigCopyWithImpl<$Res, _$KeypadStyleConfigImpl>
    implements _$$KeypadStyleConfigImplCopyWith<$Res> {
  __$$KeypadStyleConfigImplCopyWithImpl(
    _$KeypadStyleConfigImpl _value,
    $Res Function(_$KeypadStyleConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KeypadStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textStyle = freezed,
    Object? subtextStyle = freezed,
    Object? spacing = freezed,
    Object? padding = freezed,
  }) {
    return _then(
      _$KeypadStyleConfigImpl(
        textStyle: freezed == textStyle
            ? _value.textStyle
            : textStyle // ignore: cast_nullable_to_non_nullable
                  as TextStyleConfig?,
        subtextStyle: freezed == subtextStyle
            ? _value.subtextStyle
            : subtextStyle // ignore: cast_nullable_to_non_nullable
                  as TextStyleConfig?,
        spacing: freezed == spacing
            ? _value.spacing
            : spacing // ignore: cast_nullable_to_non_nullable
                  as double?,
        padding: freezed == padding
            ? _value.padding
            : padding // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$KeypadStyleConfigImpl implements _KeypadStyleConfig {
  const _$KeypadStyleConfigImpl({
    this.textStyle,
    this.subtextStyle,
    this.spacing,
    this.padding,
  });

  factory _$KeypadStyleConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeypadStyleConfigImplFromJson(json);

  /// Text style for the primary digit label on each key.
  @override
  final TextStyleConfig? textStyle;

  /// Text style for the secondary/subtext label under the digit.
  @override
  final TextStyleConfig? subtextStyle;

  /// Spacing between keys, in logical pixels (dp).
  @override
  final double? spacing;

  /// Inner padding applied to each key, in logical pixels (dp).
  @override
  final double? padding;

  @override
  String toString() {
    return 'KeypadStyleConfig(textStyle: $textStyle, subtextStyle: $subtextStyle, spacing: $spacing, padding: $padding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeypadStyleConfigImpl &&
            (identical(other.textStyle, textStyle) ||
                other.textStyle == textStyle) &&
            (identical(other.subtextStyle, subtextStyle) ||
                other.subtextStyle == subtextStyle) &&
            (identical(other.spacing, spacing) || other.spacing == spacing) &&
            (identical(other.padding, padding) || other.padding == padding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, textStyle, subtextStyle, spacing, padding);

  /// Create a copy of KeypadStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeypadStyleConfigImplCopyWith<_$KeypadStyleConfigImpl> get copyWith =>
      __$$KeypadStyleConfigImplCopyWithImpl<_$KeypadStyleConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$KeypadStyleConfigImplToJson(this);
  }
}

abstract class _KeypadStyleConfig implements KeypadStyleConfig {
  const factory _KeypadStyleConfig({
    final TextStyleConfig? textStyle,
    final TextStyleConfig? subtextStyle,
    final double? spacing,
    final double? padding,
  }) = _$KeypadStyleConfigImpl;

  factory _KeypadStyleConfig.fromJson(Map<String, dynamic> json) =
      _$KeypadStyleConfigImpl.fromJson;

  /// Text style for the primary digit label on each key.
  @override
  TextStyleConfig? get textStyle;

  /// Text style for the secondary/subtext label under the digit.
  @override
  TextStyleConfig? get subtextStyle;

  /// Spacing between keys, in logical pixels (dp).
  @override
  double? get spacing;

  /// Inner padding applied to each key, in logical pixels (dp).
  @override
  double? get padding;

  /// Create a copy of KeypadStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeypadStyleConfigImplCopyWith<_$KeypadStyleConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
