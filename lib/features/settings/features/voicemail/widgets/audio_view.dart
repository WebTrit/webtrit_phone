import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

import '../models/models.dart';

class AudioView extends StatefulWidget {
  const AudioView({
    super.key,
    required this.path,
    this.header,
    this.onPlaybackStarted,
  });

  final String path;
  final Map<String, String>? header;

  // Callback triggered when playback starts, useful for marking the audio as seen
  final VoidCallback? onPlaybackStarted;

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> with WidgetsBindingObserver {
  final _player = AudioPlayer();

  late final StreamSubscription _playbackSub;
  late final String _cachePath;
  late final Uri _uri;

  Future<void> _setupAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  File? _cacheFile() {
    if (widget.path.isLocalPath) return null;
    return File('$_cachePath${_uri.path}');
  }

  AudioSource _audioSource() {
    if (widget.path.isLocalPath) {
      return AudioSource.uri(_uri);
    } else {
      return LockCachingAudioSource(
        _uri,
        headers: widget.header,
        cacheFile: _cacheFile(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cachePath = context.read<VoicemailScreenContext>().mediaCacheBasePath;
    _uri = Uri.parse(widget.path);
    _init();
  }

  // TODO(Serdun): Sync with Vladislav manager
  Future<void> _init() async {
    await _setupAudioSession();
    await _player.setAudioSource(_audioSource());

    _playbackSub = _player.playbackEventStream.listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _playbackSub.cancel();
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) _player.stop();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.zero,
      child: StreamBuilder<Duration>(
        stream: _player.positionStream,
        builder: (context, snapshot) {
          final position = snapshot.data ?? Duration.zero;
          final duration = _player.duration ?? Duration.zero;

          final clampedPosition = position > duration ? duration : position;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _togglePlayback,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary,
                  ),
                  child: Icon(
                    _player.playing ? Icons.pause : Icons.play_arrow,
                    color: colorScheme.onPrimary,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AudioSlider(
                  position: clampedPosition,
                  duration: duration,
                  onSeek: (newPosition) => _player.seek(newPosition),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _togglePlayback() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      widget.onPlaybackStarted?.call();
      await _player.play();
    }
  }
}

class AudioSlider extends StatelessWidget {
  const AudioSlider({
    super.key,
    required this.position,
    required this.duration,
    required this.onSeek,
  });

  final Duration position;
  final Duration duration;
  final ValueChanged<Duration> onSeek;

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
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
          max: duration.inMilliseconds.toDouble().clamp(1.0, double.infinity),
          onChanged: (value) => onSeek(Duration(milliseconds: value.toInt())),
          activeColor: colorScheme.primary,
          inactiveColor: colorScheme.onSurface.withValues(alpha: 0.1),
        ),
        Transform.translate(
          offset: const Offset(0, 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatDuration(clampedPosition),
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
              Text(
                _formatDuration(duration),
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
