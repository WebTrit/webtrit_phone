import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class CallStatusStyleFactory implements ThemeStyleFactory<CallStatusStyles> {
  CallStatusStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final CallStatusesWidgetConfig? config;

  @override
  CallStatusStyles create() {
    final connectivityNone = config?.connectivityNone.toColor() ?? colors.error;
    final connectError = config?.connectError.toColor() ?? colors.error;
    final appUnregistered = config?.appUnregistered.toColor() ?? colors.onSurfaceVariant;
    final connectIssue = config?.connectIssue.toColor() ?? colors.error;
    final inProgress = config?.inProgress.toColor() ?? colors.secondary;
    final ready = config?.ready.toColor() ?? colors.tertiary;

    return CallStatusStyles(
      primary: CallStatusStyle(
        connectivityNone: connectivityNone,
        connectError: connectError,
        appUnregistered: appUnregistered,
        connectIssue: connectIssue,
        inProgress: inProgress,
        ready: ready,
      ),
    );
  }
}
