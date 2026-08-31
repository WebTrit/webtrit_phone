import '../models/common/common.dart';
import '../models/features_config/app_config.dart';
import '../models/features_config/elevated_button_style_type.dart';
import '../models/features_config/embedded_resource.dart';
import '../models/features_config/embedded_resource_type.dart';
import '../models/features_config/supported_feature.dart';
import '../models/pages/page_background.dart';
import '../models/resources/image_source.dart';
import '../models/theme_page_config.dart';
import '../models/theme_widget_config.dart';

import 'union_assembly.dart';

/// Which properties of the published contract are enum-typed.
///
/// The one fact json_serializable cannot supply, in the same way the variants of
/// a union are: it has no branch for an enum at all, so such a property comes out
/// as a bare `{"type": "object"}` - no values, no default. This names them, and
/// [assembleEnums] fills them in.
///
/// Nothing here repeats a default. Each entry says which instance to read one
/// off, so the constructor stays the only place it is written.
///
/// A missing entry is caught: `test/enum_property_test.dart` fails on any
/// property the schema still describes as a bare object.
final themeEnumProperties = <String, Map<String, EnumProperty>>{
  'BorderConfig': {'type': EnumProperty(BorderTypeConfig.values, const BorderConfig().toJson)},
  'TabBarConfig': {
    'indicatorSize': EnumProperty(TabBarIndicatorSizeConfig.values, const TabBarConfig().toJson),
    'tabAlignment': EnumProperty(TabAlignmentConfig.values, const TabBarConfig().toJson),
    'indicatorAnimation': EnumProperty(TabIndicatorAnimationConfig.values, const TabBarConfig().toJson),
    'splashFactory': EnumProperty(TabSplashFactoryConfig.values, const TabBarConfig().toJson),
  },
  'ImageRenderSpec': {
    'alignment': EnumProperty(AlignmentConfig.values, const ImageRenderSpec().toJson),
    'fit': EnumProperty(BoxFitConfig.values, const ImageRenderSpec().toJson),
  },
  'ThemeOverrideConfig': {'mode': EnumProperty(ThemeModeConfig.values, const ThemeOverrideConfig().toJson)},
  'PageBackgroundImage': {'fit': EnumProperty(BoxFitConfig.values, const PageBackgroundImage(imageUrl: '').toJson)},
  'LoginModeSelectPageConfig': {
    'buttonLoginStyleType': EnumProperty(ElevatedButtonStyleType.values, const LoginModeSelectPageConfig().toJson),
    'buttonSignupStyleType': EnumProperty(ElevatedButtonStyleType.values, const LoginModeSelectPageConfig().toJson),
  },
};

/// The same, for the `AppConfig` root.
final appConfigEnumProperties = <String, Map<String, EnumProperty>>{
  'ContactsTabScheme': {
    'layout': EnumProperty(ContactsLayoutScheme.values, const ContactsTabScheme(titleL10n: '', icon: '').toJson),
  },
  'SupportedThemeMode': {'mode': EnumProperty(ThemeModeConfig.values, const SupportedThemeMode().toJson)},
};

/// The same, for the `EmbeddedResource` root - whose enum sits on the root
/// object rather than in `$defs`.
final embeddedResourceEnumProperties = <String, Map<String, EnumProperty>>{
  'EmbeddedResource': {
    'type': EnumProperty(EmbeddedResourceType.values, const EmbeddedResource(id: '', uri: '').toJson),
  },
};
