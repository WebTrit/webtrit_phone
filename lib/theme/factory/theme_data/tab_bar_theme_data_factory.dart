import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class TabBarThemeDataFactory implements ThemeStyleFactory<TabBarThemeData> {
  const TabBarThemeDataFactory(this.colors, this.config);

  final ColorScheme colors;
  final TabBarConfig config;

  @override
  TabBarThemeData create() {
    final unselectedLabelColor = config.unselectedLabelColor?.toColor() ?? colors.onSurface;
    final dividerColor = config.dividerColor?.toColor() ?? Colors.transparent;
    final labelColor = config.labelColor?.toColor() ?? colors.onPrimary;

    return TabBarThemeData(
      indicatorColor: config.indicatorColor?.toColor() ?? colors.primary,
      dividerColor: dividerColor,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      overlayColor: config.overlayColor != null ? WidgetStateProperty.all(config.overlayColor!.toColor()) : null,
      indicator: _createIndicator(config),
      dividerHeight: config.dividerHeight,
      labelPadding: config.labelPadding?.toEdgeInsets(),
      labelStyle: config.labelStyle?.toTextStyle(),
      unselectedLabelStyle: config.unselectedLabelStyle?.toTextStyle(),
      indicatorSize: config.indicatorSize?.toTabBarIndicatorSize,
      tabAlignment: config.tabAlignment?.toTabAlignment,
      indicatorAnimation: config.indicatorAnimation?.toTabIndicatorAnimation,
      splashFactory: config.splashFactory?.toInteractiveInkFeatureFactory,
    );
  }

  Decoration? _createIndicator(TabBarConfig conf) {
    final fillColor = conf.indicatorColor?.toColor() ?? colors.primary;
    final borderConf = conf.indicatorBorder;

    if (borderConf == null) {
      return ShapeDecoration(
        shape: const StadiumBorder(side: BorderSide.none),
        color: fillColor,
      );
    }

    final borderColor = borderConf.borderColor?.toColor() ?? Colors.transparent;
    final borderWidth = borderConf.borderWidth ?? 1.0;

    switch (borderConf.type) {
      case BorderTypeConfig.outline:
        if (borderConf.borderRadius != null) {
          return BoxDecoration(
            color: fillColor,
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(borderConf.borderRadius!),
          );
        }

        return ShapeDecoration(
          color: fillColor,
          shape: StadiumBorder(
            side: BorderSide(color: borderColor, width: borderWidth),
          ),
        );

      case BorderTypeConfig.underline:
        return UnderlineTabIndicator(
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        );

      case BorderTypeConfig.none:
        return ShapeDecoration(
          shape: const StadiumBorder(side: BorderSide.none),
          color: fillColor,
        );
    }
  }
}
