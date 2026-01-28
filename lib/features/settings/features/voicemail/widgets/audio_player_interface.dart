import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';

import 'audio_slider.dart';

class AudioPlayerInterface extends StatelessWidget {
  const AudioPlayerInterface({super.key, required this.player, required this.onToggle, required this.onSeek});

  final AudioPlayer player;
  final VoidCallback onToggle;
  final ValueChanged<Duration> onSeek;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<Duration>(
      stream: player.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration = player.duration ?? Duration.zero;
        final clampedPosition = position > duration ? duration : position;

        return Row(
          children: [
            GestureDetector(
              onTap: onToggle,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.primary),
                child: Icon(player.playing ? Icons.pause : Icons.play_arrow, color: colorScheme.onPrimary, size: 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AudioSlider(position: clampedPosition, duration: duration, onSeek: onSeek),
            ),
          ],
        );
      },
    );
  }
}
