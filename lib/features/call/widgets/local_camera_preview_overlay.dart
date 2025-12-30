import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'rtc_stream_view.dart';

/// A Local-camera preview shown on top of the call screen.
///
/// This widget renders a small video thumbnail for the local [localStream]
/// (typically the front/back camera stream) and overlays a camera-switch control.
class LocalCameraPreviewOverlay extends StatelessWidget {
  /// Creates a [LocalCameraPreviewOverlay].
  const LocalCameraPreviewOverlay({
    super.key,

    /// Whether the call UI is in compact mode.
    ///
    /// When `true`, the preview moves closer to the top edge.
    required this.compact,

    /// The current device orientation.
    ///
    /// Used to compute preview width/height depending on how the screen is rotated.
    required this.orientation,

    /// Safe-area padding (e.g., notches, system bars).
    ///
    /// The overlay positions itself relative to these insets.
    required this.padding,

    /// Color used for the preview background tint and icon/progress indicator.
    required this.onTabGradient,

    /// Size of the camera-switch icon (and progress indicator outer size).
    required this.switchCameraIconSize,

    /// Indicates whether the preview should be mirrored.
    ///
    /// - `true`: mirror the preview (common for front camera).
    /// - `false`: do not mirror (common for back camera).
    /// - `null`: switching is unavailable yet; shows a loader instead of video.
    required this.frontCamera,

    /// The local WebRTC media stream to display.
    ///
    /// When `null`, no video is rendered (placeholder/empty).
    required this.localStream,

    /// Callback invoked when the user taps the overlay to switch cameras.
    ///
    /// This is injected to keep UI independent from state management (DI).
    /// If `null`, switching is disabled.
    required this.onSwitchCameraPressed,

    /// Builder used when the local stream cannot be rendered yet.
    ///
    /// Passed through to [RTCStreamView] as `placeholderBuilder`.
    required this.localPlaceholderBuilder,

    /// Animation duration for repositioning.
    this.duration = kThemeChangeDuration,

    /// The smaller side (in logical pixels) of the preview.
    ///
    /// The other side is computed using the stream aspect ratio.
    this.smallerSide = 90.0,
  });

  /// Whether the call UI is in compact mode (affects overlay vertical offset).
  final bool compact;

  /// Current device orientation (affects computed preview dimensions).
  final Orientation orientation;

  /// Safe-area padding for positioning within notches/system bars.
  final EdgeInsets padding;

  /// Color used for background tint and overlay icon/progress indicator.
  final Color onTabGradient;

  /// Camera switch icon size (also used by the loading indicator).
  final double switchCameraIconSize;

  /// Whether to mirror the local preview; `null` indicates camera state is loading.
  final bool? frontCamera;

  /// The local WebRTC stream to display.
  final MediaStream? localStream;

  /// Tap callback for switching the camera. If `null`, switching is disabled.
  final VoidCallback? onSwitchCameraPressed;

  /// Placeholder builder shown by [RTCStreamView] when stream is not ready.
  final WidgetBuilder? localPlaceholderBuilder;

  /// Animation duration used by [AnimatedPositioned].
  final Duration duration;

  /// The smaller side of the preview; the other side is derived from aspect ratio.
  final double smallerSide;

  @override
  Widget build(BuildContext context) {
    final isSwitchEnabled = frontCamera != null && onSwitchCameraPressed != null;

    final Size frameSize = _calcFrameSize(
      orientation: orientation,
      smallerSide: smallerSide,
      videoWidth: _safeVideoWidth(localStream),
      videoHeight: _safeVideoHeight(localStream),
    );

    return AnimatedPositioned(
      right: 10 + padding.right,
      top: 10 + padding.top + (compact ? 0 : 100),
      duration: duration,
      child: GestureDetector(
        onTap: isSwitchEnabled ? onSwitchCameraPressed : null,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(color: onTabGradient.withValues(alpha: 0.3)),
                width: frameSize.width,
                height: frameSize.height,
                child: frontCamera == null
                    ? null
                    : RTCStreamView(
                        key: callFrontCameraPreviewKey,
                        stream: localStream,
                        mirror: frontCamera!,
                        placeholderBuilder: localPlaceholderBuilder,
                      ),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: frontCamera == null
                  ? SizedCircularProgressIndicator(
                      size: switchCameraIconSize - 2.0,
                      outerSize: switchCameraIconSize,
                      color: onTabGradient,
                      strokeWidth: 2.0,
                    )
                  : Icon(Icons.flip_camera_ios, size: switchCameraIconSize, color: onTabGradient),
            ),
          ],
        ),
      ),
    );
  }

  /// Computes the preview frame size based on orientation and video aspect ratio.
  ///
  /// - [smallerSide] is kept fixed.
  /// - The other side is derived from `videoWidth / videoHeight`.
  /// - The aspect ratio is clamped to avoid extreme sizes when track settings are absent/invalid.
  static Size _calcFrameSize({
    required Orientation orientation,
    required double smallerSide,
    required double videoWidth,
    required double videoHeight,
  }) {
    final safeH = videoHeight <= 0 ? 1.0 : videoHeight;
    final aspectRatio = videoWidth / safeH;

    final safeAspect = aspectRatio.isFinite ? aspectRatio.clamp(0.5, 3.0) : 1.5;

    final biggerSide = smallerSide * safeAspect;

    final frameWidth = orientation == Orientation.portrait ? smallerSide : biggerSide;
    final frameHeight = orientation == Orientation.portrait ? biggerSide : smallerSide;

    return Size(frameWidth, frameHeight);
  }

  /// Reads the video track width from [MediaStream.getVideoTracks] settings.
  ///
  /// Returns a sensible fallback (1080) if:
  /// - stream or track is missing,
  /// - settings don't contain `width`,
  /// - an exception occurs.
  static double _safeVideoWidth(MediaStream? localStream) {
    try {
      final track = localStream?.getVideoTracks().first;
      final w = track?.getSettings()['width'];
      return (w is num) ? w.toDouble() : 1080.0;
    } catch (_) {
      return 1080.0;
    }
  }

  /// Reads the video track height from [MediaStream.getVideoTracks] settings.
  ///
  /// Returns a sensible fallback (720) if:
  /// - stream or track is missing,
  /// - settings don't contain `height`,
  /// - an exception occurs.
  static double _safeVideoHeight(MediaStream? localStream) {
    try {
      final track = localStream?.getVideoTracks().first;
      final h = track?.getSettings()['height'];
      return (h is num) ? h.toDouble() : 720.0;
    } catch (_) {
      return 720.0;
    }
  }
}
