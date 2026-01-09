import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../utils/utils.dart';
import 'stream_thumbnail.dart';

/// Local camera preview thumbnail intended for use inside a draggable overlay.
///
/// Displays the provided local WebRTC [localStream] (front or rear camera)
/// using [StreamThumbnail], and overlays a camera-switch control. The widget
/// adapts to the current [orientation] and exposes a tap callback to switch cameras.
class LocalCameraPreviewThumbnail extends StatelessWidget {
  /// Creates a [LocalCameraPreviewThumbnail].
  const LocalCameraPreviewThumbnail({
    super.key,
    required this.orientation,
    required this.onTabGradient,
    required this.switchCameraIconSize,
    required this.frontCamera,
    required this.localStream,
    required this.onSwitchCameraPressed,
    required this.localPlaceholderBuilder,
    this.smallerSide = ThumbnailLayout.defaultSmallerSide,
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

  /// Placeholder builder shown by [StreamThumbnail] when stream is not ready.
  final WidgetBuilder localPlaceholderBuilder;

  /// The smaller side of the preview; the other side is derived from aspect ratio.
  final double smallerSide;

  @override
  Widget build(BuildContext context) {
    final frameSize = ThumbnailLayout.calcFrameSize(orientation: orientation, smallerSide: smallerSide);

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
              StreamThumbnail(
                key: callFrontCameraPreviewKey,
                stream: hasFrontCamera ? localStream : null,
                mirror: frontCamera ?? false,
                placeholderBuilder: localPlaceholderBuilder,
              ),
              Positioned(top: 8, right: 8, child: indicatorWidget),
            ],
          ),
        ),
      ),
    );
  }
}
