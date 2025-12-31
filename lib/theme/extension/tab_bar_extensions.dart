import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

extension TabBarIndicatorSizeConfigExtension on TabBarIndicatorSizeConfig {
  TabBarIndicatorSize get toTabBarIndicatorSize => switch (this) {
    TabBarIndicatorSizeConfig.label => TabBarIndicatorSize.label,
    TabBarIndicatorSizeConfig.tab => TabBarIndicatorSize.tab,
  };
}

extension TabAlignmentConfigExtension on TabAlignmentConfig {
  TabAlignment get toTabAlignment => switch (this) {
    TabAlignmentConfig.start => TabAlignment.start,
    TabAlignmentConfig.startOffset => TabAlignment.startOffset,
    TabAlignmentConfig.fill => TabAlignment.fill,
    TabAlignmentConfig.center => TabAlignment.center,
  };
}

extension TabIndicatorAnimationConfigExtension on TabIndicatorAnimationConfig {
  TabIndicatorAnimation get toTabIndicatorAnimation => switch (this) {
    TabIndicatorAnimationConfig.elastic => TabIndicatorAnimation.elastic,
    TabIndicatorAnimationConfig.linear => TabIndicatorAnimation.linear,
  };
}

extension TabSplashFactoryConfigExtension on TabSplashFactoryConfig {
  InteractiveInkFeatureFactory get toInteractiveInkFeatureFactory => switch (this) {
    TabSplashFactoryConfig.noSplash => NoSplash.splashFactory,
    TabSplashFactoryConfig.inkRipple => InkRipple.splashFactory,
    TabSplashFactoryConfig.inkSparkle => InkSparkle.splashFactory,
  };
}
