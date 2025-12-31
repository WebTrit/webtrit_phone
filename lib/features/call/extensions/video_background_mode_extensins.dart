import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

/// Extensions for [VideoBackgroundMode] to simplify UI logic and state toggling.
extension VideoBackgroundModeExtension on VideoBackgroundMode {
  /// Returns `true` if the background mode is currently set to [VideoBackgroundMode.blur].
  bool get isBlur => this == VideoBackgroundMode.blur;

  /// Returns `true` if the background mode is currently set to [VideoBackgroundMode.none].
  bool get isNone => this == VideoBackgroundMode.none;

  /// Returns the label describing the action to be taken when toggled.
  String get actionLabel => isBlur ? 'Disable Blur' : 'Enable Blur';

  /// Returns the icon representing the action to be taken when toggled.
  IconData get actionIcon => isBlur ? Icons.blur_off : Icons.blur_on;

  /// Returns the opposite background mode.
  ///
  /// Switches between [VideoBackgroundMode.blur] and [VideoBackgroundMode.none].
  VideoBackgroundMode get toggled => isBlur ? VideoBackgroundMode.none : VideoBackgroundMode.blur;
}
