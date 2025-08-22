// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_decoration_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InputDecorationConfig _$InputDecorationConfigFromJson(
    Map<String, dynamic> json) {
  return _InputDecorationConfig.fromJson(json);
}

/// @nodoc
mixin _$InputDecorationConfig {
  /// Text that suggests what sort of input the field accepts.
  String? get hintText => throw _privateConstructorUsedError;

  /// Style to use for [hintText].
  TextStyleConfig? get hintStyle => throw _privateConstructorUsedError;

  /// Optional label text displayed above the field when focused or filled.
  String? get labelText => throw _privateConstructorUsedError;

  /// Style to use for [labelText].
  TextStyleConfig? get labelStyle => throw _privateConstructorUsedError;

  /// Additional text displayed below the field (e.g. usage hints).
  String? get helperText => throw _privateConstructorUsedError;

  /// Style to use for [helperText].
  TextStyleConfig? get helperStyle => throw _privateConstructorUsedError;

  /// Style for validation error messages.
  TextStyleConfig? get errorStyle => throw _privateConstructorUsedError;

  /// Optional fixed text placed before the input.
  String? get prefixText => throw _privateConstructorUsedError;

  /// Style for [prefixText].
  TextStyleConfig? get prefixStyle => throw _privateConstructorUsedError;

  /// Optional fixed text placed after the input.
  String? get suffixText => throw _privateConstructorUsedError;

  /// Style for [suffixText].
  TextStyleConfig? get suffixStyle => throw _privateConstructorUsedError;

  /// Background fill color (hex string, e.g. `#FFFFFF`).
  String? get fillColor => throw _privateConstructorUsedError;

  /// Whether the field should be filled with [fillColor].
  bool? get filled => throw _privateConstructorUsedError;

  /// Default border configuration for the field.
  BorderConfig? get border => throw _privateConstructorUsedError;

  /// Border configuration when the field is enabled but unfocused.
  BorderConfig? get enabledBorder => throw _privateConstructorUsedError;

  /// Border configuration when the field is focused.
  BorderConfig? get focusedBorder => throw _privateConstructorUsedError;

  /// Border configuration when the field has an error.
  BorderConfig? get errorBorder => throw _privateConstructorUsedError;

  /// Border configuration when focused and in error state.
  BorderConfig? get focusedErrorBorder => throw _privateConstructorUsedError;

  /// Border configuration when the field is disabled.
  BorderConfig? get disabledBorder => throw _privateConstructorUsedError;

  /// Serializes this InputDecorationConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InputDecorationConfigCopyWith<InputDecorationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputDecorationConfigCopyWith<$Res> {
  factory $InputDecorationConfigCopyWith(InputDecorationConfig value,
          $Res Function(InputDecorationConfig) then) =
      _$InputDecorationConfigCopyWithImpl<$Res, InputDecorationConfig>;
  @useResult
  $Res call(
      {String? hintText,
      TextStyleConfig? hintStyle,
      String? labelText,
      TextStyleConfig? labelStyle,
      String? helperText,
      TextStyleConfig? helperStyle,
      TextStyleConfig? errorStyle,
      String? prefixText,
      TextStyleConfig? prefixStyle,
      String? suffixText,
      TextStyleConfig? suffixStyle,
      String? fillColor,
      bool? filled,
      BorderConfig? border,
      BorderConfig? enabledBorder,
      BorderConfig? focusedBorder,
      BorderConfig? errorBorder,
      BorderConfig? focusedErrorBorder,
      BorderConfig? disabledBorder});

  $TextStyleConfigCopyWith<$Res>? get hintStyle;
  $TextStyleConfigCopyWith<$Res>? get labelStyle;
  $TextStyleConfigCopyWith<$Res>? get helperStyle;
  $TextStyleConfigCopyWith<$Res>? get errorStyle;
  $TextStyleConfigCopyWith<$Res>? get prefixStyle;
  $TextStyleConfigCopyWith<$Res>? get suffixStyle;
  $BorderConfigCopyWith<$Res>? get border;
  $BorderConfigCopyWith<$Res>? get enabledBorder;
  $BorderConfigCopyWith<$Res>? get focusedBorder;
  $BorderConfigCopyWith<$Res>? get errorBorder;
  $BorderConfigCopyWith<$Res>? get focusedErrorBorder;
  $BorderConfigCopyWith<$Res>? get disabledBorder;
}

/// @nodoc
class _$InputDecorationConfigCopyWithImpl<$Res,
        $Val extends InputDecorationConfig>
    implements $InputDecorationConfigCopyWith<$Res> {
  _$InputDecorationConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hintText = freezed,
    Object? hintStyle = freezed,
    Object? labelText = freezed,
    Object? labelStyle = freezed,
    Object? helperText = freezed,
    Object? helperStyle = freezed,
    Object? errorStyle = freezed,
    Object? prefixText = freezed,
    Object? prefixStyle = freezed,
    Object? suffixText = freezed,
    Object? suffixStyle = freezed,
    Object? fillColor = freezed,
    Object? filled = freezed,
    Object? border = freezed,
    Object? enabledBorder = freezed,
    Object? focusedBorder = freezed,
    Object? errorBorder = freezed,
    Object? focusedErrorBorder = freezed,
    Object? disabledBorder = freezed,
  }) {
    return _then(_value.copyWith(
      hintText: freezed == hintText
          ? _value.hintText
          : hintText // ignore: cast_nullable_to_non_nullable
              as String?,
      hintStyle: freezed == hintStyle
          ? _value.hintStyle
          : hintStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      labelText: freezed == labelText
          ? _value.labelText
          : labelText // ignore: cast_nullable_to_non_nullable
              as String?,
      labelStyle: freezed == labelStyle
          ? _value.labelStyle
          : labelStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      helperText: freezed == helperText
          ? _value.helperText
          : helperText // ignore: cast_nullable_to_non_nullable
              as String?,
      helperStyle: freezed == helperStyle
          ? _value.helperStyle
          : helperStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      errorStyle: freezed == errorStyle
          ? _value.errorStyle
          : errorStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      prefixText: freezed == prefixText
          ? _value.prefixText
          : prefixText // ignore: cast_nullable_to_non_nullable
              as String?,
      prefixStyle: freezed == prefixStyle
          ? _value.prefixStyle
          : prefixStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      suffixText: freezed == suffixText
          ? _value.suffixText
          : suffixText // ignore: cast_nullable_to_non_nullable
              as String?,
      suffixStyle: freezed == suffixStyle
          ? _value.suffixStyle
          : suffixStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      fillColor: freezed == fillColor
          ? _value.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as String?,
      filled: freezed == filled
          ? _value.filled
          : filled // ignore: cast_nullable_to_non_nullable
              as bool?,
      border: freezed == border
          ? _value.border
          : border // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
      enabledBorder: freezed == enabledBorder
          ? _value.enabledBorder
          : enabledBorder // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
      focusedBorder: freezed == focusedBorder
          ? _value.focusedBorder
          : focusedBorder // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
      errorBorder: freezed == errorBorder
          ? _value.errorBorder
          : errorBorder // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
      focusedErrorBorder: freezed == focusedErrorBorder
          ? _value.focusedErrorBorder
          : focusedErrorBorder // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
      disabledBorder: freezed == disabledBorder
          ? _value.disabledBorder
          : disabledBorder // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
    ) as $Val);
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleConfigCopyWith<$Res>? get hintStyle {
    if (_value.hintStyle == null) {
      return null;
    }

    return $TextStyleConfigCopyWith<$Res>(_value.hintStyle!, (value) {
      return _then(_value.copyWith(hintStyle: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleConfigCopyWith<$Res>? get labelStyle {
    if (_value.labelStyle == null) {
      return null;
    }

    return $TextStyleConfigCopyWith<$Res>(_value.labelStyle!, (value) {
      return _then(_value.copyWith(labelStyle: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleConfigCopyWith<$Res>? get helperStyle {
    if (_value.helperStyle == null) {
      return null;
    }

    return $TextStyleConfigCopyWith<$Res>(_value.helperStyle!, (value) {
      return _then(_value.copyWith(helperStyle: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleConfigCopyWith<$Res>? get errorStyle {
    if (_value.errorStyle == null) {
      return null;
    }

    return $TextStyleConfigCopyWith<$Res>(_value.errorStyle!, (value) {
      return _then(_value.copyWith(errorStyle: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleConfigCopyWith<$Res>? get prefixStyle {
    if (_value.prefixStyle == null) {
      return null;
    }

    return $TextStyleConfigCopyWith<$Res>(_value.prefixStyle!, (value) {
      return _then(_value.copyWith(prefixStyle: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleConfigCopyWith<$Res>? get suffixStyle {
    if (_value.suffixStyle == null) {
      return null;
    }

    return $TextStyleConfigCopyWith<$Res>(_value.suffixStyle!, (value) {
      return _then(_value.copyWith(suffixStyle: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BorderConfigCopyWith<$Res>? get border {
    if (_value.border == null) {
      return null;
    }

    return $BorderConfigCopyWith<$Res>(_value.border!, (value) {
      return _then(_value.copyWith(border: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BorderConfigCopyWith<$Res>? get enabledBorder {
    if (_value.enabledBorder == null) {
      return null;
    }

    return $BorderConfigCopyWith<$Res>(_value.enabledBorder!, (value) {
      return _then(_value.copyWith(enabledBorder: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BorderConfigCopyWith<$Res>? get focusedBorder {
    if (_value.focusedBorder == null) {
      return null;
    }

    return $BorderConfigCopyWith<$Res>(_value.focusedBorder!, (value) {
      return _then(_value.copyWith(focusedBorder: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BorderConfigCopyWith<$Res>? get errorBorder {
    if (_value.errorBorder == null) {
      return null;
    }

    return $BorderConfigCopyWith<$Res>(_value.errorBorder!, (value) {
      return _then(_value.copyWith(errorBorder: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BorderConfigCopyWith<$Res>? get focusedErrorBorder {
    if (_value.focusedErrorBorder == null) {
      return null;
    }

    return $BorderConfigCopyWith<$Res>(_value.focusedErrorBorder!, (value) {
      return _then(_value.copyWith(focusedErrorBorder: value) as $Val);
    });
  }

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BorderConfigCopyWith<$Res>? get disabledBorder {
    if (_value.disabledBorder == null) {
      return null;
    }

    return $BorderConfigCopyWith<$Res>(_value.disabledBorder!, (value) {
      return _then(_value.copyWith(disabledBorder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InputDecorationConfigImplCopyWith<$Res>
    implements $InputDecorationConfigCopyWith<$Res> {
  factory _$$InputDecorationConfigImplCopyWith(
          _$InputDecorationConfigImpl value,
          $Res Function(_$InputDecorationConfigImpl) then) =
      __$$InputDecorationConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? hintText,
      TextStyleConfig? hintStyle,
      String? labelText,
      TextStyleConfig? labelStyle,
      String? helperText,
      TextStyleConfig? helperStyle,
      TextStyleConfig? errorStyle,
      String? prefixText,
      TextStyleConfig? prefixStyle,
      String? suffixText,
      TextStyleConfig? suffixStyle,
      String? fillColor,
      bool? filled,
      BorderConfig? border,
      BorderConfig? enabledBorder,
      BorderConfig? focusedBorder,
      BorderConfig? errorBorder,
      BorderConfig? focusedErrorBorder,
      BorderConfig? disabledBorder});

  @override
  $TextStyleConfigCopyWith<$Res>? get hintStyle;
  @override
  $TextStyleConfigCopyWith<$Res>? get labelStyle;
  @override
  $TextStyleConfigCopyWith<$Res>? get helperStyle;
  @override
  $TextStyleConfigCopyWith<$Res>? get errorStyle;
  @override
  $TextStyleConfigCopyWith<$Res>? get prefixStyle;
  @override
  $TextStyleConfigCopyWith<$Res>? get suffixStyle;
  @override
  $BorderConfigCopyWith<$Res>? get border;
  @override
  $BorderConfigCopyWith<$Res>? get enabledBorder;
  @override
  $BorderConfigCopyWith<$Res>? get focusedBorder;
  @override
  $BorderConfigCopyWith<$Res>? get errorBorder;
  @override
  $BorderConfigCopyWith<$Res>? get focusedErrorBorder;
  @override
  $BorderConfigCopyWith<$Res>? get disabledBorder;
}

/// @nodoc
class __$$InputDecorationConfigImplCopyWithImpl<$Res>
    extends _$InputDecorationConfigCopyWithImpl<$Res,
        _$InputDecorationConfigImpl>
    implements _$$InputDecorationConfigImplCopyWith<$Res> {
  __$$InputDecorationConfigImplCopyWithImpl(_$InputDecorationConfigImpl _value,
      $Res Function(_$InputDecorationConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hintText = freezed,
    Object? hintStyle = freezed,
    Object? labelText = freezed,
    Object? labelStyle = freezed,
    Object? helperText = freezed,
    Object? helperStyle = freezed,
    Object? errorStyle = freezed,
    Object? prefixText = freezed,
    Object? prefixStyle = freezed,
    Object? suffixText = freezed,
    Object? suffixStyle = freezed,
    Object? fillColor = freezed,
    Object? filled = freezed,
    Object? border = freezed,
    Object? enabledBorder = freezed,
    Object? focusedBorder = freezed,
    Object? errorBorder = freezed,
    Object? focusedErrorBorder = freezed,
    Object? disabledBorder = freezed,
  }) {
    return _then(_$InputDecorationConfigImpl(
      hintText: freezed == hintText
          ? _value.hintText
          : hintText // ignore: cast_nullable_to_non_nullable
              as String?,
      hintStyle: freezed == hintStyle
          ? _value.hintStyle
          : hintStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      labelText: freezed == labelText
          ? _value.labelText
          : labelText // ignore: cast_nullable_to_non_nullable
              as String?,
      labelStyle: freezed == labelStyle
          ? _value.labelStyle
          : labelStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      helperText: freezed == helperText
          ? _value.helperText
          : helperText // ignore: cast_nullable_to_non_nullable
              as String?,
      helperStyle: freezed == helperStyle
          ? _value.helperStyle
          : helperStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      errorStyle: freezed == errorStyle
          ? _value.errorStyle
          : errorStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      prefixText: freezed == prefixText
          ? _value.prefixText
          : prefixText // ignore: cast_nullable_to_non_nullable
              as String?,
      prefixStyle: freezed == prefixStyle
          ? _value.prefixStyle
          : prefixStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      suffixText: freezed == suffixText
          ? _value.suffixText
          : suffixText // ignore: cast_nullable_to_non_nullable
              as String?,
      suffixStyle: freezed == suffixStyle
          ? _value.suffixStyle
          : suffixStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      fillColor: freezed == fillColor
          ? _value.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as String?,
      filled: freezed == filled
          ? _value.filled
          : filled // ignore: cast_nullable_to_non_nullable
              as bool?,
      border: freezed == border
          ? _value.border
          : border // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
      enabledBorder: freezed == enabledBorder
          ? _value.enabledBorder
          : enabledBorder // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
      focusedBorder: freezed == focusedBorder
          ? _value.focusedBorder
          : focusedBorder // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
      errorBorder: freezed == errorBorder
          ? _value.errorBorder
          : errorBorder // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
      focusedErrorBorder: freezed == focusedErrorBorder
          ? _value.focusedErrorBorder
          : focusedErrorBorder // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
      disabledBorder: freezed == disabledBorder
          ? _value.disabledBorder
          : disabledBorder // ignore: cast_nullable_to_non_nullable
              as BorderConfig?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$InputDecorationConfigImpl implements _InputDecorationConfig {
  const _$InputDecorationConfigImpl(
      {this.hintText,
      this.hintStyle,
      this.labelText,
      this.labelStyle,
      this.helperText,
      this.helperStyle,
      this.errorStyle,
      this.prefixText,
      this.prefixStyle,
      this.suffixText,
      this.suffixStyle,
      this.fillColor,
      this.filled,
      this.border,
      this.enabledBorder,
      this.focusedBorder,
      this.errorBorder,
      this.focusedErrorBorder,
      this.disabledBorder});

  factory _$InputDecorationConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputDecorationConfigImplFromJson(json);

  /// Text that suggests what sort of input the field accepts.
  @override
  final String? hintText;

  /// Style to use for [hintText].
  @override
  final TextStyleConfig? hintStyle;

  /// Optional label text displayed above the field when focused or filled.
  @override
  final String? labelText;

  /// Style to use for [labelText].
  @override
  final TextStyleConfig? labelStyle;

  /// Additional text displayed below the field (e.g. usage hints).
  @override
  final String? helperText;

  /// Style to use for [helperText].
  @override
  final TextStyleConfig? helperStyle;

  /// Style for validation error messages.
  @override
  final TextStyleConfig? errorStyle;

  /// Optional fixed text placed before the input.
  @override
  final String? prefixText;

  /// Style for [prefixText].
  @override
  final TextStyleConfig? prefixStyle;

  /// Optional fixed text placed after the input.
  @override
  final String? suffixText;

  /// Style for [suffixText].
  @override
  final TextStyleConfig? suffixStyle;

  /// Background fill color (hex string, e.g. `#FFFFFF`).
  @override
  final String? fillColor;

  /// Whether the field should be filled with [fillColor].
  @override
  final bool? filled;

  /// Default border configuration for the field.
  @override
  final BorderConfig? border;

  /// Border configuration when the field is enabled but unfocused.
  @override
  final BorderConfig? enabledBorder;

  /// Border configuration when the field is focused.
  @override
  final BorderConfig? focusedBorder;

  /// Border configuration when the field has an error.
  @override
  final BorderConfig? errorBorder;

  /// Border configuration when focused and in error state.
  @override
  final BorderConfig? focusedErrorBorder;

  /// Border configuration when the field is disabled.
  @override
  final BorderConfig? disabledBorder;

  @override
  String toString() {
    return 'InputDecorationConfig(hintText: $hintText, hintStyle: $hintStyle, labelText: $labelText, labelStyle: $labelStyle, helperText: $helperText, helperStyle: $helperStyle, errorStyle: $errorStyle, prefixText: $prefixText, prefixStyle: $prefixStyle, suffixText: $suffixText, suffixStyle: $suffixStyle, fillColor: $fillColor, filled: $filled, border: $border, enabledBorder: $enabledBorder, focusedBorder: $focusedBorder, errorBorder: $errorBorder, focusedErrorBorder: $focusedErrorBorder, disabledBorder: $disabledBorder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputDecorationConfigImpl &&
            (identical(other.hintText, hintText) ||
                other.hintText == hintText) &&
            (identical(other.hintStyle, hintStyle) ||
                other.hintStyle == hintStyle) &&
            (identical(other.labelText, labelText) ||
                other.labelText == labelText) &&
            (identical(other.labelStyle, labelStyle) ||
                other.labelStyle == labelStyle) &&
            (identical(other.helperText, helperText) ||
                other.helperText == helperText) &&
            (identical(other.helperStyle, helperStyle) ||
                other.helperStyle == helperStyle) &&
            (identical(other.errorStyle, errorStyle) ||
                other.errorStyle == errorStyle) &&
            (identical(other.prefixText, prefixText) ||
                other.prefixText == prefixText) &&
            (identical(other.prefixStyle, prefixStyle) ||
                other.prefixStyle == prefixStyle) &&
            (identical(other.suffixText, suffixText) ||
                other.suffixText == suffixText) &&
            (identical(other.suffixStyle, suffixStyle) ||
                other.suffixStyle == suffixStyle) &&
            (identical(other.fillColor, fillColor) ||
                other.fillColor == fillColor) &&
            (identical(other.filled, filled) || other.filled == filled) &&
            (identical(other.border, border) || other.border == border) &&
            (identical(other.enabledBorder, enabledBorder) ||
                other.enabledBorder == enabledBorder) &&
            (identical(other.focusedBorder, focusedBorder) ||
                other.focusedBorder == focusedBorder) &&
            (identical(other.errorBorder, errorBorder) ||
                other.errorBorder == errorBorder) &&
            (identical(other.focusedErrorBorder, focusedErrorBorder) ||
                other.focusedErrorBorder == focusedErrorBorder) &&
            (identical(other.disabledBorder, disabledBorder) ||
                other.disabledBorder == disabledBorder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        hintText,
        hintStyle,
        labelText,
        labelStyle,
        helperText,
        helperStyle,
        errorStyle,
        prefixText,
        prefixStyle,
        suffixText,
        suffixStyle,
        fillColor,
        filled,
        border,
        enabledBorder,
        focusedBorder,
        errorBorder,
        focusedErrorBorder,
        disabledBorder
      ]);

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InputDecorationConfigImplCopyWith<_$InputDecorationConfigImpl>
      get copyWith => __$$InputDecorationConfigImplCopyWithImpl<
          _$InputDecorationConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InputDecorationConfigImplToJson(
      this,
    );
  }
}

abstract class _InputDecorationConfig implements InputDecorationConfig {
  const factory _InputDecorationConfig(
      {final String? hintText,
      final TextStyleConfig? hintStyle,
      final String? labelText,
      final TextStyleConfig? labelStyle,
      final String? helperText,
      final TextStyleConfig? helperStyle,
      final TextStyleConfig? errorStyle,
      final String? prefixText,
      final TextStyleConfig? prefixStyle,
      final String? suffixText,
      final TextStyleConfig? suffixStyle,
      final String? fillColor,
      final bool? filled,
      final BorderConfig? border,
      final BorderConfig? enabledBorder,
      final BorderConfig? focusedBorder,
      final BorderConfig? errorBorder,
      final BorderConfig? focusedErrorBorder,
      final BorderConfig? disabledBorder}) = _$InputDecorationConfigImpl;

  factory _InputDecorationConfig.fromJson(Map<String, dynamic> json) =
      _$InputDecorationConfigImpl.fromJson;

  /// Text that suggests what sort of input the field accepts.
  @override
  String? get hintText;

  /// Style to use for [hintText].
  @override
  TextStyleConfig? get hintStyle;

  /// Optional label text displayed above the field when focused or filled.
  @override
  String? get labelText;

  /// Style to use for [labelText].
  @override
  TextStyleConfig? get labelStyle;

  /// Additional text displayed below the field (e.g. usage hints).
  @override
  String? get helperText;

  /// Style to use for [helperText].
  @override
  TextStyleConfig? get helperStyle;

  /// Style for validation error messages.
  @override
  TextStyleConfig? get errorStyle;

  /// Optional fixed text placed before the input.
  @override
  String? get prefixText;

  /// Style for [prefixText].
  @override
  TextStyleConfig? get prefixStyle;

  /// Optional fixed text placed after the input.
  @override
  String? get suffixText;

  /// Style for [suffixText].
  @override
  TextStyleConfig? get suffixStyle;

  /// Background fill color (hex string, e.g. `#FFFFFF`).
  @override
  String? get fillColor;

  /// Whether the field should be filled with [fillColor].
  @override
  bool? get filled;

  /// Default border configuration for the field.
  @override
  BorderConfig? get border;

  /// Border configuration when the field is enabled but unfocused.
  @override
  BorderConfig? get enabledBorder;

  /// Border configuration when the field is focused.
  @override
  BorderConfig? get focusedBorder;

  /// Border configuration when the field has an error.
  @override
  BorderConfig? get errorBorder;

  /// Border configuration when focused and in error state.
  @override
  BorderConfig? get focusedErrorBorder;

  /// Border configuration when the field is disabled.
  @override
  BorderConfig? get disabledBorder;

  /// Create a copy of InputDecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InputDecorationConfigImplCopyWith<_$InputDecorationConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}

BorderConfig _$BorderConfigFromJson(Map<String, dynamic> json) {
  return _BorderConfig.fromJson(json);
}

/// @nodoc
mixin _$BorderConfig {
  /// Border type: `'underline' | 'outline' | 'none'`.
  String get type => throw _privateConstructorUsedError;

  /// Corner radius for outline borders.
  double? get borderRadius => throw _privateConstructorUsedError;

  /// Border color (hex string, e.g. `#000000`).
  String? get borderColor => throw _privateConstructorUsedError;

  /// Stroke width of the border.
  double? get borderWidth => throw _privateConstructorUsedError;

  /// Serializes this BorderConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BorderConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BorderConfigCopyWith<BorderConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BorderConfigCopyWith<$Res> {
  factory $BorderConfigCopyWith(
          BorderConfig value, $Res Function(BorderConfig) then) =
      _$BorderConfigCopyWithImpl<$Res, BorderConfig>;
  @useResult
  $Res call(
      {String type,
      double? borderRadius,
      String? borderColor,
      double? borderWidth});
}

/// @nodoc
class _$BorderConfigCopyWithImpl<$Res, $Val extends BorderConfig>
    implements $BorderConfigCopyWith<$Res> {
  _$BorderConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BorderConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? borderRadius = freezed,
    Object? borderColor = freezed,
    Object? borderWidth = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      borderRadius: freezed == borderRadius
          ? _value.borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as double?,
      borderColor: freezed == borderColor
          ? _value.borderColor
          : borderColor // ignore: cast_nullable_to_non_nullable
              as String?,
      borderWidth: freezed == borderWidth
          ? _value.borderWidth
          : borderWidth // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BorderConfigImplCopyWith<$Res>
    implements $BorderConfigCopyWith<$Res> {
  factory _$$BorderConfigImplCopyWith(
          _$BorderConfigImpl value, $Res Function(_$BorderConfigImpl) then) =
      __$$BorderConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      double? borderRadius,
      String? borderColor,
      double? borderWidth});
}

/// @nodoc
class __$$BorderConfigImplCopyWithImpl<$Res>
    extends _$BorderConfigCopyWithImpl<$Res, _$BorderConfigImpl>
    implements _$$BorderConfigImplCopyWith<$Res> {
  __$$BorderConfigImplCopyWithImpl(
      _$BorderConfigImpl _value, $Res Function(_$BorderConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of BorderConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? borderRadius = freezed,
    Object? borderColor = freezed,
    Object? borderWidth = freezed,
  }) {
    return _then(_$BorderConfigImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      borderRadius: freezed == borderRadius
          ? _value.borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as double?,
      borderColor: freezed == borderColor
          ? _value.borderColor
          : borderColor // ignore: cast_nullable_to_non_nullable
              as String?,
      borderWidth: freezed == borderWidth
          ? _value.borderWidth
          : borderWidth // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$BorderConfigImpl implements _BorderConfig {
  const _$BorderConfigImpl(
      {this.type = 'underline',
      this.borderRadius,
      this.borderColor,
      this.borderWidth});

  factory _$BorderConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$BorderConfigImplFromJson(json);

  /// Border type: `'underline' | 'outline' | 'none'`.
  @override
  @JsonKey()
  final String type;

  /// Corner radius for outline borders.
  @override
  final double? borderRadius;

  /// Border color (hex string, e.g. `#000000`).
  @override
  final String? borderColor;

  /// Stroke width of the border.
  @override
  final double? borderWidth;

  @override
  String toString() {
    return 'BorderConfig(type: $type, borderRadius: $borderRadius, borderColor: $borderColor, borderWidth: $borderWidth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BorderConfigImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.borderRadius, borderRadius) ||
                other.borderRadius == borderRadius) &&
            (identical(other.borderColor, borderColor) ||
                other.borderColor == borderColor) &&
            (identical(other.borderWidth, borderWidth) ||
                other.borderWidth == borderWidth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, borderRadius, borderColor, borderWidth);

  /// Create a copy of BorderConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BorderConfigImplCopyWith<_$BorderConfigImpl> get copyWith =>
      __$$BorderConfigImplCopyWithImpl<_$BorderConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BorderConfigImplToJson(
      this,
    );
  }
}

abstract class _BorderConfig implements BorderConfig {
  const factory _BorderConfig(
      {final String type,
      final double? borderRadius,
      final String? borderColor,
      final double? borderWidth}) = _$BorderConfigImpl;

  factory _BorderConfig.fromJson(Map<String, dynamic> json) =
      _$BorderConfigImpl.fromJson;

  /// Border type: `'underline' | 'outline' | 'none'`.
  @override
  String get type;

  /// Corner radius for outline borders.
  @override
  double? get borderRadius;

  /// Border color (hex string, e.g. `#000000`).
  @override
  String? get borderColor;

  /// Stroke width of the border.
  @override
  double? get borderWidth;

  /// Create a copy of BorderConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BorderConfigImplCopyWith<_$BorderConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
