import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import './keypad_view.dart';
import 'keypad_screen_style.dart';
import 'keypad_screen_styles.dart';

export 'keypad_screen_style.dart';
export 'keypad_screen_styles.dart';

class KeypadScreen extends StatelessWidget {
  const KeypadScreen({super.key, this.title, required this.videoEnabled, required this.transferEnabled, this.style});

  final Widget? title;
  final bool videoEnabled;
  final bool transferEnabled;
  final KeypadScreenStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final effectiveStyle = style ?? themeData.extension<KeypadScreenStyles>()?.primary;
    return ThemedScaffold(
      background: effectiveStyle?.background,
      contentThemeOverride: effectiveStyle?.contentThemeOverride,
      applyToAppBar: effectiveStyle?.applyToAppBar ?? false,
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(
        title: title,
        context: context,
        flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
      ),
      body: KeypadView(videoEnabled: videoEnabled, transferEnabled: transferEnabled, style: effectiveStyle),
    );
  }
}
