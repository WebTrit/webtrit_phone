import 'package:flutter/material.dart';

import 'app_icon_style.dart';
import 'app_icon_styles.dart';

export 'app_icon_style.dart';
export 'app_icon_styles.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.iconData, {
    super.key,
    this.size,
    this.style,
  });

  final IconData iconData;
  final double? size;
  final AppIconStyle? style;

  @override
  Widget build(BuildContext context) {
    final localStyle = style ?? Theme.of(context).extension<AppIconStyles>()?.primary;

    return Icon(
      iconData,
      color: localStyle?.color,
      size: size,
    );
  }
}
