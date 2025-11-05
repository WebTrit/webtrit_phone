import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/linkify_style.dart';

class LinkifyStyles extends ThemeExtension<LinkifyStyles> {
  const LinkifyStyles({required this.primary});

  final LinkifyStyle? primary;

  @override
  ThemeExtension<LinkifyStyles> copyWith({LinkifyStyle? primary}) {
    return LinkifyStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<LinkifyStyles> lerp(ThemeExtension<LinkifyStyles>? other, double t) {
    if (other == null || primary == null || other is! LinkifyStyles) {
      return this;
    }

    return LinkifyStyles(primary: LinkifyStyle.lerp(primary, other.primary, t));
  }
}
