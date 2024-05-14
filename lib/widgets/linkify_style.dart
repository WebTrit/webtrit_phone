import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LinkifyStyle with Diagnosticable {
  LinkifyStyle({
    this.style,
    this.linkStyle,
  });

  final TextStyle? style;
  final TextStyle? linkStyle;

  static LinkifyStyle merge(LinkifyStyle? a, LinkifyStyle? b) {
    return LinkifyStyle(
      style: (a?.style ?? b?.style)?.merge(b?.style ?? const TextStyle()),
      linkStyle: (a?.linkStyle ?? b?.linkStyle)?.merge(b?.linkStyle ?? const TextStyle()),
    );
  }

  static LinkifyStyle lerp(LinkifyStyle? a, LinkifyStyle? b, double t) {
    return LinkifyStyle(
      style: TextStyle.lerp(a?.style, b?.style, t),
      linkStyle: TextStyle.lerp(a?.linkStyle, b?.linkStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextStyle?>('style', style));
    properties.add(DiagnosticsProperty<TextStyle?>('linkStyle', linkStyle));
  }
}
