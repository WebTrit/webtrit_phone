import 'dart:async';

import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

class AudioView extends StatefulWidget {
  const AudioView(this.path, {super.key, this.header});

  final String path;
  final Map<String, String>? header;

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> with WidgetsBindingObserver {
  final _player = AudioPlayer();
  late final StreamSubscription _playbackSub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    final pathUri = Uri.parse(widget.path);
    final audioSource =
        widget.path.isLocalPath ? AudioSource.uri(pathUri) : LockCachingAudioSource(pathUri, headers: widget.header);

    await _player.setAudioSource(audioSource);
    _playbackSub = _player.playbackEventStream.listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _player.dispose();
    _playbackSub.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) _player.stop();
  }

  @override
  Widget build(BuildContext context) {
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
              // Кнопка Play / Pause
              GestureDetector(
                onTap: () async {
                  _player.playing ? await _player.pause() : await _player.play();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF5B8ECF), // синій відтінок
                  ),
                  child: Icon(
                    _player.playing ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Stack(
                  children: [
                    Slider(
                      padding: EdgeInsets.zero,
                      value: clampedPosition.inMilliseconds.toDouble(),
                      max: duration.inMilliseconds.toDouble().clamp(1.0, double.infinity),
                      onChanged: (value) {
                        _player.seek(Duration(milliseconds: value.toInt()));
                      },
                      activeColor: const Color(0xFF5B8ECF),
                      inactiveColor: const Color(0xFFBBD0E9),
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
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(width: 4),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green, // Replace with desired color
                                ),
                              ),
                            ],
                          ),
                          Text(
                            _formatDuration(duration),
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
