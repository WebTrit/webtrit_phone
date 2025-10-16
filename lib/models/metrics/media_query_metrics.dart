import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_query_metrics.freezed.dart';

part 'media_query_metrics.g.dart';

@freezed
abstract class MediaQueryMetrics with _$MediaQueryMetrics {
  const factory MediaQueryMetrics({
    required String brightness,
    required double devicePixelRatio,
    required int topSafeInset,
    required int bottomSafeInset,
  }) = _MediaQueryMetrics;

  factory MediaQueryMetrics.fromJson(Map<String, dynamic> json) => _$MediaQueryMetricsFromJson(json);
}
