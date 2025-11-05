import 'package:flutter/material.dart';

import 'embedded_request_error_style.dart';

class EmbeddedRequestErrorStyles extends ThemeExtension<EmbeddedRequestErrorStyles> {
  const EmbeddedRequestErrorStyles({required this.primary});

  final EmbeddedRequestErrorStyle? primary;

  @override
  ThemeExtension<EmbeddedRequestErrorStyles> copyWith({EmbeddedRequestErrorStyle? primary}) {
    return EmbeddedRequestErrorStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<EmbeddedRequestErrorStyles> lerp(ThemeExtension<EmbeddedRequestErrorStyles>? other, double t) {
    if (other is! EmbeddedRequestErrorStyles) return this;

    return EmbeddedRequestErrorStyles(primary: EmbeddedRequestErrorStyle.lerp(primary, other.primary, t));
  }
}
