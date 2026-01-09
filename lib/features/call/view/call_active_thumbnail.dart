import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class CallActiveThumbnail extends StatelessWidget {
  const CallActiveThumbnail({super.key, required this.activeCall, this.onTap});

  final ActiveCall activeCall;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: StreamThumbnail(
        stream: activeCall.remoteStream,
        placeholderBuilder: (context) =>
            LeadingAvatar(radius: 24, username: activeCall.displayName, placeholderIcon: Icons.phone_in_talk_outlined),
      ),
    );
  }
}
