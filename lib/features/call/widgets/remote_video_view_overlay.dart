import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'rtc_stream_view.dart';

/// A remote video stream overlay that fills the entire call screen.
///
/// This widget handles the display of the remote participant's video. If
/// [videoFit] is set to [RTCVideoViewObjectFit.RTCVideoViewObjectFitContain]
/// and [enableBlurredBackground] is true, it renders a blurred version of the
/// stream behind the main video to fill the empty space.
class RemoteVideoViewOverlay extends StatelessWidget {
  /// Creates a [RemoteVideoViewOverlay].
  const RemoteVideoViewOverlay({
    required this.activeCallWasAccepted,
    required this.remoteStream,
    required this.videoFit,
    required this.onTap,
    super.key,
    this.remotePlaceholderBuilder,
    this.enableBlurredBackground = true,
  });

  /// Whether the call has been accepted and is currently active.
  ///
  /// If false, [onTap] events are ignored.
  final bool activeCallWasAccepted;

  /// The WebRTC media stream to display.
  final MediaStream? remoteStream;

  /// How the video should fit within the bounds of the screen.
  ///
  /// Affects whether the background blur effect is shown.
  final RTCVideoViewObjectFit videoFit;

  /// Callback triggered when the user taps the video overlay.
  ///
  /// Only triggered if [activeCallWasAccepted] is true.
  final VoidCallback onTap;

  /// Optional builder for a placeholder widget while the stream is initializing
  /// or missing.
  final WidgetBuilder? remotePlaceholderBuilder;

  /// Whether to render a blurred background behind the video.
  ///
  /// This effect only applies when [videoFit] is set to
  /// [RTCVideoViewObjectFit.RTCVideoViewObjectFitContain], preventing black
  /// bars by filling the screen with a blurred copy of the stream.
  final bool enableBlurredBackground;

  bool get _shouldShowBlurredBackground =>
      enableBlurredBackground && videoFit == RTCVideoViewObjectFit.RTCVideoViewObjectFitContain;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: activeCallWasAccepted ? onTap : null,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_shouldShowBlurredBackground) _BlurredBackground(stream: remoteStream),
            RTCStreamView(stream: remoteStream, placeholderBuilder: remotePlaceholderBuilder, fit: videoFit),
          ],
        ),
      ),
    );
  }
}

class _BlurredBackground extends StatelessWidget {
  const _BlurredBackground({required this.stream});

  final MediaStream? stream;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30, tileMode: TileMode.mirror),
          child: RTCStreamView(
            stream: stream,
            fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            placeholderBuilder: null,
          ),
        ),
        Container(color: theme.colorScheme.scrim.withValues(alpha: 0.3)),
      ],
    );
  }
}
