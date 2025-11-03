import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/theme.dart';

class EmbeddedRequestErrorStyle with Diagnosticable {
  const EmbeddedRequestErrorStyle({
    this.picture,
  });

  final ThemeSvgAsset? picture;

  EmbeddedRequestErrorStyle copyWith({
    final ThemeSvgAsset? picture,
  }) {
    return EmbeddedRequestErrorStyle(
      picture: picture ?? this.picture,
    );
  }

  static EmbeddedRequestErrorStyle? lerp(
    EmbeddedRequestErrorStyle? a,
    EmbeddedRequestErrorStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return EmbeddedRequestErrorStyle(
      picture: t < 0.5 ? a?.picture : b?.picture,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeSvgAsset?>('picture', picture));
  }
}
