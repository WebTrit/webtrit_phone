// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
  loginConfig: json['loginConfig'] == null
      ? const AppConfigLogin()
      : AppConfigLogin.fromJson(json['loginConfig'] as Map<String, dynamic>),
  mainConfig: json['mainConfig'] == null
      ? const AppConfigMain()
      : AppConfigMain.fromJson(json['mainConfig'] as Map<String, dynamic>),
  settingsConfig: json['settingsConfig'] == null
      ? const AppConfigSettings()
      : AppConfigSettings.fromJson(
          json['settingsConfig'] as Map<String, dynamic>,
        ),
  callConfig: json['callConfig'] == null
      ? const AppConfigCall()
      : AppConfigCall.fromJson(json['callConfig'] as Map<String, dynamic>),
  contacts: json['contacts'] == null
      ? const AppConfigContacts()
      : AppConfigContacts.fromJson(json['contacts'] as Map<String, dynamic>),
  messaging: json['messaging'] == null
      ? const AppConfigMessaging()
      : AppConfigMessaging.fromJson(json['messaging'] as Map<String, dynamic>),
  localization: json['localization'] == null
      ? const AppConfigLocalization()
      : AppConfigLocalization.fromJson(
          json['localization'] as Map<String, dynamic>,
        ),
  supported:
      (json['supported'] as List<dynamic>?)
          ?.map((e) => SupportedFeature.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
  'loginConfig': instance.loginConfig.toJson(),
  'mainConfig': instance.mainConfig.toJson(),
  'settingsConfig': instance.settingsConfig.toJson(),
  'callConfig': instance.callConfig.toJson(),
  'contacts': instance.contacts.toJson(),
  'messaging': instance.messaging.toJson(),
  'localization': instance.localization.toJson(),
  'supported': instance.supported.map((e) => e.toJson()).toList(),
};

const _$AppConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'loginConfig': {r'$ref': r'#/$defs/AppConfigLogin'},
    'mainConfig': {r'$ref': r'#/$defs/AppConfigMain'},
    'settingsConfig': {r'$ref': r'#/$defs/AppConfigSettings'},
    'callConfig': {r'$ref': r'#/$defs/AppConfigCall'},
    'contacts': {r'$ref': r'#/$defs/AppConfigContacts'},
    'messaging': {r'$ref': r'#/$defs/AppConfigMessaging'},
    'localization': {r'$ref': r'#/$defs/AppConfigLocalization'},
    'supported': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/SupportedFeature'},
      'default': [],
    },
  },
  r'$defs': {
    'AppConfigLoginCommon': {
      'type': 'object',
      'properties': {
        'fullScreenLaunchEmbeddedResourceId': {'type': 'string'},
      },
    },
    'AppConfigModeSelectAction': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean'},
        'type': {'type': 'string'},
        'titleL10n': {'type': 'string'},
        'embeddedId': {'type': 'string'},
      },
      'required': ['enabled', 'type', 'titleL10n'],
    },
    'AppConfigLoginModeSelect': {
      'type': 'object',
      'properties': {
        'greetingL10n': {'type': 'string'},
        'actions': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/AppConfigModeSelectAction'},
        },
      },
    },
    'AppConfigLoginQrFormat': {
      'type': 'object',
      'properties': {
        'type': {
          'type': 'string',
          'description': 'Decoder name (`uri`, `json`).',
        },
        'schemes': {
          'type': 'array',
          'items': {'type': 'string'},
          'description':
              '`uri` only: accepted scheme names, matched case-insensitively.',
        },
      },
      'required': ['type'],
    },
    'AppConfigLoginQr': {
      'type': 'object',
      'properties': {
        'enabled': {
          'type': 'boolean',
          'description': 'Whether the QR-code sign-in tab is available at all.',
          'default': false,
        },
        'formats': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/AppConfigLoginQrFormat'},
          'description':
              'Accepted payload formats with their per-format options, probed in this\norder.',
        },
        'expectedHost': {
          'type': 'string',
          'description':
              'Expected host (cloud id) of the code, shared by all formats. When set,\ncodes issued for a different host are rejected; null accepts any host.',
        },
      },
    },
    'AppConfigLogin': {
      'type': 'object',
      'properties': {
        'common': {r'$ref': r'#/$defs/AppConfigLoginCommon'},
        'modeSelect': {r'$ref': r'#/$defs/AppConfigLoginModeSelect'},
        'signinOrder': {
          'type': 'array',
          'items': {'type': 'string'},
          'description':
              'Order of the sign-in tabs on the login switch screen, by login type name\n(passwordSignin, otpSignin, signup, qrSignin). Only the types advertised by\nthe backend are shown; this controls their order and which one is selected\nby default. Unknown or omitted names are placed last.',
          'default': ['passwordSignin', 'otpSignin', 'signup'],
        },
        'qr': {r'$ref': r'#/$defs/AppConfigLoginQr'},
      },
    },
    'BottomMenuTabScheme': {
      'oneOf': [
        {r'$ref': r'#/$defs/FavoritesTabScheme'},
        {r'$ref': r'#/$defs/RecentsTabScheme'},
        {r'$ref': r'#/$defs/ContactsTabScheme'},
        {r'$ref': r'#/$defs/KeypadTabScheme'},
        {r'$ref': r'#/$defs/MessagingTabScheme'},
        {r'$ref': r'#/$defs/VoicemailTabScheme'},
        {r'$ref': r'#/$defs/EmbeddedTabScheme'},
      ],
    },
    'FavoritesTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'favorites'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'RecentsTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'supportsCallHistory': {'type': 'boolean', 'default': true},
        'type': {'type': 'string', 'default': 'recents'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'ContactsTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'contactSourceTypes': {
          'type': 'array',
          'items': {'type': 'string'},
          'default': [],
        },
        'layout': {
          'enum': ['tabbed', 'unified'],
          'description':
              'How the section is arranged. A deployment that says nothing keeps the\narrangement it already has.\n\nRead leniently: a configurator may offer an arrangement before an\ninstalled app knows how to draw it, and such a build has to fall back\nto the one it does know rather than fail to read its own settings.',
          'default': 'tabbed',
        },
        'favorites': {
          'type': 'boolean',
          'description':
              "Whether the favourites are one of the lists the chooser offers.\n\nThe list behind that entry is the favourites section's own - the same\nrows, in the order a person arranged them - not this section's list\nnarrowed down. Read only where the arrangement has a chooser, which is\nthe unified one; on by default, because a deployment picking that\narrangement is picking the one favourites live in.",
          'default': true,
        },
        'type': {'type': 'string', 'default': 'contacts'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'KeypadTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'keypad'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'MessagingTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'messaging'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'VoicemailTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'voicemail'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'EmbeddedTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'embeddedResourceId': {'type': 'string'},
        'type': {'type': 'string', 'default': 'embedded'},
      },
      'required': ['titleL10n', 'icon', 'embeddedResourceId'],
    },
    'AppConfigBottomMenu': {
      'type': 'object',
      'properties': {
        'cacheSelectedTab': {'type': 'boolean', 'default': true},
        'tabs': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/BottomMenuTabScheme'},
          'default': [],
        },
      },
    },
    'AppConfigMain': {
      'type': 'object',
      'properties': {
        'bottomMenu': {r'$ref': r'#/$defs/AppConfigBottomMenu'},
        'systemNotificationsEnabled': {'type': 'boolean', 'default': true},
      },
    },
    'AppConfigSettingsItem': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'titleL10n': {'type': 'string'},
        'type': {'type': 'string'},
        'icon': {'type': 'string'},
        'iconColor': {'type': 'string'},
        'embeddedResourceId': {'type': 'string'},
      },
      'required': ['titleL10n', 'type', 'icon'],
    },
    'AppConfigSettingsSection': {
      'type': 'object',
      'properties': {
        'titleL10n': {'type': 'string'},
        'enabled': {'type': 'boolean', 'default': true},
        'items': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/AppConfigSettingsItem'},
          'default': [],
        },
      },
      'required': ['titleL10n'],
    },
    'AppConfigSettings': {
      'type': 'object',
      'properties': {
        'sections': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/AppConfigSettingsSection'},
        },
      },
    },
    'AppConfigTransfer': {
      'type': 'object',
      'properties': {
        'enableBlindTransfer': {'type': 'boolean', 'default': true},
        'enableAttendedTransfer': {'type': 'boolean', 'default': true},
      },
    },
    'EncodingDefaultPresetOverride': {
      'type': 'object',
      'properties': {
        'audioBitrate': {'type': 'integer'},
        'videoBitrate': {'type': 'integer'},
        'ptime': {'type': 'integer'},
        'maxptime': {'type': 'integer'},
        'opusSamplingRate': {'type': 'integer'},
        'opusBitrate': {'type': 'integer'},
        'opusStereo': {'type': 'boolean'},
        'opusDtx': {'type': 'boolean'},
        'removeStaticAudioRtpMaps': {'type': 'boolean'},
        'remapTE8payloadTo101': {'type': 'boolean'},
        'removeREMBFeedback': {'type': 'boolean'},
        'removeTWCCFeedback': {'type': 'boolean'},
        'removeExtmaps': {
          'type': 'array',
          'items': {'type': 'string'},
        },
      },
    },
    'AppConfigEncoding': {
      'type': 'object',
      'properties': {
        'bypassConfig': {'type': 'boolean', 'default': false},
        'defaultPresetOverride': {
          r'$ref': r'#/$defs/EncodingDefaultPresetOverride',
        },
      },
    },
    'AppConfigNegotiationSettingsOverride': {
      'type': 'object',
      'properties': {
        'includeInactiveVideoInOfferAnswer': {
          'type': 'boolean',
          'default': false,
        },
      },
    },
    'AppConfigPeerConnection': {
      'type': 'object',
      'properties': {
        'negotiation': {
          r'$ref': r'#/$defs/AppConfigNegotiationSettingsOverride',
        },
      },
    },
    'AppConfigCall': {
      'type': 'object',
      'properties': {
        'videoEnabled': {'type': 'boolean', 'default': true},
        'transfer': {r'$ref': r'#/$defs/AppConfigTransfer'},
        'encoding': {r'$ref': r'#/$defs/AppConfigEncoding'},
        'peerConnection': {r'$ref': r'#/$defs/AppConfigPeerConnection'},
      },
    },
    'AppConfigContactList': {'type': 'object', 'properties': {}},
    'AppConfigContactDetailsActions': {
      'type': 'object',
      'properties': {
        'appBar': {
          'type': 'array',
          'items': {'type': 'string'},
        },
        'phoneTile': {
          'type': 'array',
          'items': {'type': 'string'},
        },
        'emailTile': {
          'type': 'array',
          'items': {'type': 'string'},
        },
      },
    },
    'AppConfigContactDetails': {
      'type': 'object',
      'properties': {
        'actions': {r'$ref': r'#/$defs/AppConfigContactDetailsActions'},
      },
    },
    'AppConfigContacts': {
      'type': 'object',
      'properties': {
        'list': {r'$ref': r'#/$defs/AppConfigContactList'},
        'details': {r'$ref': r'#/$defs/AppConfigContactDetails'},
      },
    },
    'AppConfigSms': {'type': 'object', 'properties': {}},
    'ChatContactInfo': {
      'type': 'object',
      'properties': {
        'showVideoButtonAction': {'type': 'boolean', 'default': true},
      },
    },
    'AppConfigChats': {
      'type': 'object',
      'properties': {
        'groupChatButtonEnabled': {'type': 'boolean', 'default': true},
        'contactInfo': {r'$ref': r'#/$defs/ChatContactInfo'},
      },
    },
    'AppConfigMessaging': {
      'type': 'object',
      'properties': {
        'sms': {r'$ref': r'#/$defs/AppConfigSms'},
        'chats': {r'$ref': r'#/$defs/AppConfigChats'},
      },
    },
    'AppConfigLocalization': {
      'type': 'object',
      'properties': {
        'enabledLanguages': {
          'type': 'array',
          'items': {'type': 'string'},
          'description':
              'Allowlist of language codes (ISO 639-1, e.g. \'en\', \'it\') the app exposes.\nThe app intersects this with the locales it actually bundles, so only\nlanguages present in both are selectable and used for auto-resolution.\nAn empty list (the default) means "no restriction" - all bundled locales\nare available, preserving the previous behavior.',
          'default': [],
        },
      },
    },
    'SupportedFeature': {
      'oneOf': [
        {r'$ref': r'#/$defs/SupportedThemeMode'},
        {r'$ref': r'#/$defs/SupportedVideoCall'},
        {r'$ref': r'#/$defs/SupportedLoggingConfig'},
        {r'$ref': r'#/$defs/SupportedSystemNotifications'},
        {r'$ref': r'#/$defs/SupportedHybridPresence'},
        {r'$ref': r'#/$defs/SupportedCallPull'},
      ],
    },
    'SupportedThemeMode': {
      'type': 'object',
      'properties': {
        'mode': {
          'enum': ['system', 'light', 'dark'],
          'default': 'system',
        },
        'type': {'type': 'string', 'default': 'themeMode'},
      },
    },
    'SupportedVideoCall': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'type': {'type': 'string', 'default': 'videoCall'},
      },
    },
    'SupportedLoggingConfig': {
      'type': 'object',
      'properties': {
        'logLevel': {'type': 'string', 'default': 'INFO'},
        'checkIntervalSec': {'type': 'integer', 'default': 15},
        'anonymizationEnabled': {'type': 'boolean', 'default': true},
        'type': {'type': 'string', 'default': 'loggingConfig'},
      },
    },
    'SupportedSystemNotifications': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'type': {'type': 'string', 'default': 'systemNotifications'},
      },
    },
    'SupportedHybridPresence': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'type': {'type': 'string', 'default': 'hybridPresence'},
      },
    },
    'SupportedCallPull': {
      'type': 'object',
      'properties': {
        'videoStrategy': {'type': 'string', 'default': 'softMute'},
        'type': {'type': 'string', 'default': 'callPull'},
      },
    },
  },
};

AppConfigLogin _$AppConfigLoginFromJson(Map<String, dynamic> json) =>
    AppConfigLogin(
      common: json['common'] == null
          ? const AppConfigLoginCommon()
          : AppConfigLoginCommon.fromJson(
              json['common'] as Map<String, dynamic>,
            ),
      modeSelect: json['modeSelect'] == null
          ? const AppConfigLoginModeSelect()
          : AppConfigLoginModeSelect.fromJson(
              json['modeSelect'] as Map<String, dynamic>,
            ),
      signinOrder:
          (json['signinOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['passwordSignin', 'otpSignin', 'signup'],
      qr: json['qr'] == null
          ? const AppConfigLoginQr()
          : AppConfigLoginQr.fromJson(json['qr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppConfigLoginToJson(AppConfigLogin instance) =>
    <String, dynamic>{
      'common': instance.common.toJson(),
      'modeSelect': instance.modeSelect.toJson(),
      'signinOrder': instance.signinOrder,
      'qr': instance.qr.toJson(),
    };

const _$AppConfigLoginJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'common': {r'$ref': r'#/$defs/AppConfigLoginCommon'},
    'modeSelect': {r'$ref': r'#/$defs/AppConfigLoginModeSelect'},
    'signinOrder': {
      'type': 'array',
      'items': {'type': 'string'},
      'description':
          'Order of the sign-in tabs on the login switch screen, by login type name\n(passwordSignin, otpSignin, signup, qrSignin). Only the types advertised by\nthe backend are shown; this controls their order and which one is selected\nby default. Unknown or omitted names are placed last.',
      'default': ['passwordSignin', 'otpSignin', 'signup'],
    },
    'qr': {r'$ref': r'#/$defs/AppConfigLoginQr'},
  },
  r'$defs': {
    'AppConfigLoginCommon': {
      'type': 'object',
      'properties': {
        'fullScreenLaunchEmbeddedResourceId': {'type': 'string'},
      },
    },
    'AppConfigModeSelectAction': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean'},
        'type': {'type': 'string'},
        'titleL10n': {'type': 'string'},
        'embeddedId': {'type': 'string'},
      },
      'required': ['enabled', 'type', 'titleL10n'],
    },
    'AppConfigLoginModeSelect': {
      'type': 'object',
      'properties': {
        'greetingL10n': {'type': 'string'},
        'actions': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/AppConfigModeSelectAction'},
        },
      },
    },
    'AppConfigLoginQrFormat': {
      'type': 'object',
      'properties': {
        'type': {
          'type': 'string',
          'description': 'Decoder name (`uri`, `json`).',
        },
        'schemes': {
          'type': 'array',
          'items': {'type': 'string'},
          'description':
              '`uri` only: accepted scheme names, matched case-insensitively.',
        },
      },
      'required': ['type'],
    },
    'AppConfigLoginQr': {
      'type': 'object',
      'properties': {
        'enabled': {
          'type': 'boolean',
          'description': 'Whether the QR-code sign-in tab is available at all.',
          'default': false,
        },
        'formats': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/AppConfigLoginQrFormat'},
          'description':
              'Accepted payload formats with their per-format options, probed in this\norder.',
        },
        'expectedHost': {
          'type': 'string',
          'description':
              'Expected host (cloud id) of the code, shared by all formats. When set,\ncodes issued for a different host are rejected; null accepts any host.',
        },
      },
    },
  },
};

AppConfigLoginQr _$AppConfigLoginQrFromJson(Map<String, dynamic> json) =>
    AppConfigLoginQr(
      enabled: json['enabled'] as bool? ?? false,
      formats:
          (json['formats'] as List<dynamic>?)
              ?.map(
                (e) =>
                    AppConfigLoginQrFormat.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [
            AppConfigLoginQrFormat(type: 'uri', schemes: ['csc']),
            AppConfigLoginQrFormat(type: 'json'),
          ],
      expectedHost: json['expectedHost'] as String?,
    );

Map<String, dynamic> _$AppConfigLoginQrToJson(AppConfigLoginQr instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'formats': instance.formats.map((e) => e.toJson()).toList(),
      'expectedHost': instance.expectedHost,
    };

const _$AppConfigLoginQrJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {
      'type': 'boolean',
      'description': 'Whether the QR-code sign-in tab is available at all.',
      'default': false,
    },
    'formats': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/AppConfigLoginQrFormat'},
      'description':
          'Accepted payload formats with their per-format options, probed in this\norder.',
    },
    'expectedHost': {
      'type': 'string',
      'description':
          'Expected host (cloud id) of the code, shared by all formats. When set,\ncodes issued for a different host are rejected; null accepts any host.',
    },
  },
  r'$defs': {
    'AppConfigLoginQrFormat': {
      'type': 'object',
      'properties': {
        'type': {
          'type': 'string',
          'description': 'Decoder name (`uri`, `json`).',
        },
        'schemes': {
          'type': 'array',
          'items': {'type': 'string'},
          'description':
              '`uri` only: accepted scheme names, matched case-insensitively.',
        },
      },
      'required': ['type'],
    },
  },
};

AppConfigLoginQrFormat _$AppConfigLoginQrFormatFromJson(
  Map<String, dynamic> json,
) => AppConfigLoginQrFormat(
  type: json['type'] as String,
  schemes: (json['schemes'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$AppConfigLoginQrFormatToJson(
  AppConfigLoginQrFormat instance,
) => <String, dynamic>{'type': instance.type, 'schemes': instance.schemes};

const _$AppConfigLoginQrFormatJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'type': {'type': 'string', 'description': 'Decoder name (`uri`, `json`).'},
    'schemes': {
      'type': 'array',
      'items': {'type': 'string'},
      'description':
          '`uri` only: accepted scheme names, matched case-insensitively.',
    },
  },
  'required': ['type'],
};

AppConfigLoginCommon _$AppConfigLoginCommonFromJson(
  Map<String, dynamic> json,
) => AppConfigLoginCommon(
  fullScreenLaunchEmbeddedResourceId:
      json['fullScreenLaunchEmbeddedResourceId'] as String?,
);

Map<String, dynamic> _$AppConfigLoginCommonToJson(
  AppConfigLoginCommon instance,
) => <String, dynamic>{
  'fullScreenLaunchEmbeddedResourceId':
      instance.fullScreenLaunchEmbeddedResourceId,
};

const _$AppConfigLoginCommonJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'fullScreenLaunchEmbeddedResourceId': {'type': 'string'},
  },
};

AppConfigLoginModeSelect _$AppConfigLoginModeSelectFromJson(
  Map<String, dynamic> json,
) => AppConfigLoginModeSelect(
  greetingL10n: json['greetingL10n'] as String?,
  actions:
      (json['actions'] as List<dynamic>?)
          ?.map(
            (e) =>
                AppConfigModeSelectAction.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [
        AppConfigModeSelectAction(
          enabled: true,
          type: 'login',
          titleL10n: 'login_Button_signUpToDemoInstance',
        ),
      ],
);

Map<String, dynamic> _$AppConfigLoginModeSelectToJson(
  AppConfigLoginModeSelect instance,
) => <String, dynamic>{
  'greetingL10n': instance.greetingL10n,
  'actions': instance.actions.map((e) => e.toJson()).toList(),
};

const _$AppConfigLoginModeSelectJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'greetingL10n': {'type': 'string'},
    'actions': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/AppConfigModeSelectAction'},
    },
  },
  r'$defs': {
    'AppConfigModeSelectAction': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean'},
        'type': {'type': 'string'},
        'titleL10n': {'type': 'string'},
        'embeddedId': {'type': 'string'},
      },
      'required': ['enabled', 'type', 'titleL10n'],
    },
  },
};

AppConfigModeSelectAction _$AppConfigModeSelectActionFromJson(
  Map<String, dynamic> json,
) => AppConfigModeSelectAction(
  enabled: json['enabled'] as bool,
  type: json['type'] as String,
  titleL10n: json['titleL10n'] as String,
  embeddedId: json['embeddedId'] as String?,
);

Map<String, dynamic> _$AppConfigModeSelectActionToJson(
  AppConfigModeSelectAction instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'type': instance.type,
  'titleL10n': instance.titleL10n,
  'embeddedId': instance.embeddedId,
};

const _$AppConfigModeSelectActionJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean'},
    'type': {'type': 'string'},
    'titleL10n': {'type': 'string'},
    'embeddedId': {'type': 'string'},
  },
  'required': ['enabled', 'type', 'titleL10n'],
};

AppConfigMain _$AppConfigMainFromJson(Map<String, dynamic> json) =>
    AppConfigMain(
      bottomMenu: json['bottomMenu'] == null
          ? const AppConfigBottomMenu(
              cacheSelectedTab: true,
              tabs: [
                FavoritesTabScheme(
                  enabled: true,
                  initial: false,
                  titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
                  icon: '0xe5fd',
                ),
                RecentsTabScheme(
                  enabled: false,
                  initial: false,
                  titleL10n: 'main_BottomNavigationBarItemLabel_recents',
                  icon: '0xe03a',
                  supportsCallHistory: true,
                ),
                ContactsTabScheme(
                  enabled: true,
                  initial: false,
                  titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
                  icon: '0xee35',
                  contactSourceTypes: ['local', 'external'],
                ),
                KeypadTabScheme(
                  enabled: true,
                  initial: true,
                  titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
                  icon: '0xe1ce',
                ),
                MessagingTabScheme(
                  enabled: false,
                  initial: false,
                  titleL10n: 'main_BottomNavigationBarItemLabel_chats',
                  icon: '0xe155',
                ),
              ],
            )
          : AppConfigBottomMenu.fromJson(
              json['bottomMenu'] as Map<String, dynamic>,
            ),
      systemNotificationsEnabled:
          json['systemNotificationsEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$AppConfigMainToJson(AppConfigMain instance) =>
    <String, dynamic>{
      'bottomMenu': instance.bottomMenu.toJson(),
      'systemNotificationsEnabled': instance.systemNotificationsEnabled,
    };

const _$AppConfigMainJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'bottomMenu': {r'$ref': r'#/$defs/AppConfigBottomMenu'},
    'systemNotificationsEnabled': {'type': 'boolean', 'default': true},
  },
  r'$defs': {
    'BottomMenuTabScheme': {
      'oneOf': [
        {r'$ref': r'#/$defs/FavoritesTabScheme'},
        {r'$ref': r'#/$defs/RecentsTabScheme'},
        {r'$ref': r'#/$defs/ContactsTabScheme'},
        {r'$ref': r'#/$defs/KeypadTabScheme'},
        {r'$ref': r'#/$defs/MessagingTabScheme'},
        {r'$ref': r'#/$defs/VoicemailTabScheme'},
        {r'$ref': r'#/$defs/EmbeddedTabScheme'},
      ],
    },
    'FavoritesTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'favorites'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'RecentsTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'supportsCallHistory': {'type': 'boolean', 'default': true},
        'type': {'type': 'string', 'default': 'recents'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'ContactsTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'contactSourceTypes': {
          'type': 'array',
          'items': {'type': 'string'},
          'default': [],
        },
        'layout': {
          'enum': ['tabbed', 'unified'],
          'description':
              'How the section is arranged. A deployment that says nothing keeps the\narrangement it already has.\n\nRead leniently: a configurator may offer an arrangement before an\ninstalled app knows how to draw it, and such a build has to fall back\nto the one it does know rather than fail to read its own settings.',
          'default': 'tabbed',
        },
        'favorites': {
          'type': 'boolean',
          'description':
              "Whether the favourites are one of the lists the chooser offers.\n\nThe list behind that entry is the favourites section's own - the same\nrows, in the order a person arranged them - not this section's list\nnarrowed down. Read only where the arrangement has a chooser, which is\nthe unified one; on by default, because a deployment picking that\narrangement is picking the one favourites live in.",
          'default': true,
        },
        'type': {'type': 'string', 'default': 'contacts'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'KeypadTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'keypad'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'MessagingTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'messaging'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'VoicemailTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'voicemail'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'EmbeddedTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'embeddedResourceId': {'type': 'string'},
        'type': {'type': 'string', 'default': 'embedded'},
      },
      'required': ['titleL10n', 'icon', 'embeddedResourceId'],
    },
    'AppConfigBottomMenu': {
      'type': 'object',
      'properties': {
        'cacheSelectedTab': {'type': 'boolean', 'default': true},
        'tabs': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/BottomMenuTabScheme'},
          'default': [],
        },
      },
    },
  },
};

AppConfigBottomMenu _$AppConfigBottomMenuFromJson(Map<String, dynamic> json) =>
    AppConfigBottomMenu(
      cacheSelectedTab: json['cacheSelectedTab'] as bool? ?? true,
      tabs:
          (json['tabs'] as List<dynamic>?)
              ?.map(
                (e) => BottomMenuTabScheme.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AppConfigBottomMenuToJson(
  AppConfigBottomMenu instance,
) => <String, dynamic>{
  'cacheSelectedTab': instance.cacheSelectedTab,
  'tabs': instance.tabs.map((e) => e.toJson()).toList(),
};

const _$AppConfigBottomMenuJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'cacheSelectedTab': {'type': 'boolean', 'default': true},
    'tabs': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/BottomMenuTabScheme'},
      'default': [],
    },
  },
  r'$defs': {
    'BottomMenuTabScheme': {
      'oneOf': [
        {r'$ref': r'#/$defs/FavoritesTabScheme'},
        {r'$ref': r'#/$defs/RecentsTabScheme'},
        {r'$ref': r'#/$defs/ContactsTabScheme'},
        {r'$ref': r'#/$defs/KeypadTabScheme'},
        {r'$ref': r'#/$defs/MessagingTabScheme'},
        {r'$ref': r'#/$defs/VoicemailTabScheme'},
        {r'$ref': r'#/$defs/EmbeddedTabScheme'},
      ],
    },
    'FavoritesTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'favorites'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'RecentsTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'supportsCallHistory': {'type': 'boolean', 'default': true},
        'type': {'type': 'string', 'default': 'recents'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'ContactsTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'contactSourceTypes': {
          'type': 'array',
          'items': {'type': 'string'},
          'default': [],
        },
        'layout': {
          'enum': ['tabbed', 'unified'],
          'description':
              'How the section is arranged. A deployment that says nothing keeps the\narrangement it already has.\n\nRead leniently: a configurator may offer an arrangement before an\ninstalled app knows how to draw it, and such a build has to fall back\nto the one it does know rather than fail to read its own settings.',
          'default': 'tabbed',
        },
        'favorites': {
          'type': 'boolean',
          'description':
              "Whether the favourites are one of the lists the chooser offers.\n\nThe list behind that entry is the favourites section's own - the same\nrows, in the order a person arranged them - not this section's list\nnarrowed down. Read only where the arrangement has a chooser, which is\nthe unified one; on by default, because a deployment picking that\narrangement is picking the one favourites live in.",
          'default': true,
        },
        'type': {'type': 'string', 'default': 'contacts'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'KeypadTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'keypad'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'MessagingTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'messaging'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'VoicemailTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'type': {'type': 'string', 'default': 'voicemail'},
      },
      'required': ['titleL10n', 'icon'],
    },
    'EmbeddedTabScheme': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'initial': {'type': 'boolean', 'default': false},
        'titleL10n': {'type': 'string'},
        'icon': {'type': 'string'},
        'embeddedResourceId': {'type': 'string'},
        'type': {'type': 'string', 'default': 'embedded'},
      },
      'required': ['titleL10n', 'icon', 'embeddedResourceId'],
    },
  },
};

AppConfigCall _$AppConfigCallFromJson(
  Map<String, dynamic> json,
) => AppConfigCall(
  videoEnabled: json['videoEnabled'] as bool? ?? true,
  transfer: json['transfer'] == null
      ? const AppConfigTransfer(
          enableBlindTransfer: true,
          enableAttendedTransfer: true,
        )
      : AppConfigTransfer.fromJson(json['transfer'] as Map<String, dynamic>),
  encoding: json['encoding'] == null
      ? const AppConfigEncoding()
      : AppConfigEncoding.fromJson(json['encoding'] as Map<String, dynamic>),
  peerConnection: json['peerConnection'] == null
      ? const AppConfigPeerConnection()
      : AppConfigPeerConnection.fromJson(
          json['peerConnection'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AppConfigCallToJson(AppConfigCall instance) =>
    <String, dynamic>{
      'videoEnabled': instance.videoEnabled,
      'transfer': instance.transfer.toJson(),
      'encoding': instance.encoding.toJson(),
      'peerConnection': instance.peerConnection.toJson(),
    };

const _$AppConfigCallJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'videoEnabled': {'type': 'boolean', 'default': true},
    'transfer': {r'$ref': r'#/$defs/AppConfigTransfer'},
    'encoding': {r'$ref': r'#/$defs/AppConfigEncoding'},
    'peerConnection': {r'$ref': r'#/$defs/AppConfigPeerConnection'},
  },
  r'$defs': {
    'AppConfigTransfer': {
      'type': 'object',
      'properties': {
        'enableBlindTransfer': {'type': 'boolean', 'default': true},
        'enableAttendedTransfer': {'type': 'boolean', 'default': true},
      },
    },
    'EncodingDefaultPresetOverride': {
      'type': 'object',
      'properties': {
        'audioBitrate': {'type': 'integer'},
        'videoBitrate': {'type': 'integer'},
        'ptime': {'type': 'integer'},
        'maxptime': {'type': 'integer'},
        'opusSamplingRate': {'type': 'integer'},
        'opusBitrate': {'type': 'integer'},
        'opusStereo': {'type': 'boolean'},
        'opusDtx': {'type': 'boolean'},
        'removeStaticAudioRtpMaps': {'type': 'boolean'},
        'remapTE8payloadTo101': {'type': 'boolean'},
        'removeREMBFeedback': {'type': 'boolean'},
        'removeTWCCFeedback': {'type': 'boolean'},
        'removeExtmaps': {
          'type': 'array',
          'items': {'type': 'string'},
        },
      },
    },
    'AppConfigEncoding': {
      'type': 'object',
      'properties': {
        'bypassConfig': {'type': 'boolean', 'default': false},
        'defaultPresetOverride': {
          r'$ref': r'#/$defs/EncodingDefaultPresetOverride',
        },
      },
    },
    'AppConfigNegotiationSettingsOverride': {
      'type': 'object',
      'properties': {
        'includeInactiveVideoInOfferAnswer': {
          'type': 'boolean',
          'default': false,
        },
      },
    },
    'AppConfigPeerConnection': {
      'type': 'object',
      'properties': {
        'negotiation': {
          r'$ref': r'#/$defs/AppConfigNegotiationSettingsOverride',
        },
      },
    },
  },
};

AppConfigTransfer _$AppConfigTransferFromJson(Map<String, dynamic> json) =>
    AppConfigTransfer(
      enableBlindTransfer: json['enableBlindTransfer'] as bool? ?? true,
      enableAttendedTransfer: json['enableAttendedTransfer'] as bool? ?? true,
    );

Map<String, dynamic> _$AppConfigTransferToJson(AppConfigTransfer instance) =>
    <String, dynamic>{
      'enableBlindTransfer': instance.enableBlindTransfer,
      'enableAttendedTransfer': instance.enableAttendedTransfer,
    };

const _$AppConfigTransferJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enableBlindTransfer': {'type': 'boolean', 'default': true},
    'enableAttendedTransfer': {'type': 'boolean', 'default': true},
  },
};

AppConfigEncoding _$AppConfigEncodingFromJson(Map<String, dynamic> json) =>
    AppConfigEncoding(
      bypassConfig: json['bypassConfig'] as bool? ?? false,
      defaultPresetOverride: json['defaultPresetOverride'] == null
          ? const EncodingDefaultPresetOverride()
          : EncodingDefaultPresetOverride.fromJson(
              json['defaultPresetOverride'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AppConfigEncodingToJson(AppConfigEncoding instance) =>
    <String, dynamic>{
      'bypassConfig': instance.bypassConfig,
      'defaultPresetOverride': instance.defaultPresetOverride.toJson(),
    };

const _$AppConfigEncodingJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'bypassConfig': {'type': 'boolean', 'default': false},
    'defaultPresetOverride': {
      r'$ref': r'#/$defs/EncodingDefaultPresetOverride',
    },
  },
  r'$defs': {
    'EncodingDefaultPresetOverride': {
      'type': 'object',
      'properties': {
        'audioBitrate': {'type': 'integer'},
        'videoBitrate': {'type': 'integer'},
        'ptime': {'type': 'integer'},
        'maxptime': {'type': 'integer'},
        'opusSamplingRate': {'type': 'integer'},
        'opusBitrate': {'type': 'integer'},
        'opusStereo': {'type': 'boolean'},
        'opusDtx': {'type': 'boolean'},
        'removeStaticAudioRtpMaps': {'type': 'boolean'},
        'remapTE8payloadTo101': {'type': 'boolean'},
        'removeREMBFeedback': {'type': 'boolean'},
        'removeTWCCFeedback': {'type': 'boolean'},
        'removeExtmaps': {
          'type': 'array',
          'items': {'type': 'string'},
        },
      },
    },
  },
};

AppConfigPeerConnection _$AppConfigPeerConnectionFromJson(
  Map<String, dynamic> json,
) => AppConfigPeerConnection(
  negotiation: json['negotiation'] == null
      ? const AppConfigNegotiationSettingsOverride()
      : AppConfigNegotiationSettingsOverride.fromJson(
          json['negotiation'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AppConfigPeerConnectionToJson(
  AppConfigPeerConnection instance,
) => <String, dynamic>{'negotiation': instance.negotiation.toJson()};

const _$AppConfigPeerConnectionJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'negotiation': {r'$ref': r'#/$defs/AppConfigNegotiationSettingsOverride'},
  },
  r'$defs': {
    'AppConfigNegotiationSettingsOverride': {
      'type': 'object',
      'properties': {
        'includeInactiveVideoInOfferAnswer': {
          'type': 'boolean',
          'default': false,
        },
      },
    },
  },
};

AppConfigNegotiationSettingsOverride
_$AppConfigNegotiationSettingsOverrideFromJson(Map<String, dynamic> json) =>
    AppConfigNegotiationSettingsOverride(
      includeInactiveVideoInOfferAnswer:
          json['includeInactiveVideoInOfferAnswer'] as bool? ?? false,
    );

Map<String, dynamic> _$AppConfigNegotiationSettingsOverrideToJson(
  AppConfigNegotiationSettingsOverride instance,
) => <String, dynamic>{
  'includeInactiveVideoInOfferAnswer':
      instance.includeInactiveVideoInOfferAnswer,
};

const _$AppConfigNegotiationSettingsOverrideJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'includeInactiveVideoInOfferAnswer': {'type': 'boolean', 'default': false},
  },
};

EncodingDefaultPresetOverride _$EncodingDefaultPresetOverrideFromJson(
  Map<String, dynamic> json,
) => EncodingDefaultPresetOverride(
  audioBitrate: (json['audioBitrate'] as num?)?.toInt(),
  videoBitrate: (json['videoBitrate'] as num?)?.toInt(),
  ptime: (json['ptime'] as num?)?.toInt(),
  maxptime: (json['maxptime'] as num?)?.toInt(),
  opusSamplingRate: (json['opusSamplingRate'] as num?)?.toInt(),
  opusBitrate: (json['opusBitrate'] as num?)?.toInt(),
  opusStereo: json['opusStereo'] as bool?,
  opusDtx: json['opusDtx'] as bool?,
  removeStaticAudioRtpMaps: json['removeStaticAudioRtpMaps'] as bool?,
  remapTE8payloadTo101: json['remapTE8payloadTo101'] as bool?,
  removeREMBFeedback: json['removeREMBFeedback'] as bool?,
  removeTWCCFeedback: json['removeTWCCFeedback'] as bool?,
  removeExtmaps: (json['removeExtmaps'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$EncodingDefaultPresetOverrideToJson(
  EncodingDefaultPresetOverride instance,
) => <String, dynamic>{
  'audioBitrate': instance.audioBitrate,
  'videoBitrate': instance.videoBitrate,
  'ptime': instance.ptime,
  'maxptime': instance.maxptime,
  'opusSamplingRate': instance.opusSamplingRate,
  'opusBitrate': instance.opusBitrate,
  'opusStereo': instance.opusStereo,
  'opusDtx': instance.opusDtx,
  'removeStaticAudioRtpMaps': instance.removeStaticAudioRtpMaps,
  'remapTE8payloadTo101': instance.remapTE8payloadTo101,
  'removeREMBFeedback': instance.removeREMBFeedback,
  'removeTWCCFeedback': instance.removeTWCCFeedback,
  'removeExtmaps': instance.removeExtmaps,
};

const _$EncodingDefaultPresetOverrideJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'audioBitrate': {'type': 'integer'},
    'videoBitrate': {'type': 'integer'},
    'ptime': {'type': 'integer'},
    'maxptime': {'type': 'integer'},
    'opusSamplingRate': {'type': 'integer'},
    'opusBitrate': {'type': 'integer'},
    'opusStereo': {'type': 'boolean'},
    'opusDtx': {'type': 'boolean'},
    'removeStaticAudioRtpMaps': {'type': 'boolean'},
    'remapTE8payloadTo101': {'type': 'boolean'},
    'removeREMBFeedback': {'type': 'boolean'},
    'removeTWCCFeedback': {'type': 'boolean'},
    'removeExtmaps': {
      'type': 'array',
      'items': {'type': 'string'},
    },
  },
};

AppConfigSettings _$AppConfigSettingsFromJson(Map<String, dynamic> json) =>
    AppConfigSettings(
      sections:
          (json['sections'] as List<dynamic>?)
              ?.map(
                (e) => AppConfigSettingsSection.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [
            AppConfigSettingsSection(
              titleL10n: 'settings_ListViewTileTitle_settings',
              enabled: true,
              items: [
                AppConfigSettingsItem(
                  enabled: true,
                  type: 'network',
                  titleL10n: 'settings_ListViewTileTitle_network',
                  icon: '0xe424',
                ),
                AppConfigSettingsItem(
                  enabled: true,
                  type: 'mediaSettings',
                  titleL10n: 'settings_ListViewTileTitle_mediaSettings',
                  icon: '0xf1cf',
                ),
                AppConfigSettingsItem(
                  enabled: true,
                  type: 'language',
                  titleL10n: 'settings_ListViewTileTitle_language',
                  icon: '0xe366',
                ),
                AppConfigSettingsItem(
                  enabled: true,
                  type: 'terms',
                  titleL10n: 'settings_ListViewTileTitle_termsConditions',
                  icon: '0xeedf',
                ),
                AppConfigSettingsItem(
                  enabled: true,
                  type: 'about',
                  titleL10n: 'settings_ListViewTileTitle_about',
                  icon: '0xe140',
                ),
              ],
            ),
            AppConfigSettingsSection(
              titleL10n: 'settings_ListViewTileTitle_toolbox',
              enabled: true,
              items: [
                AppConfigSettingsItem(
                  enabled: true,
                  type: 'log',
                  titleL10n: 'settings_ListViewTileTitle_logRecordsConsole',
                  icon: '0xee79',
                ),
              ],
            ),
          ],
    );

Map<String, dynamic> _$AppConfigSettingsToJson(AppConfigSettings instance) =>
    <String, dynamic>{
      'sections': instance.sections.map((e) => e.toJson()).toList(),
    };

const _$AppConfigSettingsJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'sections': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/AppConfigSettingsSection'},
    },
  },
  r'$defs': {
    'AppConfigSettingsItem': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'titleL10n': {'type': 'string'},
        'type': {'type': 'string'},
        'icon': {'type': 'string'},
        'iconColor': {'type': 'string'},
        'embeddedResourceId': {'type': 'string'},
      },
      'required': ['titleL10n', 'type', 'icon'],
    },
    'AppConfigSettingsSection': {
      'type': 'object',
      'properties': {
        'titleL10n': {'type': 'string'},
        'enabled': {'type': 'boolean', 'default': true},
        'items': {
          'type': 'array',
          'items': {r'$ref': r'#/$defs/AppConfigSettingsItem'},
          'default': [],
        },
      },
      'required': ['titleL10n'],
    },
  },
};

AppConfigSettingsSection _$AppConfigSettingsSectionFromJson(
  Map<String, dynamic> json,
) => AppConfigSettingsSection(
  titleL10n: json['titleL10n'] as String,
  enabled: json['enabled'] as bool? ?? true,
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => AppConfigSettingsItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$AppConfigSettingsSectionToJson(
  AppConfigSettingsSection instance,
) => <String, dynamic>{
  'titleL10n': instance.titleL10n,
  'enabled': instance.enabled,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

const _$AppConfigSettingsSectionJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'titleL10n': {'type': 'string'},
    'enabled': {'type': 'boolean', 'default': true},
    'items': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/AppConfigSettingsItem'},
      'default': [],
    },
  },
  'required': ['titleL10n'],
  r'$defs': {
    'AppConfigSettingsItem': {
      'type': 'object',
      'properties': {
        'enabled': {'type': 'boolean', 'default': true},
        'titleL10n': {'type': 'string'},
        'type': {'type': 'string'},
        'icon': {'type': 'string'},
        'iconColor': {'type': 'string'},
        'embeddedResourceId': {'type': 'string'},
      },
      'required': ['titleL10n', 'type', 'icon'],
    },
  },
};

AppConfigSettingsItem _$AppConfigSettingsItemFromJson(
  Map<String, dynamic> json,
) => AppConfigSettingsItem(
  enabled: json['enabled'] as bool? ?? true,
  titleL10n: json['titleL10n'] as String,
  type: json['type'] as String,
  icon: json['icon'] as String,
  iconColor: json['iconColor'] as String?,
  embeddedResourceId: const IntToStringOptionalConverter().fromJson(
    json['embeddedResourceId'],
  ),
);

Map<String, dynamic> _$AppConfigSettingsItemToJson(
  AppConfigSettingsItem instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'titleL10n': instance.titleL10n,
  'type': instance.type,
  'icon': instance.icon,
  'iconColor': instance.iconColor,
  'embeddedResourceId': const IntToStringOptionalConverter().toJson(
    instance.embeddedResourceId,
  ),
};

const _$AppConfigSettingsItemJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'titleL10n': {'type': 'string'},
    'type': {'type': 'string'},
    'icon': {'type': 'string'},
    'iconColor': {'type': 'string'},
    'embeddedResourceId': {'type': 'string'},
  },
  'required': ['titleL10n', 'type', 'icon'],
};

AppConfigContacts _$AppConfigContactsFromJson(Map<String, dynamic> json) =>
    AppConfigContacts(
      list: json['list'] == null
          ? const AppConfigContactList()
          : AppConfigContactList.fromJson(json['list'] as Map<String, dynamic>),
      details: json['details'] == null
          ? const AppConfigContactDetails()
          : AppConfigContactDetails.fromJson(
              json['details'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AppConfigContactsToJson(AppConfigContacts instance) =>
    <String, dynamic>{
      'list': instance.list.toJson(),
      'details': instance.details.toJson(),
    };

const _$AppConfigContactsJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'list': {r'$ref': r'#/$defs/AppConfigContactList'},
    'details': {r'$ref': r'#/$defs/AppConfigContactDetails'},
  },
  r'$defs': {
    'AppConfigContactList': {'type': 'object', 'properties': {}},
    'AppConfigContactDetailsActions': {
      'type': 'object',
      'properties': {
        'appBar': {
          'type': 'array',
          'items': {'type': 'string'},
        },
        'phoneTile': {
          'type': 'array',
          'items': {'type': 'string'},
        },
        'emailTile': {
          'type': 'array',
          'items': {'type': 'string'},
        },
      },
    },
    'AppConfigContactDetails': {
      'type': 'object',
      'properties': {
        'actions': {r'$ref': r'#/$defs/AppConfigContactDetailsActions'},
      },
    },
  },
};

AppConfigContactList _$AppConfigContactListFromJson(
  Map<String, dynamic> json,
) => AppConfigContactList();

Map<String, dynamic> _$AppConfigContactListToJson(
  AppConfigContactList instance,
) => <String, dynamic>{};

const _$AppConfigContactListJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {},
};

AppConfigContactDetails _$AppConfigContactDetailsFromJson(
  Map<String, dynamic> json,
) => AppConfigContactDetails(
  actions: json['actions'] == null
      ? const AppConfigContactDetailsActions()
      : AppConfigContactDetailsActions.fromJson(
          json['actions'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AppConfigContactDetailsToJson(
  AppConfigContactDetails instance,
) => <String, dynamic>{'actions': instance.actions.toJson()};

const _$AppConfigContactDetailsJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'actions': {r'$ref': r'#/$defs/AppConfigContactDetailsActions'},
  },
  r'$defs': {
    'AppConfigContactDetailsActions': {
      'type': 'object',
      'properties': {
        'appBar': {
          'type': 'array',
          'items': {'type': 'string'},
        },
        'phoneTile': {
          'type': 'array',
          'items': {'type': 'string'},
        },
        'emailTile': {
          'type': 'array',
          'items': {'type': 'string'},
        },
      },
    },
  },
};

AppConfigContactDetailsActions _$AppConfigContactDetailsActionsFromJson(
  Map<String, dynamic> json,
) => AppConfigContactDetailsActions(
  appBar: (json['appBar'] as List<dynamic>?)?.map((e) => e as String).toList(),
  phoneTile: (json['phoneTile'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  emailTile: (json['emailTile'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$AppConfigContactDetailsActionsToJson(
  AppConfigContactDetailsActions instance,
) => <String, dynamic>{
  'appBar': instance.appBar,
  'phoneTile': instance.phoneTile,
  'emailTile': instance.emailTile,
};

const _$AppConfigContactDetailsActionsJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'appBar': {
      'type': 'array',
      'items': {'type': 'string'},
    },
    'phoneTile': {
      'type': 'array',
      'items': {'type': 'string'},
    },
    'emailTile': {
      'type': 'array',
      'items': {'type': 'string'},
    },
  },
};

AppConfigMessaging _$AppConfigMessagingFromJson(Map<String, dynamic> json) =>
    AppConfigMessaging(
      sms: json['sms'] == null
          ? const AppConfigSms()
          : AppConfigSms.fromJson(json['sms'] as Map<String, dynamic>),
      chats: json['chats'] == null
          ? const AppConfigChats()
          : AppConfigChats.fromJson(json['chats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppConfigMessagingToJson(AppConfigMessaging instance) =>
    <String, dynamic>{
      'sms': instance.sms.toJson(),
      'chats': instance.chats.toJson(),
    };

const _$AppConfigMessagingJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'sms': {r'$ref': r'#/$defs/AppConfigSms'},
    'chats': {r'$ref': r'#/$defs/AppConfigChats'},
  },
  r'$defs': {
    'AppConfigSms': {'type': 'object', 'properties': {}},
    'ChatContactInfo': {
      'type': 'object',
      'properties': {
        'showVideoButtonAction': {'type': 'boolean', 'default': true},
      },
    },
    'AppConfigChats': {
      'type': 'object',
      'properties': {
        'groupChatButtonEnabled': {'type': 'boolean', 'default': true},
        'contactInfo': {r'$ref': r'#/$defs/ChatContactInfo'},
      },
    },
  },
};

AppConfigSms _$AppConfigSmsFromJson(Map<String, dynamic> json) =>
    AppConfigSms();

Map<String, dynamic> _$AppConfigSmsToJson(AppConfigSms instance) =>
    <String, dynamic>{};

const _$AppConfigSmsJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {},
};

AppConfigChats _$AppConfigChatsFromJson(Map<String, dynamic> json) =>
    AppConfigChats(
      groupChatButtonEnabled: json['groupChatButtonEnabled'] as bool? ?? true,
      contactInfo: json['contactInfo'] == null
          ? const ChatContactInfo()
          : ChatContactInfo.fromJson(
              json['contactInfo'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AppConfigChatsToJson(AppConfigChats instance) =>
    <String, dynamic>{
      'groupChatButtonEnabled': instance.groupChatButtonEnabled,
      'contactInfo': instance.contactInfo.toJson(),
    };

const _$AppConfigChatsJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'groupChatButtonEnabled': {'type': 'boolean', 'default': true},
    'contactInfo': {r'$ref': r'#/$defs/ChatContactInfo'},
  },
  r'$defs': {
    'ChatContactInfo': {
      'type': 'object',
      'properties': {
        'showVideoButtonAction': {'type': 'boolean', 'default': true},
      },
    },
  },
};

ChatContactInfo _$ChatContactInfoFromJson(Map<String, dynamic> json) =>
    ChatContactInfo(
      showVideoButtonAction: json['showVideoButtonAction'] as bool? ?? true,
    );

Map<String, dynamic> _$ChatContactInfoToJson(ChatContactInfo instance) =>
    <String, dynamic>{'showVideoButtonAction': instance.showVideoButtonAction};

const _$ChatContactInfoJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'showVideoButtonAction': {'type': 'boolean', 'default': true},
  },
};

AppConfigLocalization _$AppConfigLocalizationFromJson(
  Map<String, dynamic> json,
) => AppConfigLocalization(
  enabledLanguages:
      (json['enabledLanguages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$AppConfigLocalizationToJson(
  AppConfigLocalization instance,
) => <String, dynamic>{'enabledLanguages': instance.enabledLanguages};

const _$AppConfigLocalizationJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabledLanguages': {
      'type': 'array',
      'items': {'type': 'string'},
      'description':
          'Allowlist of language codes (ISO 639-1, e.g. \'en\', \'it\') the app exposes.\nThe app intersects this with the locales it actually bundles, so only\nlanguages present in both are selectable and used for auto-resolution.\nAn empty list (the default) means "no restriction" - all bundled locales\nare available, preserving the previous behavior.',
      'default': [],
    },
  },
};

FavoritesTabScheme _$FavoritesTabSchemeFromJson(Map<String, dynamic> json) =>
    FavoritesTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      type: json['type'] as String? ?? 'favorites',
    );

Map<String, dynamic> _$FavoritesTabSchemeToJson(FavoritesTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'type': instance.type,
    };

const _$FavoritesTabSchemeJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'initial': {'type': 'boolean', 'default': false},
    'titleL10n': {'type': 'string'},
    'icon': {'type': 'string'},
    'type': {'type': 'string', 'default': 'favorites'},
  },
  'required': ['titleL10n', 'icon'],
};

RecentsTabScheme _$RecentsTabSchemeFromJson(Map<String, dynamic> json) =>
    RecentsTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      supportsCallHistory:
          _readRecentsSupportsCallHistory(json, 'supportsCallHistory')
              as bool? ??
          true,
      type: json['type'] as String? ?? 'recents',
    );

Map<String, dynamic> _$RecentsTabSchemeToJson(RecentsTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'supportsCallHistory': instance.supportsCallHistory,
      'type': instance.type,
    };

const _$RecentsTabSchemeJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'initial': {'type': 'boolean', 'default': false},
    'titleL10n': {'type': 'string'},
    'icon': {'type': 'string'},
    'supportsCallHistory': {'type': 'boolean', 'default': true},
    'type': {'type': 'string', 'default': 'recents'},
  },
  'required': ['titleL10n', 'icon'],
};

ContactsTabScheme _$ContactsTabSchemeFromJson(Map<String, dynamic> json) =>
    ContactsTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      contactSourceTypes:
          (json['contactSourceTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      layout:
          $enumDecodeNullable(
            _$ContactsLayoutSchemeEnumMap,
            json['layout'],
            unknownValue: ContactsLayoutScheme.tabbed,
          ) ??
          ContactsLayoutScheme.tabbed,
      favorites: json['favorites'] as bool? ?? true,
      type: json['type'] as String? ?? 'contacts',
    );

Map<String, dynamic> _$ContactsTabSchemeToJson(ContactsTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'contactSourceTypes': instance.contactSourceTypes,
      'layout': _$ContactsLayoutSchemeEnumMap[instance.layout]!,
      'favorites': instance.favorites,
      'type': instance.type,
    };

const _$ContactsTabSchemeJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'initial': {'type': 'boolean', 'default': false},
    'titleL10n': {'type': 'string'},
    'icon': {'type': 'string'},
    'contactSourceTypes': {
      'type': 'array',
      'items': {'type': 'string'},
      'default': [],
    },
    'layout': {
      'enum': ['tabbed', 'unified'],
      'description':
          'How the section is arranged. A deployment that says nothing keeps the\narrangement it already has.\n\nRead leniently: a configurator may offer an arrangement before an\ninstalled app knows how to draw it, and such a build has to fall back\nto the one it does know rather than fail to read its own settings.',
      'default': 'tabbed',
    },
    'favorites': {
      'type': 'boolean',
      'description':
          "Whether the favourites are one of the lists the chooser offers.\n\nThe list behind that entry is the favourites section's own - the same\nrows, in the order a person arranged them - not this section's list\nnarrowed down. Read only where the arrangement has a chooser, which is\nthe unified one; on by default, because a deployment picking that\narrangement is picking the one favourites live in.",
      'default': true,
    },
    'type': {'type': 'string', 'default': 'contacts'},
  },
  'required': ['titleL10n', 'icon'],
};

const _$ContactsLayoutSchemeEnumMap = {
  ContactsLayoutScheme.tabbed: 'tabbed',
  ContactsLayoutScheme.unified: 'unified',
};

KeypadTabScheme _$KeypadTabSchemeFromJson(Map<String, dynamic> json) =>
    KeypadTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      type: json['type'] as String? ?? 'keypad',
    );

Map<String, dynamic> _$KeypadTabSchemeToJson(KeypadTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'type': instance.type,
    };

const _$KeypadTabSchemeJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'initial': {'type': 'boolean', 'default': false},
    'titleL10n': {'type': 'string'},
    'icon': {'type': 'string'},
    'type': {'type': 'string', 'default': 'keypad'},
  },
  'required': ['titleL10n', 'icon'],
};

MessagingTabScheme _$MessagingTabSchemeFromJson(Map<String, dynamic> json) =>
    MessagingTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      type: json['type'] as String? ?? 'messaging',
    );

Map<String, dynamic> _$MessagingTabSchemeToJson(MessagingTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'type': instance.type,
    };

const _$MessagingTabSchemeJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'initial': {'type': 'boolean', 'default': false},
    'titleL10n': {'type': 'string'},
    'icon': {'type': 'string'},
    'type': {'type': 'string', 'default': 'messaging'},
  },
  'required': ['titleL10n', 'icon'],
};

VoicemailTabScheme _$VoicemailTabSchemeFromJson(Map<String, dynamic> json) =>
    VoicemailTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      type: json['type'] as String? ?? 'voicemail',
    );

Map<String, dynamic> _$VoicemailTabSchemeToJson(VoicemailTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'type': instance.type,
    };

const _$VoicemailTabSchemeJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'initial': {'type': 'boolean', 'default': false},
    'titleL10n': {'type': 'string'},
    'icon': {'type': 'string'},
    'type': {'type': 'string', 'default': 'voicemail'},
  },
  'required': ['titleL10n', 'icon'],
};

EmbeddedTabScheme _$EmbeddedTabSchemeFromJson(Map<String, dynamic> json) =>
    EmbeddedTabScheme(
      enabled: json['enabled'] as bool? ?? true,
      initial: json['initial'] as bool? ?? false,
      titleL10n: json['titleL10n'] as String,
      icon: json['icon'] as String,
      embeddedResourceId: const IntToStringConverter().fromJson(
        json['embeddedResourceId'],
      ),
      type: json['type'] as String? ?? 'embedded',
    );

Map<String, dynamic> _$EmbeddedTabSchemeToJson(EmbeddedTabScheme instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'initial': instance.initial,
      'titleL10n': instance.titleL10n,
      'icon': instance.icon,
      'embeddedResourceId': const IntToStringConverter().toJson(
        instance.embeddedResourceId,
      ),
      'type': instance.type,
    };

const _$EmbeddedTabSchemeJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'initial': {'type': 'boolean', 'default': false},
    'titleL10n': {'type': 'string'},
    'icon': {'type': 'string'},
    'embeddedResourceId': {'type': 'string'},
    'type': {'type': 'string', 'default': 'embedded'},
  },
  'required': ['titleL10n', 'icon', 'embeddedResourceId'],
};
