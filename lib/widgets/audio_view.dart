import 'dart:async';

import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

class AudioView extends StatefulWidget {
  const AudioView(this.path, {super.key});

  final String path;

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
    final audioSource= AudioSource.uri(pathUri) ;

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
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.path.fileName,
                  style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.audiotrack, size: 16, color: Colors.grey.shade600),
            ],
          ),
          SizedBox(
            height: 32,
            child: Row(
              children: [
                if (_player.playing)
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.pause),
                    onPressed: () async {
                      await _player.pause();
                    },
                  )
                else
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () async {
                      await _player.play();
                    },
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Slider(
                    padding: EdgeInsets.zero,
                    value: _player.position.inSeconds.toDouble(),
                    min: 0,
                    max: _player.duration?.inSeconds.toDouble() ?? 1,
                    onChanged: (value) {
                      _player.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
