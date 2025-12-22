import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/theme/theme.dart';

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
    final background = effectiveStyle?.background;
    final isComplexBackground = background?.isComplex ?? false;

    return ThemedScaffold(
      background: effectiveStyle?.background,
      appBar: MainAppBar(
        title: title,
        context: context,
        backgroundColor: isComplexBackground ? Colors.transparent : null,
        elevation: isComplexBackground ? 0 : null,
      ),
      body: KeypadView(videoEnabled: videoEnabled, transferEnabled: transferEnabled, style: effectiveStyle),
    );
  }
}
