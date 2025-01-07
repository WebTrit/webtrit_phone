import 'dart:ui';

import '../models/models.dart';
import '../theme_provider.dart';

extension CustomColorExension on CustomColor {
  Color value(ThemeProvider provider) {
    return provider.custom(this);
  }
}
