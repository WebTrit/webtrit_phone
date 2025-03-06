import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import 'actionpad_style.dart';
import 'actionpad_styles.dart';

export 'actionpad_style.dart';
export 'actionpad_styles.dart';

class Actionpad extends StatelessWidget {
  const Actionpad({
    super.key,
    this.transfer = false,
    this.videoVisible = true,
    this.onAudioCallPressed,
    this.onVideoCallPressed,
    this.onTransferPressed,
    this.onBackspacePressed,
    this.onBackspaceLongPress,
    this.style,
  });

  final bool transfer;
  final bool videoVisible;
  final VoidCallback? onAudioCallPressed;
  final VoidCallback? onVideoCallPressed;
  final VoidCallback? onTransferPressed;
  final VoidCallback? onBackspacePressed;
  final VoidCallback? onBackspaceLongPress;

  final ActionpadStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final localStyle = style ?? themeData.extension<ActionpadStyles>()?.primary;

    final mediaQueryData = MediaQuery.of(context);
    final minimumDimension = min(mediaQueryData.size.width / 5, mediaQueryData.size.height / 7);

    final iconSize = Theme.of(context).textTheme.headlineLarge!.fontSize;

    return TextButtonsTable(
      minimumSize: Size.square(minimumDimension),
      children: [
        Visibility(
          visible: !transfer && videoVisible,
          child: Transform.scale(
            scale: .75,
            child: TextButton(
              onPressed: onVideoCallPressed,
              style: localStyle?.callStart,
              child: Icon(
                Icons.videocam,
                size: iconSize,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: transfer ? onTransferPressed : onAudioCallPressed,
          style: transfer ? localStyle?.callTransfer : localStyle?.callStart,
          child: Icon(
            transfer ? Icons.phone_forwarded : Icons.call,
            size: iconSize,
          ),
        ),
        TextButton(
          onPressed: onBackspacePressed,
          onLongPress: onBackspaceLongPress,
          style: localStyle?.backspacePressed,
          child: const Icon(
            Icons.backspace_outlined,
          ),
        ),
      ],
    );
  }
}
