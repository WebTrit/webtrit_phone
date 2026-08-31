// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeSettings _$ThemeSettingsFromJson(Map<String, dynamic> json) => ThemeSettings(
  lightColorSchemeConfig: json['lightColorSchemeConfig'] == null
      ? const ColorSchemeConfig()
      : ColorSchemeConfig.fromJson(json['lightColorSchemeConfig'] as Map<String, dynamic>),
  darkColorSchemeConfig: json['darkColorSchemeConfig'] == null
      ? const ColorSchemeConfig()
      : ColorSchemeConfig.fromJson(json['darkColorSchemeConfig'] as Map<String, dynamic>),
  themeWidgetLightConfig: json['themeWidgetLightConfig'] == null
      ? const ThemeWidgetConfig()
      : ThemeWidgetConfig.fromJson(json['themeWidgetLightConfig'] as Map<String, dynamic>),
  themeWidgetDarkConfig: json['themeWidgetDarkConfig'] == null
      ? const ThemeWidgetConfig()
      : ThemeWidgetConfig.fromJson(json['themeWidgetDarkConfig'] as Map<String, dynamic>),
  themePageLightConfig: json['themePageLightConfig'] == null
      ? const ThemePageConfig()
      : ThemePageConfig.fromJson(json['themePageLightConfig'] as Map<String, dynamic>),
  themePageDarkConfig: json['themePageDarkConfig'] == null
      ? const ThemePageConfig()
      : ThemePageConfig.fromJson(json['themePageDarkConfig'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ThemeSettingsToJson(ThemeSettings instance) => <String, dynamic>{
  'lightColorSchemeConfig': instance.lightColorSchemeConfig.toJson(),
  'darkColorSchemeConfig': instance.darkColorSchemeConfig.toJson(),
  'themeWidgetLightConfig': instance.themeWidgetLightConfig.toJson(),
  'themeWidgetDarkConfig': instance.themeWidgetDarkConfig.toJson(),
  'themePageLightConfig': instance.themePageLightConfig.toJson(),
  'themePageDarkConfig': instance.themePageDarkConfig.toJson(),
};

const _$ThemeSettingsJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'lightColorSchemeConfig': {
      r'$ref': r'#/$defs/ColorSchemeConfig',
      'description': 'Configuration for the light color scheme.',
    },
    'darkColorSchemeConfig': {
      r'$ref': r'#/$defs/ColorSchemeConfig',
      'description': 'Configuration for the dark color scheme.',
    },
    'themeWidgetLightConfig': {
      r'$ref': r'#/$defs/ThemeWidgetConfig',
      'description': 'Widget-level configuration for the light theme.',
    },
    'themeWidgetDarkConfig': {
      r'$ref': r'#/$defs/ThemeWidgetConfig',
      'description': 'Widget-level configuration for the dark theme.',
    },
    'themePageLightConfig': {
      r'$ref': r'#/$defs/ThemePageConfig',
      'description': 'Page-level configuration for the light theme.',
    },
    'themePageDarkConfig': {
      r'$ref': r'#/$defs/ThemePageConfig',
      'description': 'Page-level configuration for the dark theme.',
    },
  },
  r'$defs': {
    'ColorSchemeOverride': {
      'type': 'object',
      'properties': {
        'primary': {'type': 'string'},
        'onPrimary': {'type': 'string'},
        'primaryContainer': {'type': 'string'},
        'onPrimaryContainer': {'type': 'string'},
        'primaryFixed': {'type': 'string'},
        'primaryFixedDim': {'type': 'string'},
        'onPrimaryFixed': {'type': 'string'},
        'onPrimaryFixedVariant': {'type': 'string'},
        'secondary': {'type': 'string'},
        'onSecondary': {'type': 'string'},
        'secondaryContainer': {'type': 'string'},
        'onSecondaryContainer': {'type': 'string'},
        'secondaryFixed': {'type': 'string'},
        'secondaryFixedDim': {'type': 'string'},
        'onSecondaryFixed': {'type': 'string'},
        'onSecondaryFixedVariant': {'type': 'string'},
        'tertiary': {'type': 'string'},
        'onTertiary': {'type': 'string'},
        'tertiaryContainer': {'type': 'string'},
        'onTertiaryContainer': {'type': 'string'},
        'tertiaryFixed': {'type': 'string'},
        'tertiaryFixedDim': {'type': 'string'},
        'onTertiaryFixed': {'type': 'string'},
        'onTertiaryFixedVariant': {'type': 'string'},
        'error': {'type': 'string'},
        'onError': {'type': 'string'},
        'errorContainer': {'type': 'string'},
        'onErrorContainer': {'type': 'string'},
        'outline': {'type': 'string'},
        'outlineVariant': {'type': 'string'},
        'surface': {'type': 'string'},
        'onSurface': {'type': 'string'},
        'surfaceDim': {'type': 'string'},
        'surfaceBright': {'type': 'string'},
        'surfaceContainerLowest': {'type': 'string'},
        'surfaceContainerLow': {'type': 'string'},
        'surfaceContainer': {'type': 'string'},
        'surfaceContainerHigh': {'type': 'string'},
        'surfaceContainerHighest': {'type': 'string'},
        'onSurfaceVariant': {'type': 'string'},
        'inverseSurface': {'type': 'string'},
        'onInverseSurface': {'type': 'string'},
        'inversePrimary': {'type': 'string'},
        'shadow': {'type': 'string'},
        'scrim': {'type': 'string'},
        'surfaceTint': {'type': 'string'},
      },
    },
    'ColorSchemeConfig': {
      'type': 'object',
      'properties': {
        'seedColor': {
          'type': 'string',
          'description': 'The seed color used to generate tonal palettes for the theme.',
          'default': '#F95A14',
        },
        'colorSchemeOverride': {
          r'$ref': r'#/$defs/ColorSchemeOverride',
          'description': 'Explicit overrides for the generated color scheme.',
        },
      },
    },
    'FontsConfig': {
      'type': 'object',
      'properties': {
        'fontFamily': {'type': 'string'},
      },
    },
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
        'style': {'type': 'string', 'description': "Border style (e.g., 'solid', 'none').", 'default': 'solid'},
      },
    },
    'ShapeBorderConfig': {
      'type': 'object',
      'properties': {
        'type': {
          'type': 'string',
          'description': "The type of shape. Common values: 'rounded', 'circle', 'stadium', 'beveled'.",
          'default': 'rounded',
        },
        'borderRadius': {'type': 'number', 'description': 'The border radius value (for rounded/beveled shapes).'},
      },
    },
    'VisualDensityConfig': {
      'type': 'object',
      'properties': {
        'horizontal': {'type': 'number', 'default': 0.0},
        'vertical': {'type': 'number', 'default': 0.0},
      },
    },
    'ButtonStyleConfig': {
      'type': 'object',
      'properties': {
        'textStyle': {r'$ref': r'#/$defs/TextStyleConfig', 'description': "The style for a button's text descendants."},
        'backgroundColor': {'type': 'string', 'description': "The button's background fill color in hex format."},
        'foregroundColor': {
          'type': 'string',
          'description': "The color for the button's text/icon descendants in hex format.",
        },
        'selectedBackgroundColor': {
          'type': 'string',
          'description':
              "The button's background fill color in hex format while it is switched on.\n\nOnly reaches the screen for a control that can be on or off - a mute or a\ncamera button. Left empty, the switched-on look comes from the palette.",
        },
        'selectedForegroundColor': {
          'type': 'string',
          'description': 'The color for the text/icon descendants in hex format while the button is switched on.',
        },
        'selectedIconColor': {
          'type': 'string',
          'description': "The icon's color in hex format while the button is switched on.",
        },
        'disabledBackgroundColor': {
          'type': 'string',
          'description': "The button's background fill color in hex format when the button is disabled.",
        },
        'disabledForegroundColor': {
          'type': 'string',
          'description': "The color for the button's text/icon descendants in hex format when the button is disabled.",
        },
        'disabledIconColor': {
          'type': 'string',
          'description': "The icon's color in hex format when the button is disabled.",
        },
        'disabledShadowColor': {
          'type': 'string',
          'description': 'The shadow color in hex format when the button is disabled.',
        },
        'overlayColor': {
          'type': 'string',
          'description': 'The highlight color for states (focused, hovered, pressed) in hex format.',
        },
        'shadowColor': {'type': 'string', 'description': 'The shadow color in hex format.'},
        'surfaceTintColor': {'type': 'string', 'description': 'The surface tint color in hex format.'},
        'elevation': {'type': 'number', 'description': 'The elevation of the button.'},
        'padding': {
          r'$ref': r'#/$defs/EdgeInsetsConfig',
          'description': "The padding between the button's boundary and its child.",
        },
        'minimumSize': {r'$ref': r'#/$defs/SizeConfig', 'description': 'The minimum size of the button.'},
        'fixedSize': {r'$ref': r'#/$defs/SizeConfig', 'description': 'The fixed size of the button.'},
        'maximumSize': {r'$ref': r'#/$defs/SizeConfig', 'description': 'The maximum size of the button.'},
        'iconColor': {'type': 'string', 'description': "The icon's color in hex format."},
        'iconSize': {'type': 'number', 'description': "The icon's size."},
        'side': {r'$ref': r'#/$defs/BorderSideConfig', 'description': "The color and weight of the button's outline."},
        'shape': {
          r'$ref': r'#/$defs/ShapeBorderConfig',
          'description': 'The shape of the button (e.g., rounded corners).',
        },
        'visualDensity': {
          r'$ref': r'#/$defs/VisualDensityConfig',
          'description': "Defines how compact the button's layout will be.",
        },
        'animationDuration': {'type': 'integer', 'description': 'The duration of animated changes in milliseconds.'},
      },
    },
    'ButtonWidgetConfig': {
      'type': 'object',
      'properties': {
        'primaryElevatedButton': {r'$ref': r'#/$defs/ButtonStyleConfig'},
      },
    },
    'GroupTitleListTileWidgetConfig': {
      'type': 'object',
      'properties': {
        'backgroundColor': {'type': 'string'},
        'textStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
      },
    },
    'CallActionsWidgetConfig': {
      'type': 'object',
      'properties': {
        'callStartBackgroundColor': {'type': 'string'},
        'hangupBackgroundColor': {'type': 'string'},
        'transferBackgroundColor': {'type': 'string'},
        'cameraBackgroundColor': {'type': 'string'},
        'cameraActiveBackgroundColor': {'type': 'string'},
        'mutedBackgroundColor': {'type': 'string'},
        'mutedActiveBackgroundColor': {'type': 'string'},
        'speakerBackgroundColor': {'type': 'string'},
        'speakerActiveBackgroundColor': {'type': 'string'},
        'heldBackgroundColor': {'type': 'string'},
        'heldActiveBackgroundColor': {'type': 'string'},
        'swapBackgroundColor': {'type': 'string'},
        'keyBackgroundColor': {'type': 'string'},
        'keypadBackgroundColor': {'type': 'string'},
        'keypadActiveBackgroundColor': {'type': 'string'},
      },
    },
    'GroupWidgetConfig': {
      'type': 'object',
      'properties': {
        'groupTitleListTile': {r'$ref': r'#/$defs/GroupTitleListTileWidgetConfig'},
        'callActions': {r'$ref': r'#/$defs/CallActionsWidgetConfig'},
      },
    },
    'BottomNavigationBarWidgetConfig': {
      'type': 'object',
      'properties': {
        'backgroundColor': {'type': 'string'},
        'selectedItemColor': {'type': 'string'},
        'unSelectedItemColor': {'type': 'string'},
      },
    },
    'OffsetConfig': {
      'type': 'object',
      'properties': {
        'dx': {'type': 'number', 'default': 0.0},
        'dy': {'type': 'number', 'default': 0.0},
      },
    },
    'ShadowConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Color of the shadow (hex string).'},
        'offset': {r'$ref': r'#/$defs/OffsetConfig', 'description': 'The displacement of the shadow.'},
        'blurRadius': {'type': 'number', 'description': 'The blur radius of the shadow.', 'default': 0.0},
      },
    },
    'IconThemeDataConfig': {
      'type': 'object',
      'properties': {
        'size': {'type': 'number', 'description': 'The default size for icons.'},
        'fill': {
          'type': 'number',
          'description': 'The default fill for icons (0.0 to 1.0).\nUseful for variable fonts (e.g. Material Symbols).',
        },
        'weight': {
          'type': 'number',
          'description': 'The default weight for icons (e.g. 400.0).\nUseful for variable fonts.',
        },
        'grade': {'type': 'number', 'description': 'The default grade for icons.\nUseful for variable fonts.'},
        'opticalSize': {
          'type': 'number',
          'description': 'The default optical size for icons.\nUseful for variable fonts.',
        },
        'color': {'type': 'string', 'description': 'The default color for icons (hex string).'},
        'opacity': {'type': 'number', 'description': 'An opacity to apply to both explicit and default icon colors.'},
        'shadows': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/ShadowConfig'},
          'description': 'A list of shadows to apply to the icons.',
        },
        'applyTextScaling': {'type': 'boolean', 'description': 'Whether to apply text scaling to the icons.'},
      },
    },
    'OverlayStyleModel': {
      'type': 'object',
      'properties': {
        'systemNavigationBarColor': {
          'type': 'string',
          'description':
              'System navigation bar background color.\n\nIgnored by the app: Android 15+ enforces edge-to-edge, where the platform drops\nthis color entirely, so the navigation bar is always transparent and the app\npaints its own surfaces behind it. Kept only so existing theme configs that still\ncarry the field keep deserializing.',
        },
        'systemNavigationBarIconBrightness': {
          'type': 'string',
          'description': 'System navigation bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarIconBrightness': {
          'type': 'string',
          'description': 'Status bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarBrightness': {'type': 'string', 'description': 'Status bar brightness (e.g., "dark" or "light").'},
      },
    },
    'AppBarConfig': {
      'type': 'object',
      'properties': {
        'primary': {'type': 'boolean', 'default': true},
        'showBackButton': {'type': 'boolean', 'default': true},
        'backgroundColor': {'type': 'string'},
        'foregroundColor': {'type': 'string'},
        'shadowColor': {'type': 'string'},
        'surfaceTintColor': {'type': 'string'},
        'elevation': {'type': 'number'},
        'scrolledUnderElevation': {'type': 'number'},
        'titleSpacing': {'type': 'number'},
        'leadingWidth': {'type': 'number'},
        'toolbarHeight': {'type': 'number'},
        'centerTitle': {'type': 'boolean'},
        'iconTheme': {r'$ref': r'#/$defs/IconThemeDataConfig'},
        'actionsIconTheme': {r'$ref': r'#/$defs/IconThemeDataConfig'},
        'titleTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'toolbarTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'systemOverlayStyle': {r'$ref': r'#/$defs/OverlayStyleModel'},
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
    'TabBarConfig': {
      'type': 'object',
      'properties': {
        'indicatorColor': {'type': 'string'},
        'dividerColor': {'type': 'string'},
        'labelColor': {'type': 'string'},
        'unselectedLabelColor': {'type': 'string'},
        'overlayColor': {'type': 'string'},
        'dividerHeight': {'type': 'number'},
        'labelPadding': {r'$ref': r'#/$defs/PaddingConfig'},
        'labelStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'unselectedLabelStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'indicatorSize': {
          'enum': ['tab', 'label'],
        },
        'tabAlignment': {
          'enum': ['start', 'startOffset', 'fill', 'center'],
        },
        'indicatorAnimation': {
          'enum': ['linear', 'elastic'],
        },
        'splashFactory': {
          'enum': ['noSplash', 'inkRipple', 'inkSparkle'],
        },
        'indicatorBorder': {r'$ref': r'#/$defs/BorderConfig'},
      },
    },
    'BarWidgetConfig': {
      'type': 'object',
      'properties': {
        'bottomNavigationBar': {r'$ref': r'#/$defs/BottomNavigationBarWidgetConfig'},
        'appBarConfig': {r'$ref': r'#/$defs/AppBarConfig'},
        'tabBarConfig': {r'$ref': r'#/$defs/TabBarConfig'},
      },
    },
    'ImageRenderSpec': {
      'type': 'object',
      'properties': {
        'scale': {'type': 'number'},
        'padding': {r'$ref': r'#/$defs/PaddingConfig'},
        'alignment': {
          'enum': [
            'topLeft',
            'topCenter',
            'topRight',
            'centerLeft',
            'center',
            'centerRight',
            'bottomLeft',
            'bottomCenter',
            'bottomRight',
          ],
        },
        'fit': {
          'enum': ['fill', 'contain', 'cover', 'fitWidth', 'fitHeight', 'none', 'scaleDown'],
        },
      },
    },
    'Metadata': {
      'type': 'object',
      'properties': {
        'attributes': {
          'type': 'object',
          'additionalProperties': {'type': 'object'},
          'description': 'A map storing arbitrary key-value pairs for contextual or configuration data.',
          'default': {},
        },
      },
    },
    'ImageSource': {
      'type': 'object',
      'properties': {
        'id': {'type': 'string', 'description': 'Backend asset ID (unique identifier in storage).'},
        'uri': {'type': 'string', 'description': 'Unified URI pointing to the resource.'},
        'refType': {
          'type': 'string',
          'description': 'Semantic type of reference (default = "asset").',
          'default': 'asset',
        },
        'render': {
          r'$ref': r'#/$defs/ImageRenderSpec',
          'description': 'Rendering specification (scale, padding, etc.).',
        },
        'metadata': {r'$ref': r'#/$defs/Metadata', 'description': 'Freeform metadata for CLI or pipeline tools.'},
      },
    },
    'AppIconWidgetConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string'},
      },
    },
    'IconDataConfig': {
      'type': 'object',
      'properties': {
        'codePoint': {'type': 'string', 'description': 'The code point in hex, e.g. `e491`.'},
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
          'description': 'Whether the overlay should be shown by default (widget may still override).',
          'default': false,
        },
        'padding': {r'$ref': r'#/$defs/PaddingConfig', 'description': 'Padding around the loading indicator.'},
        'strokeWidth': {
          'type': 'number',
          'description': 'CircularProgressIndicator stroke width (defaults to 1.0 in widget).',
        },
      },
    },
    'SmartIndicatorStyleConfig': {
      'type': 'object',
      'properties': {
        'backgroundColor': {'type': 'string', 'description': 'Background color of the smart indicator circle.'},
        'icon': {r'$ref': r'#/$defs/IconDataConfig', 'description': 'Icon displayed inside the smart indicator.'},
        'sizeFactor': {
          'type': 'number',
          'description': 'Size factor relative to avatar diameter (widget uses ~0.4 by default).',
        },
      },
    },
    'RegisteredBadgeStyleConfig': {
      'type': 'object',
      'properties': {
        'registeredColor': {'type': 'string', 'description': 'Color used when `registered == true`.'},
        'unregisteredColor': {'type': 'string', 'description': 'Color used when `registered == false`.'},
        'sizeFactor': {
          'type': 'number',
          'description': 'Size factor relative to avatar diameter (widget uses ~0.2 by default).',
        },
      },
    },
    'PresenceBadgeStyleConfig': {
      'type': 'object',
      'properties': {
        'availableColor': {
          'type': 'string',
          'description': 'Color used when presence is "available" (e.g., online, idle).',
        },
        'unavailableColor': {
          'type': 'string',
          'description': 'Color used when presence is "unavailable" (e.g., offline).',
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
        'sizeFactor': {'type': 'number', 'description': 'Size factor relative to avatar diameter.'},
      },
    },
    'NameColorsStyleConfig': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'description': 'Whether name-derived colors are used at all.', 'default': true},
        'palette': {
          'type': 'array',
          'items': {'type': 'string'},
          'description':
              'Optional fixed palette to pick from; when null/empty the color is generated from the\nname hash (hue) so the number of distinct colors is unbounded.',
        },
      },
    },
    'LeadingAvatarStyleConfig': {
      'type': 'object',
      'properties': {
        'backgroundColor': {
          'type': 'string',
          'description': 'Circle background color. Defaults to theme.secondaryContainer when null.',
        },
        'radius': {'type': 'number', 'description': 'Avatar radius (defaults to 20.0 in widget if null).'},
        'initialsTextStyle': {r'$ref': r'#/$defs/TextStyleConfig', 'description': 'Text style for initials fallback.'},
        'placeholderIcon': {
          r'$ref': r'#/$defs/IconDataConfig',
          'description': 'Placeholder icon when no username/thumbnail is available.',
        },
        'loading': {r'$ref': r'#/$defs/LoadingOverlayStyleConfig', 'description': 'Loading overlay appearance.'},
        'smartIndicator': {
          r'$ref': r'#/$defs/SmartIndicatorStyleConfig',
          'description': '"Smart" badge indicator appearance.',
        },
        'registeredBadge': {
          r'$ref': r'#/$defs/RegisteredBadgeStyleConfig',
          'description': 'Registered/unregistered badge appearance.',
        },
        'presenceBadge': {r'$ref': r'#/$defs/PresenceBadgeStyleConfig', 'description': 'Presence badge appearance.'},
        'nameColors': {
          r'$ref': r'#/$defs/NameColorsStyleConfig',
          'description': 'Per-name pseudorandom color appearance.',
        },
      },
    },
    'ImageAssetsConfig': {
      'type': 'object',
      'properties': {
        'defaultPlaceholderImage': {r'$ref': r'#/$defs/ImageSource'},
        'appIcon': {r'$ref': r'#/$defs/AppIconWidgetConfig'},
        'leadingAvatarStyle': {r'$ref': r'#/$defs/LeadingAvatarStyleConfig'},
      },
    },
    'BorderWidgetConfig': {
      'type': 'object',
      'properties': {
        'typicalColor': {'type': 'string'},
        'errorColor': {'type': 'string'},
      },
    },
    'InputBorderWidgetConfig': {
      'type': 'object',
      'properties': {
        'disabled': {r'$ref': r'#/$defs/BorderWidgetConfig'},
        'focused': {r'$ref': r'#/$defs/BorderWidgetConfig'},
        'any': {r'$ref': r'#/$defs/BorderWidgetConfig'},
      },
    },
    'TextFormFieldWidgetConfig': {
      'type': 'object',
      'properties': {
        'labelColor': {'type': 'string'},
        'border': {r'$ref': r'#/$defs/InputBorderWidgetConfig'},
      },
    },
    'InputWidgetConfig': {
      'type': 'object',
      'properties': {
        'primary': {r'$ref': r'#/$defs/TextFormFieldWidgetConfig'},
      },
    },
    'TextSelectionWidgetConfig': {
      'type': 'object',
      'properties': {
        'cursorColor': {'type': 'string'},
        'selectionColor': {'type': 'string'},
        'selectionHandleColor': {'type': 'string'},
      },
    },
    'LinkifyWidgetConfig': {
      'type': 'object',
      'properties': {
        'styleColor': {'type': 'string'},
        'linkifyStyleColor': {'type': 'string'},
      },
    },
    'TextWidgetConfig': {
      'type': 'object',
      'properties': {
        'selection': {r'$ref': r'#/$defs/TextSelectionWidgetConfig'},
        'linkify': {r'$ref': r'#/$defs/LinkifyWidgetConfig'},
      },
    },
    'DialogThemeConfig': {
      'type': 'object',
      'properties': {
        'backgroundColor': {'type': 'string'},
        'surfaceTintColor': {'type': 'string'},
        'shadowColor': {'type': 'string'},
        'barrierColor': {'type': 'string'},
        'elevation': {'type': 'number'},
        'borderRadius': {'type': 'number'},
        'titleTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'contentTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
      },
    },
    'ConfirmDialogWidgetConfig': {
      'type': 'object',
      'properties': {
        'activeButtonColor1': {'type': 'string'},
        'activeButtonColor2': {'type': 'string'},
        'defaultButtonColor': {'type': 'string'},
        'backgroundColor': {
          'type': 'string',
          'description':
              'Confirm-dialog-only overrides layered on top of [DialogThemeConfig];\nwhen null the dialog inherits [ThemeData.dialogTheme].',
        },
        'surfaceTintColor': {'type': 'string'},
        'elevation': {'type': 'number'},
        'borderRadius': {'type': 'number'},
        'titleTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'contentTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
      },
    },
    'SnackBarWidgetConfig': {
      'type': 'object',
      'properties': {
        'successBackgroundColor': {'type': 'string', 'default': '#75B943'},
        'errorBackgroundColor': {'type': 'string', 'default': '#E74C3C'},
        'infoBackgroundColor': {'type': 'string', 'default': '#494949'},
        'warningBackgroundColor': {'type': 'string', 'default': '#F95A14'},
      },
    },
    'DialogWidgetConfig': {
      'type': 'object',
      'properties': {
        'theme': {
          r'$ref': r'#/$defs/DialogThemeConfig',
          'description':
              'Baseline appearance applied to every dialog via [ThemeData.dialogTheme].\n\nMaterial 3 derives the dialog background from `surfaceContainerHigh`, which\ncan resolve to an unreadable color in some color schemes; this config lets a\ntheme pin a predictable surface/text/shape for all dialogs.',
        },
        'confirmDialog': {r'$ref': r'#/$defs/ConfirmDialogWidgetConfig'},
        'snackBar': {r'$ref': r'#/$defs/SnackBarWidgetConfig'},
      },
    },
    'RegistrationStatusesWidgetConfig': {
      'type': 'object',
      'properties': {
        'online': {'type': 'string', 'default': '#75B943'},
        'offline': {'type': 'string', 'default': '#EEF3F6'},
      },
    },
    'CallStatusesWidgetConfig': {
      'type': 'object',
      'properties': {
        'connectivityNone': {'type': 'string', 'default': '#E74C3C'},
        'connectError': {'type': 'string', 'default': '#E74C3C'},
        'appUnregistered': {'type': 'string', 'default': '#494949'},
        'connectIssue': {'type': 'string', 'default': '#E74C3C'},
        'inProgress': {'type': 'string', 'default': '#123752'},
        'ready': {'type': 'string', 'default': '#75B943'},
      },
    },
    'StatusesWidgetConfig': {
      'type': 'object',
      'properties': {
        'registrationStatuses': {r'$ref': r'#/$defs/RegistrationStatusesWidgetConfig'},
        'callStatuses': {r'$ref': r'#/$defs/CallStatusesWidgetConfig'},
      },
    },
    'ThemeWidgetConfig': {
      'type': 'object',
      'properties': {
        'fonts': {r'$ref': r'#/$defs/FontsConfig'},
        'button': {r'$ref': r'#/$defs/ButtonWidgetConfig'},
        'group': {r'$ref': r'#/$defs/GroupWidgetConfig'},
        'bar': {r'$ref': r'#/$defs/BarWidgetConfig'},
        'imageAssets': {r'$ref': r'#/$defs/ImageAssetsConfig'},
        'input': {r'$ref': r'#/$defs/InputWidgetConfig'},
        'text': {r'$ref': r'#/$defs/TextWidgetConfig'},
        'dialog': {r'$ref': r'#/$defs/DialogWidgetConfig'},
        'statuses': {r'$ref': r'#/$defs/StatusesWidgetConfig'},
      },
    },
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {
          'enum': ['system', 'light', 'dark'],
          'description': 'The target mode to force (e.g., ensure screen is always Dark).',
          'default': 'system',
        },
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
        },
      },
    },
    'PageBackground': {
      'oneOf': [
        {r'$ref': r'#/$defs/PageBackgroundSolid'},
        {r'$ref': r'#/$defs/PageBackgroundGradient'},
        {r'$ref': r'#/$defs/PageBackgroundImage'},
      ],
    },
    'PageBackgroundSolid': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'The colour to fill with (hex string, e.g. `#3A6EA5`).'},
        'type': {'type': 'string', 'description': 'The discriminator. Always `solid`.', 'default': 'solid'},
      },
      'required': ['color'],
    },
    'PageBackgroundGradient': {
      'type': 'object',
      'properties': {
        'colors': {
          'type': 'array',
          'items': {'type': 'string'},
          'description': 'The colours to run between (hex strings).',
        },
        'stops': {
          'type': 'array',
          'items': {'type': 'number'},
          'description': 'Where each colour sits, `0.0` to `1.0`. Empty means an even spread.',
          'default': [],
        },
        'beginX': {'type': 'number', 'default': 0.0},
        'beginY': {'type': 'number', 'default': 0.0},
        'endX': {'type': 'number', 'default': 1.0},
        'endY': {'type': 'number', 'default': 1.0},
        'type': {'type': 'string', 'description': 'The discriminator. Always `gradient`.', 'default': 'gradient'},
      },
      'required': ['colors'],
    },
    'PageBackgroundImage': {
      'type': 'object',
      'properties': {
        'imageUrl': {'type': 'string'},
        'fit': {
          'enum': ['fill', 'contain', 'cover', 'fitWidth', 'fitHeight', 'none', 'scaleDown'],
          'description': 'How the image is fitted into the page.',
          'default': 'cover',
        },
        'opacity': {'type': 'number', 'default': 1.0},
        'type': {'type': 'string', 'description': 'The discriminator. Always `image`.', 'default': 'image'},
      },
      'required': ['imageUrl'],
    },
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
      },
    },
    'LoginModeSelectPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {r'$ref': r'#/$defs/ThemeOverrideConfig'},
        'systemUiOverlayStyle': {r'$ref': r'#/$defs/OverlayStyleModel'},
        'mainLogo': {r'$ref': r'#/$defs/ImageSource'},
        'buttonLoginStyleType': {
          'enum': ['primary', 'neutral', 'primaryOnDark', 'neutralOnDark'],
          'default': 'primary',
        },
        'buttonSignupStyleType': {
          'enum': ['primary', 'neutral', 'primaryOnDark', 'neutralOnDark'],
          'default': 'primary',
        },
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'greetingTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'LoginSwitchPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {r'$ref': r'#/$defs/ThemeOverrideConfig'},
        'mainLogo': {r'$ref': r'#/$defs/ImageSource'},
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'segmentButtonStyle': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
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
    'TextFieldConfig': {
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
    },
    'LoginOtpSigninPageConfig': {
      'type': 'object',
      'properties': {
        'refTextField': {r'$ref': r'#/$defs/TextFieldConfig'},
      },
    },
    'LoginPasswordSigninPageConfig': {
      'type': 'object',
      'properties': {
        'refTextField': {r'$ref': r'#/$defs/TextFieldConfig'},
        'passwordTextField': {r'$ref': r'#/$defs/TextFieldConfig'},
      },
    },
    'LoginOtpSigninVerifyScreenPageConfig': {
      'type': 'object',
      'properties': {
        'countdownRepeatIntervalSeconds': {'type': 'integer', 'default': 30},
      },
    },
    'LoginSignupVerifyScreenPageConfig': {
      'type': 'object',
      'properties': {
        'countdownRepeatIntervalSeconds': {'type': 'integer', 'default': 30},
      },
    },
    'LoginCoreUrlAssignPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {r'$ref': r'#/$defs/ThemeOverrideConfig'},
        'systemUiOverlayStyle': {r'$ref': r'#/$defs/OverlayStyleModel'},
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'LoginPageConfig': {
      'type': 'object',
      'properties': {
        'modeSelect': {r'$ref': r'#/$defs/LoginModeSelectPageConfig'},
        'switchPage': {r'$ref': r'#/$defs/LoginSwitchPageConfig'},
        'otpSignin': {r'$ref': r'#/$defs/LoginOtpSigninPageConfig'},
        'passwordSignin': {r'$ref': r'#/$defs/LoginPasswordSigninPageConfig'},
        'otpSigninVerify': {r'$ref': r'#/$defs/LoginOtpSigninVerifyScreenPageConfig'},
        'signupVerify': {r'$ref': r'#/$defs/LoginSignupVerifyScreenPageConfig'},
        'coreUrlAssign': {r'$ref': r'#/$defs/LoginCoreUrlAssignPageConfig'},
      },
    },
    'AboutPageConfig': {
      'type': 'object',
      'properties': {
        'mainLogo': {r'$ref': r'#/$defs/ImageSource'},
        'metadata': {r'$ref': r'#/$defs/Metadata'},
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'CallPageInfoConfig': {
      'type': 'object',
      'properties': {
        'usernameTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'numberTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'callStatusTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'processingStatusTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
      },
    },
    'CallPageListConfig': {
      'type': 'object',
      'properties': {
        'rowBackgroundColor': {'type': 'string'},
        'rowFocusedBackgroundColor': {'type': 'string'},
        'rowFocusedBorderColor': {'type': 'string'},
        'dotRingingColor': {'type': 'string'},
        'dotOnCallColor': {'type': 'string'},
        'dotHeldColor': {'type': 'string'},
      },
    },
    'CallPageHintConfig': {
      'type': 'object',
      'properties': {
        'backgroundColor': {'type': 'string'},
        'affectedNameColor': {'type': 'string'},
      },
    },
    'CallPageActionsConfig': {
      'type': 'object',
      'properties': {
        'callStart': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'hangup': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'transfer': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'camera': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'muted': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'speaker': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'held': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'swap': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'key': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'keypadInputStyle': {
          r'$ref': r'#/$defs/TextStyleConfig',
          'description':
              'Text style for the digits typed on the in-call DTMF keypad (the value shown\nabove the keys). When unset the app falls back to its default display text\nstyle for the keypad input.',
        },
      },
    },
    'CallPageConfig': {
      'type': 'object',
      'properties': {
        'systemUiOverlayStyle': {r'$ref': r'#/$defs/OverlayStyleModel'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
        'callInfo': {r'$ref': r'#/$defs/CallPageInfoConfig'},
        'callList': {r'$ref': r'#/$defs/CallPageListConfig'},
        'actingOnHint': {r'$ref': r'#/$defs/CallPageHintConfig'},
        'actions': {r'$ref': r'#/$defs/CallPageActionsConfig'},
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
      },
    },
    'KeypadStyleConfig': {
      'type': 'object',
      'properties': {
        'textStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'subtextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'spacing': {'type': 'number'},
        'padding': {'type': 'number'},
      },
    },
    'ActionPadWidgetConfig': {
      'type': 'object',
      'properties': {
        'callStart': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'callTransfer': {r'$ref': r'#/$defs/ButtonStyleConfig'},
        'backspace': {
          r'$ref': r'#/$defs/ButtonStyleConfig',
          'description': 'Style of the backspace key under the dial pad.',
        },
      },
    },
    'KeypadPageConfig': {
      'type': 'object',
      'properties': {
        'systemUiOverlayStyle': {r'$ref': r'#/$defs/OverlayStyleModel'},
        'textField': {r'$ref': r'#/$defs/TextFieldConfig'},
        'contactName': {r'$ref': r'#/$defs/TextFieldConfig'},
        'keypad': {r'$ref': r'#/$defs/KeypadStyleConfig'},
        'actionpad': {r'$ref': r'#/$defs/ActionPadWidgetConfig'},
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'themeOverride': {
          r'$ref': r'#/$defs/ThemeOverrideConfig',
          'description': 'Configuration to force override the theme mode (e.g., force Dark mode).',
        },
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'SeparatorStyleConfig': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'description': 'Whether to render the separator. `null` → shown (default).'},
        'color': {
          'type': 'string',
          'description': 'Separator color (hex string, e.g. `#CAC7D1`). `null` → theme default.',
        },
      },
    },
    'SettingsPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {
          r'$ref': r'#/$defs/ThemeOverrideConfig',
          'description': 'Configuration to force override the theme mode.',
        },
        'leadingIconsColor': {'type': 'string'},
        'userIconColor': {'type': 'string'},
        'logoutIconColor': {'type': 'string'},
        'groupTitleListTile': {r'$ref': r'#/$defs/GroupTitleListTileWidgetConfig'},
        'showSeparators': {
          'type': 'boolean',
          'description':
              'Deprecated: visibility now lives in [separator] (`separator.enabled`).\nKept for backward compatibility with themes saved before [separator] existed.',
          'default': true,
        },
        'separator': {
          r'$ref': r'#/$defs/SeparatorStyleConfig',
          'description': 'Style of the divider lines between setting items (visibility + color).',
        },
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'itemTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'ContactsPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {
          r'$ref': r'#/$defs/ThemeOverrideConfig',
          'description': 'Configuration to force override the theme mode.',
        },
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'EmbeddedPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {
          r'$ref': r'#/$defs/ThemeOverrideConfig',
          'description': 'Configuration to force override the theme mode.',
        },
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'FavoritesPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {
          r'$ref': r'#/$defs/ThemeOverrideConfig',
          'description': 'Configuration to force override the theme mode.',
        },
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'ConversationsPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {
          r'$ref': r'#/$defs/ThemeOverrideConfig',
          'description': 'Configuration to force override the theme mode.',
        },
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'RecentsPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {
          r'$ref': r'#/$defs/ThemeOverrideConfig',
          'description': 'Configuration to force override the theme mode.',
        },
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'NumberCdrsPageConfig': {
      'type': 'object',
      'properties': {
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
      },
    },
    'ThemePageConfig': {
      'type': 'object',
      'properties': {
        'login': {r'$ref': r'#/$defs/LoginPageConfig'},
        'about': {r'$ref': r'#/$defs/AboutPageConfig'},
        'dialing': {r'$ref': r'#/$defs/CallPageConfig'},
        'keypad': {r'$ref': r'#/$defs/KeypadPageConfig'},
        'settings': {r'$ref': r'#/$defs/SettingsPageConfig'},
        'contacts': {r'$ref': r'#/$defs/ContactsPageConfig'},
        'embedded': {r'$ref': r'#/$defs/EmbeddedPageConfig'},
        'favorites': {r'$ref': r'#/$defs/FavoritesPageConfig'},
        'conversations': {r'$ref': r'#/$defs/ConversationsPageConfig'},
        'recents': {r'$ref': r'#/$defs/RecentsPageConfig'},
        'numberCdrs': {r'$ref': r'#/$defs/NumberCdrsPageConfig'},
      },
    },
  },
};
