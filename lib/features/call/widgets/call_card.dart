import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class CallCard extends StatelessWidget {
  const CallCard({
    super.key,
    required this.handle,
    this.displayName,
    required this.videoRenderer,
  });

  final CallkeepHandle handle;
  final String? displayName;
  final RTCVideoRenderer videoRenderer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0,
      height: 120.0,
      child: Card(
        child: videoRenderer.renderVideo
            ? RTCVideoView(
                videoRenderer,
              )
            : Center(
                child: LeadingAvatar(
                  maxRadius: 24,
                  username: displayName ?? handle.value,
                ),
              ),
      ),
    );
  }
}
