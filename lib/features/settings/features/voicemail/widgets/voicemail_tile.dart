import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'audio_view.dart';
import 'circle_indicator.dart';

class VoicemailTile extends StatelessWidget {
  const VoicemailTile({
    super.key,
    required this.voicemail,
    required this.onDeleted,
    required this.mediaHeaders,
    this.onTap,
    required this.displayName,
    this.thumbnail,
    this.thumbnailUrl,
    this.registered,
    required this.smart,
    required this.onToggleSeenStatus,
    required this.onCall,
    this.onMessage,
  });

  final Voicemail voicemail;
  final Map<String, String> mediaHeaders;
  final VoidCallback? onTap;
  final String displayName;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final bool? registered;
  final bool smart;

  final void Function(Voicemail) onDeleted;
  final void Function(Voicemail) onToggleSeenStatus;
  final void Function(Voicemail) onCall;
  final void Function(Voicemail)? onMessage;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
          subtitle: Row(
            children: [
              Visibility(
                visible: !voicemail.seen,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleIndicator(
                    color: voicemail.seen ? colorScheme.onSurface : colorScheme.tertiary,
                  ),
                ),
              ),
              Text(DateFormat('d MMMM yyyy').format(DateTime.parse(voicemail.date))),
            ],
          ),
          onTap: onTap,
          trailing: PopupMenuButton<_VoicemailMenuAction>(
            padding: EdgeInsets.zero,
            position: PopupMenuPosition.under,
            onSelected: _onPopupMenuSelected,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: _VoicemailMenuAction.call,
                child: ListTile(
                  leading: Icon(Icons.call),
                  title: Text('Call'),
                ),
              ),
              const PopupMenuItem(
                value: _VoicemailMenuAction.message,
                child: ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Message'),
                ),
              ),
              PopupMenuItem(
                value: _VoicemailMenuAction.toggleSeenStatus,
                child: ListTile(
                  leading: Icon(voicemail.seen ? Icons.mark_email_read : Icons.mark_email_unread),
                  title: Row(
                    children: [
                      if (voicemail.seen) Icon(Icons.circle, size: 8, color: colorScheme.tertiary),
                      const SizedBox(width: 4),
                      Text(voicemail.seen ? 'Mark as new' : 'Mark as heard'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: _VoicemailMenuAction.delete,
                child: ListTile(
                  leading: Icon(Icons.delete, color: colorScheme.error),
                  title: const Text('Delete'),
                ),
              ),
            ],
            child: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        AudioView(
          path: voicemail.url!,
          header: mediaHeaders,
          onPlaybackStarted: _onPlaybackStarted,
        ),
      ],
    );
  }

  void _onPlaybackStarted() {
    if (!voicemail.seen) {
      onToggleSeenStatus.call(voicemail);
    }
  }

  void _onPopupMenuSelected(_VoicemailMenuAction action) {
    switch (action) {
      case _VoicemailMenuAction.call:
        onCall(voicemail);
        break;
      case _VoicemailMenuAction.message:
        onMessage?.call(voicemail);
        break;
      case _VoicemailMenuAction.toggleSeenStatus:
        onToggleSeenStatus(voicemail);
        break;
      case _VoicemailMenuAction.delete:
        onDeleted(voicemail);
        break;
    }
  }
}

enum _VoicemailMenuAction {
  call,
  message,
  toggleSeenStatus,
  delete,
}
