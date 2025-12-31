import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'rtc_stream_view.dart';

/// Defines the visual style for the background when the video does not fill the screen.
///
/// This is used when the video fit is set to contain, leaving empty space
/// around the active video stream.
enum VideoBackgroundMode {
  /// No background effect. Usually renders black or transparent.
  none,

  /// Applies a Gaussian blur to the stretched video stream.
  ///
  /// This creates a visually pleasing ambient effect but has a higher GPU cost.
  blur,

  /// Applies a simple dark overlay over the stretched video without blur.
  ///
  /// This is the most performance-efficient option while still providing context.
  dimmed,
}

/// A remote video stream overlay that fills the entire call screen.
///
/// This widget manages the display of the remote participant's video, including
/// gesture handling for toggling UI controls and rendering ambient backgrounds
/// when the video aspect ratio does not match the screen.
class RemoteVideoViewOverlay extends StatelessWidget {
  /// Creates a [RemoteVideoViewOverlay].
  const RemoteVideoViewOverlay({
    required this.activeCallWasAccepted,
    required this.remoteStream,
    required this.videoFit,
    required this.onTap,
    super.key,
    this.remotePlaceholderBuilder,
    this.backgroundMode = VideoBackgroundMode.blur,
  });

  /// Whether the call has been accepted and is currently active.
  ///
  /// Interaction is disabled if the call is not yet accepted.
  final bool activeCallWasAccepted;

  /// The WebRTC media stream received from the remote participant.
  final MediaStream? remoteStream;

  /// How the video should fit within the bounds of the screen.
  final RTCVideoViewObjectFit videoFit;

  /// Callback triggered when the user taps the video overlay.
  final VoidCallback onTap;

  /// Optional builder for a placeholder widget while the stream is initializing.
  final WidgetBuilder? remotePlaceholderBuilder;

  /// Determines how the empty space behind the video is rendered.
  ///
  /// Only applies when [videoFit] is [RTCVideoViewObjectFit.RTCVideoViewObjectFitContain].
  /// Defaults to [VideoBackgroundMode.blur].
  final VideoBackgroundMode backgroundMode;

  bool get _shouldRenderBackground =>
      videoFit == RTCVideoViewObjectFit.RTCVideoViewObjectFitContain && backgroundMode != VideoBackgroundMode.none;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: activeCallWasAccepted ? onTap : null,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_shouldRenderBackground) _BackgroundLayer(stream: remoteStream, mode: backgroundMode),
            RTCStreamView(stream: remoteStream, placeholderBuilder: remotePlaceholderBuilder, fit: videoFit),
          ],
        ),
      ),
    );
  }
}

/// A private widget responsible for rendering the ambient background layer.
///
/// It displays a stretched version of the video stream with either a blur
/// effect or a dimming overlay, based on the provided [mode].
class _BackgroundLayer extends StatelessWidget {
  /// Creates a [_BackgroundLayer].
  const _BackgroundLayer({required this.stream, required this.mode});

  /// The video stream to use for the background generation.
  final MediaStream? stream;

  /// The display mode (blur or dimmed).
  final VideoBackgroundMode mode;

  @override
  Widget build(BuildContext context) {
    // The background layer always stretches the video to cover the space
    // to create the ambient effect.
    final videoLayer = RTCStreamView(
      stream: stream,
      fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
      placeholderBuilder: null,
    );

    final isBlur = mode == VideoBackgroundMode.blur;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (isBlur)
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30, tileMode: TileMode.mirror),
            child: videoLayer,
          )
        else
          videoLayer,
        _BackgroundScrim(isBlur: isBlur),
      ],
    );
  }
}

/// A private widget that applies a colored overlay (scrim) on top of the background.
///
/// This ensures the background remains subtle and does not distract from the
/// main video content.
class _BackgroundScrim extends StatelessWidget {
  /// Creates a [_BackgroundScrim].
  const _BackgroundScrim({required this.isBlur});

  /// Whether the underlying layer is blurred.
  ///
  /// If true, a lighter alpha is used to maintain vibrancy.
  /// If false, a darker alpha is used to push the background back visually.
  final bool isBlur;

  @override
  Widget build(BuildContext context) {
    final scrimColor = Theme.of(context).colorScheme.scrim;

    final alpha = isBlur ? 0.3 : 0.85;

    return Container(color: scrimColor.withValues(alpha: alpha));
  }
}
