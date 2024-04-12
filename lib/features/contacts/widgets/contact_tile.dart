import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.displayName,
    this.thumbnail,
    this.smart = false,
    this.onTap,
    this.onLongPress,
    this.onMessagePressed,
  });

  final String displayName;
  final Uint8List? thumbnail;
  final bool smart;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onMessagePressed;

  @override
  Widget build(BuildContext context) {
    final Uint8List? thumbnail = this.thumbnail;
    final avatar = Stack(
      clipBehavior: Clip.none,
      children: [
        if (thumbnail == null)
          LeadingAvatar(
            username: displayName,
          )
        else
          CircleAvatar(
            foregroundImage: MemoryImage(thumbnail),
          ),
        if (smart)
          Positioned(
            right: -4,
            bottom: -4,
            width: 20,
            height: 20,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: const Icon(
                Icons.person,
                size: 18,
              ),
            ),
          )
      ],
    );

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      leading: avatar,
      title: Text(displayName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onMessagePressed != null)
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.messenger_outline),
              onPressed: onMessagePressed,
            ),
        ],
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
