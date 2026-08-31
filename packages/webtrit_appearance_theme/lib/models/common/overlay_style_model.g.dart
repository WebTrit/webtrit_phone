// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overlay_style_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverlayStyleModel _$OverlayStyleModelFromJson(Map<String, dynamic> json) =>
    OverlayStyleModel(
      systemNavigationBarColor: json['systemNavigationBarColor'] as String?,
      systemNavigationBarIconBrightness:
          json['systemNavigationBarIconBrightness'] as String?,
      statusBarIconBrightness: json['statusBarIconBrightness'] as String?,
      statusBarBrightness: json['statusBarBrightness'] as String?,
    );

Map<String, dynamic> _$OverlayStyleModelToJson(OverlayStyleModel instance) =>
    <String, dynamic>{
      'systemNavigationBarColor': instance.systemNavigationBarColor,
      'systemNavigationBarIconBrightness':
          instance.systemNavigationBarIconBrightness,
      'statusBarIconBrightness': instance.statusBarIconBrightness,
      'statusBarBrightness': instance.statusBarBrightness,
    };

const _$OverlayStyleModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
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
      'description': 'Status bar icon brightness (e.g., "dark" or "light").',
    },
    'statusBarBrightness': {
      'type': 'string',
      'description': 'Status bar brightness (e.g., "dark" or "light").',
    },
  },
};
