import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';

import 'audio_view.dart';
import 'circle_indicator.dart';

class VoicemailTile extends StatelessWidget {
  const VoicemailTile({
    super.key,
    required this.voicemail,
    required this.displayName,
    required this.selected,
    required this.onCall,
    required this.onDeleted,
    required this.onToggleSeenStatus,
    required this.onLongPress,
    required this.onTap,
    this.thumbnail,
    this.thumbnailUrl,
  });

  final Voicemail voicemail;
  final String displayName;
  final bool selected;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;

  final void Function(Voicemail) onCall;
  final void Function(Voicemail) onDeleted;
  final void Function(Voicemail) onToggleSeenStatus;
  final void Function(Voicemail) onLongPress;
  final void Function(Voicemail)? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = context.read<VoicemailScreenContext>().dateFormat;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: () => onLongPress(voicemail),
      onTap: onTap != null ? () => onTap!(voicemail) : null,
      child: PlainListTile(
        contentPadding: EdgeInsetsGeometry.all(16),
        selected: selected,
        selectedTileColor: colorScheme.primaryContainer.withValues(alpha: .5),
        crossAxisAlignment: CrossAxisAlignment.start,
        leading: LeadingAvatar(username: displayName, thumbnail: thumbnail, thumbnailUrl: thumbnailUrl),
        title: Text(voicemail.displaySender),
        subtitle: _VoicemailSubtitle(voicemail: voicemail, dateFormat: dateFormat),
        bottom: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AudioView(path: voicemail.url!, cacheKey: voicemail.id, onPlaybackStarted: _onPlaybackStarted),
            _VoicemailTranscript(voicemail: voicemail),
          ],
        ),
        trailing: PopupMenuButton<_VoicemailMenuAction>(
          padding: EdgeInsets.zero,
          position: PopupMenuPosition.under,
          onSelected: _onPopupMenuSelected,
          itemBuilder: (context) => _buildMenuItems(context, colorScheme),
          icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
        ),
      ),
    );
  }

  List<PopupMenuEntry<_VoicemailMenuAction>> _buildMenuItems(BuildContext context, ColorScheme colorScheme) => [
    PopupMenuItem(
      value: _VoicemailMenuAction.call,
      child: ListTile(leading: const Icon(Icons.call), title: Text(context.l10n.voicemail_Label_call)),
    ),
    PopupMenuItem(
      value: _VoicemailMenuAction.toggleSeenStatus,
      enabled: !voicemail.status.isUnknown,
      child: ListTile(
        leading: const Icon(Icons.voicemail),
        title: Badge(
          isLabelVisible: voicemail.status.showBadge,
          backgroundColor: colorScheme.tertiary,
          label: null,
          child: Text(voicemail.status.toggleActionLabelL10n(context)),
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
  ];

  void _onPlaybackStarted() {
    if (voicemail.status.isUnread) onToggleSeenStatus(voicemail);
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

/// A widget that displays the voicemail's timestamp and a dynamic unread status indicator.
/// It uses an [AnimatedSwitcher] to transition between an empty state, a loading indicator
/// for unknown statuses, and a solid circle for unread messages
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
            // TODO: migrate to alignment (deprecated after Flutter 3.41.0-1.0.pre)
            // ignore: deprecated_member_use
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
        Text(dateFormat.format(DateTime.parse(voicemail.date).toLocal())),
      ],
    );
  }
}

/// Renders the voicemail transcript below the audio player: the text itself
/// (collapsed to a few lines, tap to expand), a progress hint while the
/// transcript is being produced, or an "unavailable" note when it failed.
/// Nothing is rendered when transcription is disabled.
class _VoicemailTranscript extends StatefulWidget {
  const _VoicemailTranscript({required this.voicemail});

  final Voicemail voicemail;

  @override
  State<_VoicemailTranscript> createState() => _VoicemailTranscriptState();
}

class _VoicemailTranscriptState extends State<_VoicemailTranscript> {
  static const _collapsedMaxLines = 3;

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant);

    final voicemail = widget.voicemail;
    final transcript = voicemail.transcript;

    final Widget? content;
    if (voicemail.transcriptStatus.isDone && transcript != null && transcript.isNotEmpty) {
      content = GestureDetector(
        onTap: () => setState(() => _expanded = !_expanded),
        child: Text(
          transcript,
          style: textStyle,
          maxLines: _expanded ? null : _collapsedMaxLines,
          overflow: _expanded ? null : TextOverflow.ellipsis,
        ),
      );
    } else if (voicemail.transcriptStatus.isInProgress) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedCircularProgressIndicator(size: 10, outerSize: 12, color: colorScheme.tertiary, strokeWidth: 1),
          const SizedBox(width: 8),
          Text(context.l10n.voicemail_Transcript_inProgress, style: textStyle),
        ],
      );
    } else if (voicemail.transcriptStatus.isUnavailable) {
      content = Text(
        context.l10n.voicemail_Transcript_unavailable,
        style: textStyle?.copyWith(fontStyle: FontStyle.italic),
      );
    } else {
      content = null;
    }

    if (content == null) return const SizedBox.shrink();

    return Padding(padding: const EdgeInsets.only(top: 8), child: content);
  }
}

enum _VoicemailMenuAction { call, toggleSeenStatus, delete }
