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
              child: _OverflowMenuButton(
                enabled: actionsEnabled,
                style: localStyle?.secondary?.style,
                iconSize: iconSize,
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
          )
        else
          Visibility(
            visible: onInitiatedTransferPressed == null && onVideoCallPressed != null,
            child: Transform.scale(
              scale: localStyle?.secondary?.scale ?? 1.0,
              child: SemanticAction(
                label: context.l10n.numberActions_videoCall,
                identifier: actionPadVideoCallId,
                child: TextButton(
                  key: actionPadVideoCallKey,
                  onPressed: actionsEnabled ? onVideoCallPressed : null,
                  style: localStyle?.secondary?.style,
                  child: Icon(Icons.videocam, size: iconSize),
                ),
              ),
            ),
          ),
        if (onInitiatedTransferPressed != null)
          Transform.scale(
            scale: localStyle?.primary?.scale ?? 1.0,
            child: SemanticAction(
              label: context.l10n.numberActions_transfer,
              identifier: actionPadTransferId,
              child: TextButton(
                onPressed: actionsEnabled ? onInitiatedTransferPressed : null,
                style: localStyle?.primary?.style,
                child: Icon(Icons.phone_forwarded, size: iconSize),
              ),
            ),
          )
        else
          Transform.scale(
            scale: localStyle?.primary?.scale ?? 1.0,
            child: SemanticAction(
              label: context.l10n.numberActions_audioCall,
              identifier: actionPadVoiceCallId,
              child: TextButton(
                onPressed: actionsEnabled ? onAudioCallPressed : null,
                style: localStyle?.primary?.style,
                child: Icon(Icons.call, size: iconSize),
              ),
            ),
          ),
        Transform.scale(
          scale: localStyle?.backspace?.scale ?? 1.0,
          child: SemanticAction(
            label: context.l10n.actionpad_SemanticsLabel_backspace,
            identifier: actionPadBackspaceId,
            child: TextButton(
              key: actionPadBackspaceKey,
              onPressed: actionsEnabled ? onBackspacePressed : null,
              onLongPress: actionsEnabled ? onBackspaceLongPress : null,
              style: localStyle?.backspace?.style,
              child: const Icon(Icons.backspace_outlined),
            ),
          ),
        ),
      ],
    );
  }
}

/// The overflow trigger merges its styling TextButton and the popup control
/// into one semantics node, and after the merge the TextButton's handler is
/// the node's tap action - so the button must open the menu itself, or
/// assistive-technology activation would hit a decorative no-op.
class _OverflowMenuButton extends StatefulWidget {
  const _OverflowMenuButton({
    required this.enabled,
    required this.style,
    required this.iconSize,
    required this.itemBuilder,
  });

  final bool enabled;
  final ButtonStyle? style;
  final double? iconSize;
  final PopupMenuItemBuilder<dynamic> itemBuilder;

  @override
  State<_OverflowMenuButton> createState() => _OverflowMenuButtonState();
}

class _OverflowMenuButtonState extends State<_OverflowMenuButton> {
  final _menuKey = GlobalKey<PopupMenuButtonState<dynamic>>();

  @override
  Widget build(BuildContext context) {
    return SemanticAction(
      identifier: actionPadOverflowId,
      child: TextButton(
        onPressed: widget.enabled ? () => _menuKey.currentState?.showButtonMenu() : null,
        style: widget.style,
        child: PopupMenuButton(
          key: _menuKey,
          enabled: widget.enabled,
          itemBuilder: widget.itemBuilder,
          child: Icon(Icons.more_vert, size: widget.iconSize),
        ),
      ),
    );
  }
}
