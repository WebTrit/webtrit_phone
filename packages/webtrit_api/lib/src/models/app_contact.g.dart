// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppContactImpl _$$AppContactImplFromJson(Map<String, dynamic> json) =>
    _$AppContactImpl(
      identifier: json['identifier'] as String,
      phones: (json['phones'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$AppContactImplToJson(_$AppContactImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'phones': instance.phones,
    };
