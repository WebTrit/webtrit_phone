// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_smart_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSmartContactImpl _$$AppSmartContactImplFromJson(
        Map<String, dynamic> json) =>
    _$AppSmartContactImpl(
      identifier: json['identifier'] as String,
      phones:
          (json['phones'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$AppSmartContactImplToJson(
        _$AppSmartContactImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'phones': instance.phones,
    };
