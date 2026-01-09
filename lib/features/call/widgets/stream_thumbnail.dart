import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

/// A responsive widget that renders a WebRTC [MediaStream].
///
/// This widget handles the initialization and disposal of the [RTCVideoRenderer].
/// It fills the constraints provided by its parent (e.g., a specific [SizedBox]).
class StreamThumbnail extends StatefulWidget {
  const StreamThumbnail({
    super.key,
    required this.stream,
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

  /// How the video is fitted inside the thumbnail.
  /// Defaults to `RTCVideoViewObjectFit.RTCVideoViewObjectFitCover`.
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
    return Stack(
      fit: StackFit.expand,
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
    );
  }

  @override
  void dispose() {
    // Prevent "Call initialize before setting the stream" error
    // by checking initialization status before accessing srcObject.
    if (_isRendererInitialized) _renderer.srcObject = null;

    _renderer.dispose();
    super.dispose();
  }
}
