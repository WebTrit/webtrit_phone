// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_collection_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ImageCollectionDTO _$$_ImageCollectionDTOFromJson(
        Map<String, dynamic> json) =>
    _$_ImageCollectionDTO(
      onboarding: json['onboarding'] as String?,
      applicationLogo: json['applicationLogo'] as String?,
      notificationLogo: json['notificationLogo'] as String?,
      adaptiveIconBackground: json['adaptiveIconBackground'] as String?,
      adaptiveIconForeground: json['adaptiveIconForeground'] as String?,
      androidLauncherIcon: json['androidLauncherIcon'] as String?,
      iosLauncherIcon: json['iosLauncherIcon'] as String?,
      webLauncherIcon: json['webLauncherIcon'] as String?,
    );

Map<String, dynamic> _$$_ImageCollectionDTOToJson(
        _$_ImageCollectionDTO instance) =>
    <String, dynamic>{
      'onboarding': instance.onboarding,
      'applicationLogo': instance.applicationLogo,
      'notificationLogo': instance.notificationLogo,
      'adaptiveIconBackground': instance.adaptiveIconBackground,
      'adaptiveIconForeground': instance.adaptiveIconForeground,
      'androidLauncherIcon': instance.androidLauncherIcon,
      'iosLauncherIcon': instance.iosLauncherIcon,
      'webLauncherIcon': instance.webLauncherIcon,
    };
