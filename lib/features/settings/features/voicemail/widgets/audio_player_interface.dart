import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';

import 'audio_slider.dart';
import 'playback_button.dart';

class AudioPlayerInterface extends StatelessWidget {
  const AudioPlayerInterface({super.key, required this.player, required this.onToggle, required this.onSeek});

  final AudioPlayer player;
  final VoidCallback onToggle;
  final ValueChanged<Duration> onSeek;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: player.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration = player.duration ?? Duration.zero;
        final clampedPosition = position > duration ? duration : position;

        return Row(
          children: [
            PlaybackButton(playing: player.playing, onPressed: onToggle),
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
