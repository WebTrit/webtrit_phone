// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_contacts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppContact _$AppContactFromJson(Map<String, dynamic> json) {
  return AppContact(
    identifier: json['identifier'] as String,
    phones: (json['phones'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$AppContactToJson(AppContact instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'phones': instance.phones,
    };
