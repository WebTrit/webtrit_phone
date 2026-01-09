import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

/// A widget that renders a WebRTC [MediaStream] within a thumbnail container.
///
/// This widget handles the initialization and disposal of the [RTCVideoRenderer].
/// It automatically adjusts its dimensions based on the video's aspect ratio
/// (portrait vs landscape) to either 90x120 or 120x90.
class StreamThumbnail extends StatefulWidget {
  const StreamThumbnail({
    required this.stream,
    super.key,
    this.placeholderBuilder,
    this.overlayBuilder,
    this.objectFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
    this.mirror = false,
  });

  /// The media stream to display.
  final MediaStream? stream;

  /// Builder for the placeholder shown when video is unavailable.
  final WidgetBuilder? placeholderBuilder;

  /// Builder for UI overlay displayed on top of the video.
  final WidgetBuilder? overlayBuilder;

  final RTCVideoViewObjectFit objectFit;
  final bool mirror;

  @override
  State<StreamThumbnail> createState() => _StreamThumbnailState();
}

class _StreamThumbnailState extends State<StreamThumbnail> {
  late final RTCVideoRenderer _renderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _initializeRenderer();
  }

  @override
  void didUpdateWidget(StreamThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stream != oldWidget.stream) {
      _updateSrcObject();
    }
  }

  Future<void> _initializeRenderer() async {
    await _renderer.initialize();
    if (mounted) _updateSrcObject();
  }

  void _updateSrcObject() {
    setState(() => _renderer.srcObject = widget.stream);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RTCVideoValue>(
      valueListenable: _renderer,
      builder: (context, value, child) => _ThumbnailSizer(value: value, child: child!),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            RTCVideoView(
              _renderer,
              objectFit: widget.objectFit,
              mirror: widget.mirror,
              placeholderBuilder: widget.placeholderBuilder,
            ),
            if (widget.overlayBuilder != null) widget.overlayBuilder!(context),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _renderer.srcObject = null;
    _renderer.dispose();
    super.dispose();
  }
}

class _ThumbnailSizer extends StatelessWidget {
  const _ThumbnailSizer({required this.value, required this.child});

  final RTCVideoValue value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isPortrait = !value.renderVideo || value.aspectRatio < 1;

    return SizedBox(width: isPortrait ? 90 : 120, height: isPortrait ? 120 : 90, child: child);
  }
}
