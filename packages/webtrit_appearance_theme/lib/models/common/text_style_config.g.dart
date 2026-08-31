// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextStyleConfig _$TextStyleConfigFromJson(Map<String, dynamic> json) => TextStyleConfig(
  fontFamily: json['fontFamily'] as String?,
  fontSize: (json['fontSize'] as num?)?.toDouble(),
  fontWeight: json['fontWeight'] == null ? null : FontWeightConfig.fromJson(json['fontWeight'] as Map<String, dynamic>),
  fontStyle: json['fontStyle'] == null ? null : FontStyleConfig.fromJson(json['fontStyle'] as Map<String, dynamic>),
  color: json['color'] as String?,
  letterSpacing: (json['letterSpacing'] as num?)?.toDouble(),
  wordSpacing: (json['wordSpacing'] as num?)?.toDouble(),
  height: (json['height'] as num?)?.toDouble(),
  decoration: json['decoration'] == null
      ? null
      : TextDecorationConfig.fromJson(json['decoration'] as Map<String, dynamic>),
  backgroundColor: json['backgroundColor'] as String?,
  backgroundBorderRadius: (json['backgroundBorderRadius'] as num?)?.toDouble(),
  backgroundPadding: json['backgroundPadding'] == null
      ? null
      : PaddingConfig.fromJson(json['backgroundPadding'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TextStyleConfigToJson(TextStyleConfig instance) => <String, dynamic>{
  'fontFamily': instance.fontFamily,
  'fontSize': instance.fontSize,
  'fontWeight': instance.fontWeight?.toJson(),
  'fontStyle': instance.fontStyle?.toJson(),
  'color': instance.color,
  'letterSpacing': instance.letterSpacing,
  'wordSpacing': instance.wordSpacing,
  'height': instance.height,
  'decoration': instance.decoration?.toJson(),
  'backgroundColor': instance.backgroundColor,
  'backgroundBorderRadius': instance.backgroundBorderRadius,
  'backgroundPadding': instance.backgroundPadding?.toJson(),
};

const _$TextStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  },
};

FontWeightConfig _$FontWeightConfigFromJson(Map<String, dynamic> json) =>
    FontWeightConfig(weight: (json['weight'] as num).toInt());

Map<String, dynamic> _$FontWeightConfigToJson(FontWeightConfig instance) => <String, dynamic>{
  'weight': instance.weight,
};

const _$FontWeightConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'weight': {'type': 'integer', 'description': 'Numeric weight of the font (100–900 typical).'},
  },
  'required': ['weight'],
};

FontStyleConfig _$FontStyleConfigFromJson(Map<String, dynamic> json) =>
    FontStyleConfig(value: json['value'] as String? ?? 'normal');

Map<String, dynamic> _$FontStyleConfigToJson(FontStyleConfig instance) => <String, dynamic>{'value': instance.value};

const _$FontStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'value': {
      'type': 'string',
      'description': 'The font style, as a string. Common values: `"normal"`, `"italic"`.',
      'default': 'normal',
    },
  },
};

TextDecorationConfig _$TextDecorationConfigFromJson(Map<String, dynamic> json) => TextDecorationConfig(
  types: (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
  hint: json['hint'] as String?,
  hintStyle: json['hintStyle'] == null ? null : TextStyleConfig.fromJson(json['hintStyle'] as Map<String, dynamic>),
  prefixText: json['prefixText'] as String?,
  prefixStyle: json['prefixStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['prefixStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TextDecorationConfigToJson(TextDecorationConfig instance) => <String, dynamic>{
  'types': instance.types,
  'hint': instance.hint,
  'hintStyle': instance.hintStyle?.toJson(),
  'prefixText': instance.prefixText,
  'prefixStyle': instance.prefixStyle?.toJson(),
};

const _$TextDecorationConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  },
};
