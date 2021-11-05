import 'package:flutter/material.dart';

class ContactPhoneTile extends StatelessWidget {
  const ContactPhoneTile({
    Key? key,
    required this.number,
    required this.label,
    this.onTap,
    this.onLongPress,
    this.onAudioPressed,
    this.onVideoPressed,
  }) : super(key: key);

  final String number;
  final String label;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
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
