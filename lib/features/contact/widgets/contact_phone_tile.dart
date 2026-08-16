import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ContactPhoneTile extends StatelessWidget {
  const ContactPhoneTile({
    super.key,
    required this.number,
    required this.label,
    required this.favorite,
    required this.callNumbers,
    this.index = 0,
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

  /// Position of the number on the card. A contact can carry several numbers
  /// and every row offers the same actions, so the ids are numbered by it -
  /// otherwise a test asking for "the call button" finds more than one.
  final int index;

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
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      title: Text(number),
      subtitle: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [..._buildActionIcons(context), _buildMoreMenuButton(context)],
      ),
    );
  }

  List<Widget> _buildActionIcons(BuildContext context) {
    final l10n = context.l10n;
    final icons = <Widget>[];

    if (onFavoriteChanged != null) {
      icons.add(
        SemanticAction(
          label: favorite
              ? l10n.contact_SemanticsLabel_removeFavorite(number)
              : l10n.contact_SemanticsLabel_addFavorite(number),
          identifier: numberedId(contactPhoneTileFavIconId, index),
          child: IconButton(
            key: contactPhoneTileFavIconKey,
            splashRadius: 24,
            icon: favorite ? const Icon(Icons.star) : const Icon(Icons.star_border),
            onPressed: () => onFavoriteChanged!(!favorite),
          ),
        ),
      );
    }

    if (onInitiatedTransferPressed != null) {
      icons.add(
        SemanticAction(
          label: l10n.contact_SemanticsLabel_transfer(number),
          identifier: numberedId(contactPhoneTransferId, index),
          child: IconButton(
            splashRadius: 24,
            icon: const Icon(Icons.phone_forwarded),
            onPressed: onInitiatedTransferPressed,
          ),
        ),
      );
    } else {
      if (onAudioPressed != null) {
        icons.add(
          SemanticAction(
            label: l10n.callTile_SemanticsLabel_call(number),
            identifier: numberedId(contactPhoneVoiceCallId, index),
            child: IconButton(splashRadius: 24, icon: const Icon(Icons.call), onPressed: onAudioPressed),
          ),
        );
      }
      if (onVideoPressed != null) {
        icons.add(
          SemanticAction(
            label: l10n.callTile_SemanticsLabel_videoCall(number),
            identifier: numberedId(contactPhoneVideoCallId, index),
            child: IconButton(splashRadius: 24, icon: const Icon(Icons.videocam), onPressed: onVideoPressed),
          ),
        );
      }
    }

    if (onMessagePressed != null) {
      icons.add(
        SemanticAction(
          label: l10n.numberActions_chat,
          identifier: numberedId(contactPhoneChatId, index),
          child: IconButton(splashRadius: 24, icon: const Icon(Icons.message), onPressed: onMessagePressed),
        ),
      );
    }

    return icons;
  }

  Widget _buildMoreMenuButton(BuildContext context) {
    return SemanticAction(
      label: context.l10n.callTileActions_more,
      identifier: numberedId(contactPhoneMenuId, index),
      child: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        // The stock tooltip would be spoken on top of the name above.
        tooltip: '',
        // Audio/video/message are surfaced as inline icons above, so only the
        // remaining actions are wired into the shared menu builder here.
        itemBuilder: (context) => numberActionsToMenu(
          buildNumberActions(
            context,
            callNumbers: callNumbers,
            onCallLogPressed: onCallLogPressed,
            onTransferPressed: onTransferPressed,
            onSendSmsPressed: onSendSmsPressed,
            onCallFrom: onCallFrom,
            copyNumber: number,
          ),
        ),
      ),
    );
  }
}
