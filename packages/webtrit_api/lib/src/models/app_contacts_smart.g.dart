// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_contacts_smart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSmartContact _$AppSmartContactFromJson(Map<String, dynamic> json) =>
    AppSmartContact(
      identifier: json['identifier'] as String,
      phones:
          (json['phones'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AppSmartContactToJson(AppSmartContact instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'phones': instance.phones,
    };
