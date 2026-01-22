import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          leading: LeadingAvatar(username: displayName, thumbnail: thumbnail, thumbnailUrl: thumbnailUrl),
          title: Text(voicemail.displaySender),
          subtitle: _VoicemailSubtitle(voicemail: voicemail, dateFormat: dateFormat),
          trailing: PopupMenuButton<_VoicemailMenuAction>(
            padding: EdgeInsets.zero,
            position: PopupMenuPosition.under,
            onSelected: _onPopupMenuSelected,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: _VoicemailMenuAction.call,
                child: ListTile(leading: const Icon(Icons.call), title: Text(context.l10n.voicemail_Label_call)),
              ),
              PopupMenuItem(
                value: _VoicemailMenuAction.toggleSeenStatus,
                enabled: !voicemail.status.isUnknown,
                child: ListTile(
                  leading: const Icon(Icons.voicemail),
                  title: Row(
                    children: [
                      const SizedBox(width: 4),
                      if (voicemail.status.isRead) Icon(Icons.circle, size: 8, color: colorScheme.tertiary),
                      Text(
                        voicemail.status.isRead
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
            child: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        AudioView(path: voicemail.url!, onPlaybackStarted: _onPlaybackStarted),
      ],
    );
  }

  void _onPlaybackStarted() {
    if (voicemail.status.isUnread) {
      onToggleSeenStatus(voicemail);
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

class _VoicemailSubtitle extends StatelessWidget {
  const _VoicemailSubtitle({required this.voicemail, required this.dateFormat});

  final Voicemail voicemail;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            axisAlignment: -1,
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: voicemail.status.isRead
              ? const SizedBox.shrink()
              : Padding(
                  key: const ValueKey('unread_indicator'),
                  padding: const EdgeInsets.only(right: 8),
                  child: voicemail.status.isUnknown
                      ? SizedCircularProgressIndicator(
                          size: 8,
                          outerSize: 10,
                          color: colorScheme.tertiary,
                          strokeWidth: 1,
                        )
                      : CircleIndicator(color: colorScheme.tertiary),
                ),
        ),
        Text(dateFormat.format(DateTime.parse(voicemail.date))),
      ],
    );
  }
}

enum _VoicemailMenuAction { call, toggleSeenStatus, delete }
