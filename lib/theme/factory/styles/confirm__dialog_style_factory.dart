import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_widget_config.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/widgets/confirm_dialog.dart';

import '../theme_style_factory.dart';

class ConfirmDialogStyleFactory implements ThemeStyleFactory<ConfirmDialogStyles> {
  ConfirmDialogStyleFactory(this.colors, this.styles, this.config);

  final ColorScheme colors;
  final TextButtonStyles styles;
  final ConfirmDialogWidgetConfig? config;

  @override
  ConfirmDialogStyles create() {
    final activeButtonStyle1ForegroundColor = WidgetStatePropertyAll(config?.activeButtonColor1?.toColor());
    final activeButtonStyle2ForegroundColor = WidgetStatePropertyAll(config?.activeButtonColor2?.toColor());
    final defaultButtonStyleForegroundColor = WidgetStatePropertyAll(config?.defaultButtonColor?.toColor());

    final activeButtonStyle1 = styles.neutral?.copyWith(foregroundColor: activeButtonStyle1ForegroundColor);
    final activeButtonStyle2 = styles.dangerous?.copyWith(foregroundColor: activeButtonStyle2ForegroundColor);
    final defaultButtonStyle = const ButtonStyle().copyWith(foregroundColor: defaultButtonStyleForegroundColor);

    return ConfirmDialogStyles(
      primary: ConfirmDialogStyle(
        activeButtonStyle1: activeButtonStyle1,
        activeButtonStyle2: activeButtonStyle2,
        defaultButtonStyle: defaultButtonStyle,
      ),
    );
  }
}
