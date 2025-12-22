import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';

extension BoxFitConfigExtension on BoxFitConfig {
  BoxFit? get boxFit {
    switch (this) {
      case BoxFitConfig.fill:
        return BoxFit.fill;
      case BoxFitConfig.contain:
        return BoxFit.contain;
      case BoxFitConfig.cover:
        return BoxFit.cover;
      case BoxFitConfig.fitWidth:
        return BoxFit.fitWidth;
      case BoxFitConfig.fitHeight:
        return BoxFit.fitHeight;
      case BoxFitConfig.none:
        return BoxFit.none;
      case BoxFitConfig.scaleDown:
        return BoxFit.scaleDown;
    }
  }
}
