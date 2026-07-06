import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/widgets/call/number_actions.dart';

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
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      title: Text(number),
      subtitle: Text(label),
      onTap: onTap,
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [..._buildActionIcons(), _buildMoreMenuButton(context)]),
    );
  }

  List<Widget> _buildActionIcons() {
    final icons = <Widget>[];

    if (onFavoriteChanged != null) {
      icons.add(
        IconButton(
          key: contactPhoneTileFavIconKey,
          splashRadius: 24,
          icon: favorite ? const Icon(Icons.star) : const Icon(Icons.star_border),
          onPressed: () => onFavoriteChanged!(!favorite),
        ),
      );
    }

    if (onInitiatedTransferPressed != null) {
      icons.add(
        IconButton(splashRadius: 24, icon: const Icon(Icons.phone_forwarded), onPressed: onInitiatedTransferPressed),
      );
    } else {
      if (onAudioPressed != null) {
        icons.add(IconButton(splashRadius: 24, icon: const Icon(Icons.call), onPressed: onAudioPressed));
      }
      if (onVideoPressed != null) {
        icons.add(IconButton(splashRadius: 24, icon: const Icon(Icons.videocam), onPressed: onVideoPressed));
      }
    }

    if (onMessagePressed != null) {
      icons.add(IconButton(splashRadius: 24, icon: const Icon(Icons.message), onPressed: onMessagePressed));
    }

    return icons;
  }

  Widget _buildMoreMenuButton(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
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
    );
  }
}
