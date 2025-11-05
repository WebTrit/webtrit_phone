import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class RegisteredStatusStyleFactory implements ThemeStyleFactory<RegisteredStatusStyles> {
  RegisteredStatusStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final RegistrationStatusesWidgetConfig? config;

  @override
  RegisteredStatusStyles create() {
    final registered = config?.online.toColor() ?? colors.error;
    final unregisters = config?.offline.toColor() ?? colors.error;

    return RegisteredStatusStyles(
      primary: RegisteredStatusStyle(registered: registered, unregistered: unregisters),
    );
  }
}
