import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

// Follow naming conventions as outlined in https://api.flutter.dev/flutter/widgets/Visibility-class.html
class ContactPhoneTile extends StatelessWidget {
  const ContactPhoneTile({
    super.key,
    required this.number,
    required this.label,
    required this.favorite,
    required this.callNumbers,
    this.onTap,
    this.onFavoriteChanged,
    this.onAudioPressed,
    this.onVideoPressed,
    this.onTransferPressed,
    this.onInitiatedTransferPressed,
    this.onMessagePressed,
    this.onSendSmsPressed,
    this.onCallLogPressed,
    this.onCallFrom,
  });

  final String number;
  final String label;
  final bool favorite;
  final List<String> callNumbers;
  final GestureTapCallback? onTap;
  final ValueChanged<bool>? onFavoriteChanged;
  final VoidCallback? onAudioPressed;
  final VoidCallback? onVideoPressed;
  final VoidCallback? onTransferPressed;
  final VoidCallback? onInitiatedTransferPressed;
  final GestureTapCallback? onMessagePressed;
  final VoidCallback? onSendSmsPressed;
  final VoidCallback? onCallLogPressed;
  final Function(String)? onCallFrom;

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuEntry> actions = [
      if (callNumbers.length > 1)
        for (final number in callNumbers)
          PopupMenuItem(
            onTap: () => onCallFrom?.call(number),
            child: Text(context.l10n.numberActions_callFrom(number)),
          ),
      if (onTransferPressed != null)
        PopupMenuItem(
          onTap: onTransferPressed,
          child: Text(context.l10n.numberActions_transfer),
        ),
      if (onSendSmsPressed != null)
        PopupMenuItem(
          onTap: onSendSmsPressed,
          child: Text(context.l10n.numberActions_sendSms),
        ),
      if (onCallLogPressed != null)
        PopupMenuItem(
          onTap: onCallLogPressed,
          child: Text(context.l10n.numberActions_callLog),
        ),
      PopupMenuItem(
        onTap: () {
          Clipboard.setData(ClipboardData(text: number));
        },
        child: Text(context.l10n.numberActions_copyNumber),
      ),
    ];

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onFavoriteChanged != null)
            IconButton(
              splashRadius: 24,
              icon: favorite ? const Icon(Icons.star) : const Icon(Icons.star_border),
              onPressed: () => onFavoriteChanged!(!favorite),
            ),
          if (onInitiatedTransferPressed != null)
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.phone_forwarded),
              onPressed: onInitiatedTransferPressed,
            )
          else ...[
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.call),
              onPressed: onAudioPressed,
            ),
            if (onVideoPressed != null)
              IconButton(
                splashRadius: 24,
                icon: const Icon(Icons.videocam),
                onPressed: onVideoPressed,
              ),
          ],
          if (onMessagePressed != null)
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.messenger),
              onPressed: onMessagePressed,
            ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) {
              return actions;
            },
          ),
        ],
      ),
      title: Text(number),
      subtitle: Text(label),
      onTap: onTap,
    );
  }
}
