import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

import '../../styles/styles.dart';
import '../theme_style_factory.dart';

class CallScreenStyleFactory implements ThemeStyleFactory<CallScreenStyles> {
  CallScreenStyleFactory(this.config, this.colors);

  final CallPageConfig? config;
  final ColorScheme colors;

  @override
  CallScreenStyles create() {
    final appBarConfig = config?.appBarStyle;
    final infoConfig = config?.callInfo;

    return CallScreenStyles(
      primary: CallScreenStyle(
        appBar: _toAppBarStyle(appBarConfig),
        systemUiOverlayStyle: config?.systemUiOverlayStyle?.toSystemUiOverlayStyle(),
        callInfo: CallInfoStyle(
          userInfo: infoConfig?.usernameTextStyle?.toTextStyle(fallbackColor: colors.surface),
          number: infoConfig?.numberTextStyle?.toTextStyle(fallbackColor: colors.surface),
          callStatus: infoConfig?.callStatusTextStyle?.toTextStyle(fallbackColor: colors.surface),
          processingStatus: infoConfig?.processingStatusTextStyle?.toTextStyle(fallbackColor: colors.surface),
        ),
      ),
    );
  }

  AppBarStyle? _toAppBarStyle(AppBarStyleConfig? cfg) {
    if (cfg == null) return null;

    return AppBarStyle(
      backgroundColor: cfg.backgroundColor?.toColor() ?? Colors.transparent,
      foregroundColor: cfg.foregroundColor?.toColor(),
      primary: cfg.primary,
      showBackButton: cfg.showBackButton,
    );
  }
}
