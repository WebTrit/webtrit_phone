import 'package:flutter/material.dart';

class AudioSlider extends StatelessWidget {
  const AudioSlider({super.key, required this.position, required this.duration, required this.onSeek});

  final Duration position;
  final Duration duration;
  final ValueChanged<Duration> onSeek;

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _handleChanged(double value) {
    onSeek(Duration(milliseconds: value.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final clampedPosition = position > duration ? duration : position;

    return Stack(
      children: [
        Slider(
          padding: EdgeInsets.zero,
          value: clampedPosition.inMilliseconds.toDouble(),
          max: duration.inMilliseconds.toDouble().clamp(1, double.infinity),
          onChanged: _handleChanged,
          activeColor: colorScheme.primary,
          inactiveColor: colorScheme.onSurface.withValues(alpha: 0.1),
        ),
        Transform.translate(
          offset: const Offset(0, 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(clampedPosition),
                style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.5)),
              ),
              Text(
                _formatDuration(duration),
                style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.5)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
