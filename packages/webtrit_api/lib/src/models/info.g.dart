// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      core: CoreInfo.fromJson(json['core'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'core': instance.core,
    };

CoreInfo _$CoreInfoFromJson(Map<String, dynamic> json) => CoreInfo(
      version: const VersionConverter().fromJson(json['version'] as String),
    );

Map<String, dynamic> _$CoreInfoToJson(CoreInfo instance) => <String, dynamic>{
      'version': const VersionConverter().toJson(instance.version),
    };
