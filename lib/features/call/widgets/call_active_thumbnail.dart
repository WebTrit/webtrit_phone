import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/call_bloc.dart';
import '../utils/utils.dart';
import 'stream_thumbnail.dart';

class CallActiveThumbnail extends StatelessWidget {
  const CallActiveThumbnail({
    required this.activeCall,
    required this.orientation,
    super.key,
    this.contactResolver,
    this.onTap,
    this.smallerSide = ThumbnailLayout.defaultSmallerSide,
  });

  final ActiveCall activeCall;
  final Orientation orientation;
  final ContactResolver? contactResolver;
  final GestureTapCallback? onTap;
  final double smallerSide;

  @override
  Widget build(BuildContext context) {
    final frameSize = ThumbnailLayout.calcFrameSize(orientation: orientation, smallerSide: smallerSide);
    final hasRemoteVideo = activeCall.remoteStream?.getVideoTracks().isNotEmpty ?? false;

    return SizedBox.fromSize(
      size: frameSize,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              StreamThumbnail(
                stream: activeCall.remoteStream,
                placeholderBuilder: (context) {
                  final theme = Theme.of(context);
                  final colorScheme = theme.colorScheme;
                  final isAccepted = activeCall.wasAccepted;

                  final duration = isAccepted ? const Duration(milliseconds: 2500) : const Duration(milliseconds: 1500);

                  final baseAlpha = 0.75;
                  final highlightAlpha = 0.95;

                  final baseColor = isAccepted
                      ? colorScheme.primary.withValues(alpha: baseAlpha)
                      : colorScheme.surfaceContainerHighest.withValues(alpha: highlightAlpha);

                  final highlightColor = isAccepted
                      ? colorScheme.surface.withValues(alpha: baseAlpha)
                      : colorScheme.surface.withValues(alpha: highlightAlpha);

                  return Shimmer(duration: duration, baseColor: baseColor, highlightColor: highlightColor);
                },
              ),
              if (!hasRemoteVideo) _AvatarOverlay(activeCall: activeCall, contactResolver: contactResolver),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarOverlay extends StatelessWidget {
  const _AvatarOverlay({required this.activeCall, this.contactResolver});

  final ActiveCall activeCall;
  final ContactResolver? contactResolver;

  @override
  Widget build(BuildContext context) {
    final number = activeCall.handle.value;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: FutureBuilder<Contact?>(
        future: contactResolver?.resolve(number),
        builder: (context, snapshot) {
          final displayName = activeCall.displayName ?? '';
          final resolvedName = snapshot.data?.maybeName ?? displayName;

          return LeadingAvatar(
            radius: 24,
            username: resolvedName,
            thumbnailUrl: snapshot.data?.thumbnailUrl,
            placeholderIcon: Icons.phone_in_talk_outlined,
          );
        },
      ),
    );
  }
}
