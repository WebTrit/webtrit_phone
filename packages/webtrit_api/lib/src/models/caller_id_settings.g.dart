// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_id_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrefixMatcher _$PrefixMatcherFromJson(Map<String, dynamic> json) =>
    PrefixMatcher(
      prefix: json['prefix'] as String,
      number: json['number'] as String,
    );

Map<String, dynamic> _$PrefixMatcherToJson(PrefixMatcher instance) =>
    <String, dynamic>{'prefix': instance.prefix, 'number': instance.number};

CallerIdSettings _$CallerIdSettingsFromJson(Map<String, dynamic> json) =>
    CallerIdSettings(
      defaultNumber: json['default_number'] as String?,
      prefixMatchers: (json['prefix_matchers'] as List<dynamic>)
          .map((e) => PrefixMatcher.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: (json['version'] as num).toInt(),
      modifiedAt: DateTime.parse(json['modified_at'] as String),
    );

Map<String, dynamic> _$CallerIdSettingsToJson(
  CallerIdSettings instance,
) => <String, dynamic>{
  'default_number': instance.defaultNumber,
  'prefix_matchers': instance.prefixMatchers.map((e) => e.toJson()).toList(),
  'version': instance.version,
  'modified_at': instance.modifiedAt.toIso8601String(),
};
