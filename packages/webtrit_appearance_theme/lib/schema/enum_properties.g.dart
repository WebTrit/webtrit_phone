// GENERATED CODE - DO NOT MODIFY BY HAND

import 'union_assembly.dart';

/// Which properties of the published contract are enum-typed, and what each may hold.
///
/// json_serializable has no branch for an enum, so such a property comes out of
/// the generator as a bare `{"type": "object"}` - no values, no default.
/// [assembleEnums] fills them in from here.
const enumProperties = <String, Map<String, EnumProperty>>{
  'BorderConfig': {
    'type': EnumProperty(<String>['underline', 'outline', 'none'], 'underline'),
  },
  'ContactsTabScheme': {
    'layout': EnumProperty(<String>['tabbed', 'unified'], 'tabbed'),
  },
  'EmbeddedResource': {
    'type': EnumProperty(<String>['terms', 'unknown'], 'unknown'),
  },
  'ImageRenderSpec': {
    'alignment': EnumProperty(<String>[
      'topLeft',
      'topCenter',
      'topRight',
      'centerLeft',
      'center',
      'centerRight',
      'bottomLeft',
      'bottomCenter',
      'bottomRight',
    ], null),
    'fit': EnumProperty(<String>['fill', 'contain', 'cover', 'fitWidth', 'fitHeight', 'none', 'scaleDown'], null),
  },
  'LoginModeSelectPageConfig': {
    'buttonLoginStyleType': EnumProperty(<String>['primary', 'neutral', 'primaryOnDark', 'neutralOnDark'], 'primary'),
    'buttonSignupStyleType': EnumProperty(<String>['primary', 'neutral', 'primaryOnDark', 'neutralOnDark'], 'primary'),
  },
  'PageBackgroundImage': {
    'fit': EnumProperty(<String>['fill', 'contain', 'cover', 'fitWidth', 'fitHeight', 'none', 'scaleDown'], 'cover'),
  },
  'SupportedThemeMode': {
    'mode': EnumProperty(<String>['system', 'light', 'dark'], 'system'),
  },
  'TabBarConfig': {
    'indicatorAnimation': EnumProperty(<String>['linear', 'elastic'], null),
    'indicatorSize': EnumProperty(<String>['tab', 'label'], null),
    'splashFactory': EnumProperty(<String>['noSplash', 'inkRipple', 'inkSparkle'], null),
    'tabAlignment': EnumProperty(<String>['start', 'startOffset', 'fill', 'center'], null),
  },
  'ThemeOverrideConfig': {
    'mode': EnumProperty(<String>['system', 'light', 'dark'], 'system'),
  },
};
