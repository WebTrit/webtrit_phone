import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/call_bloc.dart';
import '../utils/utils.dart';
import 'stream_thumbnail.dart';
import 'thumbnail_frame.dart';

final _logger = Logger('CallActiveThumbnail');

class CallActiveThumbnail extends StatefulWidget {
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
  State<CallActiveThumbnail> createState() => _CallActiveThumbnailState();
}

class _CallActiveThumbnailState extends State<CallActiveThumbnail> {
  static const Duration _remoteFrameProbeDelay = Duration(seconds: 1);

  /// Where frames cannot be analysed there is nothing to wait for, so the remote
  /// video is shown without a probe confirming it first.
  static const bool _showsRemoteVideoUnprobed = !FrameAnalysisWorker.isSupported;

  Timer? _remoteFrameWatcher;
  bool _hasRenderableRemoteFrame = _showsRemoteVideoUnprobed;
  late final FrameAnalysisWorker _frameAnalysisWorker;

  @override
  void initState() {
    super.initState();
    _frameAnalysisWorker = FrameAnalysisWorker()..start();
    _scheduleNextProbe(Duration.zero);
  }

  @override
  void didUpdateWidget(CallActiveThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset when the remote stream changes so we don't flash stale content.
    if (oldWidget.activeCall.remoteStream != widget.activeCall.remoteStream) {
      _setHasRenderableRemoteFrame(_showsRemoteVideoUnprobed);
    }
  }

  @override
  void dispose() {
    _remoteFrameWatcher?.cancel();
    _frameAnalysisWorker.dispose();
    super.dispose();
  }

  MediaStreamTrack? get _remoteVideoTrack {
    final tracks = widget.activeCall.remoteStream?.getVideoTracks();
    return (tracks != null && tracks.isNotEmpty) ? tracks.first : null;
  }

  void _scheduleNextProbe(Duration delay) {
    if (!mounted || !FrameAnalysisWorker.isSupported) return;
    _remoteFrameWatcher = Timer(delay, _probeRemoteFrame);
  }

  Future<void> _probeRemoteFrame() async {
    if (!mounted) return;

    final track = _remoteVideoTrack;
    if (track == null) {
      _scheduleNextProbe(_remoteFrameProbeDelay);
      return;
    }

    try {
      final capturedFrame = await track.captureFrame().timeout(const Duration(seconds: 10));
      final isBlackOrEmpty = await _frameAnalysisWorker.analyzeFrame(capturedFrame.asUint8List());
      _setHasRenderableRemoteFrame(!isBlackOrEmpty);
    } catch (_) {
      _setHasRenderableRemoteFrame(true);
    } finally {
      _logger.fine('Thumbnail frame probe done, hasRenderableFrame=$_hasRenderableRemoteFrame');
      _scheduleNextProbe(_remoteFrameProbeDelay);
    }
  }

  void _setHasRenderableRemoteFrame(bool value) {
    if (_hasRenderableRemoteFrame == value || !mounted) return;
    setState(() => _hasRenderableRemoteFrame = value);
  }

  @override
  Widget build(BuildContext context) {
    final hasRemoteVideo = widget.activeCall.remoteStream?.getVideoTracks().isNotEmpty ?? false;

    // Hide video when held to avoid showing frozen/last frames, and also when the
    // frame analyser hasn't confirmed renderable content yet (black/empty guard).
    final displayStream = hasRemoteVideo && widget.activeCall.held == false && _hasRenderableRemoteFrame;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isAccepted = widget.activeCall.wasAccepted;

    final duration = isAccepted ? const Duration(milliseconds: 2500) : const Duration(milliseconds: 1500);

    final baseAlpha = 0.75;
    final highlightAlpha = 0.95;

    final baseColor = isAccepted
        ? colorScheme.primary.withValues(alpha: baseAlpha)
        : colorScheme.surfaceContainerHighest.withValues(alpha: highlightAlpha);

    final highlightColor = isAccepted
        ? colorScheme.surface.withValues(alpha: baseAlpha)
        : colorScheme.surface.withValues(alpha: highlightAlpha);

    return ThumbnailFrame(
      orientation: widget.orientation,
      smallerSide: widget.smallerSide,
      onTap: widget.onTap,
      // It is the only way back into a call once the user has moved on, so it
      // says where it leads rather than what it shows.
      label: context.l10n.callThumbnail_SemanticsLabel_returnToCall,
      identifier: callActiveThumbnailId,
      raised: true,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Shimmer(duration: duration, baseColor: baseColor, highlightColor: highlightColor),
          if (displayStream)
            StreamThumbnail(stream: widget.activeCall.remoteStream)
          else
            _AvatarOverlay(activeCall: widget.activeCall, contactResolver: widget.contactResolver),
        ],
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

    // The window stretches whatever fills it to its own 9:16 shape. The avatar is a
    // circle of a fixed size, so it has to be let out of those constraints: taken
    // tight, it is drawn as an ellipse the shape of the window and the photo inside
    // it is cropped to match.
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
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
      ),
    );
  }
}
