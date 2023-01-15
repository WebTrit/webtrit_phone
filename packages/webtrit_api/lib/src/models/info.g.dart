// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Info _$$_InfoFromJson(Map<String, dynamic> json) => _$_Info(
      core: CoreInfo.fromJson(json['core'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_InfoToJson(_$_Info instance) => <String, dynamic>{
      'core': instance.core,
    };

_$_CoreInfo _$$_CoreInfoFromJson(Map<String, dynamic> json) => _$_CoreInfo(
      version: const VersionConverter().fromJson(json['version'] as String),
    );

Map<String, dynamic> _$$_CoreInfoToJson(_$_CoreInfo instance) =>
    <String, dynamic>{
      'version': const VersionConverter().toJson(instance.version),
    };
