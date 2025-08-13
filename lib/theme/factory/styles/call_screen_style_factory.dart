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
        callInfo: _toCallScreenStyle(infoConfig),
      ),
    );
  }

  CallInfoStyle? _toCallScreenStyle(CallPageInfoConfig? cfg) {
    return CallInfoStyle(
      userInfo: cfg?.usernameTextStyle?.toTextStyle(
        fallbackColor: colors.surface,
        defaultFontSize: 24,
        defaultFontWeight: FontWeight.w400,
      ),
      number: cfg?.numberTextStyle?.toTextStyle(
        fallbackColor: colors.surface,
        defaultFontSize: 20,
        defaultFontWeight: FontWeight.w400,
      ),
      callStatus: cfg?.callStatusTextStyle?.toTextStyle(
        fallbackColor: colors.surface,
        defaultFontSize: 16,
        defaultFontWeight: FontWeight.w400,
      ),
      processingStatus: cfg?.processingStatusTextStyle?.toTextStyle(
        fallbackColor: colors.surface,
        defaultFontSize: 14,
        defaultFontWeight: FontWeight.w500,
      ),
    );
  }

  AppBarStyle? _toAppBarStyle(AppBarStyleConfig? cfg) {
    return AppBarStyle(
      backgroundColor: cfg?.backgroundColor?.toColor() ?? Colors.transparent,
      foregroundColor: cfg?.foregroundColor?.toColor() ?? colors.surface,
      primary: false,
      showBackButton: true,
    );
  }
}
