import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'actionpad_style.dart';
import 'actionpad_styles.dart';

export 'actionpad_style.dart';
export 'actionpad_styles.dart';

class Actionpad extends StatelessWidget {
  const Actionpad({
    required this.callNumbers,
    required this.actionsEnabled,
    this.onAudioCallPressed,
    this.onVideoCallPressed,
    this.onTransferPressed,
    this.onInitiatedTransferPressed,
    this.onBackspacePressed,
    this.onBackspaceLongPress,
    this.onCallFrom,
    this.style,
    super.key,
  });

  final bool actionsEnabled;
  final VoidCallback? onAudioCallPressed;
  final VoidCallback? onVideoCallPressed;
  final VoidCallback? onTransferPressed;
  final VoidCallback? onInitiatedTransferPressed;
  final VoidCallback? onBackspacePressed;
  final VoidCallback? onBackspaceLongPress;
  final Function(String)? onCallFrom;
  final List<String> callNumbers;
  final ActionpadStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final localStyle = style ?? themeData.extension<ActionpadStyles>()?.primary;

    final mediaQueryData = MediaQuery.of(context);
    final minimumDimension = min(mediaQueryData.size.width / 5, mediaQueryData.size.height / 7);
    final iconSize = Theme.of(context).textTheme.headlineLarge!.fontSize;

    final optionsAvaliable = onTransferPressed != null || callNumbers.length > 1;

    return TextButtonsTable(
      minimumSize: Size.square(minimumDimension),
      children: [
        if (optionsAvaliable)
          Visibility(
            visible: onInitiatedTransferPressed == null,
            child: Transform.scale(
              scale: .75,
              child: TextButton(
                onPressed: actionsEnabled ? () {} : null,
                style: localStyle?.callStart,
                child: PopupMenuButton(
                  enabled: actionsEnabled,
                  child: Icon(Icons.more_vert, size: iconSize),
                  itemBuilder: (context) {
                    return [
                      if (onVideoCallPressed != null)
                        PopupMenuItem(
                          onTap: onVideoCallPressed,
                          child: Text(context.l10n.numberActions_videoCall),
                        ),
                      if (onTransferPressed != null)
                        PopupMenuItem(
                          onTap: onTransferPressed,
                          child: Text(context.l10n.numberActions_transfer),
                        ),
                      for (final number in callNumbers)
                        PopupMenuItem(
                          onTap: () => onCallFrom?.call(number),
                          child: Text(context.l10n.numberActions_callFrom(number)),
                        ),
                    ];
                  },
                ),
              ),
            ),
          )
        else
          Visibility(
            visible: onInitiatedTransferPressed == null && onVideoCallPressed != null,
            child: Transform.scale(
              scale: .75,
              child: TextButton(
                onPressed: actionsEnabled ? onVideoCallPressed : null,
                style: localStyle?.callStart,
                child: Icon(Icons.videocam, size: iconSize),
              ),
            ),
          ),
        if (onInitiatedTransferPressed != null)
          TextButton(
            onPressed: actionsEnabled ? onInitiatedTransferPressed : null,
            style: localStyle?.callTransfer,
            child: Icon(Icons.phone_forwarded, size: iconSize),
          )
        else
          TextButton(
            onPressed: actionsEnabled ? onAudioCallPressed : null,
            style: localStyle?.callStart,
            child: Icon(Icons.call, size: iconSize),
          ),
        TextButton(
          onPressed: actionsEnabled ? onBackspacePressed : null,
          onLongPress: actionsEnabled ? onBackspaceLongPress : null,
          style: localStyle?.backspacePressed,
          child: const Icon(
            Icons.backspace_outlined,
          ),
        ),
      ],
    );
  }
}
