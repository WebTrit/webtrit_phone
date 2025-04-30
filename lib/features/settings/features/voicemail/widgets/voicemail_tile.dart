import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../models/models.dart';

import 'audio_view.dart';
import 'circle_indicator.dart';

class VoicemailTile extends StatelessWidget {
  const VoicemailTile({
    super.key,
    required this.voicemail,
    required this.displayName,
    required this.onCall,
    required this.onDeleted,
    required this.onToggleSeenStatus,
    this.thumbnail,
    this.thumbnailUrl,
  });

  final Voicemail voicemail;
  final String displayName;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;

  final void Function(Voicemail) onCall;
  final void Function(Voicemail) onDeleted;
  final void Function(Voicemail) onToggleSeenStatus;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = context.read<VoicemailScreenContext>().dateFormat;

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
              Text(dateFormat.format(DateTime.parse(voicemail.date))),
            ],
          ),
          trailing: PopupMenuButton<_VoicemailMenuAction>(
            padding: EdgeInsets.zero,
            position: PopupMenuPosition.under,
            onSelected: _onPopupMenuSelected,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: _VoicemailMenuAction.call,
                child: ListTile(
                  leading: const Icon(Icons.call),
                  title: Text(context.l10n.voicemail_Label_call),
                ),
              ),
              PopupMenuItem(
                value: _VoicemailMenuAction.toggleSeenStatus,
                child: ListTile(
                  leading: const Icon(Icons.voicemail),
                  title: Row(
                    children: [
                      if (voicemail.seen) Icon(Icons.circle, size: 8, color: colorScheme.tertiary),
                      const SizedBox(width: 4),
                      Text(
                        voicemail.seen
                            ? context.l10n.voicemail_Label_markAsNew
                            : context.l10n.voicemail_Label_markAsHeard,
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: _VoicemailMenuAction.delete,
                child: ListTile(
                  leading: Icon(Icons.delete, color: colorScheme.error),
                  title: Text(context.l10n.voicemail_Label_delete),
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
  toggleSeenStatus,
  delete,
}
