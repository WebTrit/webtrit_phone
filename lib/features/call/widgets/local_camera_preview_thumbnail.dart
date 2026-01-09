import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'rtc_stream_view.dart';

/// A Local-camera preview intended to be used within a draggable overlay.
///
/// This widget renders a video thumbnail for the local [localStream]
/// (typically the front/back camera stream) and overlays a camera-switch control.
/// It calculates its own size based on the [orientation] and stream aspect ratio.
class LocalCameraPreviewThumbnail extends StatelessWidget {
  /// Creates a [LocalCameraPreviewThumbnail].
  const LocalCameraPreviewThumbnail({
    super.key,

    /// The current device orientation.
    ///
    /// Used to compute preview width/height depending on how the screen is rotated.
    required this.orientation,

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
    /// If `null`, switching is disabled.
    required this.onSwitchCameraPressed,

    /// Builder used when the local stream cannot be rendered yet.
    ///
    /// Passed through to [RTCStreamView] as `placeholderBuilder`.
    required this.localPlaceholderBuilder,

    /// The smaller side (in logical pixels) of the preview.
    ///
    /// The other side is computed using the stream aspect ratio.
    this.smallerSide = 90.0,
  });

  /// Current device orientation (affects computed preview dimensions).
  final Orientation orientation;

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
  final WidgetBuilder localPlaceholderBuilder;

  /// The smaller side of the preview; the other side is derived from aspect ratio.
  final double smallerSide;

  @override
  Widget build(BuildContext context) {
    final frameSize = _calcFrameSize(orientation: orientation, smallerSide: smallerSide);

    final hasFrontCamera = frontCamera != null;
    final isSwitchEnabled = hasFrontCamera && onSwitchCameraPressed != null;

    final indicatorWidget = !hasFrontCamera
        ? SizedCircularProgressIndicator(
            size: switchCameraIconSize - 2,
            outerSize: switchCameraIconSize,
            color: onTabGradient,
            strokeWidth: 2,
          )
        : Icon(Icons.flip_camera_ios, size: switchCameraIconSize, color: onTabGradient);

    return SizedBox.fromSize(
      size: frameSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: isSwitchEnabled ? onSwitchCameraPressed : null,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (!hasFrontCamera) localPlaceholderBuilder(context),
              if (hasFrontCamera && localStream != null)
                RTCStreamView(
                  key: callFrontCameraPreviewKey,
                  stream: localStream,
                  mirror: frontCamera!,
                  fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  placeholderBuilder: localPlaceholderBuilder,
                ),
              Positioned(top: 4, right: 4, child: indicatorWidget),
            ],
          ),
        ),
      ),
    );
  }

  /// Computes the preview frame size based on orientation and a fixed 16:9 aspect ratio.
  static Size _calcFrameSize({required Orientation orientation, required double smallerSide}) {
    // Standard aspect ratio for mobile cameras (16:9).
    // Using a fixed constant ensures the UI does not jitter during stream loading.
    const aspectRatio = 16.0 / 9.0;

    final biggerSide = smallerSide * aspectRatio;

    final frameWidth = orientation == Orientation.portrait ? smallerSide : biggerSide;
    final frameHeight = orientation == Orientation.portrait ? biggerSide : smallerSide;

    return Size(frameWidth, frameHeight);
  }
}
