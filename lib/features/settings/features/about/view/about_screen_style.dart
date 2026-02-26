import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/blurred_surface.dart';

class AboutScreenStyle extends BaseScreenStyle with Diagnosticable {
  const AboutScreenStyle({
    super.background,
    super.appBarBackgroundColor,
    super.appBarBlurredSurface,
    this.pictureLogoStyle,
  });

  final ThemeImageStyle? pictureLogoStyle;

  AboutScreenStyle copyWith({
    BackgroundStyle? background,
    Color? appBarBackgroundColor,
    BlurredSurfaceStyle? appBarBlurredSurface,
    ThemeImageStyle? pictureLogoStyle,
  }) {
    return AboutScreenStyle(
      background: background ?? this.background,
      appBarBackgroundColor: appBarBackgroundColor ?? this.appBarBackgroundColor,
      appBarBlurredSurface: appBarBlurredSurface ?? this.appBarBlurredSurface,
      pictureLogoStyle: pictureLogoStyle ?? this.pictureLogoStyle,
    );
  }

  static AboutScreenStyle merge(AboutScreenStyle? a, AboutScreenStyle? b) {
    if (a == null) return b ?? const AboutScreenStyle();
    if (b == null) return a;

    return AboutScreenStyle(
      background: b.background ?? a.background,
      appBarBackgroundColor: b.appBarBackgroundColor ?? a.appBarBackgroundColor,
      appBarBlurredSurface: BlurredSurfaceStyle.merge(a.appBarBlurredSurface, b.appBarBlurredSurface),
      pictureLogoStyle: ThemeImageStyle.merge(a.pictureLogoStyle, b.pictureLogoStyle),
    );
  }

  static AboutScreenStyle lerp(AboutScreenStyle? a, AboutScreenStyle? b, double t) {
    if (identical(a, b)) {
      return a ?? const AboutScreenStyle();
    }

    return AboutScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
      appBarBackgroundColor: Color.lerp(a?.appBarBackgroundColor, b?.appBarBackgroundColor, t),
      appBarBlurredSurface: BlurredSurfaceStyle.lerp(a?.appBarBlurredSurface, b?.appBarBlurredSurface, t),
      pictureLogoStyle: ThemeImageStyle.lerp(a?.pictureLogoStyle, b?.pictureLogoStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BackgroundStyle?>('background', background));
    properties.add(DiagnosticsProperty<ThemeImageStyle?>('pictureLogoStyle', pictureLogoStyle));
  }
}
