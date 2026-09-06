import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// The round play / pause button of a voicemail row.
///
/// Shared by the idle row and the active player so both states expose the same
/// control to assistive technology: one node that says what the press will do
/// and carries the same identifier either way.
class PlaybackButton extends StatelessWidget {
  const PlaybackButton({super.key, required this.playing, required this.onPressed});

  /// Whether playback is running, which is what the button offers to stop.
  final bool playing;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SemanticAction.button(
      label: playing ? context.l10n.voicemail_SemanticsLabel_pause : context.l10n.voicemail_SemanticsLabel_play,
      identifier: voicemailPlaybackId,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.primary),
          child: Icon(playing ? Icons.pause : Icons.play_arrow, color: colorScheme.onPrimary, size: 24),
        ),
      ),
    );
  }
}
