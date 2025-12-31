import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/theme.dart';

class AboutScreenStyle extends BaseScreenStyle with Diagnosticable {
  const AboutScreenStyle({super.background, this.pictureLogoStyle});

  final ThemeImageStyle? pictureLogoStyle;

  AboutScreenStyle copyWith({BackgroundStyle? background, ThemeImageStyle? pictureLogoStyle}) {
    return AboutScreenStyle(
      background: background ?? this.background,
      pictureLogoStyle: pictureLogoStyle ?? this.pictureLogoStyle,
    );
  }

  static AboutScreenStyle merge(AboutScreenStyle? a, AboutScreenStyle? b) {
    if (a == null) return b ?? const AboutScreenStyle();
    if (b == null) return a;

    return AboutScreenStyle(
      background: b.background ?? a.background,
      pictureLogoStyle: ThemeImageStyle.merge(a.pictureLogoStyle, b.pictureLogoStyle),
    );
  }

  static AboutScreenStyle lerp(AboutScreenStyle? a, AboutScreenStyle? b, double t) {
    if (identical(a, b)) {
      return a ?? const AboutScreenStyle();
    }

    return AboutScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
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
