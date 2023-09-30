import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import '../call.dart';

class CallActiveThumbnail extends StatelessWidget {
  const CallActiveThumbnail({
    super.key,
    required this.activeCall,
    this.localePlaceholderBuilder,
    this.remotePlaceholderBuilder,
  });

  final ActiveCall activeCall;
  final WidgetBuilder? localePlaceholderBuilder;
  final WidgetBuilder? remotePlaceholderBuilder;

  @override
  Widget build(BuildContext context) {
    final remoteRenderer = activeCall.renderers.remote;
    return ValueListenableBuilder<RTCVideoValue>(
      valueListenable: remoteRenderer,
      builder: (BuildContext context, RTCVideoValue value, Widget? child) {
        final isPortrait = value.renderVideo == false || value.aspectRatio < 1.0;
        return SizedBox(
          width: isPortrait ? 90.0 : 120.0,
          height: isPortrait ? 120.0 : 90.0,
          child: child,
        );
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            LeadingAvatar(
              maxRadius: 24,
              username: activeCall.displayName,
              placeholderIcon: Icons.phone_in_talk_outlined,
            ),
            RTCVideoView(
              remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              placeholderBuilder: remotePlaceholderBuilder,
            ),
          ],
        ),
      ),
    );
  }
}
