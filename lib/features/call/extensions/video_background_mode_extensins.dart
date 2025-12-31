import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

extension VideoBackgroundModeExtension on VideoBackgroundMode {
  /// Returns the label for the action button.
  String get toggleLabel {
    return this == VideoBackgroundMode.blur ? 'Disable Blur' : 'Enable Blur';
  }

  /// Returns the icon for the action button.
  IconData get toggleIcon {
    return this == VideoBackgroundMode.blur ? Icons.blur_off : Icons.blur_on;
  }

  /// Switches between [VideoBackgroundMode.blur] and [VideoBackgroundMode.none].
  VideoBackgroundMode get toggled {
    return this == VideoBackgroundMode.blur ? VideoBackgroundMode.none : VideoBackgroundMode.blur;
  }
}
