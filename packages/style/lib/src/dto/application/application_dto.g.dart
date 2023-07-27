// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ApplicationDTO _$$_ApplicationDTOFromJson(Map<String, dynamic> json) =>
    _$_ApplicationDTO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      platformIdentifier: json['platformIdentifier'] as String?,
      theme: json['theme'] as String?,
      version: json['version'] as int?,
      googleServices: json['googleServices'] == null
          ? null
          : GoogleServices.fromJson(
              json['googleServices'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ApplicationDTOToJson(_$_ApplicationDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('platformIdentifier', instance.platformIdentifier);
  writeNotNull('theme', instance.theme);
  writeNotNull('version', instance.version);
  writeNotNull('googleServices', instance.googleServices);
  return val;
}

_$_GoogleServicesDTO _$$_GoogleServicesDTOFromJson(Map<String, dynamic> json) =>
    _$_GoogleServicesDTO(
      androidUrl: json['androidUrl'] as String?,
      androidPath: json['androidPath'] as String?,
      iosUrl: json['iosUrl'] as String?,
      iosPath: json['iosPath'] as String?,
      projectId: json['projectId'] as String?,
    );

Map<String, dynamic> _$$_GoogleServicesDTOToJson(
    _$_GoogleServicesDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('androidUrl', instance.androidUrl);
  writeNotNull('androidPath', instance.androidPath);
  writeNotNull('iosUrl', instance.iosUrl);
  writeNotNull('iosPath', instance.iosPath);
  writeNotNull('projectId', instance.projectId);
  return val;
}
