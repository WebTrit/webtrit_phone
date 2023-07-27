// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Config _$$_ConfigFromJson(Map<String, dynamic> json) => _$_Config(
      name: json['name'] as String?,
      version: json['version'] as String?,
      autoUpdate: json['autoUpdate'] as bool? ?? false,
      mapping: Mapping.fromJson(json['mapping'] as Map<String, dynamic>),
      hosts: Hosts.fromJson(json['hosts'] as Map<String, dynamic>),
      output: json['output'] == null
          ? null
          : Output.fromJson(json['output'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ConfigToJson(_$_Config instance) => <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'autoUpdate': instance.autoUpdate,
      'mapping': instance.mapping,
      'hosts': instance.hosts,
      'output': instance.output,
    };

_$_Output _$$_OutputFromJson(Map<String, dynamic> json) => _$_Output(
      theme: json['theme'] == null
          ? null
          : Path.fromJson(json['theme'] as Map<String, dynamic>),
      onboarding: json['onboarding'] == null
          ? null
          : Path.fromJson(json['onboarding'] as Map<String, dynamic>),
      logo: json['logo'] == null
          ? null
          : Path.fromJson(json['logo'] as Map<String, dynamic>),
      pushNotificationIcon: json['pushNotificationIcon'] == null
          ? null
          : Path.fromJson(json['pushNotificationIcon'] as Map<String, dynamic>),
      adaptiveIconBackground: json['adaptiveIconBackground'] == null
          ? null
          : Path.fromJson(
              json['adaptiveIconBackground'] as Map<String, dynamic>),
      adaptiveIconForeground: json['adaptiveIconForeground'] == null
          ? null
          : Path.fromJson(
              json['adaptiveIconForeground'] as Map<String, dynamic>),
      androidLauncherIcon: json['androidLauncherIcon'] == null
          ? null
          : Path.fromJson(json['androidLauncherIcon'] as Map<String, dynamic>),
      iosLauncherIcon: json['iosLauncherIcon'] == null
          ? null
          : Path.fromJson(json['iosLauncherIcon'] as Map<String, dynamic>),
      webLauncherIcon: json['webLauncherIcon'] == null
          ? null
          : Path.fromJson(json['webLauncherIcon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_OutputToJson(_$_Output instance) => <String, dynamic>{
      'theme': instance.theme,
      'onboarding': instance.onboarding,
      'logo': instance.logo,
      'pushNotificationIcon': instance.pushNotificationIcon,
      'adaptiveIconBackground': instance.adaptiveIconBackground,
      'adaptiveIconForeground': instance.adaptiveIconForeground,
      'androidLauncherIcon': instance.androidLauncherIcon,
      'iosLauncherIcon': instance.iosLauncherIcon,
      'webLauncherIcon': instance.webLauncherIcon,
    };

_$_Path _$$_PathFromJson(Map<String, dynamic> json) => _$_Path(
      path: json['path'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_PathToJson(_$_Path instance) => <String, dynamic>{
      'path': instance.path,
      'name': instance.name,
    };

_$_Hosts _$$_HostsFromJson(Map<String, dynamic> json) => _$_Hosts(
      stage: json['stage'] as String?,
      prod: json['prod'] as String,
    );

Map<String, dynamic> _$$_HostsToJson(_$_Hosts instance) => <String, dynamic>{
      'stage': instance.stage,
      'prod': instance.prod,
    };

_$_CredentialBean _$$_CredentialBeanFromJson(Map<String, dynamic> json) =>
    _$_CredentialBean(
      themeId: json['themeId'] as String?,
      applicationId: json['applicationId'] as String?,
      themePath: json['themePath'] as String?,
      applicationPath: json['applicationPath'] as String?,
    );

Map<String, dynamic> _$$_CredentialBeanToJson(_$_CredentialBean instance) =>
    <String, dynamic>{
      'themeId': instance.themeId,
      'applicationId': instance.applicationId,
      'themePath': instance.themePath,
      'applicationPath': instance.applicationPath,
    };
