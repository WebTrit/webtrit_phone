import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/call_bloc.dart';
import '../utils/utils.dart';
import 'stream_thumbnail.dart';

class CallActiveThumbnail extends StatelessWidget {
  const CallActiveThumbnail({
    super.key,
    required this.activeCall,
    required this.orientation,
    this.onTap,
    this.smallerSide = ThumbnailLayout.defaultSmallerSide,
  });

  final ActiveCall activeCall;
  final Orientation orientation;
  final GestureTapCallback? onTap;
  final double smallerSide;

  @override
  Widget build(BuildContext context) {
    final frameSize = ThumbnailLayout.calcFrameSize(orientation: orientation, smallerSide: smallerSide);

    return SizedBox.fromSize(
      size: frameSize,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: StreamThumbnail(
            stream: activeCall.remoteStream,
            placeholderBuilder: (context) => LeadingAvatar(
              radius: 24,
              username: activeCall.displayName,
              placeholderIcon: Icons.phone_in_talk_outlined,
            ),
          ),
        ),
      ),
    );
  }
}
