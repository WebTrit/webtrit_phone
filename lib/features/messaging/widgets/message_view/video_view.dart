import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http_cache_stream/http_cache_stream.dart';
import 'package:video_player/video_player.dart';

import 'package:webtrit_phone/extensions/duration.dart';
import 'package:webtrit_phone/features/messaging/extensions/string_path_utils.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_view/multisource_image_view.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_view/video_thumbnail_builder.dart';

class VideoView extends StatefulWidget {
  const VideoView(this.path, {super.key});

  final String path;

  @override
  VideoViewState createState() => VideoViewState();
}

class VideoViewState extends State<VideoView> {
  late final _cacheStream = HttpCacheManager.instance.createStream(Uri.parse(widget.path));
  late final _controller = widget.path.isLocalPath
      ? VideoPlayerController.file(File(widget.path))
      : VideoPlayerController.networkUrl(_cacheStream.cacheUrl);

  bool _showControls = false;
  Timer? _hideControlsTimer;
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
    _cacheStream.dispose();
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
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showControls = false);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_controller.value.isInitialized == false) {
      return Container(
        color: Colors.black,
        child: VideoThumbnailBuilder(
          widget.path,
          (File? file) {
            return Stack(
              children: [
                if (file != null) Positioned.fill(child: MultisourceImageView(file.path, fit: BoxFit.contain)),
                const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      );
    }

    return Container(
      color: Colors.black,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Center(child: AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller))),
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
                    icon: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.secondary.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: colorScheme.onSecondary,
                      ),
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
                  height: 64,
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
    );
  }
}
