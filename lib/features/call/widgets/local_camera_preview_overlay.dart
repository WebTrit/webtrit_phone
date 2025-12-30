import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'rtc_stream_view.dart';

class LocalCameraPreviewOverlay extends StatelessWidget {
  const LocalCameraPreviewOverlay({
    super.key,
    required this.compact,
    required this.orientation,
    required this.padding,
    required this.onTabGradient,
    required this.switchCameraIconSize,
    required this.frontCamera,
    required this.localStream,
    required this.onSwitchCameraPressed,
    required this.localePlaceholderBuilder,
    this.duration = kThemeChangeDuration,
    this.smallerSide = 90.0,
  });

  final bool compact;

  final Orientation orientation;

  final EdgeInsets padding;

  final Color onTabGradient;

  final double switchCameraIconSize;

  final bool? frontCamera;

  final MediaStream? localStream;

  final VoidCallback? onSwitchCameraPressed;

  final WidgetBuilder? localePlaceholderBuilder;

  final Duration duration;
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
            Container(
              decoration: BoxDecoration(color: onTabGradient.withValues(alpha: 0.3)),
              width: frameSize.width,
              height: frameSize.height,
              child: frontCamera == null
                  ? null
                  : RTCStreamView(
                      key: callFrontCameraPreviewKey,
                      stream: localStream,
                      mirror: frontCamera!,
                      placeholderBuilder: localePlaceholderBuilder,
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

  static double _safeVideoWidth(dynamic localStream) {
    try {
      final track = localStream?.getVideoTracks()?.first;
      final w = track?.getSettings()?['width'];
      return (w is num) ? w.toDouble() : 1080.0;
    } catch (_) {
      return 1080.0;
    }
  }

  static double _safeVideoHeight(dynamic localStream) {
    try {
      final track = localStream?.getVideoTracks()?.first;
      final h = track?.getSettings()?['height'];
      return (h is num) ? h.toDouble() : 720.0;
    } catch (_) {
      return 720.0;
    }
  }
}
