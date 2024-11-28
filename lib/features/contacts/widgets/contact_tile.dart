import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.displayName,
    this.thumbnail,
    this.thumbnailUrl,
    this.registered,
    this.smart = false,
    this.onTap,
    this.onLongPress,
    this.onMessagePressed,
  });

  final String displayName;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final bool? registered;
  final bool smart;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onMessagePressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      leading: LeadingAvatar(
        username: displayName,
        thumbnail: thumbnail,
        thumbnailUrl: thumbnailUrl,
        registered: registered,
        smart: smart,
      ),
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
