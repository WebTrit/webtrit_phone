// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leading_avatar_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadingAvatarStyleConfig _$LeadingAvatarStyleConfigFromJson(
  Map<String, dynamic> json,
) => LeadingAvatarStyleConfig(
  backgroundColor: json['backgroundColor'] as String?,
  radius: (json['radius'] as num?)?.toDouble(),
  initialsTextStyle: json['initialsTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(
          json['initialsTextStyle'] as Map<String, dynamic>,
        ),
  placeholderIcon: json['placeholderIcon'] == null
      ? null
      : IconDataConfig.fromJson(
          json['placeholderIcon'] as Map<String, dynamic>,
        ),
  loading: json['loading'] == null
      ? null
      : LoadingOverlayStyleConfig.fromJson(
          json['loading'] as Map<String, dynamic>,
        ),
  smartIndicator: json['smartIndicator'] == null
      ? null
      : SmartIndicatorStyleConfig.fromJson(
          json['smartIndicator'] as Map<String, dynamic>,
        ),
  registeredBadge: json['registeredBadge'] == null
      ? null
      : RegisteredBadgeStyleConfig.fromJson(
          json['registeredBadge'] as Map<String, dynamic>,
        ),
  presenceBadge: json['presenceBadge'] == null
      ? null
      : PresenceBadgeStyleConfig.fromJson(
          json['presenceBadge'] as Map<String, dynamic>,
        ),
  nameColors: json['nameColors'] == null
      ? null
      : NameColorsStyleConfig.fromJson(
          json['nameColors'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$LeadingAvatarStyleConfigToJson(
  LeadingAvatarStyleConfig instance,
) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'radius': instance.radius,
  'initialsTextStyle': instance.initialsTextStyle?.toJson(),
  'placeholderIcon': instance.placeholderIcon?.toJson(),
  'loading': instance.loading?.toJson(),
  'smartIndicator': instance.smartIndicator?.toJson(),
  'registeredBadge': instance.registeredBadge?.toJson(),
  'presenceBadge': instance.presenceBadge?.toJson(),
  'nameColors': instance.nameColors?.toJson(),
};

const _$LeadingAvatarStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'backgroundColor': {
      'type': 'string',
      'description':
          'Circle background color. Defaults to theme.secondaryContainer when null.',
    },
    'radius': {
      'type': 'number',
      'description': 'Avatar radius (defaults to 20.0 in widget if null).',
    },
    'initialsTextStyle': {
      r'$ref': r'#/$defs/TextStyleConfig',
      'description': 'Text style for initials fallback.',
    },
    'placeholderIcon': {
      r'$ref': r'#/$defs/IconDataConfig',
      'description':
          'Placeholder icon when no username/thumbnail is available.',
    },
    'loading': {
      r'$ref': r'#/$defs/LoadingOverlayStyleConfig',
      'description': 'Loading overlay appearance.',
    },
    'smartIndicator': {
      r'$ref': r'#/$defs/SmartIndicatorStyleConfig',
      'description': '"Smart" badge indicator appearance.',
    },
    'registeredBadge': {
      r'$ref': r'#/$defs/RegisteredBadgeStyleConfig',
      'description': 'Registered/unregistered badge appearance.',
    },
    'presenceBadge': {
      r'$ref': r'#/$defs/PresenceBadgeStyleConfig',
      'description': 'Presence badge appearance.',
    },
    'nameColors': {
      r'$ref': r'#/$defs/NameColorsStyleConfig',
      'description': 'Per-name pseudorandom color appearance.',
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
    'IconDataConfig': {
      'type': 'object',
      'properties': {
        'codePoint': {'type': 'integer'},
        'fontFamily': {'type': 'string', 'default': 'MaterialIcons'},
        'matchTextDirection': {'type': 'boolean', 'default': false},
      },
      'required': ['codePoint'],
    },
    'LoadingOverlayStyleConfig': {
      'type': 'object',
      'properties': {
        'showByDefault': {
          'type': 'boolean',
          'description':
              'Whether the overlay should be shown by default (widget may still override).',
          'default': false,
        },
        'padding': {
          r'$ref': r'#/$defs/PaddingConfig',
          'description': 'Padding around the loading indicator.',
        },
        'strokeWidth': {
          'type': 'number',
          'description':
              'CircularProgressIndicator stroke width (defaults to 1.0 in widget).',
        },
      },
    },
    'SmartIndicatorStyleConfig': {
      'type': 'object',
      'properties': {
        'backgroundColor': {
          'type': 'string',
          'description': 'Background color of the smart indicator circle.',
        },
        'icon': {
          r'$ref': r'#/$defs/IconDataConfig',
          'description': 'Icon displayed inside the smart indicator.',
        },
        'sizeFactor': {
          'type': 'number',
          'description':
              'Size factor relative to avatar diameter (widget uses ~0.4 by default).',
        },
      },
    },
    'RegisteredBadgeStyleConfig': {
      'type': 'object',
      'properties': {
        'registeredColor': {
          'type': 'string',
          'description': 'Color used when `registered == true`.',
        },
        'unregisteredColor': {
          'type': 'string',
          'description': 'Color used when `registered == false`.',
        },
        'sizeFactor': {
          'type': 'number',
          'description':
              'Size factor relative to avatar diameter (widget uses ~0.2 by default).',
        },
      },
    },
    'PresenceBadgeStyleConfig': {
      'type': 'object',
      'properties': {
        'availableColor': {
          'type': 'string',
          'description':
              'Color used when presence is "available" (e.g., online, idle).',
        },
        'unavailableColor': {
          'type': 'string',
          'description':
              'Color used when presence is "unavailable" (e.g., offline).',
        },
        'busyColor': {
          'type': 'string',
          'description':
              'Color used when the contact should not be called right now: one\npublishing "busy" or "do not disturb".',
        },
        'iconColor': {
          'type': 'string',
          'description':
              'Color of the activity glyph drawn inside the badge; it has to read on\ntop of the badge fill.',
        },
        'sizeFactor': {
          'type': 'number',
          'description': 'Size factor relative to avatar diameter.',
        },
      },
    },
    'NameColorsStyleConfig': {
      'type': 'object',
      'properties': {
        'enabled': {
          'type': 'boolean',
          'description': 'Whether name-derived colors are used at all.',
          'default': true,
        },
        'palette': {
          'type': 'array',
          'items': {'type': 'string'},
          'description':
              'Optional fixed palette to pick from; when null/empty the color is generated from the\nname hash (hue) so the number of distinct colors is unbounded.',
        },
      },
    },
  },
};

NameColorsStyleConfig _$NameColorsStyleConfigFromJson(
  Map<String, dynamic> json,
) => NameColorsStyleConfig(
  enabled: json['enabled'] as bool? ?? true,
  palette: (json['palette'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$NameColorsStyleConfigToJson(
  NameColorsStyleConfig instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'palette': instance.palette,
};

const _$NameColorsStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {
      'type': 'boolean',
      'description': 'Whether name-derived colors are used at all.',
      'default': true,
    },
    'palette': {
      'type': 'array',
      'items': {'type': 'string'},
      'description':
          'Optional fixed palette to pick from; when null/empty the color is generated from the\nname hash (hue) so the number of distinct colors is unbounded.',
    },
  },
};

LoadingOverlayStyleConfig _$LoadingOverlayStyleConfigFromJson(
  Map<String, dynamic> json,
) => LoadingOverlayStyleConfig(
  showByDefault: json['showByDefault'] as bool? ?? false,
  padding: json['padding'] == null
      ? PaddingConfig.default2
      : PaddingConfig.fromJson(json['padding'] as Map<String, dynamic>),
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble(),
);

Map<String, dynamic> _$LoadingOverlayStyleConfigToJson(
  LoadingOverlayStyleConfig instance,
) => <String, dynamic>{
  'showByDefault': instance.showByDefault,
  'padding': instance.padding,
  'strokeWidth': instance.strokeWidth,
};

const _$LoadingOverlayStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'showByDefault': {
      'type': 'boolean',
      'description':
          'Whether the overlay should be shown by default (widget may still override).',
      'default': false,
    },
    'padding': {
      r'$ref': r'#/$defs/PaddingConfig',
      'description': 'Padding around the loading indicator.',
    },
    'strokeWidth': {
      'type': 'number',
      'description':
          'CircularProgressIndicator stroke width (defaults to 1.0 in widget).',
    },
  },
  r'$defs': {
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
  },
};

SmartIndicatorStyleConfig _$SmartIndicatorStyleConfigFromJson(
  Map<String, dynamic> json,
) => SmartIndicatorStyleConfig(
  backgroundColor: json['backgroundColor'] as String?,
  icon: json['icon'] == null
      ? null
      : IconDataConfig.fromJson(json['icon'] as Map<String, dynamic>),
  sizeFactor: (json['sizeFactor'] as num?)?.toDouble(),
);

Map<String, dynamic> _$SmartIndicatorStyleConfigToJson(
  SmartIndicatorStyleConfig instance,
) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'icon': instance.icon,
  'sizeFactor': instance.sizeFactor,
};

const _$SmartIndicatorStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'backgroundColor': {
      'type': 'string',
      'description': 'Background color of the smart indicator circle.',
    },
    'icon': {
      r'$ref': r'#/$defs/IconDataConfig',
      'description': 'Icon displayed inside the smart indicator.',
    },
    'sizeFactor': {
      'type': 'number',
      'description':
          'Size factor relative to avatar diameter (widget uses ~0.4 by default).',
    },
  },
  r'$defs': {
    'IconDataConfig': {
      'type': 'object',
      'properties': {
        'codePoint': {'type': 'integer'},
        'fontFamily': {'type': 'string', 'default': 'MaterialIcons'},
        'matchTextDirection': {'type': 'boolean', 'default': false},
      },
      'required': ['codePoint'],
    },
  },
};

RegisteredBadgeStyleConfig _$RegisteredBadgeStyleConfigFromJson(
  Map<String, dynamic> json,
) => RegisteredBadgeStyleConfig(
  registeredColor: json['registeredColor'] as String?,
  unregisteredColor: json['unregisteredColor'] as String?,
  sizeFactor: (json['sizeFactor'] as num?)?.toDouble(),
);

Map<String, dynamic> _$RegisteredBadgeStyleConfigToJson(
  RegisteredBadgeStyleConfig instance,
) => <String, dynamic>{
  'registeredColor': instance.registeredColor,
  'unregisteredColor': instance.unregisteredColor,
  'sizeFactor': instance.sizeFactor,
};

const _$RegisteredBadgeStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'registeredColor': {
      'type': 'string',
      'description': 'Color used when `registered == true`.',
    },
    'unregisteredColor': {
      'type': 'string',
      'description': 'Color used when `registered == false`.',
    },
    'sizeFactor': {
      'type': 'number',
      'description':
          'Size factor relative to avatar diameter (widget uses ~0.2 by default).',
    },
  },
};

PresenceBadgeStyleConfig _$PresenceBadgeStyleConfigFromJson(
  Map<String, dynamic> json,
) => PresenceBadgeStyleConfig(
  availableColor: json['availableColor'] as String?,
  unavailableColor: json['unavailableColor'] as String?,
  busyColor: json['busyColor'] as String?,
  iconColor: json['iconColor'] as String?,
  sizeFactor: (json['sizeFactor'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PresenceBadgeStyleConfigToJson(
  PresenceBadgeStyleConfig instance,
) => <String, dynamic>{
  'availableColor': instance.availableColor,
  'unavailableColor': instance.unavailableColor,
  'busyColor': instance.busyColor,
  'iconColor': instance.iconColor,
  'sizeFactor': instance.sizeFactor,
};

const _$PresenceBadgeStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'availableColor': {
      'type': 'string',
      'description':
          'Color used when presence is "available" (e.g., online, idle).',
    },
    'unavailableColor': {
      'type': 'string',
      'description':
          'Color used when presence is "unavailable" (e.g., offline).',
    },
    'busyColor': {
      'type': 'string',
      'description':
          'Color used when the contact should not be called right now: one\npublishing "busy" or "do not disturb".',
    },
    'iconColor': {
      'type': 'string',
      'description':
          'Color of the activity glyph drawn inside the badge; it has to read on\ntop of the badge fill.',
    },
    'sizeFactor': {
      'type': 'number',
      'description': 'Size factor relative to avatar diameter.',
    },
  },
};
