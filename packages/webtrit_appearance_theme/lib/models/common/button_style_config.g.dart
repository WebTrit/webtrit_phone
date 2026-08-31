// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ButtonStyleConfig _$ButtonStyleConfigFromJson(Map<String, dynamic> json) =>
    ButtonStyleConfig(
      textStyle: json['textStyle'] == null
          ? null
          : TextStyleConfig.fromJson(json['textStyle'] as Map<String, dynamic>),
      backgroundColor: json['backgroundColor'] as String?,
      foregroundColor: json['foregroundColor'] as String?,
      overlayColor: json['overlayColor'] as String?,
      shadowColor: json['shadowColor'] as String?,
      surfaceTintColor: json['surfaceTintColor'] as String?,
      elevation: (json['elevation'] as num?)?.toDouble(),
      padding: json['padding'] == null
          ? null
          : EdgeInsetsConfig.fromJson(json['padding'] as Map<String, dynamic>),
      minimumSize: json['minimumSize'] == null
          ? null
          : SizeConfig.fromJson(json['minimumSize'] as Map<String, dynamic>),
      fixedSize: json['fixedSize'] == null
          ? null
          : SizeConfig.fromJson(json['fixedSize'] as Map<String, dynamic>),
      maximumSize: json['maximumSize'] == null
          ? null
          : SizeConfig.fromJson(json['maximumSize'] as Map<String, dynamic>),
      iconColor: json['iconColor'] as String?,
      iconSize: (json['iconSize'] as num?)?.toDouble(),
      side: json['side'] == null
          ? null
          : BorderSideConfig.fromJson(json['side'] as Map<String, dynamic>),
      shape: json['shape'] == null
          ? null
          : ShapeBorderConfig.fromJson(json['shape'] as Map<String, dynamic>),
      visualDensity: json['visualDensity'] == null
          ? null
          : VisualDensityConfig.fromJson(
              json['visualDensity'] as Map<String, dynamic>,
            ),
      animationDuration: (json['animationDuration'] as num?)?.toInt(),
      selectedBackgroundColor: json['selectedBackgroundColor'] as String?,
      selectedForegroundColor: json['selectedForegroundColor'] as String?,
      selectedIconColor: json['selectedIconColor'] as String?,
      disabledBackgroundColor: json['disabledBackgroundColor'] as String?,
      disabledForegroundColor: json['disabledForegroundColor'] as String?,
      disabledIconColor: json['disabledIconColor'] as String?,
      disabledShadowColor: json['disabledShadowColor'] as String?,
    );

Map<String, dynamic> _$ButtonStyleConfigToJson(ButtonStyleConfig instance) =>
    <String, dynamic>{
      'textStyle': instance.textStyle?.toJson(),
      'backgroundColor': instance.backgroundColor,
      'foregroundColor': instance.foregroundColor,
      'selectedBackgroundColor': instance.selectedBackgroundColor,
      'selectedForegroundColor': instance.selectedForegroundColor,
      'selectedIconColor': instance.selectedIconColor,
      'disabledBackgroundColor': instance.disabledBackgroundColor,
      'disabledForegroundColor': instance.disabledForegroundColor,
      'disabledIconColor': instance.disabledIconColor,
      'disabledShadowColor': instance.disabledShadowColor,
      'overlayColor': instance.overlayColor,
      'shadowColor': instance.shadowColor,
      'surfaceTintColor': instance.surfaceTintColor,
      'elevation': instance.elevation,
      'padding': instance.padding?.toJson(),
      'minimumSize': instance.minimumSize?.toJson(),
      'fixedSize': instance.fixedSize?.toJson(),
      'maximumSize': instance.maximumSize?.toJson(),
      'iconColor': instance.iconColor,
      'iconSize': instance.iconSize,
      'side': instance.side?.toJson(),
      'shape': instance.shape?.toJson(),
      'visualDensity': instance.visualDensity?.toJson(),
      'animationDuration': instance.animationDuration,
    };

const _$ButtonStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'textStyle': {
      r'$ref': r'#/$defs/TextStyleConfig',
      'description': "The style for a button's text descendants.",
    },
    'backgroundColor': {
      'type': 'string',
      'description': "The button's background fill color in hex format.",
    },
    'foregroundColor': {
      'type': 'string',
      'description':
          "The color for the button's text/icon descendants in hex format.",
    },
    'selectedBackgroundColor': {
      'type': 'string',
      'description':
          "The button's background fill color in hex format while it is switched on.\n\nOnly reaches the screen for a control that can be on or off - a mute or a\ncamera button. Left empty, the switched-on look comes from the palette.",
    },
    'selectedForegroundColor': {
      'type': 'string',
      'description':
          'The color for the text/icon descendants in hex format while the button is switched on.',
    },
    'selectedIconColor': {
      'type': 'string',
      'description':
          "The icon's color in hex format while the button is switched on.",
    },
    'disabledBackgroundColor': {
      'type': 'string',
      'description':
          "The button's background fill color in hex format when the button is disabled.",
    },
    'disabledForegroundColor': {
      'type': 'string',
      'description':
          "The color for the button's text/icon descendants in hex format when the button is disabled.",
    },
    'disabledIconColor': {
      'type': 'string',
      'description':
          "The icon's color in hex format when the button is disabled.",
    },
    'disabledShadowColor': {
      'type': 'string',
      'description':
          'The shadow color in hex format when the button is disabled.',
    },
    'overlayColor': {
      'type': 'string',
      'description':
          'The highlight color for states (focused, hovered, pressed) in hex format.',
    },
    'shadowColor': {
      'type': 'string',
      'description': 'The shadow color in hex format.',
    },
    'surfaceTintColor': {
      'type': 'string',
      'description': 'The surface tint color in hex format.',
    },
    'elevation': {
      'type': 'number',
      'description': 'The elevation of the button.',
    },
    'padding': {
      r'$ref': r'#/$defs/EdgeInsetsConfig',
      'description': "The padding between the button's boundary and its child.",
    },
    'minimumSize': {
      r'$ref': r'#/$defs/SizeConfig',
      'description': 'The minimum size of the button.',
    },
    'fixedSize': {
      r'$ref': r'#/$defs/SizeConfig',
      'description': 'The fixed size of the button.',
    },
    'maximumSize': {
      r'$ref': r'#/$defs/SizeConfig',
      'description': 'The maximum size of the button.',
    },
    'iconColor': {
      'type': 'string',
      'description': "The icon's color in hex format.",
    },
    'iconSize': {'type': 'number', 'description': "The icon's size."},
    'side': {
      r'$ref': r'#/$defs/BorderSideConfig',
      'description': "The color and weight of the button's outline.",
    },
    'shape': {
      r'$ref': r'#/$defs/ShapeBorderConfig',
      'description': 'The shape of the button (e.g., rounded corners).',
    },
    'visualDensity': {
      r'$ref': r'#/$defs/VisualDensityConfig',
      'description': "Defines how compact the button's layout will be.",
    },
    'animationDuration': {
      'type': 'integer',
      'description': 'The duration of animated changes in milliseconds.',
    },
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
    'EdgeInsetsConfig': {
      'type': 'object',
      'properties': {
        'left': {'type': 'number', 'default': 0.0},
        'top': {'type': 'number', 'default': 0.0},
        'right': {'type': 'number', 'default': 0.0},
        'bottom': {'type': 'number', 'default': 0.0},
      },
    },
    'SizeConfig': {
      'type': 'object',
      'properties': {
        'width': {'type': 'number'},
        'height': {'type': 'number'},
      },
      'required': ['width', 'height'],
    },
    'BorderSideConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Color in hex format.'},
        'width': {'type': 'number', 'default': 1.0},
        'style': {
          'type': 'string',
          'description': "Border style (e.g., 'solid', 'none').",
          'default': 'solid',
        },
      },
    },
    'ShapeBorderConfig': {
      'type': 'object',
      'properties': {
        'type': {
          'type': 'string',
          'description':
              "The type of shape. Common values: 'rounded', 'circle', 'stadium', 'beveled'.",
          'default': 'rounded',
        },
        'borderRadius': {
          'type': 'number',
          'description':
              'The border radius value (for rounded/beveled shapes).',
        },
      },
    },
    'VisualDensityConfig': {
      'type': 'object',
      'properties': {
        'horizontal': {'type': 'number', 'default': 0.0},
        'vertical': {'type': 'number', 'default': 0.0},
      },
    },
  },
};
