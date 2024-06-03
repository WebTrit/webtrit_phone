import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.displayName,
    this.thumbnail,
    this.registered,
    this.smart = false,
    this.onTap,
    this.onLongPress,
  });

  final String displayName;
  final Uint8List? thumbnail;
  final bool? registered;
  final bool smart;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;

    final bool? registered = this.registered;
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
            left: -4,
            bottom: -4,
            width: 20,
            height: 20,
            child: CircleAvatar(
              backgroundColor: colorScheme.surfaceContainerLowest,
              child: const Icon(
                Icons.person,
                size: 18,
              ),
            ),
          ),
        if (registered != null)
          Positioned(
            right: 0,
            bottom: 0,
            width: 8,
            height: 8,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: registered ? colorScheme.tertiary : colorScheme.surface,
              ),
            ),
          )
      ],
    );

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      leading: avatar,
      title: Text(displayName),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
