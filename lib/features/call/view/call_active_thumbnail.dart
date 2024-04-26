import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import '../call.dart';

class CallActiveThumbnail extends StatefulWidget {
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
  State<CallActiveThumbnail> createState() => _CallActiveThumbnailState();
}

class _CallActiveThumbnailState extends State<CallActiveThumbnail> {
  late final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  @override
  initState() {
    super.initState();
    remoteRenderer.initialize().then((value) {
      if (!mounted) return;
      remoteRenderer.srcObject = widget.activeCall.remoteStream;
    });
  }

  @override
  dispose() {
    super.dispose();
    remoteRenderer.srcObject = null;
    remoteRenderer.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              username: widget.activeCall.displayName,
              placeholderIcon: Icons.phone_in_talk_outlined,
            ),
            RTCVideoView(
              remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              placeholderBuilder: widget.remotePlaceholderBuilder,
            ),
          ],
        ),
      ),
    );
  }
}
