import 'package:flutter/widgets.dart';

import 'package:webtrit_appearance_theme/models/models.dart';

extension AlignmentConfigExtension on AlignmentConfig {
  AlignmentGeometry get geometry {
    switch (this) {
      case AlignmentConfig.topLeft:
        return Alignment.topLeft;
      case AlignmentConfig.topCenter:
        return Alignment.topCenter;
      case AlignmentConfig.topRight:
        return Alignment.topRight;
      case AlignmentConfig.centerLeft:
        return Alignment.centerLeft;
      case AlignmentConfig.center:
        return Alignment.center;
      case AlignmentConfig.centerRight:
        return Alignment.centerRight;
      case AlignmentConfig.bottomLeft:
        return Alignment.bottomLeft;
      case AlignmentConfig.bottomCenter:
        return Alignment.bottomCenter;
      case AlignmentConfig.bottomRight:
        return Alignment.bottomRight;
    }
  }
}
