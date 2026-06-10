import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call.dart';

final _logger = Logger('CallActiveScaffold');

class CallActiveScaffold extends StatefulWidget {
  const CallActiveScaffold({
    super.key,
    required this.callStatus,
    required this.activeCalls,
    required this.focusedCall,
    required this.audioDevice,
    required this.availableAudioDevices,
    required this.callConfig,
    required this.localePlaceholderBuilder,
    required this.remotePlaceholderBuilder,
  });

  final CallStatus callStatus;
  final List<ActiveCall> activeCalls;

  /// The call the info block and the action area act on (see
  /// [CallState.focusedCall]); the call list highlights its row.
  final ActiveCall focusedCall;
  final CallAudioDevice? audioDevice;
  final List<CallAudioDevice> availableAudioDevices;
  final CallCapabilitiesConfig callConfig;
  final WidgetBuilder? localePlaceholderBuilder;
  final WidgetBuilder? remotePlaceholderBuilder;

  @override
  CallActiveScaffoldState createState() => CallActiveScaffoldState();
}

class CallActiveScaffoldState extends State<CallActiveScaffold> {
  static const Duration _remoteFrameProbeInterval = Duration(seconds: 1);
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
  bool _hasRenderableRemoteFrame = false;

  static const Duration _debounceDuration = Duration(seconds: 2);
  DateTime? _debounceReleaseTime;
  Timer? _debounceTimer;
  StreamSubscription? _debounceByStateSubscription;

  @override
  void initState() {
    super.initState();
    // Cache the CallBloc reference to avoid context lookups in callbacks.
    _callBloc = context.read<CallBloc>();

    // Synchronize the auto-hide logic with the initial call list configuration.
    _compactController = CompactAutoResetController(initiallyActive: widget.activeCalls.shouldAutoCompact);
    _remoteFrameWatcher = Timer.periodic(_remoteFrameProbeInterval, (_) => _probeRemoteFrame());

    // Dispatch interaction debounce whenever any call is in updating state
    // to prevent user race conditions e.g hold or upgrade to video when the call is updating from remote side.
    _debounceByStateSubscription = _callBloc.stream.listen((state) {
      if (state.activeCalls.any((call) => call.updating)) {
        dispatchInteractionDebounce();
      }
    });

    _compactController.addListener(_onCompactChanged);
  }

  @override
  void didUpdateWidget(covariant CallActiveScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Synchronize the auto-hide logic with the latest call list configuration.
    _compactController.setActive(widget.activeCalls.shouldAutoCompact, reason: 'didUpdateWidget');
  }

  @override
  void dispose() {
    _disposeRemoteFrameWatcher();
    _compactController.removeListener(_onCompactChanged);
    _compactController.dispose();
    _debounceByStateSubscription?.cancel();
    super.dispose();
  }

  void _onCompactChanged() {
    if (_compactController.compact && mounted) {
      _logger.finer('_onCompactChanged - closing all popups');
      Navigator.of(context).popUntil((route) => route is! PopupRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeCalls = widget.activeCalls;
    final activeCall = activeCalls.current;
    final heldCalls = activeCalls.nonCurrent;

    final incomingRingingCalls = activeCalls.where((call) => call.isIncoming && call.wasAccepted == false).toList();
    final nonIncomingRingingCalls = activeCalls.whereNot((call) => incomingRingingCalls.contains(call)).toList();
    final nonIncomingRingingCanBeHolded = nonIncomingRingingCalls.where((call) => call.wasAccepted == true).toList();

    // The info block and the action area below act on the focused call; the
    // media overlay keeps following the derived `current` call.
    final focusedCall = widget.focusedCall;
    final focusedIsRinging = focusedCall.isIncoming && !focusedCall.wasAccepted;
    final focusedTransfer = focusedCall.transfer;

    final themeData = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    final style = themeData.extension<CallScreenStyles>()?.primary;

    return GestureDetector(
      onTap: _compactController.toggle,

      child: ThemedScaffold(
        background: style?.background,
        extendBodyBehindAppBar: true,
        body: OrientationBuilder(
          builder: (context, orientation) {
            return GestureDetector(
              child: Stack(
                children: [
                  if (_hasRenderableRemoteFrame)
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
                                            // List-based call screen: with more than one call every
                                            // call is a tappable row, and the info block + action
                                            // area below act on the focused call.
                                            if (activeCalls.length > 1)
                                              CallList(
                                                calls: activeCalls,
                                                focusedCallId: focusedCall.callId,
                                                style: style?.callInfo,
                                                onCallTap: (callId) {
                                                  _callBloc.add(CallControlEvent.callSelected(callId));
                                                },
                                              ),
                                            CallInfo(
                                              transfering: focusedTransfer is Transfering,
                                              requestToAttendedTransfer: false,
                                              inviteToAttendedTransfer: focusedTransfer is InviteToAttendedTransfer,
                                              isIncoming: focusedCall.isIncoming,
                                              held: focusedCall.held,
                                              number: focusedCall.handle.value,
                                              username: focusedCall.displayName,
                                              acceptedTime: focusedCall.acceptedTime,
                                              style: style?.callInfo,
                                              processingStatus: focusedCall.processingStatus,
                                              callStatus: widget.callStatus,
                                              iceConnectionIssue: focusedCall.iceConnectionIssue,
                                              networkQuality: focusedCall.networkQuality,
                                            ),
                                            if (!focusedIsRinging)
                                              ActiveCallActions(
                                                style: style?.actions,
                                                // Blocks signaling-dependent actions (hold, transfer, camera).
                                                // False during: interaction debounce, signaling not ready, SDP renegotiation.
                                                enableInteractions:
                                                    interactionsDebounceActive == false &&
                                                    widget.callStatus == CallStatus.ready &&
                                                    activeCalls.any((call) => call.updating) == false,
                                                isIncoming: focusedCall.isIncoming,
                                                remoteVideo:
                                                    focusedCall.remoteVideo &&
                                                    _hasRenderableRemoteFrame &&
                                                    focusedCall.held == false,
                                                wasAccepted: focusedCall.wasAccepted,
                                                wasHungUp: focusedCall.wasHungUp,
                                                cameraValue: focusedCall.isCameraActive,
                                                inviteToAttendedTransfer: focusedTransfer is InviteToAttendedTransfer,
                                                onCameraChanged: widget.callConfig.isVideoCallEnabled
                                                    ? (bool value) {
                                                        _callBloc.add(
                                                          CallControlEvent.cameraEnabled(focusedCall.callId, value),
                                                        );
                                                        dispatchInteractionDebounce();
                                                      }
                                                    : null,
                                                mutedValue: focusedCall.muted,
                                                onMutedChanged: (bool value) {
                                                  _callBloc.add(CallControlEvent.setMuted(focusedCall.callId, value));
                                                },
                                                audioDevice: widget.audioDevice,
                                                availableAudioDevices: widget.availableAudioDevices,
                                                onAudioDeviceChanged: (CallAudioDevice device) {
                                                  _callBloc.add(
                                                    CallControlEvent.audioDeviceSet(focusedCall.callId, device),
                                                  );
                                                },
                                                transferableCalls: heldCalls,
                                                onBlindTransferInitiated: widget.callConfig.isBlindTransferEnabled
                                                    ? (!focusedCall.wasAccepted || focusedTransfer != null
                                                          ? null
                                                          : () {
                                                              _callBloc.add(
                                                                CallControlEvent.blindTransferInitiated(
                                                                  focusedCall.callId,
                                                                ),
                                                              );
                                                            })
                                                    : null,
                                                // TODO (Serdun): Simplify complex condition in the widget tree.
                                                onAttendedTransferInitiated: widget.callConfig.isAttendedTransferEnabled
                                                    ? (!focusedCall.wasAccepted || focusedTransfer != null
                                                          ? null
                                                          : () {
                                                              _callBloc.add(
                                                                CallControlEvent.attendedTransferInitiated(
                                                                  focusedCall.callId,
                                                                ),
                                                              );
                                                            })
                                                    : null,
                                                // TODO (Serdun): Simplify complex condition in the widget tree.
                                                onAttendedTransferSubmitted: widget.callConfig.isAttendedTransferEnabled
                                                    ? (!focusedCall.wasAccepted || focusedTransfer != null
                                                          ? null
                                                          : (ActiveCall referorCall) {
                                                              _callBloc.add(
                                                                CallControlEvent.attendedTransferSubmitted(
                                                                  referorCall: referorCall,
                                                                  replaceCall: focusedCall,
                                                                ),
                                                              );
                                                            })
                                                    : null,
                                                heldValue: focusedCall.held,
                                                onHeldChanged: (bool value) {
                                                  _callBloc.add(CallControlEvent.setHeld(focusedCall.callId, value));
                                                  dispatchInteractionDebounce();
                                                },
                                                // Swap keeps acting on the derived current call: its
                                                // semantics are "hold the active one, resume the rest"
                                                // regardless of which row is focused.
                                                onSwapPressed: activeCalls.length == 2
                                                    ? () {
                                                        _callBloc.add(
                                                          CallControlEvent.swapped(activeCalls.current.callId),
                                                        );
                                                        dispatchInteractionDebounce();
                                                      }
                                                    : null,
                                                onHangupPressed: () {
                                                  _callBloc.add(CallControlEvent.ended(focusedCall.callId));
                                                  dispatchInteractionDebounce();
                                                },

                                                onKeyPressed: (value) {
                                                  _callBloc.add(CallControlEvent.sentDTMF(focusedCall.callId, value));
                                                },
                                              )
                                            else ...[
                                              // Decline / Answer for the focused ringing call -
                                              // always two buttons. Answering holds the answered
                                              // calls (or ends the non-holdable ones); the hint
                                              // names the focused call and spells the side effect.
                                              // Edge-cases (covered by the call list above):
                                              // - two incoming ringing calls
                                              // - one outgoing ringing + one incoming ringing
                                              if (activeCalls.length > 1)
                                                FocusedActionHint(
                                                  focusedName: focusedCall.displayName ?? focusedCall.handle.value,
                                                  willBeHeldNames: nonIncomingRingingCanBeHolded.isEmpty
                                                      ? const []
                                                      : [
                                                          for (final call in nonIncomingRingingCanBeHolded)
                                                            if (!call.held) call.displayName ?? call.handle.value,
                                                        ],
                                                  willBeEndedNames: nonIncomingRingingCanBeHolded.isNotEmpty
                                                      ? const []
                                                      : [
                                                          for (final call in nonIncomingRingingCalls)
                                                            call.displayName ?? call.handle.value,
                                                        ],
                                                  style: style?.callInfo,
                                                ),
                                              IncomingCallActions(
                                                style: style?.actions,
                                                inviteToAttendedTransfer: false,
                                                enableInteractions:
                                                    interactionsDebounceActive == false &&
                                                    widget.callStatus == CallStatus.ready &&
                                                    activeCalls.any((call) => call.updating) == false,
                                                remoteVideo: focusedCall.remoteVideo && focusedCall.held == false,
                                                onHangupPressed: () {
                                                  _callBloc.add(CallControlEvent.ended(focusedCall.callId));
                                                  dispatchInteractionDebounce();
                                                },
                                                // Answering with other calls present mutates them
                                                // (hold/end), so it is gated by the interactions
                                                // debounce like any signaling-dependent action.
                                                onAcceptPressed:
                                                    nonIncomingRingingCalls.isNotEmpty &&
                                                        (interactionsDebounceActive ||
                                                            widget.callStatus != CallStatus.ready ||
                                                            activeCalls.any((call) => call.updating))
                                                    ? null
                                                    : () {
                                                        _callBloc.add(
                                                          CallControlEvent.answerFocused(
                                                            focusedCall.callId,
                                                            hasHoldableOthers: nonIncomingRingingCanBeHolded.isNotEmpty,
                                                            hasNonRingingOthers: nonIncomingRingingCalls.isNotEmpty,
                                                          ),
                                                        );
                                                        dispatchInteractionDebounce();
                                                      },
                                              ),
                                            ],
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
              ),
            );
          },
        ),
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

  MediaStreamTrack? get _currentRemoteVideoTrack {
    final stream = widget.activeCalls.current.remoteStream;
    final tracks = stream?.getVideoTracks();

    if (tracks == null || tracks.isEmpty) {
      return null;
    }

    return tracks.first;
  }

  Future<void> _probeRemoteFrame() async {
    if (_remoteFrameProbeInProgress || mounted == false) return;

    final track = _currentRemoteVideoTrack;
    if (track == null) return;

    _remoteFrameProbeInProgress = true;
    final startTime = DateTime.now();
    try {
      final isBlackOrEmpty = await _isTrackFrameBlackOrEmpty(track).timeout(const Duration(seconds: 5));
      _setHasRenderableRemoteFrame(!isBlackOrEmpty);
    } catch (_) {
      // In case of any errors during frame capture or analysis, we optimistically assume that the remote frame is renderable.
      _setHasRenderableRemoteFrame(true);
    } finally {
      _remoteFrameProbeInProgress = false;
      final elapsed = DateTime.now().difference(startTime);
      _logger.fine('Remote frame probe completed in ${elapsed.inMilliseconds}ms, $_hasRenderableRemoteFrame');
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

  bool get interactionsDebounceActive {
    if (_debounceReleaseTime == null) return false;
    return DateTime.now().isBefore(_debounceReleaseTime!);
  }

  void dispatchInteractionDebounce({Duration? duration}) {
    _debounceReleaseTime = DateTime.now().add(duration ?? _debounceDuration);
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration ?? _debounceDuration, () {
      if (mounted) setState(() {});
    });
  }
}
