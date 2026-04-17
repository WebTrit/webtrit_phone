import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call.dart';

class CallActiveScaffold extends StatefulWidget {
  const CallActiveScaffold({
    super.key,
    required this.callStatus,
    required this.activeCalls,
    required this.audioDevice,
    required this.availableAudioDevices,
    required this.callConfig,
    required this.localePlaceholderBuilder,
    required this.remotePlaceholderBuilder,
  });

  final CallStatus callStatus;
  final List<ActiveCall> activeCalls;
  final CallAudioDevice? audioDevice;
  final List<CallAudioDevice> availableAudioDevices;
  final CallCapabilitiesConfig callConfig;
  final WidgetBuilder? localePlaceholderBuilder;
  final WidgetBuilder? remotePlaceholderBuilder;

  @override
  CallActiveScaffoldState createState() => CallActiveScaffoldState();
}

class CallActiveScaffoldState extends State<CallActiveScaffold> {
  static const Duration _remoteFrameProbeInterval = Duration(seconds: 2);
  static const int _remoteFrameMaxSamples = 1200;
  static const int _blackLumaThreshold = 16;
  static const double _blackFrameRatioThreshold = 0.98;

  /// Cached `CallBloc` obtained in `initState`.
  /// Avoids unsafe `context.read` during widget deactivation (e.g., navigation pop).
  late final CallBloc _callBloc;

  /// Manages the visibility state of call controls (Compact vs. Expanded) and
  /// handles the auto-hide timer logic based on user activity and call state.
  late final CompactAutoResetController _compactController;

  /// Controls the object fit mode (cover or contain) for the remote video stream.
  ///
  /// Consider moving this to a global state (e.g., BLoC or Some config provider).
  RTCVideoViewObjectFit _videoFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;

  /// Controls the visual style of the background when the video does not fill the screen.
  ///
  /// Consider moving this to a global state (e.g., BLoC or Some config provider).
  VideoBackgroundMode _backgroundMode = VideoBackgroundMode.blur;

  Timer? _remoteFrameWatcher;
  bool _remoteFrameProbeInProgress = false;
  bool _hasRenderableRemoteFrame = true;
  String? _watchedRemoteTrackId;

  @override
  void initState() {
    super.initState();
    // Cache the CallBloc reference to avoid context lookups in callbacks.
    _callBloc = context.read<CallBloc>();

    // Synchronize the auto-hide logic with the initial call list configuration.
    _compactController = CompactAutoResetController(initiallyActive: widget.activeCalls.shouldAutoCompact);
    _syncRemoteFrameWatcher();
  }

  @override
  void didUpdateWidget(covariant CallActiveScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Synchronize the auto-hide logic with the latest call list configuration.
    _compactController.setActive(widget.activeCalls.shouldAutoCompact, reason: 'didUpdateWidget');
    _syncRemoteFrameWatcher();
  }

  @override
  Widget build(BuildContext context) {
    final activeCalls = widget.activeCalls;
    final activeCall = activeCalls.current;
    final heldCalls = activeCalls.nonCurrent;

    final activeTransfer = activeCall.transfer;

    final themeData = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    final style = themeData.extension<CallScreenStyles>()?.primary;

    // activeCall.remoteStream.getVideoTracks().first.captureFrame

    return ThemedScaffold(
      background: style?.background,
      extendBodyBehindAppBar: true,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              if (activeCall.remoteVideo)
                RemoteVideoViewOverlay(
                  activeCallWasAccepted: activeCall.wasAccepted,
                  remoteStream: activeCall.remoteStream,
                  videoFit: _videoFit,
                  onTap: _compactController.toggle,
                  remotePlaceholderBuilder: widget.remotePlaceholderBuilder,
                  backgroundMode: _backgroundMode,
                  hasRenderableRemoteFrame: _hasRenderableRemoteFrame,
                  // Its important to hide video if held to avoid showing frozen/last frames when held,
                  // and especially for case when both sides turn on hold and after one side unholds video started to show for another 'holded' side.
                  hideVideo: activeCall.held,
                ),
              AnimatedBuilder(
                animation: _compactController,
                builder: (context, _) => Positioned.fill(
                  left: mediaQueryData.padding.left,
                  right: mediaQueryData.padding.right,
                  top: mediaQueryData.padding.top,
                  bottom: mediaQueryData.padding.bottom,
                  child: AnimatedOpacity(
                    opacity: _compactController.compact ? 0 : 1,
                    duration: kThemeAnimationDuration,
                    child: IgnorePointer(
                      ignoring: _compactController.compact,
                      child: Column(
                        children: [
                          AppBar(
                            leading: style?.appBar?.showBackButton == false ? null : const ExtBackButton(),
                            backgroundColor: style?.appBar?.backgroundColor,
                            foregroundColor: style?.appBar?.foregroundColor,
                            primary: style?.appBar?.primary ?? false,
                            actions: [
                              if (activeCalls.shouldAutoCompact)
                                CallPopupMenuButton<void>(
                                  items: _buildPopupMenuItems,
                                  child: const Icon(Icons.more_vert),
                                ),
                            ],
                          ),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return FittedBox(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: constraints.maxWidth,
                                      minHeight: constraints.minHeight,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (final activeCall in activeCalls)
                                          CallInfo(
                                            transfering: activeTransfer is Transfering,
                                            requestToAttendedTransfer: false,
                                            inviteToAttendedTransfer: activeTransfer is InviteToAttendedTransfer,
                                            isIncoming: activeCall.isIncoming,
                                            held: activeCall.held,
                                            number: activeCall.handle.value,
                                            username: activeCall.displayName,
                                            acceptedTime: activeCall.acceptedTime,
                                            style: style?.callInfo,
                                            processingStatus: activeCall.processingStatus,
                                            callStatus: widget.callStatus,
                                          ),
                                        if (activeTransfer is AttendedTransferConfirmationRequested)
                                          CallInfo(
                                            transfering: false,
                                            requestToAttendedTransfer: true,
                                            inviteToAttendedTransfer: false,
                                            isIncoming: false,
                                            held: false,
                                            number: activeCall.handle.value,
                                            username: activeCall.displayName,
                                            style: style?.callInfo,
                                            callStatus: widget.callStatus,
                                          ),
                                        CallActions(
                                          style: style?.actions,
                                          enableInteractions:
                                              widget.callStatus == CallStatus.ready &&
                                              activeCalls.any((call) => call.updating) == false,
                                          isIncoming: activeCall.isIncoming,
                                          remoteVideo:
                                              activeCall.remoteVideo &&
                                              _hasRenderableRemoteFrame &&
                                              activeCall.held == false,
                                          wasAccepted: activeCall.wasAccepted,
                                          wasHungUp: activeCall.wasHungUp,
                                          cameraValue: activeCall.isCameraActive,
                                          inviteToAttendedTransfer: activeTransfer is InviteToAttendedTransfer,
                                          onCameraChanged: widget.callConfig.isVideoCallEnabled
                                              ? (bool value) => _callBloc.add(
                                                  CallControlEvent.cameraEnabled(activeCall.callId, value),
                                                )
                                              : null,
                                          mutedValue: activeCall.muted,
                                          onMutedChanged: (bool value) =>
                                              _callBloc.add(CallControlEvent.setMuted(activeCall.callId, value)),
                                          audioDevice: widget.audioDevice,
                                          availableAudioDevices: widget.availableAudioDevices,
                                          onAudioDeviceChanged: (CallAudioDevice device) {
                                            _callBloc.add(CallControlEvent.audioDeviceSet(activeCall.callId, device));
                                          },
                                          transferableCalls: heldCalls,
                                          onBlindTransferInitiated: widget.callConfig.isBlindTransferEnabled
                                              ? (!activeCall.wasAccepted || activeTransfer != null
                                                    ? null
                                                    : () {
                                                        _callBloc.add(
                                                          CallControlEvent.blindTransferInitiated(activeCall.callId),
                                                        );
                                                      })
                                              : null,
                                          // TODO (Serdun): Simplify complex condition in the widget tree.
                                          onAttendedTransferInitiated: widget.callConfig.isAttendedTransferEnabled
                                              ? (!activeCall.wasAccepted || activeTransfer != null
                                                    ? null
                                                    : () {
                                                        _callBloc.add(
                                                          CallControlEvent.attendedTransferInitiated(activeCall.callId),
                                                        );
                                                      })
                                              : null,
                                          // TODO (Serdun): Simplify complex condition in the widget tree.
                                          onAttendedTransferSubmitted: widget.callConfig.isAttendedTransferEnabled
                                              ? (!activeCall.wasAccepted || activeTransfer != null
                                                    ? null
                                                    : (ActiveCall referorCall) {
                                                        _callBloc.add(
                                                          CallControlEvent.attendedTransferSubmitted(
                                                            referorCall: referorCall,
                                                            replaceCall: activeCall,
                                                          ),
                                                        );
                                                      })
                                              : null,
                                          heldValue: activeCall.held,
                                          onHeldChanged: (bool value) {
                                            _callBloc.add(CallControlEvent.setHeld(activeCall.callId, value));
                                          },
                                          onSwapPressed: activeCalls.length == 2
                                              ? () {
                                                  _callBloc.add(CallControlEvent.setHeld(activeCall.callId, true));
                                                  for (final otherActiveCall in activeCalls) {
                                                    if (otherActiveCall.callId != activeCall.callId) {
                                                      _callBloc.add(
                                                        CallControlEvent.setHeld(otherActiveCall.callId, false),
                                                      );
                                                    }
                                                  }
                                                }
                                              : null,
                                          onHangupPressed: () {
                                            _callBloc.add(CallControlEvent.ended(activeCall.callId));
                                          },
                                          onHangupAndAcceptPressed: activeCalls.length > 1
                                              ? () {
                                                  for (final otherActiveCall in activeCalls) {
                                                    if (otherActiveCall.callId != activeCall.callId) {
                                                      _callBloc.add(CallControlEvent.ended(otherActiveCall.callId));
                                                    }
                                                  }
                                                  _callBloc.add(CallControlEvent.answered(activeCall.callId));
                                                }
                                              : null,
                                          onHoldAndAcceptPressed: activeCalls.length > 1
                                              ? () {
                                                  for (final otherActiveCall in activeCalls) {
                                                    if (otherActiveCall.callId != activeCall.callId) {
                                                      _callBloc.add(
                                                        CallControlEvent.setHeld(otherActiveCall.callId, true),
                                                      );
                                                    }
                                                  }
                                                  _callBloc.add(CallControlEvent.answered(activeCall.callId));
                                                }
                                              : null,
                                          onAcceptPressed: () {
                                            _callBloc.add(CallControlEvent.answered(activeCall.callId));
                                          },
                                          onApproveTransferPressed:
                                              activeTransfer is AttendedTransferConfirmationRequested
                                              ? () {
                                                  _callBloc.add(
                                                    CallControlEvent.attendedRequestApproved(
                                                      referId: activeTransfer.referId,
                                                      referTo: activeTransfer.referTo,
                                                    ),
                                                  );
                                                }
                                              : null,
                                          onDeclineTransferPressed:
                                              activeTransfer is AttendedTransferConfirmationRequested
                                              ? () {
                                                  _callBloc.add(
                                                    CallControlEvent.attendedRequestDeclined(
                                                      callId: activeCall.callId,
                                                      referId: activeTransfer.referId,
                                                    ),
                                                  );
                                                }
                                              : null,
                                          onKeyPressed: (value) {
                                            _callBloc.add(CallControlEvent.sentDTMF(activeCall.callId, value));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Generates the list of menu items for the call options popup.
  ///
  /// The list always includes the video fit toggle. The background mode toggle
  /// is conditionally added only when the video is in 'contain' mode, as the
  /// background is not visible in 'cover' mode.
  List<PopupMenuItem<void>> get _buildPopupMenuItems {
    final iconColor = Theme.of(context).colorScheme.onSurface;

    return [
      CallPopupMenuItem(
        onTap: _onVideoFitTogglePressed,
        text: _videoFit.actionLabelL10n(context),
        icon: Icon(_videoFit.actionIcon, color: iconColor),
      ),
      if (_videoFit.isContain)
        CallPopupMenuItem(
          onTap: _onBlurTogglePressed,
          text: _backgroundMode.actionLabelL10n(context),
          icon: Icon(_backgroundMode.actionIcon, color: iconColor),
        ),
    ];
  }

  void _onVideoFitTogglePressed() {
    setState(() => _videoFit = _videoFit.toggled);
  }

  void _onBlurTogglePressed() {
    setState(() => _backgroundMode = _backgroundMode.toggled);
  }

  void _syncRemoteFrameWatcher() {
    final track = _currentRemoteVideoTrack;
    final trackId = track?.id;

    if (trackId == null) {
      _disposeRemoteFrameWatcher();
      _remoteFrameProbeInProgress = false;
      _watchedRemoteTrackId = null;
      _setHasRenderableRemoteFrame(true);
      return;
    }

    if (_watchedRemoteTrackId == trackId && _remoteFrameWatcher != null) {
      return;
    }

    _disposeRemoteFrameWatcher();
    _watchedRemoteTrackId = trackId;
    _setHasRenderableRemoteFrame(true);
    _probeRemoteFrame();
    _remoteFrameWatcher = Timer.periodic(_remoteFrameProbeInterval, (_) => _probeRemoteFrame());
  }

  MediaStreamTrack? get _currentRemoteVideoTrack {
    final stream = widget.activeCalls.current.remoteStream;
    final tracks = stream?.getVideoTracks();

    if (tracks == null || tracks.isEmpty) {
      return null;
    }

    return tracks.first;
  }

  Future<void> _probeRemoteFrame() async {
    if (_remoteFrameProbeInProgress || mounted == false) {
      return;
    }

    final track = _currentRemoteVideoTrack;

    if (track == null) {
      _setHasRenderableRemoteFrame(true);
      return;
    }

    _remoteFrameProbeInProgress = true;
    try {
      final isBlackOrEmpty = await _isTrackFrameBlackOrEmpty(track);
      if (mounted) {
        _setHasRenderableRemoteFrame(!isBlackOrEmpty);
      }
    } catch (_) {
      if (mounted) {
        _setHasRenderableRemoteFrame(true);
      }
    } finally {
      _remoteFrameProbeInProgress = false;
    }
  }

  Future<bool> _isTrackFrameBlackOrEmpty(MediaStreamTrack track) async {
    final capturedFrame = await track.captureFrame();
    final framePngBytes = capturedFrame.asUint8List();

    if (framePngBytes.isEmpty) {
      return true;
    }

    final codec = await ui.instantiateImageCodec(framePngBytes);
    try {
      final nextFrame = await codec.getNextFrame();
      final image = nextFrame.image;
      try {
        final frameRgbaBytes = await image.toByteData(format: ui.ImageByteFormat.rawRgba);

        if (frameRgbaBytes == null || frameRgbaBytes.lengthInBytes == 0) {
          return true;
        }

        final rgbaBytes = frameRgbaBytes.buffer.asUint8List(frameRgbaBytes.offsetInBytes, frameRgbaBytes.lengthInBytes);

        return _isMostlyBlackRgbaFrame(rgbaBytes);
      } finally {
        image.dispose();
      }
    } finally {
      codec.dispose();
    }
  }

  bool _isMostlyBlackRgbaFrame(Uint8List rgbaBytes) {
    final totalPixels = rgbaBytes.length ~/ 4;

    if (totalPixels == 0) {
      return true;
    }

    final step = math.max(1, totalPixels ~/ _remoteFrameMaxSamples);
    var sampledPixels = 0;
    var opaquePixels = 0;
    var blackPixels = 0;

    for (var pixelIndex = 0; pixelIndex < totalPixels; pixelIndex += step) {
      final offset = pixelIndex * 4;
      final red = rgbaBytes[offset];
      final green = rgbaBytes[offset + 1];
      final blue = rgbaBytes[offset + 2];
      final alpha = rgbaBytes[offset + 3];

      sampledPixels++;

      if (alpha == 0) {
        continue;
      }

      opaquePixels++;

      final luma = ((red * 299) + (green * 587) + (blue * 114)) ~/ 1000;
      if (luma <= _blackLumaThreshold) {
        blackPixels++;
      }
    }

    if (sampledPixels == 0 || opaquePixels == 0) {
      return true;
    }

    return blackPixels / opaquePixels >= _blackFrameRatioThreshold;
  }

  void _setHasRenderableRemoteFrame(bool value) {
    if (_hasRenderableRemoteFrame == value || mounted == false) {
      return;
    }

    setState(() => _hasRenderableRemoteFrame = value);
  }

  void _disposeRemoteFrameWatcher() {
    _remoteFrameWatcher?.cancel();
    _remoteFrameWatcher = null;
  }

  @override
  void dispose() {
    _disposeRemoteFrameWatcher();
    _compactController.dispose();
    super.dispose();
  }
}
