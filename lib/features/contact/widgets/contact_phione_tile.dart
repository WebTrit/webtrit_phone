import 'package:flutter/material.dart';

class ContactPhoneTile extends StatelessWidget {
  const ContactPhoneTile({
    Key? key,
    required this.number,
    required this.label,
    required this.favorite,
    this.onTap,
    this.onLongPress,
    this.onFavoriteChanged,
    this.onAudioPressed,
    this.onVideoPressed,
  }) : super(key: key);

  final String number;
  final String label;
  final bool favorite;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final ValueChanged<bool>? onFavoriteChanged;
  final VoidCallback? onAudioPressed;
  final VoidCallback? onVideoPressed;

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
      ),
      title: Text(number),
      subtitle: Text(label),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
