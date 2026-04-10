import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

/// Extensions for [VideoBackgroundMode] to simplify UI logic and state toggling.
extension VideoBackgroundModeExtension on VideoBackgroundMode {
  /// Returns `true` if the background mode is currently set to [VideoBackgroundMode.blur].
  bool get isBlur => this == VideoBackgroundMode.blur;

  /// Returns the label describing the action to be taken when toggled.
  String actionLabelL10n(BuildContext context) {
    return isBlur
        ? context.l10n.call_videoBackground_actionLabel_disableBlur
        : context.l10n.call_videoBackground_actionLabel_enableBlur;
  }

  /// Returns the icon representing the action to be taken when toggled.
  IconData get actionIcon => isBlur ? Icons.blur_off : Icons.blur_on;

  /// Returns the opposite background mode.
  ///
  /// Switches between [VideoBackgroundMode.blur] and [VideoBackgroundMode.none].
  VideoBackgroundMode get toggled => isBlur ? VideoBackgroundMode.none : VideoBackgroundMode.blur;
}
