// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_decoration_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputDecorationConfig _$InputDecorationConfigFromJson(Map<String, dynamic> json) => InputDecorationConfig(
  hintText: json['hintText'] as String?,
  hintStyle: json['hintStyle'] == null ? null : TextStyleConfig.fromJson(json['hintStyle'] as Map<String, dynamic>),
  labelText: json['labelText'] as String?,
  labelStyle: json['labelStyle'] == null ? null : TextStyleConfig.fromJson(json['labelStyle'] as Map<String, dynamic>),
  helperText: json['helperText'] as String?,
  helperStyle: json['helperStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['helperStyle'] as Map<String, dynamic>),
  errorStyle: json['errorStyle'] == null ? null : TextStyleConfig.fromJson(json['errorStyle'] as Map<String, dynamic>),
  prefixText: json['prefixText'] as String?,
  prefixStyle: json['prefixStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['prefixStyle'] as Map<String, dynamic>),
  suffixText: json['suffixText'] as String?,
  suffixStyle: json['suffixStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['suffixStyle'] as Map<String, dynamic>),
  fillColor: json['fillColor'] as String?,
  filled: json['filled'] as bool?,
  border: json['border'] == null ? null : BorderConfig.fromJson(json['border'] as Map<String, dynamic>),
  enabledBorder: json['enabledBorder'] == null
      ? null
      : BorderConfig.fromJson(json['enabledBorder'] as Map<String, dynamic>),
  focusedBorder: json['focusedBorder'] == null
      ? null
      : BorderConfig.fromJson(json['focusedBorder'] as Map<String, dynamic>),
  errorBorder: json['errorBorder'] == null ? null : BorderConfig.fromJson(json['errorBorder'] as Map<String, dynamic>),
  focusedErrorBorder: json['focusedErrorBorder'] == null
      ? null
      : BorderConfig.fromJson(json['focusedErrorBorder'] as Map<String, dynamic>),
  disabledBorder: json['disabledBorder'] == null
      ? null
      : BorderConfig.fromJson(json['disabledBorder'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InputDecorationConfigToJson(InputDecorationConfig instance) => <String, dynamic>{
  'hintText': instance.hintText,
  'hintStyle': instance.hintStyle?.toJson(),
  'labelText': instance.labelText,
  'labelStyle': instance.labelStyle?.toJson(),
  'helperText': instance.helperText,
  'helperStyle': instance.helperStyle?.toJson(),
  'errorStyle': instance.errorStyle?.toJson(),
  'prefixText': instance.prefixText,
  'prefixStyle': instance.prefixStyle?.toJson(),
  'suffixText': instance.suffixText,
  'suffixStyle': instance.suffixStyle?.toJson(),
  'fillColor': instance.fillColor,
  'filled': instance.filled,
  'border': instance.border?.toJson(),
  'enabledBorder': instance.enabledBorder?.toJson(),
  'focusedBorder': instance.focusedBorder?.toJson(),
  'errorBorder': instance.errorBorder?.toJson(),
  'focusedErrorBorder': instance.focusedErrorBorder?.toJson(),
  'disabledBorder': instance.disabledBorder?.toJson(),
};

const _$InputDecorationConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'hintText': {'type': 'string'},
    'hintStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'labelText': {'type': 'string'},
    'labelStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'helperText': {'type': 'string'},
    'helperStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'errorStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'prefixText': {'type': 'string'},
    'prefixStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'suffixText': {'type': 'string'},
    'suffixStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'fillColor': {'type': 'string'},
    'filled': {'type': 'boolean'},
    'border': {r'$ref': r'#/$defs/BorderConfig'},
    'enabledBorder': {r'$ref': r'#/$defs/BorderConfig'},
    'focusedBorder': {r'$ref': r'#/$defs/BorderConfig'},
    'errorBorder': {r'$ref': r'#/$defs/BorderConfig'},
    'focusedErrorBorder': {r'$ref': r'#/$defs/BorderConfig'},
    'disabledBorder': {r'$ref': r'#/$defs/BorderConfig'},
  },
  r'$defs': {
    'FontWeightConfig': {
      'type': 'object',
      'properties': {
        'weight': {'type': 'integer', 'description': 'Numeric weight of the font (100–900 typical).'},
      },
      'required': ['weight'],
    },
    'FontStyleConfig': {
      'type': 'object',
      'properties': {
        'value': {
          'type': 'string',
          'description': 'The font style, as a string. Common values: `"normal"`, `"italic"`.',
          'default': 'normal',
        },
      },
    },
    'TextDecorationConfig': {
      'type': 'object',
      'properties': {
        'types': {
          'type': 'array',
          'items': {'type': 'string'},
          'description': 'A list of decoration types. Supported values:\n`"underline"`, `"lineThrough"`, `"overline"`.',
          'default': [],
        },
        'hint': {'type': 'string', 'description': 'Text to suggest what sort of input the field accepts.'},
        'hintStyle': {r'$ref': r'#/$defs/TextStyleConfig', 'description': 'The style to use for the [hint].'},
        'prefixText': {
          'type': 'string',
          'description':
              'Text that appears before the editable part of the field (e.g., a currency symbol or country code).',
        },
        'prefixStyle': {r'$ref': r'#/$defs/TextStyleConfig', 'description': 'The style to use for the [prefixText].'},
      },
    },
    'PaddingConfig': {
      'type': 'object',
      'properties': {
        'left': {'type': 'number', 'description': 'Left padding value.', 'default': 0.0},
        'top': {'type': 'number', 'description': 'Top padding value.', 'default': 0.0},
        'right': {'type': 'number', 'description': 'Right padding value.', 'default': 0.0},
        'bottom': {'type': 'number', 'description': 'Bottom padding value.', 'default': 0.0},
      },
    },
    'TextStyleConfig': {
      'type': 'object',
      'properties': {
        'fontFamily': {'type': 'string', 'description': 'The name of the font family to use (e.g., "Roboto").'},
        'fontSize': {'type': 'number', 'description': 'The size of glyphs (e.g., 14.0).'},
        'fontWeight': {r'$ref': r'#/$defs/FontWeightConfig', 'description': 'The thickness of the glyphs.'},
        'fontStyle': {r'$ref': r'#/$defs/FontStyleConfig', 'description': 'Whether the glyphs should be italicized.'},
        'color': {'type': 'string', 'description': 'The text color in hex format (e.g., "#FF0000").'},
        'letterSpacing': {'type': 'number', 'description': 'The spacing between letters, in logical pixels.'},
        'wordSpacing': {'type': 'number', 'description': 'The spacing between words, in logical pixels.'},
        'height': {'type': 'number', 'description': 'The line height, as a multiplier of font size.'},
        'decoration': {
          r'$ref': r'#/$defs/TextDecorationConfig',
          'description': 'Decorations like underline or strikethrough.',
        },
        'backgroundColor': {'type': 'string', 'description': 'Background color for the text in hex format.'},
        'backgroundBorderRadius': {'type': 'number', 'description': 'Border radius for background decoration.'},
        'backgroundPadding': {
          r'$ref': r'#/$defs/PaddingConfig',
          'description': 'Padding around text when background is applied.',
        },
      },
    },
    'BorderConfig': {
      'type': 'object',
      'properties': {
        'type': {
          'enum': ['underline', 'outline', 'none'],
          'description':
              'Border type:\n- [`BorderTypeConfig.underline`]\n- [`BorderTypeConfig.outline`]\n- [`BorderTypeConfig.none`]',
          'default': 'underline',
        },
        'borderRadius': {'type': 'number', 'description': 'Corner radius for outline borders.'},
        'borderColor': {'type': 'string', 'description': 'Border color (hex string, e.g. `#000000`).'},
        'borderWidth': {'type': 'number', 'description': 'Stroke width of the border.'},
      },
    },
  },
};
