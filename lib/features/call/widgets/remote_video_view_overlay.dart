import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'rtc_stream_view.dart';

/// A remote video stream overlay that fills the entire call screen.
///
/// This widget renders the remote [RTCStreamView] and handles tap interactions
/// to toggle the interface controls visibility.
class RemoteVideoViewOverlay extends StatelessWidget {
  /// Creates a [RemoteVideoViewOverlay].
  const RemoteVideoViewOverlay({
    super.key,
    required this.activeCallWasAccepted,
    required this.remoteStream,
    required this.videoFit,
    required this.onTap,
    this.remotePlaceholderBuilder,
  });

  /// Indicates if the call has been accepted.
  ///
  /// Used to determine if the tap gesture should trigger [onTap].
  final bool activeCallWasAccepted;

  /// The remote WebRTC media stream to display.
  final MediaStream? remoteStream;

  /// Defines how the video fits within the available space (cover/contain).
  final RTCVideoViewObjectFit videoFit;

  /// Callback triggered when the user taps the overlay.
  ///
  /// Only invoked if [activeCallWasAccepted] is true.
  final VoidCallback onTap;

  /// Builder used when the remote stream cannot be rendered yet.
  final WidgetBuilder? remotePlaceholderBuilder;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: activeCallWasAccepted ? onTap : null,
        behavior: HitTestBehavior.translucent,
        child: SizedBox.expand(
          child: RTCStreamView(stream: remoteStream, placeholderBuilder: remotePlaceholderBuilder, fit: videoFit),
        ),
      ),
    );
  }
}
