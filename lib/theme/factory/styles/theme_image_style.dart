import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class ThemeImageStyleFactory implements ThemeStyleFactory<ThemeImageStyle> {
  const ThemeImageStyleFactory({
    required this.source,
    this.defaultScale = 0.5,
    this.defaultAlignment = Alignment.center,
  });

  final ImageSource? source;
  final double defaultScale;
  final AlignmentGeometry defaultAlignment;

  @override
  ThemeImageStyle create() {
    final renderSpec = source?.render;
    final picture = source?.uri?.toThemeSvgAsset();
    final widthFactor = renderSpec?.scale;
    final padding = renderSpec?.padding?.toEdgeInsets();
    final alignment = renderSpec?.alignment?.geometry ?? defaultAlignment;
    final fit = renderSpec?.fit?.boxFit ?? BoxFit.contain;

    return ThemeImageStyle(
      picture: picture,
      widthFactor: widthFactor,
      padding: padding,
      alignment: alignment,
      fit: fit,
    );
  }
}
