import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class ContactTile extends StatelessWidget {
  ContactTile({
    Key? key,
    required this.displayName,
    this.thumbnail,
    this.smart = false,
    this.onTap,
    this.onLongPress,
    this.onAudioPressed,
    this.onVideoPressed,
  }) : super(key: key);

  final String displayName;
  final Uint8List? thumbnail;
  final bool smart;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final VoidCallback? onAudioPressed;
  final VoidCallback? onVideoPressed;

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
              child: Icon(
                Icons.person,
                size: 18,
              ),
            ),
          )
      ],
    );

    return ListTile(
      contentPadding: EdgeInsets.only(left: 16.0),
      leading: avatar,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            splashRadius: 24,
            icon: Icon(Icons.call),
            onPressed: onAudioPressed,
          ),
          IconButton(
            splashRadius: 24,
            icon: Icon(Icons.videocam),
            onPressed: onVideoPressed,
          ),
        ],
      ),
      title: Text(displayName),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
