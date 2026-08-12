import 'package:flutter/material.dart';

/// The round play / pause button of a voicemail row.
///
/// Shared by the idle row and the active player so the two states cannot
/// drift apart: same size, same colours, same icon rules in one place.
class PlaybackButton extends StatelessWidget {
  const PlaybackButton({super.key, required this.playing, required this.onPressed});

  /// Whether playback is running, which is what the button offers to stop.
  final bool playing;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.primary),
        child: Icon(playing ? Icons.pause : Icons.play_arrow, color: colorScheme.onPrimary, size: 24),
      ),
    );
  }
}
