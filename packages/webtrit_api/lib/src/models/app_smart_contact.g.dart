// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_smart_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppSmartContact _$$_AppSmartContactFromJson(Map<String, dynamic> json) =>
    _$_AppSmartContact(
      identifier: json['identifier'] as String,
      phones:
          (json['phones'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_AppSmartContactToJson(_$_AppSmartContact instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'phones': instance.phones,
    };
