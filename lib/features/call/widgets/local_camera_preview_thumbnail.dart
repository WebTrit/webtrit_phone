import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../utils/utils.dart';
import 'stream_thumbnail.dart';
import 'thumbnail_frame.dart';

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
    required this.frontCamera,
    required this.localStream,
    required this.onSwitchCameraPressed,
    this.smallerSide = ThumbnailLayout.defaultSmallerSide,
  });

  /// Current device orientation (affects computed preview dimensions).
  final Orientation orientation;

  /// Whether to mirror the local preview; `null` indicates camera state is loading.
  final bool? frontCamera;

  /// The local WebRTC stream to display.
  final MediaStream? localStream;

  /// Tap callback for switching the camera. If `null`, switching is disabled.
  final VoidCallback? onSwitchCameraPressed;

  /// The smaller side of the preview; the other side is derived from aspect ratio.
  final double smallerSide;

  @override
  Widget build(BuildContext context) {
    final hasFrontCamera = frontCamera != null;
    final isSwitchEnabled = hasFrontCamera && onSwitchCameraPressed != null;

    final themeData = Theme.of(context);
    final switchCameraIconSize = themeData.textTheme.titleMedium?.fontSize ?? 16.0;

    final indicatorWidget = !hasFrontCamera
        ? SizedCircularProgressIndicator(
            size: switchCameraIconSize - 2,
            outerSize: switchCameraIconSize,
            color: themeData.colorScheme.surface,
            strokeWidth: 2,
          )
        : Icon(Icons.flip_camera_ios, size: switchCameraIconSize, color: themeData.colorScheme.surface);

    return ThumbnailFrame(
      orientation: orientation,
      smallerSide: smallerSide,
      onTap: isSwitchEnabled ? onSwitchCameraPressed : null,
      label: context.l10n.callCameraPreview_SemanticsLabel_switchCamera,
      identifier: callFrontCameraPreviewId,
      child: Stack(
        fit: StackFit.expand,
        children: [
          StreamThumbnail(
            key: callFrontCameraPreviewKey,
            stream: hasFrontCamera ? localStream : null,
            mirror: frontCamera ?? false,
            placeholderBuilder: (context) => Shimmer(
              baseColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
              highlightColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.15),
            ),
          ),
          Positioned(top: 8, right: 8, child: indicatorWidget),
        ],
      ),
    );
  }
}
