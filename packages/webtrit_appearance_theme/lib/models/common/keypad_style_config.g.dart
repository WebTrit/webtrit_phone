// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keypad_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeypadStyleConfig _$KeypadStyleConfigFromJson(Map<String, dynamic> json) =>
    KeypadStyleConfig(
      textStyle: json['textStyle'] == null
          ? null
          : TextStyleConfig.fromJson(json['textStyle'] as Map<String, dynamic>),
      subtextStyle: json['subtextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['subtextStyle'] as Map<String, dynamic>,
            ),
      spacing: (json['spacing'] as num?)?.toDouble(),
      padding: (json['padding'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$KeypadStyleConfigToJson(KeypadStyleConfig instance) =>
    <String, dynamic>{
      'textStyle': instance.textStyle?.toJson(),
      'subtextStyle': instance.subtextStyle?.toJson(),
      'spacing': instance.spacing,
      'padding': instance.padding,
    };

const _$KeypadStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'textStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'subtextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'spacing': {'type': 'number'},
    'padding': {'type': 'number'},
  },
  r'$defs': {
    'FontWeightConfig': {
      'type': 'object',
      'properties': {
        'weight': {
          'type': 'integer',
          'description': 'Numeric weight of the font (100–900 typical).',
        },
      },
      'required': ['weight'],
    },
    'FontStyleConfig': {
      'type': 'object',
      'properties': {
        'value': {
          'type': 'string',
          'description':
              'The font style, as a string. Common values: `"normal"`, `"italic"`.',
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
          'description':
              'A list of decoration types. Supported values:\n`"underline"`, `"lineThrough"`, `"overline"`.',
          'default': [],
        },
        'hint': {
          'type': 'string',
          'description':
              'Text to suggest what sort of input the field accepts.',
        },
        'hintStyle': {
          r'$ref': r'#/$defs/TextStyleConfig',
          'description': 'The style to use for the [hint].',
        },
        'prefixText': {
          'type': 'string',
          'description':
              'Text that appears before the editable part of the field (e.g., a currency symbol or country code).',
        },
        'prefixStyle': {
          r'$ref': r'#/$defs/TextStyleConfig',
          'description': 'The style to use for the [prefixText].',
        },
      },
    },
    'PaddingConfig': {
      'type': 'object',
      'properties': {
        'left': {
          'type': 'number',
          'description': 'Left padding value.',
          'default': 0.0,
        },
        'top': {
          'type': 'number',
          'description': 'Top padding value.',
          'default': 0.0,
        },
        'right': {
          'type': 'number',
          'description': 'Right padding value.',
          'default': 0.0,
        },
        'bottom': {
          'type': 'number',
          'description': 'Bottom padding value.',
          'default': 0.0,
        },
      },
    },
    'TextStyleConfig': {
      'type': 'object',
      'properties': {
        'fontFamily': {
          'type': 'string',
          'description': 'The name of the font family to use (e.g., "Roboto").',
        },
        'fontSize': {
          'type': 'number',
          'description': 'The size of glyphs (e.g., 14.0).',
        },
        'fontWeight': {
          r'$ref': r'#/$defs/FontWeightConfig',
          'description': 'The thickness of the glyphs.',
        },
        'fontStyle': {
          r'$ref': r'#/$defs/FontStyleConfig',
          'description': 'Whether the glyphs should be italicized.',
        },
        'color': {
          'type': 'string',
          'description': 'The text color in hex format (e.g., "#FF0000").',
        },
        'letterSpacing': {
          'type': 'number',
          'description': 'The spacing between letters, in logical pixels.',
        },
        'wordSpacing': {
          'type': 'number',
          'description': 'The spacing between words, in logical pixels.',
        },
        'height': {
          'type': 'number',
          'description': 'The line height, as a multiplier of font size.',
        },
        'decoration': {
          r'$ref': r'#/$defs/TextDecorationConfig',
          'description': 'Decorations like underline or strikethrough.',
        },
        'backgroundColor': {
          'type': 'string',
          'description': 'Background color for the text in hex format.',
        },
        'backgroundBorderRadius': {
          'type': 'number',
          'description': 'Border radius for background decoration.',
        },
        'backgroundPadding': {
          r'$ref': r'#/$defs/PaddingConfig',
          'description': 'Padding around text when background is applied.',
        },
      },
    },
  },
};
