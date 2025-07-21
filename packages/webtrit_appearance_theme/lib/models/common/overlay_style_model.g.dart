// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overlay_style_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OverlayStyleModelImpl _$$OverlayStyleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OverlayStyleModelImpl(
      statusBarColor: json['statusBarColor'] as String,
      statusBarIconBrightness: json['statusBarIconBrightness'] as String,
      statusBarBrightness: json['statusBarBrightness'] as String?,
      systemNavigationBarColor: json['systemNavigationBarColor'] as String?,
      systemNavigationBarIconBrightness:
          json['systemNavigationBarIconBrightness'] as String?,
    );

Map<String, dynamic> _$$OverlayStyleModelImplToJson(
        _$OverlayStyleModelImpl instance) =>
    <String, dynamic>{
      'statusBarColor': instance.statusBarColor,
      'statusBarIconBrightness': instance.statusBarIconBrightness,
      'statusBarBrightness': instance.statusBarBrightness,
      'systemNavigationBarColor': instance.systemNavigationBarColor,
      'systemNavigationBarIconBrightness':
          instance.systemNavigationBarIconBrightness,
    };
