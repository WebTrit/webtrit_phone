import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/theme.dart';

class AboutScreenStyle with Diagnosticable {
  AboutScreenStyle({this.picture});

  final ThemeSvgAsset? picture;

  static AboutScreenStyle? lerp(AboutScreenStyle? a, AboutScreenStyle? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return AboutScreenStyle(picture: t < 0.5 ? a?.picture : b?.picture);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeSvgAsset?>('picture', picture));
  }
}
