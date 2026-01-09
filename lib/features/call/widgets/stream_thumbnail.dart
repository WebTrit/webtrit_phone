import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

/// A responsive widget that renders a WebRTC [MediaStream].
///
/// This widget handles the initialization and disposal of the [RTCVideoRenderer].
class StreamThumbnail extends StatefulWidget {
  const StreamThumbnail({
    super.key,
    required this.stream,
    this.placeholderBuilder,
    this.objectFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
    this.mirror = false,
  });

  /// The media stream to display.
  final MediaStream? stream;

  /// Builder for the placeholder shown when video is unavailable.
  final WidgetBuilder? placeholderBuilder;

  /// How the video is fitted inside the thumbnail.
  final RTCVideoViewObjectFit objectFit;

  /// If true, mirror the video horizontally (useful for local/self view).
  final bool mirror;

  @override
  State<StreamThumbnail> createState() => _StreamThumbnailState();
}

class _StreamThumbnailState extends State<StreamThumbnail> {
  final RTCVideoRenderer _renderer = RTCVideoRenderer();
  bool _isRendererInitialized = false;

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
    _isRendererInitialized = true;
    if (mounted) _updateSrcObject();
  }

  void _updateSrcObject() {
    if (_isRendererInitialized) {
      setState(() => _renderer.srcObject = widget.stream);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RTCVideoView(
      _renderer,
      objectFit: widget.objectFit,
      mirror: widget.mirror,
      placeholderBuilder: widget.placeholderBuilder,
    );
  }

  @override
  void dispose() {
    if (_isRendererInitialized) _renderer.srcObject = null;
    _renderer.dispose();
    super.dispose();
  }
}
