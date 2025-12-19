import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/theme.dart';

class AboutScreenStyle with Diagnosticable {
  const AboutScreenStyle({this.pictureLogoStyle});

  final ThemeImageStyle? pictureLogoStyle;

  AboutScreenStyle copyWith({ThemeImageStyle? pictureLogoStyle}) {
    return AboutScreenStyle(pictureLogoStyle: pictureLogoStyle ?? this.pictureLogoStyle);
  }

  static AboutScreenStyle merge(AboutScreenStyle? a, AboutScreenStyle? b) {
    if (a == null) return b ?? const AboutScreenStyle();
    if (b == null) return a;

    return AboutScreenStyle(pictureLogoStyle: ThemeImageStyle.merge(a.pictureLogoStyle, b.pictureLogoStyle));
  }

  static AboutScreenStyle? lerp(AboutScreenStyle? a, AboutScreenStyle? b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return AboutScreenStyle(pictureLogoStyle: ThemeImageStyle.lerp(a?.pictureLogoStyle, b?.pictureLogoStyle, t));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeImageStyle?>('pictureLogoStyle', pictureLogoStyle));
  }
}
