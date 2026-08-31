// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_widget_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeWidgetConfig _$ThemeWidgetConfigFromJson(
  Map<String, dynamic> json,
) => ThemeWidgetConfig(
  fonts: json['fonts'] == null
      ? const FontsConfig()
      : FontsConfig.fromJson(json['fonts'] as Map<String, dynamic>),
  button: json['button'] == null
      ? const ButtonWidgetConfig()
      : ButtonWidgetConfig.fromJson(json['button'] as Map<String, dynamic>),
  group: json['group'] == null
      ? const GroupWidgetConfig()
      : GroupWidgetConfig.fromJson(json['group'] as Map<String, dynamic>),
  bar: json['bar'] == null
      ? const BarWidgetConfig()
      : BarWidgetConfig.fromJson(json['bar'] as Map<String, dynamic>),
  imageAssets: json['imageAssets'] == null
      ? const ImageAssetsConfig()
      : ImageAssetsConfig.fromJson(json['imageAssets'] as Map<String, dynamic>),
  input: json['input'] == null
      ? const InputWidgetConfig()
      : InputWidgetConfig.fromJson(json['input'] as Map<String, dynamic>),
  text: json['text'] == null
      ? const TextWidgetConfig()
      : TextWidgetConfig.fromJson(json['text'] as Map<String, dynamic>),
  dialog: json['dialog'] == null
      ? const DialogWidgetConfig()
      : DialogWidgetConfig.fromJson(json['dialog'] as Map<String, dynamic>),
  statuses: json['statuses'] == null
      ? const StatusesWidgetConfig()
      : StatusesWidgetConfig.fromJson(json['statuses'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ThemeWidgetConfigToJson(ThemeWidgetConfig instance) =>
    <String, dynamic>{
      'fonts': instance.fonts.toJson(),
      'button': instance.button.toJson(),
      'group': instance.group?.toJson(),
      'bar': instance.bar.toJson(),
      'imageAssets': instance.imageAssets.toJson(),
      'input': instance.input.toJson(),
      'text': instance.text.toJson(),
      'dialog': instance.dialog.toJson(),
      'statuses': instance.statuses.toJson(),
    };

const _$ThemeWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
    'FontsConfig': {
      'type': 'object',
      'properties': {
        'fontFamily': {'type': 'string'},
      },
    },
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
    'ButtonStyleConfig': {
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
          'description':
              "The padding between the button's boundary and its child.",
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
        'groupTitleListTile': {
          r'$ref': r'#/$defs/GroupTitleListTileWidgetConfig',
        },
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
        'color': {
          'type': 'string',
          'description': 'Color of the shadow (hex string).',
        },
        'offset': {
          r'$ref': r'#/$defs/OffsetConfig',
          'description': 'The displacement of the shadow.',
        },
        'blurRadius': {
          'type': 'number',
          'description': 'The blur radius of the shadow.',
          'default': 0.0,
        },
      },
    },
    'IconThemeDataConfig': {
      'type': 'object',
      'properties': {
        'size': {
          'type': 'number',
          'description': 'The default size for icons.',
        },
        'fill': {
          'type': 'number',
          'description':
              'The default fill for icons (0.0 to 1.0).\nUseful for variable fonts (e.g. Material Symbols).',
        },
        'weight': {
          'type': 'number',
          'description':
              'The default weight for icons (e.g. 400.0).\nUseful for variable fonts.',
        },
        'grade': {
          'type': 'number',
          'description':
              'The default grade for icons.\nUseful for variable fonts.',
        },
        'opticalSize': {
          'type': 'number',
          'description':
              'The default optical size for icons.\nUseful for variable fonts.',
        },
        'color': {
          'type': 'string',
          'description': 'The default color for icons (hex string).',
        },
        'opacity': {
          'type': 'number',
          'description':
              'An opacity to apply to both explicit and default icon colors.',
        },
        'shadows': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/ShadowConfig'},
          'description': 'A list of shadows to apply to the icons.',
        },
        'applyTextScaling': {
          'type': 'boolean',
          'description': 'Whether to apply text scaling to the icons.',
        },
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
          'description':
              'System navigation bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarIconBrightness': {
          'type': 'string',
          'description':
              'Status bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarBrightness': {
          'type': 'string',
          'description': 'Status bar brightness (e.g., "dark" or "light").',
        },
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
        'borderRadius': {
          'type': 'number',
          'description': 'Corner radius for outline borders.',
        },
        'borderColor': {
          'type': 'string',
          'description': 'Border color (hex string, e.g. `#000000`).',
        },
        'borderWidth': {
          'type': 'number',
          'description': 'Stroke width of the border.',
        },
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
        'bottomNavigationBar': {
          r'$ref': r'#/$defs/BottomNavigationBarWidgetConfig',
        },
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
          'enum': [
            'fill',
            'contain',
            'cover',
            'fitWidth',
            'fitHeight',
            'none',
            'scaleDown',
          ],
        },
      },
    },
    'Metadata': {
      'type': 'object',
      'properties': {
        'attributes': {
          'type': 'object',
          'additionalProperties': {'type': 'object'},
          'description':
              'A map storing arbitrary key-value pairs for contextual or configuration data.',
          'default': {},
        },
      },
    },
    'ImageSource': {
      'type': 'object',
      'properties': {
        'id': {
          'type': 'string',
          'description': 'Backend asset ID (unique identifier in storage).',
        },
        'uri': {
          'type': 'string',
          'description': 'Unified URI pointing to the resource.',
        },
        'refType': {
          'type': 'string',
          'description': 'Semantic type of reference (default = "asset").',
          'default': 'asset',
        },
        'render': {
          r'$ref': r'#/$defs/ImageRenderSpec',
          'description': 'Rendering specification (scale, padding, etc.).',
        },
        'metadata': {
          r'$ref': r'#/$defs/Metadata',
          'description': 'Freeform metadata for CLI or pipeline tools.',
        },
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
    'LeadingAvatarStyleConfig': {
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
        'registrationStatuses': {
          r'$ref': r'#/$defs/RegistrationStatusesWidgetConfig',
        },
        'callStatuses': {r'$ref': r'#/$defs/CallStatusesWidgetConfig'},
      },
    },
  },
};

FontsConfig _$FontsConfigFromJson(Map<String, dynamic> json) =>
    FontsConfig(fontFamily: json['fontFamily'] as String?);

Map<String, dynamic> _$FontsConfigToJson(FontsConfig instance) =>
    <String, dynamic>{'fontFamily': instance.fontFamily};

const _$FontsConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'fontFamily': {'type': 'string'},
  },
};

ButtonWidgetConfig _$ButtonWidgetConfigFromJson(Map<String, dynamic> json) =>
    ButtonWidgetConfig(
      primaryElevatedButton: json['primaryElevatedButton'] == null
          ? null
          : ButtonStyleConfig.fromJson(
              json['primaryElevatedButton'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ButtonWidgetConfigToJson(ButtonWidgetConfig instance) =>
    <String, dynamic>{
      'primaryElevatedButton': instance.primaryElevatedButton?.toJson(),
    };

const _$ButtonWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'primaryElevatedButton': {r'$ref': r'#/$defs/ButtonStyleConfig'},
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
    'ButtonStyleConfig': {
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
          'description':
              "The padding between the button's boundary and its child.",
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
    },
  },
};

GroupWidgetConfig _$GroupWidgetConfigFromJson(Map<String, dynamic> json) =>
    GroupWidgetConfig(
      groupTitleListTile: json['groupTitleListTile'] == null
          ? const GroupTitleListTileWidgetConfig()
          : GroupTitleListTileWidgetConfig.fromJson(
              json['groupTitleListTile'] as Map<String, dynamic>,
            ),
      callActions: json['callActions'] == null
          ? const CallActionsWidgetConfig()
          : CallActionsWidgetConfig.fromJson(
              json['callActions'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$GroupWidgetConfigToJson(GroupWidgetConfig instance) =>
    <String, dynamic>{
      'groupTitleListTile': instance.groupTitleListTile.toJson(),
      'callActions': instance.callActions.toJson(),
    };

const _$GroupWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'groupTitleListTile': {r'$ref': r'#/$defs/GroupTitleListTileWidgetConfig'},
    'callActions': {r'$ref': r'#/$defs/CallActionsWidgetConfig'},
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
  },
};

BarWidgetConfig _$BarWidgetConfigFromJson(Map<String, dynamic> json) =>
    BarWidgetConfig(
      bottomNavigationBar: json['bottomNavigationBar'] == null
          ? const BottomNavigationBarWidgetConfig()
          : BottomNavigationBarWidgetConfig.fromJson(
              json['bottomNavigationBar'] as Map<String, dynamic>,
            ),
      appBarConfig: json['appBarConfig'] == null
          ? const AppBarConfig()
          : AppBarConfig.fromJson(json['appBarConfig'] as Map<String, dynamic>),
      tabBarConfig: json['tabBarConfig'] == null
          ? const TabBarConfig()
          : TabBarConfig.fromJson(json['tabBarConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BarWidgetConfigToJson(BarWidgetConfig instance) =>
    <String, dynamic>{
      'bottomNavigationBar': instance.bottomNavigationBar.toJson(),
      'appBarConfig': instance.appBarConfig.toJson(),
      'tabBarConfig': instance.tabBarConfig.toJson(),
    };

const _$BarWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'bottomNavigationBar': {
      r'$ref': r'#/$defs/BottomNavigationBarWidgetConfig',
    },
    'appBarConfig': {r'$ref': r'#/$defs/AppBarConfig'},
    'tabBarConfig': {r'$ref': r'#/$defs/TabBarConfig'},
  },
  r'$defs': {
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
        'color': {
          'type': 'string',
          'description': 'Color of the shadow (hex string).',
        },
        'offset': {
          r'$ref': r'#/$defs/OffsetConfig',
          'description': 'The displacement of the shadow.',
        },
        'blurRadius': {
          'type': 'number',
          'description': 'The blur radius of the shadow.',
          'default': 0.0,
        },
      },
    },
    'IconThemeDataConfig': {
      'type': 'object',
      'properties': {
        'size': {
          'type': 'number',
          'description': 'The default size for icons.',
        },
        'fill': {
          'type': 'number',
          'description':
              'The default fill for icons (0.0 to 1.0).\nUseful for variable fonts (e.g. Material Symbols).',
        },
        'weight': {
          'type': 'number',
          'description':
              'The default weight for icons (e.g. 400.0).\nUseful for variable fonts.',
        },
        'grade': {
          'type': 'number',
          'description':
              'The default grade for icons.\nUseful for variable fonts.',
        },
        'opticalSize': {
          'type': 'number',
          'description':
              'The default optical size for icons.\nUseful for variable fonts.',
        },
        'color': {
          'type': 'string',
          'description': 'The default color for icons (hex string).',
        },
        'opacity': {
          'type': 'number',
          'description':
              'An opacity to apply to both explicit and default icon colors.',
        },
        'shadows': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/ShadowConfig'},
          'description': 'A list of shadows to apply to the icons.',
        },
        'applyTextScaling': {
          'type': 'boolean',
          'description': 'Whether to apply text scaling to the icons.',
        },
      },
    },
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
          'description':
              'System navigation bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarIconBrightness': {
          'type': 'string',
          'description':
              'Status bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarBrightness': {
          'type': 'string',
          'description': 'Status bar brightness (e.g., "dark" or "light").',
        },
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
        'borderRadius': {
          'type': 'number',
          'description': 'Corner radius for outline borders.',
        },
        'borderColor': {
          'type': 'string',
          'description': 'Border color (hex string, e.g. `#000000`).',
        },
        'borderWidth': {
          'type': 'number',
          'description': 'Stroke width of the border.',
        },
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
  },
};

BottomNavigationBarWidgetConfig _$BottomNavigationBarWidgetConfigFromJson(
  Map<String, dynamic> json,
) => BottomNavigationBarWidgetConfig(
  backgroundColor: json['backgroundColor'] as String?,
  selectedItemColor: json['selectedItemColor'] as String?,
  unSelectedItemColor: json['unSelectedItemColor'] as String?,
);

Map<String, dynamic> _$BottomNavigationBarWidgetConfigToJson(
  BottomNavigationBarWidgetConfig instance,
) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'selectedItemColor': instance.selectedItemColor,
  'unSelectedItemColor': instance.unSelectedItemColor,
};

const _$BottomNavigationBarWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'backgroundColor': {'type': 'string'},
    'selectedItemColor': {'type': 'string'},
    'unSelectedItemColor': {'type': 'string'},
  },
};

ExtTabBarWidgetConfig _$ExtTabBarWidgetConfigFromJson(
  Map<String, dynamic> json,
) => ExtTabBarWidgetConfig(
  foregroundColor: json['foregroundColor'] as String?,
  backgroundColor: json['backgroundColor'] as String?,
  selectedItemColor: json['selectedItemColor'] as String?,
  unSelectedItemColor: json['unSelectedItemColor'] as String?,
);

Map<String, dynamic> _$ExtTabBarWidgetConfigToJson(
  ExtTabBarWidgetConfig instance,
) => <String, dynamic>{
  'foregroundColor': instance.foregroundColor,
  'backgroundColor': instance.backgroundColor,
  'selectedItemColor': instance.selectedItemColor,
  'unSelectedItemColor': instance.unSelectedItemColor,
};

const _$ExtTabBarWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'foregroundColor': {'type': 'string'},
    'backgroundColor': {'type': 'string'},
    'selectedItemColor': {'type': 'string'},
    'unSelectedItemColor': {'type': 'string'},
  },
};

GroupTitleListTileWidgetConfig _$GroupTitleListTileWidgetConfigFromJson(
  Map<String, dynamic> json,
) => GroupTitleListTileWidgetConfig(
  backgroundColor: json['backgroundColor'] as String?,
  textStyle: json['textStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['textStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GroupTitleListTileWidgetConfigToJson(
  GroupTitleListTileWidgetConfig instance,
) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'textStyle': instance.textStyle?.toJson(),
};

const _$GroupTitleListTileWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'backgroundColor': {'type': 'string'},
    'textStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
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

CallActionsWidgetConfig _$CallActionsWidgetConfigFromJson(
  Map<String, dynamic> json,
) => CallActionsWidgetConfig(
  callStartBackgroundColor: json['callStartBackgroundColor'] as String?,
  hangupBackgroundColor: json['hangupBackgroundColor'] as String?,
  transferBackgroundColor: json['transferBackgroundColor'] as String?,
  cameraBackgroundColor: json['cameraBackgroundColor'] as String?,
  cameraActiveBackgroundColor: json['cameraActiveBackgroundColor'] as String?,
  mutedBackgroundColor: json['mutedBackgroundColor'] as String?,
  mutedActiveBackgroundColor: json['mutedActiveBackgroundColor'] as String?,
  speakerBackgroundColor: json['speakerBackgroundColor'] as String?,
  speakerActiveBackgroundColor: json['speakerActiveBackgroundColor'] as String?,
  heldBackgroundColor: json['heldBackgroundColor'] as String?,
  heldActiveBackgroundColor: json['heldActiveBackgroundColor'] as String?,
  swapBackgroundColor: json['swapBackgroundColor'] as String?,
  keyBackgroundColor: json['keyBackgroundColor'] as String?,
  keypadBackgroundColor: json['keypadBackgroundColor'] as String?,
  keypadActiveBackgroundColor: json['keypadActiveBackgroundColor'] as String?,
);

Map<String, dynamic> _$CallActionsWidgetConfigToJson(
  CallActionsWidgetConfig instance,
) => <String, dynamic>{
  'callStartBackgroundColor': instance.callStartBackgroundColor,
  'hangupBackgroundColor': instance.hangupBackgroundColor,
  'transferBackgroundColor': instance.transferBackgroundColor,
  'cameraBackgroundColor': instance.cameraBackgroundColor,
  'cameraActiveBackgroundColor': instance.cameraActiveBackgroundColor,
  'mutedBackgroundColor': instance.mutedBackgroundColor,
  'mutedActiveBackgroundColor': instance.mutedActiveBackgroundColor,
  'speakerBackgroundColor': instance.speakerBackgroundColor,
  'speakerActiveBackgroundColor': instance.speakerActiveBackgroundColor,
  'heldBackgroundColor': instance.heldBackgroundColor,
  'heldActiveBackgroundColor': instance.heldActiveBackgroundColor,
  'swapBackgroundColor': instance.swapBackgroundColor,
  'keyBackgroundColor': instance.keyBackgroundColor,
  'keypadBackgroundColor': instance.keypadBackgroundColor,
  'keypadActiveBackgroundColor': instance.keypadActiveBackgroundColor,
};

const _$CallActionsWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
};

ImageAssetsConfig _$ImageAssetsConfigFromJson(Map<String, dynamic> json) =>
    ImageAssetsConfig(
      defaultPlaceholderImage: json['defaultPlaceholderImage'] == null
          ? null
          : ImageSource.fromJson(
              json['defaultPlaceholderImage'] as Map<String, dynamic>,
            ),
      appIcon: json['appIcon'] == null
          ? const AppIconWidgetConfig()
          : AppIconWidgetConfig.fromJson(
              json['appIcon'] as Map<String, dynamic>,
            ),
      leadingAvatarStyle: json['leadingAvatarStyle'] == null
          ? const LeadingAvatarStyleConfig()
          : LeadingAvatarStyleConfig.fromJson(
              json['leadingAvatarStyle'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ImageAssetsConfigToJson(ImageAssetsConfig instance) =>
    <String, dynamic>{
      'defaultPlaceholderImage': instance.defaultPlaceholderImage?.toJson(),
      'appIcon': instance.appIcon.toJson(),
      'leadingAvatarStyle': instance.leadingAvatarStyle.toJson(),
    };

const _$ImageAssetsConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'defaultPlaceholderImage': {r'$ref': r'#/$defs/ImageSource'},
    'appIcon': {r'$ref': r'#/$defs/AppIconWidgetConfig'},
    'leadingAvatarStyle': {r'$ref': r'#/$defs/LeadingAvatarStyleConfig'},
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
          'enum': [
            'fill',
            'contain',
            'cover',
            'fitWidth',
            'fitHeight',
            'none',
            'scaleDown',
          ],
        },
      },
    },
    'Metadata': {
      'type': 'object',
      'properties': {
        'attributes': {
          'type': 'object',
          'additionalProperties': {'type': 'object'},
          'description':
              'A map storing arbitrary key-value pairs for contextual or configuration data.',
          'default': {},
        },
      },
    },
    'ImageSource': {
      'type': 'object',
      'properties': {
        'id': {
          'type': 'string',
          'description': 'Backend asset ID (unique identifier in storage).',
        },
        'uri': {
          'type': 'string',
          'description': 'Unified URI pointing to the resource.',
        },
        'refType': {
          'type': 'string',
          'description': 'Semantic type of reference (default = "asset").',
          'default': 'asset',
        },
        'render': {
          r'$ref': r'#/$defs/ImageRenderSpec',
          'description': 'Rendering specification (scale, padding, etc.).',
        },
        'metadata': {
          r'$ref': r'#/$defs/Metadata',
          'description': 'Freeform metadata for CLI or pipeline tools.',
        },
      },
    },
    'AppIconWidgetConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string'},
      },
    },
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
    'LeadingAvatarStyleConfig': {
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
    },
  },
};

ImageAssetConfig _$ImageAssetConfigFromJson(Map<String, dynamic> json) =>
    ImageAssetConfig(
      imageSource: json['imageSource'] == null
          ? null
          : ImageSource.fromJson(json['imageSource'] as Map<String, dynamic>),
      widthFactor: (json['widthFactor'] as num?)?.toDouble() ?? 1.0,
      labelColor: json['labelColor'] as String? ?? '#FFFFFF',
      metadata: json['metadata'] == null
          ? const Metadata()
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      uri: json['uri'] as String?,
    );

Map<String, dynamic> _$ImageAssetConfigToJson(ImageAssetConfig instance) =>
    <String, dynamic>{
      'imageSource': instance.imageSource?.toJson(),
      'widthFactor': instance.widthFactor,
      'labelColor': instance.labelColor,
      'metadata': instance.metadata.toJson(),
      'uri': instance.uri,
    };

const _$ImageAssetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'imageSource': {r'$ref': r'#/$defs/ImageSource'},
    'widthFactor': {'type': 'number', 'default': 1.0},
    'labelColor': {'type': 'string', 'default': '#FFFFFF'},
    'metadata': {r'$ref': r'#/$defs/Metadata'},
    'uri': {'type': 'string'},
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
          'enum': [
            'fill',
            'contain',
            'cover',
            'fitWidth',
            'fitHeight',
            'none',
            'scaleDown',
          ],
        },
      },
    },
    'Metadata': {
      'type': 'object',
      'properties': {
        'attributes': {
          'type': 'object',
          'additionalProperties': {'type': 'object'},
          'description':
              'A map storing arbitrary key-value pairs for contextual or configuration data.',
          'default': {},
        },
      },
    },
    'ImageSource': {
      'type': 'object',
      'properties': {
        'id': {
          'type': 'string',
          'description': 'Backend asset ID (unique identifier in storage).',
        },
        'uri': {
          'type': 'string',
          'description': 'Unified URI pointing to the resource.',
        },
        'refType': {
          'type': 'string',
          'description': 'Semantic type of reference (default = "asset").',
          'default': 'asset',
        },
        'render': {
          r'$ref': r'#/$defs/ImageRenderSpec',
          'description': 'Rendering specification (scale, padding, etc.).',
        },
        'metadata': {
          r'$ref': r'#/$defs/Metadata',
          'description': 'Freeform metadata for CLI or pipeline tools.',
        },
      },
    },
  },
};

AppIconWidgetConfig _$AppIconWidgetConfigFromJson(Map<String, dynamic> json) =>
    AppIconWidgetConfig(color: json['color'] as String?);

Map<String, dynamic> _$AppIconWidgetConfigToJson(
  AppIconWidgetConfig instance,
) => <String, dynamic>{'color': instance.color};

const _$AppIconWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'color': {'type': 'string'},
  },
};

InputWidgetConfig _$InputWidgetConfigFromJson(Map<String, dynamic> json) =>
    InputWidgetConfig(
      primary: json['primary'] == null
          ? const TextFormFieldWidgetConfig()
          : TextFormFieldWidgetConfig.fromJson(
              json['primary'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$InputWidgetConfigToJson(InputWidgetConfig instance) =>
    <String, dynamic>{'primary': instance.primary.toJson()};

const _$InputWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'primary': {r'$ref': r'#/$defs/TextFormFieldWidgetConfig'},
  },
  r'$defs': {
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
  },
};

TextFormFieldWidgetConfig _$TextFormFieldWidgetConfigFromJson(
  Map<String, dynamic> json,
) => TextFormFieldWidgetConfig(
  labelColor: json['labelColor'] as String?,
  border: json['border'] == null
      ? const InputBorderWidgetConfig()
      : InputBorderWidgetConfig.fromJson(
          json['border'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$TextFormFieldWidgetConfigToJson(
  TextFormFieldWidgetConfig instance,
) => <String, dynamic>{
  'labelColor': instance.labelColor,
  'border': instance.border.toJson(),
};

const _$TextFormFieldWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'labelColor': {'type': 'string'},
    'border': {r'$ref': r'#/$defs/InputBorderWidgetConfig'},
  },
  r'$defs': {
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
  },
};

InputBorderWidgetConfig _$InputBorderWidgetConfigFromJson(
  Map<String, dynamic> json,
) => InputBorderWidgetConfig(
  disabled: json['disabled'] == null
      ? const BorderWidgetConfig()
      : BorderWidgetConfig.fromJson(json['disabled'] as Map<String, dynamic>),
  focused: json['focused'] == null
      ? const BorderWidgetConfig()
      : BorderWidgetConfig.fromJson(json['focused'] as Map<String, dynamic>),
  any: json['any'] == null
      ? const BorderWidgetConfig()
      : BorderWidgetConfig.fromJson(json['any'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InputBorderWidgetConfigToJson(
  InputBorderWidgetConfig instance,
) => <String, dynamic>{
  'disabled': instance.disabled.toJson(),
  'focused': instance.focused.toJson(),
  'any': instance.any.toJson(),
};

const _$InputBorderWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'disabled': {r'$ref': r'#/$defs/BorderWidgetConfig'},
    'focused': {r'$ref': r'#/$defs/BorderWidgetConfig'},
    'any': {r'$ref': r'#/$defs/BorderWidgetConfig'},
  },
  r'$defs': {
    'BorderWidgetConfig': {
      'type': 'object',
      'properties': {
        'typicalColor': {'type': 'string'},
        'errorColor': {'type': 'string'},
      },
    },
  },
};

BorderWidgetConfig _$BorderWidgetConfigFromJson(Map<String, dynamic> json) =>
    BorderWidgetConfig(
      typicalColor: json['typicalColor'] as String?,
      errorColor: json['errorColor'] as String?,
    );

Map<String, dynamic> _$BorderWidgetConfigToJson(BorderWidgetConfig instance) =>
    <String, dynamic>{
      'typicalColor': instance.typicalColor,
      'errorColor': instance.errorColor,
    };

const _$BorderWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'typicalColor': {'type': 'string'},
    'errorColor': {'type': 'string'},
  },
};

TextWidgetConfig _$TextWidgetConfigFromJson(Map<String, dynamic> json) =>
    TextWidgetConfig(
      selection: json['selection'] == null
          ? const TextSelectionWidgetConfig()
          : TextSelectionWidgetConfig.fromJson(
              json['selection'] as Map<String, dynamic>,
            ),
      linkify: json['linkify'] == null
          ? const LinkifyWidgetConfig()
          : LinkifyWidgetConfig.fromJson(
              json['linkify'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TextWidgetConfigToJson(TextWidgetConfig instance) =>
    <String, dynamic>{
      'selection': instance.selection.toJson(),
      'linkify': instance.linkify.toJson(),
    };

const _$TextWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'selection': {r'$ref': r'#/$defs/TextSelectionWidgetConfig'},
    'linkify': {r'$ref': r'#/$defs/LinkifyWidgetConfig'},
  },
  r'$defs': {
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
  },
};

TextSelectionWidgetConfig _$TextSelectionWidgetConfigFromJson(
  Map<String, dynamic> json,
) => TextSelectionWidgetConfig(
  cursorColor: json['cursorColor'] as String?,
  selectionColor: json['selectionColor'] as String?,
  selectionHandleColor: json['selectionHandleColor'] as String?,
);

Map<String, dynamic> _$TextSelectionWidgetConfigToJson(
  TextSelectionWidgetConfig instance,
) => <String, dynamic>{
  'cursorColor': instance.cursorColor,
  'selectionColor': instance.selectionColor,
  'selectionHandleColor': instance.selectionHandleColor,
};

const _$TextSelectionWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'cursorColor': {'type': 'string'},
    'selectionColor': {'type': 'string'},
    'selectionHandleColor': {'type': 'string'},
  },
};

LinkifyWidgetConfig _$LinkifyWidgetConfigFromJson(Map<String, dynamic> json) =>
    LinkifyWidgetConfig(
      styleColor: json['styleColor'] as String?,
      linkifyStyleColor: json['linkifyStyleColor'] as String?,
    );

Map<String, dynamic> _$LinkifyWidgetConfigToJson(
  LinkifyWidgetConfig instance,
) => <String, dynamic>{
  'styleColor': instance.styleColor,
  'linkifyStyleColor': instance.linkifyStyleColor,
};

const _$LinkifyWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'styleColor': {'type': 'string'},
    'linkifyStyleColor': {'type': 'string'},
  },
};

DialogWidgetConfig _$DialogWidgetConfigFromJson(Map<String, dynamic> json) =>
    DialogWidgetConfig(
      theme: json['theme'] == null
          ? const DialogThemeConfig()
          : DialogThemeConfig.fromJson(json['theme'] as Map<String, dynamic>),
      confirmDialog: json['confirmDialog'] == null
          ? const ConfirmDialogWidgetConfig()
          : ConfirmDialogWidgetConfig.fromJson(
              json['confirmDialog'] as Map<String, dynamic>,
            ),
      snackBar: json['snackBar'] == null
          ? const SnackBarWidgetConfig()
          : SnackBarWidgetConfig.fromJson(
              json['snackBar'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DialogWidgetConfigToJson(DialogWidgetConfig instance) =>
    <String, dynamic>{
      'theme': instance.theme.toJson(),
      'confirmDialog': instance.confirmDialog.toJson(),
      'snackBar': instance.snackBar.toJson(),
    };

const _$DialogWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  },
};

DialogThemeConfig _$DialogThemeConfigFromJson(Map<String, dynamic> json) =>
    DialogThemeConfig(
      backgroundColor: json['backgroundColor'] as String?,
      surfaceTintColor: json['surfaceTintColor'] as String?,
      shadowColor: json['shadowColor'] as String?,
      barrierColor: json['barrierColor'] as String?,
      elevation: (json['elevation'] as num?)?.toDouble(),
      borderRadius: (json['borderRadius'] as num?)?.toDouble(),
      titleTextStyle: json['titleTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['titleTextStyle'] as Map<String, dynamic>,
            ),
      contentTextStyle: json['contentTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['contentTextStyle'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DialogThemeConfigToJson(DialogThemeConfig instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'surfaceTintColor': instance.surfaceTintColor,
      'shadowColor': instance.shadowColor,
      'barrierColor': instance.barrierColor,
      'elevation': instance.elevation,
      'borderRadius': instance.borderRadius,
      'titleTextStyle': instance.titleTextStyle?.toJson(),
      'contentTextStyle': instance.contentTextStyle?.toJson(),
    };

const _$DialogThemeConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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

ConfirmDialogWidgetConfig _$ConfirmDialogWidgetConfigFromJson(
  Map<String, dynamic> json,
) => ConfirmDialogWidgetConfig(
  activeButtonColor1: json['activeButtonColor1'] as String?,
  activeButtonColor2: json['activeButtonColor2'] as String?,
  defaultButtonColor: json['defaultButtonColor'] as String?,
  backgroundColor: json['backgroundColor'] as String?,
  surfaceTintColor: json['surfaceTintColor'] as String?,
  elevation: (json['elevation'] as num?)?.toDouble(),
  borderRadius: (json['borderRadius'] as num?)?.toDouble(),
  titleTextStyle: json['titleTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(
          json['titleTextStyle'] as Map<String, dynamic>,
        ),
  contentTextStyle: json['contentTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(
          json['contentTextStyle'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ConfirmDialogWidgetConfigToJson(
  ConfirmDialogWidgetConfig instance,
) => <String, dynamic>{
  'activeButtonColor1': instance.activeButtonColor1,
  'activeButtonColor2': instance.activeButtonColor2,
  'defaultButtonColor': instance.defaultButtonColor,
  'backgroundColor': instance.backgroundColor,
  'surfaceTintColor': instance.surfaceTintColor,
  'elevation': instance.elevation,
  'borderRadius': instance.borderRadius,
  'titleTextStyle': instance.titleTextStyle?.toJson(),
  'contentTextStyle': instance.contentTextStyle?.toJson(),
};

const _$ConfirmDialogWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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

SnackBarWidgetConfig _$SnackBarWidgetConfigFromJson(
  Map<String, dynamic> json,
) => SnackBarWidgetConfig(
  successBackgroundColor:
      json['successBackgroundColor'] as String? ?? '#75B943',
  errorBackgroundColor: json['errorBackgroundColor'] as String? ?? '#E74C3C',
  infoBackgroundColor: json['infoBackgroundColor'] as String? ?? '#494949',
  warningBackgroundColor:
      json['warningBackgroundColor'] as String? ?? '#F95A14',
);

Map<String, dynamic> _$SnackBarWidgetConfigToJson(
  SnackBarWidgetConfig instance,
) => <String, dynamic>{
  'successBackgroundColor': instance.successBackgroundColor,
  'errorBackgroundColor': instance.errorBackgroundColor,
  'infoBackgroundColor': instance.infoBackgroundColor,
  'warningBackgroundColor': instance.warningBackgroundColor,
};

const _$SnackBarWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'successBackgroundColor': {'type': 'string', 'default': '#75B943'},
    'errorBackgroundColor': {'type': 'string', 'default': '#E74C3C'},
    'infoBackgroundColor': {'type': 'string', 'default': '#494949'},
    'warningBackgroundColor': {'type': 'string', 'default': '#F95A14'},
  },
};

StatusesWidgetConfig _$StatusesWidgetConfigFromJson(
  Map<String, dynamic> json,
) => StatusesWidgetConfig(
  registrationStatuses: json['registrationStatuses'] == null
      ? const RegistrationStatusesWidgetConfig()
      : RegistrationStatusesWidgetConfig.fromJson(
          json['registrationStatuses'] as Map<String, dynamic>,
        ),
  callStatuses: json['callStatuses'] == null
      ? const CallStatusesWidgetConfig()
      : CallStatusesWidgetConfig.fromJson(
          json['callStatuses'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$StatusesWidgetConfigToJson(
  StatusesWidgetConfig instance,
) => <String, dynamic>{
  'registrationStatuses': instance.registrationStatuses.toJson(),
  'callStatuses': instance.callStatuses.toJson(),
};

const _$StatusesWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'registrationStatuses': {
      r'$ref': r'#/$defs/RegistrationStatusesWidgetConfig',
    },
    'callStatuses': {r'$ref': r'#/$defs/CallStatusesWidgetConfig'},
  },
  r'$defs': {
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
  },
};

RegistrationStatusesWidgetConfig _$RegistrationStatusesWidgetConfigFromJson(
  Map<String, dynamic> json,
) => RegistrationStatusesWidgetConfig(
  online: json['online'] as String? ?? '#75B943',
  offline: json['offline'] as String? ?? '#EEF3F6',
);

Map<String, dynamic> _$RegistrationStatusesWidgetConfigToJson(
  RegistrationStatusesWidgetConfig instance,
) => <String, dynamic>{'online': instance.online, 'offline': instance.offline};

const _$RegistrationStatusesWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'online': {'type': 'string', 'default': '#75B943'},
    'offline': {'type': 'string', 'default': '#EEF3F6'},
  },
};

CallStatusesWidgetConfig _$CallStatusesWidgetConfigFromJson(
  Map<String, dynamic> json,
) => CallStatusesWidgetConfig(
  connectivityNone: json['connectivityNone'] as String? ?? '#E74C3C',
  connectError: json['connectError'] as String? ?? '#E74C3C',
  appUnregistered: json['appUnregistered'] as String? ?? '#494949',
  connectIssue: json['connectIssue'] as String? ?? '#E74C3C',
  inProgress: json['inProgress'] as String? ?? '#123752',
  ready: json['ready'] as String? ?? '#75B943',
);

Map<String, dynamic> _$CallStatusesWidgetConfigToJson(
  CallStatusesWidgetConfig instance,
) => <String, dynamic>{
  'connectivityNone': instance.connectivityNone,
  'connectError': instance.connectError,
  'appUnregistered': instance.appUnregistered,
  'connectIssue': instance.connectIssue,
  'inProgress': instance.inProgress,
  'ready': instance.ready,
};

const _$CallStatusesWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'connectivityNone': {'type': 'string', 'default': '#E74C3C'},
    'connectError': {'type': 'string', 'default': '#E74C3C'},
    'appUnregistered': {'type': 'string', 'default': '#494949'},
    'connectIssue': {'type': 'string', 'default': '#E74C3C'},
    'inProgress': {'type': 'string', 'default': '#123752'},
    'ready': {'type': 'string', 'default': '#75B943'},
  },
};

TabBarConfig _$TabBarConfigFromJson(Map<String, dynamic> json) => TabBarConfig(
  indicatorColor: json['indicatorColor'] as String?,
  dividerColor: json['dividerColor'] as String?,
  labelColor: json['labelColor'] as String?,
  unselectedLabelColor: json['unselectedLabelColor'] as String?,
  overlayColor: json['overlayColor'] as String?,
  dividerHeight: (json['dividerHeight'] as num?)?.toDouble(),
  labelPadding: json['labelPadding'] == null
      ? null
      : PaddingConfig.fromJson(json['labelPadding'] as Map<String, dynamic>),
  labelStyle: json['labelStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['labelStyle'] as Map<String, dynamic>),
  unselectedLabelStyle: json['unselectedLabelStyle'] == null
      ? null
      : TextStyleConfig.fromJson(
          json['unselectedLabelStyle'] as Map<String, dynamic>,
        ),
  indicatorSize: $enumDecodeNullable(
    _$TabBarIndicatorSizeConfigEnumMap,
    json['indicatorSize'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  tabAlignment: $enumDecodeNullable(
    _$TabAlignmentConfigEnumMap,
    json['tabAlignment'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  indicatorAnimation: $enumDecodeNullable(
    _$TabIndicatorAnimationConfigEnumMap,
    json['indicatorAnimation'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  splashFactory: $enumDecodeNullable(
    _$TabSplashFactoryConfigEnumMap,
    json['splashFactory'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  indicatorBorder: json['indicatorBorder'] == null
      ? null
      : BorderConfig.fromJson(json['indicatorBorder'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TabBarConfigToJson(
  TabBarConfig instance,
) => <String, dynamic>{
  'indicatorColor': instance.indicatorColor,
  'dividerColor': instance.dividerColor,
  'labelColor': instance.labelColor,
  'unselectedLabelColor': instance.unselectedLabelColor,
  'overlayColor': instance.overlayColor,
  'dividerHeight': instance.dividerHeight,
  'labelPadding': instance.labelPadding?.toJson(),
  'labelStyle': instance.labelStyle?.toJson(),
  'unselectedLabelStyle': instance.unselectedLabelStyle?.toJson(),
  'indicatorSize': _$TabBarIndicatorSizeConfigEnumMap[instance.indicatorSize],
  'tabAlignment': _$TabAlignmentConfigEnumMap[instance.tabAlignment],
  'indicatorAnimation':
      _$TabIndicatorAnimationConfigEnumMap[instance.indicatorAnimation],
  'splashFactory': _$TabSplashFactoryConfigEnumMap[instance.splashFactory],
  'indicatorBorder': instance.indicatorBorder?.toJson(),
};

const _$TabBarConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
    'BorderConfig': {
      'type': 'object',
      'properties': {
        'type': {
          'enum': ['underline', 'outline', 'none'],
          'description':
              'Border type:\n- [`BorderTypeConfig.underline`]\n- [`BorderTypeConfig.outline`]\n- [`BorderTypeConfig.none`]',
          'default': 'underline',
        },
        'borderRadius': {
          'type': 'number',
          'description': 'Corner radius for outline borders.',
        },
        'borderColor': {
          'type': 'string',
          'description': 'Border color (hex string, e.g. `#000000`).',
        },
        'borderWidth': {
          'type': 'number',
          'description': 'Stroke width of the border.',
        },
      },
    },
  },
};

const _$TabBarIndicatorSizeConfigEnumMap = {
  TabBarIndicatorSizeConfig.tab: 'tab',
  TabBarIndicatorSizeConfig.label: 'label',
};

const _$TabAlignmentConfigEnumMap = {
  TabAlignmentConfig.start: 'start',
  TabAlignmentConfig.startOffset: 'startOffset',
  TabAlignmentConfig.fill: 'fill',
  TabAlignmentConfig.center: 'center',
};

const _$TabIndicatorAnimationConfigEnumMap = {
  TabIndicatorAnimationConfig.linear: 'linear',
  TabIndicatorAnimationConfig.elastic: 'elastic',
};

const _$TabSplashFactoryConfigEnumMap = {
  TabSplashFactoryConfig.noSplash: 'noSplash',
  TabSplashFactoryConfig.inkRipple: 'inkRipple',
  TabSplashFactoryConfig.inkSparkle: 'inkSparkle',
};

_AppBarConfig _$AppBarConfigFromJson(
  Map<String, dynamic> json,
) => _AppBarConfig(
  primary: json['primary'] as bool? ?? true,
  showBackButton: json['showBackButton'] as bool? ?? true,
  backgroundColor: json['backgroundColor'] as String?,
  foregroundColor: json['foregroundColor'] as String?,
  shadowColor: json['shadowColor'] as String?,
  surfaceTintColor: json['surfaceTintColor'] as String?,
  elevation: (json['elevation'] as num?)?.toDouble(),
  scrolledUnderElevation: (json['scrolledUnderElevation'] as num?)?.toDouble(),
  titleSpacing: (json['titleSpacing'] as num?)?.toDouble(),
  leadingWidth: (json['leadingWidth'] as num?)?.toDouble(),
  toolbarHeight: (json['toolbarHeight'] as num?)?.toDouble(),
  centerTitle: json['centerTitle'] as bool?,
  iconTheme: json['iconTheme'] == null
      ? null
      : IconThemeDataConfig.fromJson(json['iconTheme'] as Map<String, dynamic>),
  actionsIconTheme: json['actionsIconTheme'] == null
      ? null
      : IconThemeDataConfig.fromJson(
          json['actionsIconTheme'] as Map<String, dynamic>,
        ),
  titleTextStyle: json['titleTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(
          json['titleTextStyle'] as Map<String, dynamic>,
        ),
  toolbarTextStyle: json['toolbarTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(
          json['toolbarTextStyle'] as Map<String, dynamic>,
        ),
  systemOverlayStyle: json['systemOverlayStyle'] == null
      ? null
      : OverlayStyleModel.fromJson(
          json['systemOverlayStyle'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AppBarConfigToJson(_AppBarConfig instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'showBackButton': instance.showBackButton,
      'backgroundColor': instance.backgroundColor,
      'foregroundColor': instance.foregroundColor,
      'shadowColor': instance.shadowColor,
      'surfaceTintColor': instance.surfaceTintColor,
      'elevation': instance.elevation,
      'scrolledUnderElevation': instance.scrolledUnderElevation,
      'titleSpacing': instance.titleSpacing,
      'leadingWidth': instance.leadingWidth,
      'toolbarHeight': instance.toolbarHeight,
      'centerTitle': instance.centerTitle,
      'iconTheme': instance.iconTheme,
      'actionsIconTheme': instance.actionsIconTheme,
      'titleTextStyle': instance.titleTextStyle,
      'toolbarTextStyle': instance.toolbarTextStyle,
      'systemOverlayStyle': instance.systemOverlayStyle,
    };

const _$_AppBarConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
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
        'color': {
          'type': 'string',
          'description': 'Color of the shadow (hex string).',
        },
        'offset': {
          r'$ref': r'#/$defs/OffsetConfig',
          'description': 'The displacement of the shadow.',
        },
        'blurRadius': {
          'type': 'number',
          'description': 'The blur radius of the shadow.',
          'default': 0.0,
        },
      },
    },
    'IconThemeDataConfig': {
      'type': 'object',
      'properties': {
        'size': {
          'type': 'number',
          'description': 'The default size for icons.',
        },
        'fill': {
          'type': 'number',
          'description':
              'The default fill for icons (0.0 to 1.0).\nUseful for variable fonts (e.g. Material Symbols).',
        },
        'weight': {
          'type': 'number',
          'description':
              'The default weight for icons (e.g. 400.0).\nUseful for variable fonts.',
        },
        'grade': {
          'type': 'number',
          'description':
              'The default grade for icons.\nUseful for variable fonts.',
        },
        'opticalSize': {
          'type': 'number',
          'description':
              'The default optical size for icons.\nUseful for variable fonts.',
        },
        'color': {
          'type': 'string',
          'description': 'The default color for icons (hex string).',
        },
        'opacity': {
          'type': 'number',
          'description':
              'An opacity to apply to both explicit and default icon colors.',
        },
        'shadows': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/ShadowConfig'},
          'description': 'A list of shadows to apply to the icons.',
        },
        'applyTextScaling': {
          'type': 'boolean',
          'description': 'Whether to apply text scaling to the icons.',
        },
      },
    },
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
          'description':
              'System navigation bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarIconBrightness': {
          'type': 'string',
          'description':
              'Status bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarBrightness': {
          'type': 'string',
          'description': 'Status bar brightness (e.g., "dark" or "light").',
        },
      },
    },
  },
};
