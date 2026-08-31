// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_page_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemePageConfig _$ThemePageConfigFromJson(Map<String, dynamic> json) => ThemePageConfig(
  login: json['login'] == null
      ? const LoginPageConfig()
      : LoginPageConfig.fromJson(json['login'] as Map<String, dynamic>),
  about: json['about'] == null
      ? const AboutPageConfig()
      : AboutPageConfig.fromJson(json['about'] as Map<String, dynamic>),
  dialing: json['dialing'] == null
      ? const CallPageConfig()
      : CallPageConfig.fromJson(json['dialing'] as Map<String, dynamic>),
  keypad: json['keypad'] == null
      ? const KeypadPageConfig()
      : KeypadPageConfig.fromJson(json['keypad'] as Map<String, dynamic>),
  settings: json['settings'] == null
      ? const SettingsPageConfig()
      : SettingsPageConfig.fromJson(json['settings'] as Map<String, dynamic>),
  contacts: json['contacts'] == null
      ? const ContactsPageConfig()
      : ContactsPageConfig.fromJson(json['contacts'] as Map<String, dynamic>),
  embedded: json['embedded'] == null
      ? const EmbeddedPageConfig()
      : EmbeddedPageConfig.fromJson(json['embedded'] as Map<String, dynamic>),
  favorites: json['favorites'] == null
      ? const FavoritesPageConfig()
      : FavoritesPageConfig.fromJson(json['favorites'] as Map<String, dynamic>),
  conversations: json['conversations'] == null
      ? const ConversationsPageConfig()
      : ConversationsPageConfig.fromJson(json['conversations'] as Map<String, dynamic>),
  recents: json['recents'] == null
      ? const RecentsPageConfig()
      : RecentsPageConfig.fromJson(json['recents'] as Map<String, dynamic>),
  numberCdrs: json['numberCdrs'] == null
      ? const NumberCdrsPageConfig()
      : NumberCdrsPageConfig.fromJson(json['numberCdrs'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ThemePageConfigToJson(ThemePageConfig instance) => <String, dynamic>{
  'login': instance.login.toJson(),
  'about': instance.about.toJson(),
  'dialing': instance.dialing.toJson(),
  'keypad': instance.keypad.toJson(),
  'settings': instance.settings.toJson(),
  'contacts': instance.contacts.toJson(),
  'embedded': instance.embedded.toJson(),
  'favorites': instance.favorites.toJson(),
  'conversations': instance.conversations.toJson(),
  'recents': instance.recents.toJson(),
  'numberCdrs': instance.numberCdrs.toJson(),
};

const _$ThemePageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
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
          'description': 'System navigation bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarIconBrightness': {
          'type': 'string',
          'description': 'Status bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarBrightness': {'type': 'string', 'description': 'Status bar brightness (e.g., "dark" or "light").'},
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
    'ImageRenderSpec': {
      'type': 'object',
      'properties': {
        'scale': {'type': 'number'},
        'padding': {r'$ref': r'#/$defs/PaddingConfig'},
        'alignment': {'type': 'object'},
        'fit': {'type': 'object'},
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
    'PageBackground': {'type': 'object', 'properties': {}},
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
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
    'LoginModeSelectPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {r'$ref': r'#/$defs/ThemeOverrideConfig'},
        'systemUiOverlayStyle': {r'$ref': r'#/$defs/OverlayStyleModel'},
        'mainLogo': {r'$ref': r'#/$defs/ImageSource'},
        'buttonLoginStyleType': {'type': 'object'},
        'buttonSignupStyleType': {'type': 'object'},
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'greetingTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
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
    'GroupTitleListTileWidgetConfig': {
      'type': 'object',
      'properties': {
        'backgroundColor': {'type': 'string'},
        'textStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
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
  },
};

ThemeOverrideConfig _$ThemeOverrideConfigFromJson(Map<String, dynamic> json) => ThemeOverrideConfig(
  mode: $enumDecodeNullable(_$ThemeModeConfigEnumMap, json['mode']) ?? ThemeModeConfig.system,
  applyToAppBar: json['applyToAppBar'] as bool? ?? true,
);

Map<String, dynamic> _$ThemeOverrideConfigToJson(ThemeOverrideConfig instance) => <String, dynamic>{
  'mode': _$ThemeModeConfigEnumMap[instance.mode]!,
  'applyToAppBar': instance.applyToAppBar,
};

const _$ThemeOverrideConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
    'applyToAppBar': {
      'type': 'boolean',
      'description': 'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
      'default': true,
    },
  },
};

const _$ThemeModeConfigEnumMap = {
  ThemeModeConfig.system: 'system',
  ThemeModeConfig.light: 'light',
  ThemeModeConfig.dark: 'dark',
};

LoginPageConfig _$LoginPageConfigFromJson(Map<String, dynamic> json) => LoginPageConfig(
  modeSelect: json['modeSelect'] == null
      ? const LoginModeSelectPageConfig()
      : LoginModeSelectPageConfig.fromJson(json['modeSelect'] as Map<String, dynamic>),
  switchPage: json['switchPage'] == null
      ? const LoginSwitchPageConfig()
      : LoginSwitchPageConfig.fromJson(json['switchPage'] as Map<String, dynamic>),
  otpSignin: json['otpSignin'] == null
      ? const LoginOtpSigninPageConfig()
      : LoginOtpSigninPageConfig.fromJson(json['otpSignin'] as Map<String, dynamic>),
  passwordSignin: json['passwordSignin'] == null
      ? const LoginPasswordSigninPageConfig()
      : LoginPasswordSigninPageConfig.fromJson(json['passwordSignin'] as Map<String, dynamic>),
  otpSigninVerify: json['otpSigninVerify'] == null
      ? const LoginOtpSigninVerifyScreenPageConfig()
      : LoginOtpSigninVerifyScreenPageConfig.fromJson(json['otpSigninVerify'] as Map<String, dynamic>),
  signupVerify: json['signupVerify'] == null
      ? const LoginSignupVerifyScreenPageConfig()
      : LoginSignupVerifyScreenPageConfig.fromJson(json['signupVerify'] as Map<String, dynamic>),
  coreUrlAssign: json['coreUrlAssign'] == null
      ? const LoginCoreUrlAssignPageConfig()
      : LoginCoreUrlAssignPageConfig.fromJson(json['coreUrlAssign'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginPageConfigToJson(LoginPageConfig instance) => <String, dynamic>{
  'modeSelect': instance.modeSelect.toJson(),
  'switchPage': instance.switchPage.toJson(),
  'otpSignin': instance.otpSignin.toJson(),
  'passwordSignin': instance.passwordSignin.toJson(),
  'otpSigninVerify': instance.otpSigninVerify.toJson(),
  'signupVerify': instance.signupVerify.toJson(),
  'coreUrlAssign': instance.coreUrlAssign.toJson(),
};

const _$LoginPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
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
          'description': 'System navigation bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarIconBrightness': {
          'type': 'string',
          'description': 'Status bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarBrightness': {'type': 'string', 'description': 'Status bar brightness (e.g., "dark" or "light").'},
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
    'ImageRenderSpec': {
      'type': 'object',
      'properties': {
        'scale': {'type': 'number'},
        'padding': {r'$ref': r'#/$defs/PaddingConfig'},
        'alignment': {'type': 'object'},
        'fit': {'type': 'object'},
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
    'PageBackground': {'type': 'object', 'properties': {}},
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
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
    'LoginModeSelectPageConfig': {
      'type': 'object',
      'properties': {
        'themeOverride': {r'$ref': r'#/$defs/ThemeOverrideConfig'},
        'systemUiOverlayStyle': {r'$ref': r'#/$defs/OverlayStyleModel'},
        'mainLogo': {r'$ref': r'#/$defs/ImageSource'},
        'buttonLoginStyleType': {'type': 'object'},
        'buttonSignupStyleType': {'type': 'object'},
        'background': {r'$ref': r'#/$defs/PageBackground'},
        'greetingTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
        'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
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
  },
};

LoginOtpSigninPageConfig _$LoginOtpSigninPageConfigFromJson(Map<String, dynamic> json) => LoginOtpSigninPageConfig(
  refTextField: json['refTextField'] == null
      ? null
      : TextFieldConfig.fromJson(json['refTextField'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginOtpSigninPageConfigToJson(LoginOtpSigninPageConfig instance) => <String, dynamic>{
  'refTextField': instance.refTextField?.toJson(),
};

const _$LoginOtpSigninPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'refTextField': {r'$ref': r'#/$defs/TextFieldConfig'},
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
  },
};

LoginPasswordSigninPageConfig _$LoginPasswordSigninPageConfigFromJson(Map<String, dynamic> json) =>
    LoginPasswordSigninPageConfig(
      refTextField: json['refTextField'] == null
          ? null
          : TextFieldConfig.fromJson(json['refTextField'] as Map<String, dynamic>),
      passwordTextField: json['passwordTextField'] == null
          ? null
          : TextFieldConfig.fromJson(json['passwordTextField'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginPasswordSigninPageConfigToJson(LoginPasswordSigninPageConfig instance) => <String, dynamic>{
  'refTextField': instance.refTextField?.toJson(),
  'passwordTextField': instance.passwordTextField?.toJson(),
};

const _$LoginPasswordSigninPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'refTextField': {r'$ref': r'#/$defs/TextFieldConfig'},
    'passwordTextField': {r'$ref': r'#/$defs/TextFieldConfig'},
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
  },
};

LoginOtpSigninVerifyScreenPageConfig _$LoginOtpSigninVerifyScreenPageConfigFromJson(Map<String, dynamic> json) =>
    LoginOtpSigninVerifyScreenPageConfig(
      countdownRepeatIntervalSeconds: (json['countdownRepeatIntervalSeconds'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$LoginOtpSigninVerifyScreenPageConfigToJson(LoginOtpSigninVerifyScreenPageConfig instance) =>
    <String, dynamic>{'countdownRepeatIntervalSeconds': instance.countdownRepeatIntervalSeconds};

const _$LoginOtpSigninVerifyScreenPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'countdownRepeatIntervalSeconds': {'type': 'integer', 'default': 30},
  },
};

LoginSignupVerifyScreenPageConfig _$LoginSignupVerifyScreenPageConfigFromJson(Map<String, dynamic> json) =>
    LoginSignupVerifyScreenPageConfig(
      countdownRepeatIntervalSeconds: (json['countdownRepeatIntervalSeconds'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$LoginSignupVerifyScreenPageConfigToJson(LoginSignupVerifyScreenPageConfig instance) =>
    <String, dynamic>{'countdownRepeatIntervalSeconds': instance.countdownRepeatIntervalSeconds};

const _$LoginSignupVerifyScreenPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'countdownRepeatIntervalSeconds': {'type': 'integer', 'default': 30},
  },
};

LoginModeSelectPageConfig _$LoginModeSelectPageConfigFromJson(Map<String, dynamic> json) => LoginModeSelectPageConfig(
  themeOverride: json['themeOverride'] == null
      ? const ThemeOverrideConfig()
      : ThemeOverrideConfig.fromJson(json['themeOverride'] as Map<String, dynamic>),
  systemUiOverlayStyle: json['systemUiOverlayStyle'] == null
      ? null
      : OverlayStyleModel.fromJson(json['systemUiOverlayStyle'] as Map<String, dynamic>),
  mainLogo: json['mainLogo'] == null ? null : ImageSource.fromJson(json['mainLogo'] as Map<String, dynamic>),
  buttonLoginStyleType:
      $enumDecodeNullable(_$ElevatedButtonStyleTypeEnumMap, json['buttonLoginStyleType']) ??
      ElevatedButtonStyleType.primary,
  buttonSignupStyleType:
      $enumDecodeNullable(_$ElevatedButtonStyleTypeEnumMap, json['buttonSignupStyleType']) ??
      ElevatedButtonStyleType.primary,
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  greetingTextStyle: json['greetingTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['greetingTextStyle'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginModeSelectPageConfigToJson(LoginModeSelectPageConfig instance) => <String, dynamic>{
  'themeOverride': instance.themeOverride.toJson(),
  'systemUiOverlayStyle': instance.systemUiOverlayStyle?.toJson(),
  'mainLogo': instance.mainLogo?.toJson(),
  'buttonLoginStyleType': _$ElevatedButtonStyleTypeEnumMap[instance.buttonLoginStyleType]!,
  'buttonSignupStyleType': _$ElevatedButtonStyleTypeEnumMap[instance.buttonSignupStyleType]!,
  'background': instance.background?.toJson(),
  'greetingTextStyle': instance.greetingTextStyle?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$LoginModeSelectPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'themeOverride': {r'$ref': r'#/$defs/ThemeOverrideConfig'},
    'systemUiOverlayStyle': {r'$ref': r'#/$defs/OverlayStyleModel'},
    'mainLogo': {r'$ref': r'#/$defs/ImageSource'},
    'buttonLoginStyleType': {'type': 'object'},
    'buttonSignupStyleType': {'type': 'object'},
    'background': {r'$ref': r'#/$defs/PageBackground'},
    'greetingTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
    'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
  },
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
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
          'description': 'System navigation bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarIconBrightness': {
          'type': 'string',
          'description': 'Status bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarBrightness': {'type': 'string', 'description': 'Status bar brightness (e.g., "dark" or "light").'},
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
    'ImageRenderSpec': {
      'type': 'object',
      'properties': {
        'scale': {'type': 'number'},
        'padding': {r'$ref': r'#/$defs/PaddingConfig'},
        'alignment': {'type': 'object'},
        'fit': {'type': 'object'},
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
    'PageBackground': {'type': 'object', 'properties': {}},
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
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

const _$ElevatedButtonStyleTypeEnumMap = {
  ElevatedButtonStyleType.primary: 'primary',
  ElevatedButtonStyleType.neutral: 'neutral',
  ElevatedButtonStyleType.primaryOnDark: 'primaryOnDark',
  ElevatedButtonStyleType.neutralOnDark: 'neutralOnDark',
};

LoginSwitchPageConfig _$LoginSwitchPageConfigFromJson(Map<String, dynamic> json) => LoginSwitchPageConfig(
  mainLogo: json['mainLogo'] == null ? null : ImageSource.fromJson(json['mainLogo'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  themeOverride: json['themeOverride'] == null
      ? const ThemeOverrideConfig()
      : ThemeOverrideConfig.fromJson(json['themeOverride'] as Map<String, dynamic>),
  segmentButtonStyle: json['segmentButtonStyle'] == null
      ? null
      : ButtonStyleConfig.fromJson(json['segmentButtonStyle'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginSwitchPageConfigToJson(LoginSwitchPageConfig instance) => <String, dynamic>{
  'themeOverride': instance.themeOverride.toJson(),
  'mainLogo': instance.mainLogo?.toJson(),
  'background': instance.background?.toJson(),
  'segmentButtonStyle': instance.segmentButtonStyle?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$LoginSwitchPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'themeOverride': {r'$ref': r'#/$defs/ThemeOverrideConfig'},
    'mainLogo': {r'$ref': r'#/$defs/ImageSource'},
    'background': {r'$ref': r'#/$defs/PageBackground'},
    'segmentButtonStyle': {r'$ref': r'#/$defs/ButtonStyleConfig'},
    'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
    'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
  },
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
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
    'ImageRenderSpec': {
      'type': 'object',
      'properties': {
        'scale': {'type': 'number'},
        'padding': {r'$ref': r'#/$defs/PaddingConfig'},
        'alignment': {'type': 'object'},
        'fit': {'type': 'object'},
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
    'PageBackground': {'type': 'object', 'properties': {}},
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
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

AboutPageConfig _$AboutPageConfigFromJson(Map<String, dynamic> json) => AboutPageConfig(
  mainLogo: json['mainLogo'] == null ? null : ImageSource.fromJson(json['mainLogo'] as Map<String, dynamic>),
  metadata: json['metadata'] == null ? const Metadata() : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AboutPageConfigToJson(AboutPageConfig instance) => <String, dynamic>{
  'mainLogo': instance.mainLogo?.toJson(),
  'metadata': instance.metadata.toJson(),
  'background': instance.background?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$AboutPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'mainLogo': {r'$ref': r'#/$defs/ImageSource'},
    'metadata': {r'$ref': r'#/$defs/Metadata'},
    'background': {r'$ref': r'#/$defs/PageBackground'},
    'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
    'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
  },
  r'$defs': {
    'PaddingConfig': {
      'type': 'object',
      'properties': {
        'left': {'type': 'number', 'description': 'Left padding value.', 'default': 0.0},
        'top': {'type': 'number', 'description': 'Top padding value.', 'default': 0.0},
        'right': {'type': 'number', 'description': 'Right padding value.', 'default': 0.0},
        'bottom': {'type': 'number', 'description': 'Bottom padding value.', 'default': 0.0},
      },
    },
    'ImageRenderSpec': {
      'type': 'object',
      'properties': {
        'scale': {'type': 'number'},
        'padding': {r'$ref': r'#/$defs/PaddingConfig'},
        'alignment': {'type': 'object'},
        'fit': {'type': 'object'},
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
    'PageBackground': {'type': 'object', 'properties': {}},
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

CallPageConfig _$CallPageConfigFromJson(Map<String, dynamic> json) => CallPageConfig(
  systemUiOverlayStyle: json['systemUiOverlayStyle'] == null
      ? null
      : OverlayStyleModel.fromJson(json['systemUiOverlayStyle'] as Map<String, dynamic>),
  callInfo: json['callInfo'] == null ? null : CallPageInfoConfig.fromJson(json['callInfo'] as Map<String, dynamic>),
  callList: json['callList'] == null ? null : CallPageListConfig.fromJson(json['callList'] as Map<String, dynamic>),
  actingOnHint: json['actingOnHint'] == null
      ? null
      : CallPageHintConfig.fromJson(json['actingOnHint'] as Map<String, dynamic>),
  actions: json['actions'] == null ? null : CallPageActionsConfig.fromJson(json['actions'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CallPageConfigToJson(CallPageConfig instance) => <String, dynamic>{
  'systemUiOverlayStyle': instance.systemUiOverlayStyle?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
  'callInfo': instance.callInfo?.toJson(),
  'callList': instance.callList?.toJson(),
  'actingOnHint': instance.actingOnHint?.toJson(),
  'actions': instance.actions?.toJson(),
  'background': instance.background?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
};

const _$CallPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
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
    'PageBackground': {'type': 'object', 'properties': {}},
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
      },
    },
  },
};

CallPageActionsConfig _$CallPageActionsConfigFromJson(Map<String, dynamic> json) => CallPageActionsConfig(
  callStart: json['callStart'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['callStart'] as Map<String, dynamic>),
  hangup: json['hangup'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['hangup'] as Map<String, dynamic>),
  transfer: json['transfer'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['transfer'] as Map<String, dynamic>),
  camera: json['camera'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['camera'] as Map<String, dynamic>),
  muted: json['muted'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['muted'] as Map<String, dynamic>),
  speaker: json['speaker'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['speaker'] as Map<String, dynamic>),
  held: json['held'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['held'] as Map<String, dynamic>),
  swap: json['swap'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['swap'] as Map<String, dynamic>),
  key: json['key'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['key'] as Map<String, dynamic>),
  keypadInputStyle: json['keypadInputStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['keypadInputStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CallPageActionsConfigToJson(CallPageActionsConfig instance) => <String, dynamic>{
  'callStart': instance.callStart.toJson(),
  'hangup': instance.hangup.toJson(),
  'transfer': instance.transfer.toJson(),
  'camera': instance.camera.toJson(),
  'muted': instance.muted.toJson(),
  'speaker': instance.speaker.toJson(),
  'held': instance.held.toJson(),
  'swap': instance.swap.toJson(),
  'key': instance.key.toJson(),
  'keypadInputStyle': instance.keypadInputStyle?.toJson(),
};

const _$CallPageActionsConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  },
};

CallPageInfoConfig _$CallPageInfoConfigFromJson(Map<String, dynamic> json) => CallPageInfoConfig(
  usernameTextStyle: json['usernameTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['usernameTextStyle'] as Map<String, dynamic>),
  numberTextStyle: json['numberTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['numberTextStyle'] as Map<String, dynamic>),
  callStatusTextStyle: json['callStatusTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['callStatusTextStyle'] as Map<String, dynamic>),
  processingStatusTextStyle: json['processingStatusTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['processingStatusTextStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CallPageInfoConfigToJson(CallPageInfoConfig instance) => <String, dynamic>{
  'usernameTextStyle': instance.usernameTextStyle?.toJson(),
  'numberTextStyle': instance.numberTextStyle?.toJson(),
  'callStatusTextStyle': instance.callStatusTextStyle?.toJson(),
  'processingStatusTextStyle': instance.processingStatusTextStyle?.toJson(),
};

const _$CallPageInfoConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'usernameTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'numberTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'callStatusTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
    'processingStatusTextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
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

CallPageListConfig _$CallPageListConfigFromJson(Map<String, dynamic> json) => CallPageListConfig(
  rowBackgroundColor: json['rowBackgroundColor'] as String?,
  rowFocusedBackgroundColor: json['rowFocusedBackgroundColor'] as String?,
  rowFocusedBorderColor: json['rowFocusedBorderColor'] as String?,
  dotRingingColor: json['dotRingingColor'] as String?,
  dotOnCallColor: json['dotOnCallColor'] as String?,
  dotHeldColor: json['dotHeldColor'] as String?,
);

Map<String, dynamic> _$CallPageListConfigToJson(CallPageListConfig instance) => <String, dynamic>{
  'rowBackgroundColor': instance.rowBackgroundColor,
  'rowFocusedBackgroundColor': instance.rowFocusedBackgroundColor,
  'rowFocusedBorderColor': instance.rowFocusedBorderColor,
  'dotRingingColor': instance.dotRingingColor,
  'dotOnCallColor': instance.dotOnCallColor,
  'dotHeldColor': instance.dotHeldColor,
};

const _$CallPageListConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'rowBackgroundColor': {'type': 'string'},
    'rowFocusedBackgroundColor': {'type': 'string'},
    'rowFocusedBorderColor': {'type': 'string'},
    'dotRingingColor': {'type': 'string'},
    'dotOnCallColor': {'type': 'string'},
    'dotHeldColor': {'type': 'string'},
  },
};

CallPageHintConfig _$CallPageHintConfigFromJson(Map<String, dynamic> json) => CallPageHintConfig(
  backgroundColor: json['backgroundColor'] as String?,
  affectedNameColor: json['affectedNameColor'] as String?,
);

Map<String, dynamic> _$CallPageHintConfigToJson(CallPageHintConfig instance) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'affectedNameColor': instance.affectedNameColor,
};

const _$CallPageHintConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'backgroundColor': {'type': 'string'},
    'affectedNameColor': {'type': 'string'},
  },
};

KeypadPageConfig _$KeypadPageConfigFromJson(Map<String, dynamic> json) => KeypadPageConfig(
  systemUiOverlayStyle: json['systemUiOverlayStyle'] == null
      ? null
      : OverlayStyleModel.fromJson(json['systemUiOverlayStyle'] as Map<String, dynamic>),
  textField: json['textField'] == null ? null : TextFieldConfig.fromJson(json['textField'] as Map<String, dynamic>),
  contactName: json['contactName'] == null
      ? null
      : TextFieldConfig.fromJson(json['contactName'] as Map<String, dynamic>),
  keypad: json['keypad'] == null ? null : KeypadStyleConfig.fromJson(json['keypad'] as Map<String, dynamic>),
  actionpad: json['actionpad'] == null
      ? null
      : ActionPadWidgetConfig.fromJson(json['actionpad'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  themeOverride: json['themeOverride'] == null
      ? const ThemeOverrideConfig()
      : ThemeOverrideConfig.fromJson(json['themeOverride'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$KeypadPageConfigToJson(KeypadPageConfig instance) => <String, dynamic>{
  'systemUiOverlayStyle': instance.systemUiOverlayStyle?.toJson(),
  'textField': instance.textField?.toJson(),
  'contactName': instance.contactName?.toJson(),
  'keypad': instance.keypad?.toJson(),
  'actionpad': instance.actionpad?.toJson(),
  'background': instance.background?.toJson(),
  'themeOverride': instance.themeOverride.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$KeypadPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
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
    'KeypadStyleConfig': {
      'type': 'object',
      'properties': {
        'textStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'subtextStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
        'spacing': {'type': 'number'},
        'padding': {'type': 'number'},
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
    'PageBackground': {'type': 'object', 'properties': {}},
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
        },
      },
    },
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

ActionPadWidgetConfig _$ActionPadWidgetConfigFromJson(Map<String, dynamic> json) => ActionPadWidgetConfig(
  callStart: json['callStart'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['callStart'] as Map<String, dynamic>),
  callTransfer: json['callTransfer'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['callTransfer'] as Map<String, dynamic>),
  backspace: json['backspace'] == null
      ? const ButtonStyleConfig()
      : ButtonStyleConfig.fromJson(json['backspace'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActionPadWidgetConfigToJson(ActionPadWidgetConfig instance) => <String, dynamic>{
  'callStart': instance.callStart.toJson(),
  'callTransfer': instance.callTransfer.toJson(),
  'backspace': instance.backspace.toJson(),
};

const _$ActionPadWidgetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'callStart': {r'$ref': r'#/$defs/ButtonStyleConfig'},
    'callTransfer': {r'$ref': r'#/$defs/ButtonStyleConfig'},
    'backspace': {
      r'$ref': r'#/$defs/ButtonStyleConfig',
      'description': 'Style of the backspace key under the dial pad.',
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
  },
};

SettingsPageConfig _$SettingsPageConfigFromJson(Map<String, dynamic> json) => SettingsPageConfig(
  themeOverride: json['themeOverride'] == null
      ? const ThemeOverrideConfig()
      : ThemeOverrideConfig.fromJson(json['themeOverride'] as Map<String, dynamic>),
  leadingIconsColor: json['leadingIconsColor'] as String?,
  userIconColor: json['userIconColor'] as String?,
  logoutIconColor: json['logoutIconColor'] as String?,
  groupTitleListTile: json['groupTitleListTile'] == null
      ? null
      : GroupTitleListTileWidgetConfig.fromJson(json['groupTitleListTile'] as Map<String, dynamic>),
  showSeparators: json['showSeparators'] as bool? ?? true,
  separator: json['separator'] == null
      ? null
      : SeparatorStyleConfig.fromJson(json['separator'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  itemTextStyle: json['itemTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['itemTextStyle'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SettingsPageConfigToJson(SettingsPageConfig instance) => <String, dynamic>{
  'themeOverride': instance.themeOverride.toJson(),
  'leadingIconsColor': instance.leadingIconsColor,
  'userIconColor': instance.userIconColor,
  'logoutIconColor': instance.logoutIconColor,
  'groupTitleListTile': instance.groupTitleListTile?.toJson(),
  'showSeparators': instance.showSeparators,
  'separator': instance.separator?.toJson(),
  'background': instance.background?.toJson(),
  'itemTextStyle': instance.itemTextStyle?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$SettingsPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
        },
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
    'GroupTitleListTileWidgetConfig': {
      'type': 'object',
      'properties': {
        'backgroundColor': {'type': 'string'},
        'textStyle': {r'$ref': r'#/$defs/TextStyleConfig'},
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
    'PageBackground': {'type': 'object', 'properties': {}},
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

ContactsPageConfig _$ContactsPageConfigFromJson(Map<String, dynamic> json) => ContactsPageConfig(
  themeOverride: json['themeOverride'] == null
      ? const ThemeOverrideConfig()
      : ThemeOverrideConfig.fromJson(json['themeOverride'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ContactsPageConfigToJson(ContactsPageConfig instance) => <String, dynamic>{
  'themeOverride': instance.themeOverride.toJson(),
  'background': instance.background?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$ContactsPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
        },
      },
    },
    'PageBackground': {'type': 'object', 'properties': {}},
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

EmbeddedPageConfig _$EmbeddedPageConfigFromJson(Map<String, dynamic> json) => EmbeddedPageConfig(
  themeOverride: json['themeOverride'] == null
      ? const ThemeOverrideConfig()
      : ThemeOverrideConfig.fromJson(json['themeOverride'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EmbeddedPageConfigToJson(EmbeddedPageConfig instance) => <String, dynamic>{
  'themeOverride': instance.themeOverride.toJson(),
  'background': instance.background?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$EmbeddedPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
        },
      },
    },
    'PageBackground': {'type': 'object', 'properties': {}},
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

FavoritesPageConfig _$FavoritesPageConfigFromJson(Map<String, dynamic> json) => FavoritesPageConfig(
  themeOverride: json['themeOverride'] == null
      ? const ThemeOverrideConfig()
      : ThemeOverrideConfig.fromJson(json['themeOverride'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FavoritesPageConfigToJson(FavoritesPageConfig instance) => <String, dynamic>{
  'themeOverride': instance.themeOverride.toJson(),
  'background': instance.background?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$FavoritesPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
        },
      },
    },
    'PageBackground': {'type': 'object', 'properties': {}},
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

ConversationsPageConfig _$ConversationsPageConfigFromJson(Map<String, dynamic> json) => ConversationsPageConfig(
  themeOverride: json['themeOverride'] == null
      ? const ThemeOverrideConfig()
      : ThemeOverrideConfig.fromJson(json['themeOverride'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConversationsPageConfigToJson(ConversationsPageConfig instance) => <String, dynamic>{
  'themeOverride': instance.themeOverride.toJson(),
  'background': instance.background?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$ConversationsPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
        },
      },
    },
    'PageBackground': {'type': 'object', 'properties': {}},
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

RecentsPageConfig _$RecentsPageConfigFromJson(Map<String, dynamic> json) => RecentsPageConfig(
  themeOverride: json['themeOverride'] == null
      ? const ThemeOverrideConfig()
      : ThemeOverrideConfig.fromJson(json['themeOverride'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RecentsPageConfigToJson(RecentsPageConfig instance) => <String, dynamic>{
  'themeOverride': instance.themeOverride.toJson(),
  'background': instance.background?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$RecentsPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
        },
      },
    },
    'PageBackground': {'type': 'object', 'properties': {}},
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

LoginCoreUrlAssignPageConfig _$LoginCoreUrlAssignPageConfigFromJson(
  Map<String, dynamic> json,
) => LoginCoreUrlAssignPageConfig(
  themeOverride: json['themeOverride'] == null
      ? const ThemeOverrideConfig()
      : ThemeOverrideConfig.fromJson(json['themeOverride'] as Map<String, dynamic>),
  systemUiOverlayStyle: json['systemUiOverlayStyle'] == null
      ? null
      : OverlayStyleModel.fromJson(json['systemUiOverlayStyle'] as Map<String, dynamic>),
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginCoreUrlAssignPageConfigToJson(LoginCoreUrlAssignPageConfig instance) => <String, dynamic>{
  'themeOverride': instance.themeOverride.toJson(),
  'systemUiOverlayStyle': instance.systemUiOverlayStyle?.toJson(),
  'background': instance.background?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$LoginCoreUrlAssignPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'themeOverride': {r'$ref': r'#/$defs/ThemeOverrideConfig'},
    'systemUiOverlayStyle': {r'$ref': r'#/$defs/OverlayStyleModel'},
    'background': {r'$ref': r'#/$defs/PageBackground'},
    'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
    'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
  },
  r'$defs': {
    'ThemeOverrideConfig': {
      'type': 'object',
      'properties': {
        'mode': {'type': 'object', 'description': 'The target mode to force (e.g., ensure screen is always Dark).'},
        'applyToAppBar': {
          'type': 'boolean',
          'description':
              'If true (default), the AppBar adopts the [mode].\nIf false, the AppBar keeps the global theme.',
          'default': true,
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
          'description': 'System navigation bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarIconBrightness': {
          'type': 'string',
          'description': 'Status bar icon brightness (e.g., "dark" or "light").',
        },
        'statusBarBrightness': {'type': 'string', 'description': 'Status bar brightness (e.g., "dark" or "light").'},
      },
    },
    'PageBackground': {'type': 'object', 'properties': {}},
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};

NumberCdrsPageConfig _$NumberCdrsPageConfigFromJson(Map<String, dynamic> json) => NumberCdrsPageConfig(
  background: json['background'] == null ? null : PageBackground.fromJson(json['background'] as Map<String, dynamic>),
  appBarBlurredSurface: json['appBarBlurredSurface'] == null
      ? null
      : BlurredSurfaceConfig.fromJson(json['appBarBlurredSurface'] as Map<String, dynamic>),
  appBarStyle: json['appBarStyle'] == null ? null : AppBarConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NumberCdrsPageConfigToJson(NumberCdrsPageConfig instance) => <String, dynamic>{
  'background': instance.background?.toJson(),
  'appBarBlurredSurface': instance.appBarBlurredSurface?.toJson(),
  'appBarStyle': instance.appBarStyle?.toJson(),
};

const _$NumberCdrsPageConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'background': {r'$ref': r'#/$defs/PageBackground'},
    'appBarBlurredSurface': {r'$ref': r'#/$defs/BlurredSurfaceConfig'},
    'appBarStyle': {r'$ref': r'#/$defs/AppBarConfig'},
  },
  r'$defs': {
    'PageBackground': {'type': 'object', 'properties': {}},
    'BlurredSurfaceConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
        'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
        'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
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
  },
};
