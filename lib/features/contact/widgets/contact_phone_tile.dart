import 'package:flutter/material.dart';

class ContactPhoneTile extends StatelessWidget {
  const ContactPhoneTile({
    super.key,
    required this.number,
    required this.label,
    required this.favorite,
    required this.transfer,
    this.onTap,
    this.onLongPress,
    this.onFavoriteChanged,
    this.onAudioPressed,
    this.onVideoPressed,
    this.onTransferPressed,
    this.onMessagePressed,
  });

  final String number;
  final String label;
  final bool favorite;
  final bool transfer;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final ValueChanged<bool>? onFavoriteChanged;
  final VoidCallback? onAudioPressed;
  final VoidCallback? onVideoPressed;
  final VoidCallback? onTransferPressed;
  final GestureTapCallback? onMessagePressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            splashRadius: 24,
            icon: favorite ? const Icon(Icons.star) : const Icon(Icons.star_border),
            onPressed: onFavoriteChanged == null ? null : () => onFavoriteChanged!(!favorite),
          ),
          if (transfer)
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.phone_forwarded),
              onPressed: onTransferPressed,
            )
          else ...[
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.call),
              onPressed: onAudioPressed,
            ),
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
        ],
      ),
      title: Text(number),
      subtitle: Text(label),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
