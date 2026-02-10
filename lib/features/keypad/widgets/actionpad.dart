import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
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
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      minimumSize: Size.square(minimumDimension),
      children: [
        if (optionsAvaliable)
          Visibility(
            visible: onInitiatedTransferPressed == null,
            child: Transform.scale(
              scale: localStyle?.secondary?.scale ?? 1.0,
              child: TextButton(
                onPressed: actionsEnabled ? () {} : null,
                style: localStyle?.secondary?.style,
                child: PopupMenuButton(
                  enabled: actionsEnabled,
                  child: Icon(Icons.more_vert, size: iconSize),
                  itemBuilder: (context) {
                    return [
                      if (onVideoCallPressed != null)
                        PopupMenuItem(onTap: onVideoCallPressed, child: Text(context.l10n.numberActions_videoCall)),
                      if (onTransferPressed != null)
                        PopupMenuItem(onTap: onTransferPressed, child: Text(context.l10n.numberActions_transfer)),
                      if (callNumbers.length > 1)
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
              scale: localStyle?.secondary?.scale ?? 1.0,
              child: TextButton(
                key: actionPadVideoCallKey,
                onPressed: actionsEnabled ? onVideoCallPressed : null,
                style: localStyle?.secondary?.style,
                child: Icon(Icons.videocam, size: iconSize),
              ),
            ),
          ),
        if (onInitiatedTransferPressed != null)
          Transform.scale(
            scale: localStyle?.primary?.scale ?? 1.0,
            child: TextButton(
              onPressed: actionsEnabled ? onInitiatedTransferPressed : null,
              style: localStyle?.primary?.style,
              child: Icon(Icons.phone_forwarded, size: iconSize),
            ),
          )
        else
          Transform.scale(
            scale: localStyle?.primary?.scale ?? 1.0,
            child: TextButton(
              key: actionPadStartKey,
              onPressed: actionsEnabled ? onAudioCallPressed : null,
              style: localStyle?.primary?.style,
              child: Icon(Icons.call, size: iconSize),
            ),
          ),
        Transform.scale(
          scale: localStyle?.backspace?.scale ?? 1.0,
          child: TextButton(
            key: actionPadBackspaceKey,
            onPressed: actionsEnabled ? onBackspacePressed : null,
            onLongPress: actionsEnabled ? onBackspaceLongPress : null,
            style: localStyle?.backspace?.style,
            child: const Icon(Icons.backspace_outlined),
          ),
        ),
      ],
    );
  }
}
