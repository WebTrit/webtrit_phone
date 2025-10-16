// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_query_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MediaQueryMetrics _$MediaQueryMetricsFromJson(Map<String, dynamic> json) =>
    _MediaQueryMetrics(
      brightness: json['brightness'] as String,
      devicePixelRatio: (json['devicePixelRatio'] as num).toDouble(),
      topSafeInset: (json['topSafeInset'] as num).toInt(),
      bottomSafeInset: (json['bottomSafeInset'] as num).toInt(),
    );

Map<String, dynamic> _$MediaQueryMetricsToJson(_MediaQueryMetrics instance) =>
    <String, dynamic>{
      'brightness': instance.brightness,
      'devicePixelRatio': instance.devicePixelRatio,
      'topSafeInset': instance.topSafeInset,
      'bottomSafeInset': instance.bottomSafeInset,
    };
