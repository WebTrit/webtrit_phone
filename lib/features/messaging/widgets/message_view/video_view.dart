import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:webtrit_phone/extensions/duration.dart';

class VideoView extends StatefulWidget {
  const VideoView(this.path, {super.key});

  final String path;

  @override
  VideoViewState createState() => VideoViewState();
}

class VideoViewState extends State<VideoView> {
  late final _controller = VideoPlayerController.networkUrl(Uri.parse(widget.path));

  Timer? _showControlsTimer;
  bool _showControls = false;
  Duration? _seekTo;

  bool get showControls {
    if (_controller.value.isPlaying == false) return true;
    return _showControls;
  }

  bool get seeking {
    if (_seekTo == _controller.value.position) return true;
    return false;
  }

  @override
  void initState() {
    super.initState();
    _controller.initialize().then((_) {
      setState(() {});
      _controller.addListener(() => setState(() {}));
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> onSeek(double value) async {
    if (showControls == false) return;
    final duration = Duration(seconds: value.toInt());
    if (_controller.value.isPlaying == true) _seekTo = duration;
    setState(() {});
    await _controller.seekTo(duration);
  }

  void onPlayPause() {
    if (showControls == false) return;
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
    setState(() {});
  }

  void onTap() {
    _showControls = true;
    _showControlsTimer?.cancel();
    _showControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showControls = false);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_controller.value.isInitialized == false) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(_controller),
              if (seeking)
                Center(
                  child: CircularProgressIndicator(
                    color: colorScheme.primary,
                  ),
                ),
              if (!seeking)
                Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: showControls ? 1 : 0,
                    child: IconButton(
                      onPressed: onPlayPause,
                      icon: Icon(
                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: showControls ? 1 : 0,
                  child: Container(
                    height: 32,
                    width: double.infinity,
                    color: colorScheme.secondary.withValues(alpha: 0.5),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Slider(
                            padding: EdgeInsets.zero,
                            value: _controller.value.position.inSeconds.toDouble(),
                            min: 0,
                            max: _controller.value.duration.inSeconds.toDouble(),
                            onChanged: onSeek,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_controller.value.position.format()} / ${_controller.value.duration.format()}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
