import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';

extension MediaQueryMetricsContextX on BuildContext {
  /// Collects metrics from [MediaQuery] and [Theme] of this [BuildContext].
  MediaQueryMetrics get mediaQueryMetrics {
    final mq = MediaQuery.of(this);
    final theme = Theme.of(this);

    return MediaQueryMetrics(
      brightness: theme.brightness.name,
      devicePixelRatio: mq.devicePixelRatio,
      topSafeInset: mq.viewPadding.top.round(),
      bottomSafeInset: mq.viewPadding.bottom.round(),
    );
  }
}
