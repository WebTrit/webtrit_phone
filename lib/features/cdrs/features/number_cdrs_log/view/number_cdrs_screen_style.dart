import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/blurred_surface.dart';

class NumberCdrsScreenStyle extends BaseScreenStyle with Diagnosticable {
  const NumberCdrsScreenStyle({super.background, super.appBarBlurredSurface, super.appBarTheme});

  NumberCdrsScreenStyle copyWith({
    BackgroundStyle? background,
    BlurredSurfaceStyle? appBarBlurredSurface,
    AppBarTheme? appBarTheme,
  }) {
    return NumberCdrsScreenStyle(
      background: background ?? this.background,
      appBarBlurredSurface: appBarBlurredSurface ?? this.appBarBlurredSurface,
      appBarTheme: appBarTheme ?? this.appBarTheme,
    );
  }

  static NumberCdrsScreenStyle lerp(NumberCdrsScreenStyle? a, NumberCdrsScreenStyle? b, double t) {
    return NumberCdrsScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
      appBarBlurredSurface: BlurredSurfaceStyle.lerp(a?.appBarBlurredSurface, b?.appBarBlurredSurface, t),
      appBarTheme: AppBarTheme.lerp(a?.appBarTheme, b?.appBarTheme, t),
    );
  }
}
