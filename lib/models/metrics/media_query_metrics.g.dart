// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_query_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaQueryMetricsImpl _$$MediaQueryMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$MediaQueryMetricsImpl(
      brightness: json['brightness'] as String,
      devicePixelRatio: (json['devicePixelRatio'] as num).toDouble(),
      topSafeInset: (json['topSafeInset'] as num).toInt(),
      bottomSafeInset: (json['bottomSafeInset'] as num).toInt(),
    );

Map<String, dynamic> _$$MediaQueryMetricsImplToJson(
        _$MediaQueryMetricsImpl instance) =>
    <String, dynamic>{
      'brightness': instance.brightness,
      'devicePixelRatio': instance.devicePixelRatio,
      'topSafeInset': instance.topSafeInset,
      'bottomSafeInset': instance.bottomSafeInset,
    };
