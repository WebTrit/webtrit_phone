import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../theme_style_factory.dart';

class LinkifyStyleFactory implements ThemeStyleFactory<LinkifyStyles> {
  LinkifyStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final LinkifyWidgetConfig? config;

  @override
  LinkifyStyles create() {
    final regularTextColor = config?.styleColor?.toColor();
    final linkifyTextColor = config?.linkifyStyleColor?.toColor() ?? colors.primary;

    final regularTextStyle = TextStyle(color: regularTextColor);
    final linkifyTextStyle = TextStyle(color: linkifyTextColor);

    return LinkifyStyles(
      primary: LinkifyStyle(style: regularTextStyle, linkStyle: linkifyTextStyle),
    );
  }
}
