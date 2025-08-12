import 'package:flutter/widgets.dart';

import '../models/models.dart';

extension PaddingConfigMapper on PaddingConfig {
  /// Convert data-only padding to Flutter's EdgeInsets.
  EdgeInsets toEdgeInsets() => EdgeInsets.fromLTRB(left, top, right, bottom);
}

extension PaddingConfigNullableMapper on PaddingConfig? {
  /// Convert nullable config to EdgeInsets, falling back when null.
  EdgeInsets toEdgeInsetsOr(EdgeInsets fallback) {
    final p = this;
    if (p == null) return fallback;
    return EdgeInsets.fromLTRB(p.left, p.top, p.right, p.bottom);
  }
}
