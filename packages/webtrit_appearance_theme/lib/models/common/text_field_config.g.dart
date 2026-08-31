// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_field_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextFieldConfig _$TextFieldConfigFromJson(Map<String, dynamic> json) => TextFieldConfig(
  decoration: json['decoration'] == null
      ? null
      : InputDecorationConfig.fromJson(json['decoration'] as Map<String, dynamic>),
  style: json['style'] == null ? null : TextStyleConfig.fromJson(json['style'] as Map<String, dynamic>),
  textAlign: json['textAlign'] as String? ?? 'center',
  showCursor: json['showCursor'] as bool? ?? true,
  keyboardType: json['keyboardType'] as String? ?? 'none',
  mask: json['mask'] == null ? null : MaskConfig.fromJson(json['mask'] as Map<String, dynamic>),
  inputValue: json['inputValue'] == null ? null : InputValueConfig.fromJson(json['inputValue'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TextFieldConfigToJson(TextFieldConfig instance) => <String, dynamic>{
  'decoration': instance.decoration?.toJson(),
  'style': instance.style?.toJson(),
  'textAlign': instance.textAlign,
  'showCursor': instance.showCursor,
  'keyboardType': instance.keyboardType,
  'mask': instance.mask?.toJson(),
  'inputValue': instance.inputValue?.toJson(),
};

const _$TextFieldConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'decoration': {r'$ref': r'#/$defs/InputDecorationConfig'},
    'style': {r'$ref': r'#/$defs/TextStyleConfig'},
    'textAlign': {'type': 'string', 'default': 'center'},
    'showCursor': {'type': 'boolean', 'default': true},
    'keyboardType': {'type': 'string', 'default': 'none'},
    'mask': {r'$ref': r'#/$defs/MaskConfig'},
    'inputValue': {r'$ref': r'#/$defs/InputValueConfig'},
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
          'type': 'object',
          'description':
              'Border type:\n- [`BorderTypeConfig.underline`]\n- [`BorderTypeConfig.outline`]\n- [`BorderTypeConfig.none`]',
        },
        'borderRadius': {'type': 'number', 'description': 'Corner radius for outline borders.'},
        'borderColor': {'type': 'string', 'description': 'Border color (hex string, e.g. `#000000`).'},
        'borderWidth': {'type': 'number', 'description': 'Stroke width of the border.'},
      },
    },
    'InputDecorationConfig': {
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
    },
    'MaskConfig': {
      'type': 'object',
      'properties': {
        'pattern': {'type': 'string', 'description': 'The mask pattern, e.g. "+380 (##) ###-##-##"'},
        'filter': {
          'type': 'object',
          'additionalProperties': {'type': 'string'},
          'description':
              'Regex filter map, e.g. {"#": "[0-9]"}\nNote: Values are regex strings, need to be converted to RegExp in UI code.',
        },
      },
    },
    'InputValueConfig': {
      'type': 'object',
      'properties': {
        'includePrefixInData': {'type': 'boolean'},
        'initialValue': {'type': 'string'},
      },
    },
  },
};

InputValueConfig _$InputValueConfigFromJson(Map<String, dynamic> json) => InputValueConfig(
  includePrefixInData: json['includePrefixInData'] as bool?,
  initialValue: json['initialValue'] as String?,
);

Map<String, dynamic> _$InputValueConfigToJson(InputValueConfig instance) => <String, dynamic>{
  'includePrefixInData': instance.includePrefixInData,
  'initialValue': instance.initialValue,
};

const _$InputValueConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'includePrefixInData': {'type': 'boolean'},
    'initialValue': {'type': 'string'},
  },
};
