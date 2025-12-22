import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import '../styles/styles.dart';

import 'theme_json_serializable.dart';
import 'box_fit_config_extension.dart';

extension PageBackgroundConfigExtension on PageBackground {
  BackgroundStyle toStyle() {
    return map(
      solid: (s) => SolidBackgroundStyle(color: s.color.toColor()),
      gradient: (g) => GradientBackgroundStyle(
        gradient: LinearGradient(
          colors: g.colors.map((c) => c.toColor()).toList(),
          stops: g.stops.length == g.colors.length ? g.stops : null,
          begin: Alignment(g.beginX, g.beginY),
          end: Alignment(g.endX, g.endY),
        ),
      ),
      image: (i) => ImageBackgroundStyle(imageUrl: i.imageUrl, opacity: i.opacity, fit: i.fit.boxFit ?? BoxFit.cover),
    );
  }
}
