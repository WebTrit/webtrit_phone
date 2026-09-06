// GENERATED CODE - DO NOT MODIFY BY HAND

import '../models/features_config/app_config.dart';
import '../models/features_config/supported_feature.dart';
import '../models/pages/page_background.dart';

/// Which classes each union of the published contract is made of.
///
/// A sealed base declares no fields of its own, so the generator publishes it as
/// an empty object and reaches none of its variants. [assembleUnions] turns it
/// into a `oneOf` over the schemas below.
const unionVariants = <String, Map<String, Map<String, Object?>>>{
  'BottomMenuTabScheme': {
    'FavoritesTabScheme': FavoritesTabScheme.jsonSchema,
    'RecentsTabScheme': RecentsTabScheme.jsonSchema,
    'ContactsTabScheme': ContactsTabScheme.jsonSchema,
    'KeypadTabScheme': KeypadTabScheme.jsonSchema,
    'MessagingTabScheme': MessagingTabScheme.jsonSchema,
    'VoicemailTabScheme': VoicemailTabScheme.jsonSchema,
    'EmbeddedTabScheme': EmbeddedTabScheme.jsonSchema,
  },
  'PageBackground': {
    'PageBackgroundSolid': PageBackgroundSolid.jsonSchema,
    'PageBackgroundGradient': PageBackgroundGradient.jsonSchema,
    'PageBackgroundImage': PageBackgroundImage.jsonSchema,
  },
  'SupportedFeature': {
    'SupportedThemeMode': SupportedThemeMode.jsonSchema,
    'SupportedVideoCall': SupportedVideoCall.jsonSchema,
    'SupportedLoggingConfig': SupportedLoggingConfig.jsonSchema,
    'SupportedSystemNotifications': SupportedSystemNotifications.jsonSchema,
    'SupportedHybridPresence': SupportedHybridPresence.jsonSchema,
    'SupportedCallPull': SupportedCallPull.jsonSchema,
  },
};
