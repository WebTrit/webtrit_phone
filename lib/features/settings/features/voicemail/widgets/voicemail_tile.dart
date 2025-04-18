import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/audio_view.dart';

import '../../../../../widgets/leading_avatar.dart';

class VoicemailTile extends StatelessWidget {
  const VoicemailTile({
    super.key,
    required this.voicemail,
    this.onDeleted,
    required this.mediaHeaders,
    this.onTap,
    required this.displayName,
    this.thumbnail,
    this.thumbnailUrl,
    this.registered,
    required this.smart,
  });

  final Voicemail voicemail;
  final Map<String, String> mediaHeaders;
  final VoidCallback? onTap;
  final void Function(Voicemail)? onDeleted;
  final String displayName;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final bool? registered;
  final bool smart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
      ListTile(
      contentPadding: EdgeInsets.zero,
      leading: LeadingAvatar(
        username: displayName,
        thumbnail: thumbnail,
        thumbnailUrl: thumbnailUrl,
        registered: registered,
        smart: smart,
      ),
      title: Text(voicemail.displaySender),
      subtitle: Text(DateFormat('d MMMM yyyy').format(DateTime.parse(voicemail.date))),
      onTap: onTap,
      trailing: PopupMenuButton<_VoicemailMenuAction>(
        child: Icon(
        Icons.more_vert,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.under,
      onSelected: (action) {
        switch (action) {
          case _VoicemailMenuAction.call:
          // TODO: реалізуй дзвінок
            break;
          case _VoicemailMenuAction.message:
          // TODO: реалізуй повідомлення
            break;
          case _VoicemailMenuAction.markAsNew:
          // TODO: реалізуй логіку "позначити як нове"
            break;
          case _VoicemailMenuAction.delete:
            if (onDeleted != null) {
              onDeleted!(voicemail);
            }
            break;
        }
      },
      itemBuilder: (context) =>
      [
        PopupMenuItem(
          value: _VoicemailMenuAction.call,
          child: ListTile(
            leading: Icon(Icons.call),
            title: Text('Call'),
          ),
        ),
        PopupMenuItem(
          value: _VoicemailMenuAction.message,
          child: ListTile(
            leading: Icon(Icons.message),
            title: Text('Message'),
          ),
        ),
        PopupMenuItem(
          value: _VoicemailMenuAction.markAsNew,
          child: ListTile(
            leading: Icon(Icons.mark_email_unread),
            title: Row(
              children: [
                Icon(Icons.circle, size: 8, color: Colors.green),
                SizedBox(width: 4),
                Text('Mark as new'),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          value: _VoicemailMenuAction.delete,
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        ),
      ],
    ),
    ),
    AudioView(
    voicemail.url!,
    header: mediaHeaders,
    ),
    ],
    );
    }
}

enum _VoicemailMenuAction {
  call,
  message,
  markAsNew,
  delete,
}
