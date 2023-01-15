// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppContact _$$_AppContactFromJson(Map<String, dynamic> json) =>
    _$_AppContact(
      identifier: json['identifier'] as String,
      phones:
          (json['phones'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_AppContactToJson(_$_AppContact instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'phones': instance.phones,
    };
