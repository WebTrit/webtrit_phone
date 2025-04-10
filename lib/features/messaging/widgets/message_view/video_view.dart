import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:webtrit_phone/data/media_storage.dart';

import 'package:webtrit_phone/extensions/duration.dart';
import 'package:webtrit_phone/features/messaging/extensions/string_path_utils.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_view/multisource_image_view.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_view/video_thumbnail_builder.dart';

class VideoView extends StatefulWidget {
  const VideoView(
    this.path, {
    super.key,
    this.onControlsDisplayChanged,
  });

  final String path;
  final Function(bool value)? onControlsDisplayChanged;

  @override
  VideoViewState createState() => VideoViewState();
}

class VideoViewState extends State<VideoView> {
  late final VideoPlayerController _controller;

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
    init();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  init() async {
    if (widget.path.isLocalPath) {
      _controller = VideoPlayerController.file(File(widget.path));
    } else {
      final cachedFile = MediaStorage().getFileIfExist(widget.path);
      if (cachedFile != null) {
        _controller = VideoPlayerController.file(cachedFile);
      } else {
        final cacheStreamUri = MediaStorage().getCacheStreamUrl(widget.path);
        _controller = VideoPlayerController.networkUrl(cacheStreamUri);
      }
    }

    _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.play();
      setState(() {});
      notifyControlsDisplayChanged();
      _controller.addListener(() => setState(() {}));
    });
  }

  Future<void> onSeek(double value) async {
    if (showControls == false) return;
    final duration = Duration(seconds: value.toInt());
    if (_controller.value.isPlaying == true) _seekTo = duration;
    setState(() {});
    notifyControlsDisplayChanged();

    await _controller.seekTo(duration);
  }

  void onPlayPause() {
    if (showControls == false) return;
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
    setState(() {});
    notifyControlsDisplayChanged();
  }

  void onTap() {
    _showControls = !_showControls;
    _hideControlsTimer?.cancel();
    setState(() {});
    notifyControlsDisplayChanged();

    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showControls = false);
      notifyControlsDisplayChanged();
    });
  }

  void notifyControlsDisplayChanged() {
    widget.onControlsDisplayChanged?.call(showControls);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_controller.value.isInitialized == false) {
      return VideoThumbnailBuilder(
        widget.path,
        (File? file) {
          return Stack(
            children: [
              if (file != null)
                Positioned.fill(
                    child: MultisourceImageView(
                  file.path,
                  fit: BoxFit.contain,
                  placeholder: const SizedBox(),
                  error: const SizedBox(),
                )),
              const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
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
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
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
                      const SizedBox(width: 16),
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
