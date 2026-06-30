import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:image/image.dart' as img;
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call.dart';

final _logger = Logger('CallActiveScaffold');

const int _remoteFrameMaxSamples = 1200;
const int _blackLumaThreshold = 16;
const double _blackFrameRatioThreshold = 0.98;

// Decodes PNG bytes and determines whether the frame is black or empty.
// Runs entirely in the worker isolate — no dart:ui dependency.
bool _analyzeFrameInIsolate(Uint8List pngBytes) {
  if (pngBytes.isEmpty) return true;

  final decoded = img.decodeImage(pngBytes);
  if (decoded == null) return true;

  final totalPixels = decoded.width * decoded.height;
  if (totalPixels == 0) return true;

  final step = math.max(1, totalPixels ~/ _remoteFrameMaxSamples);
  var sampledPixels = 0;
  var opaquePixels = 0;
  var blackPixels = 0;

  for (var i = 0; i < totalPixels; i += step) {
    final pixel = decoded.getPixel(i % decoded.width, i ~/ decoded.width);
    sampledPixels++;
    if (pixel.a == 0) continue;
    opaquePixels++;
    final luma = (pixel.r * 299 + pixel.g * 587 + pixel.b * 114) ~/ 1000;
    if (luma <= _blackLumaThreshold) blackPixels++;
  }

  if (sampledPixels == 0 || opaquePixels == 0) return true;
  return blackPixels / opaquePixels >= _blackFrameRatioThreshold;
}

// Entry point for the long-lived frame-analysis isolate.
// Sends back its own SendPort on startup, then processes PNG Uint8List messages
// and replies with a bool. Any non-Uint8List message (null) shuts it down.
void _frameAnalysisIsolateEntry(SendPort mainSendPort) {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);
  receivePort.listen((message) {
    if (message is Uint8List) {
      try {
        mainSendPort.send(_analyzeFrameInIsolate(message));
      } catch (_) {
        mainSendPort.send(false); // optimistically renderable on analysis error
      }
    } else {
      receivePort.close();
    }
  });
}

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
  static const Duration _remoteFrameProbeThrottle = Duration(seconds: 1);

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
  bool _hasRenderableRemoteFrame = false;

  Isolate? _frameAnalysisIsolate;
  ReceivePort? _frameAnalysisReceivePort;
  SendPort? _frameAnalysisSendPort;
  Completer<bool>? _pendingFrameAnalysis;
  late Future<void> _frameAnalysisIsolateReady;

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
    _frameAnalysisIsolateReady = _initFrameAnalysisIsolate();
    _scheduleNextProbe(Duration.zero);

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
    _disposeFrameAnalysisIsolate();
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

  // --- Focused-call intent helpers -----------------------------------------
  // AGENTS.md: callbacks in the widget tree are single-expression; multi-step
  // logic lives here.

  /// Holds the focused call, or resumes it (holding the other live calls
  /// first) when it is already held.
  void _toggleFocusedHeld(bool value) {
    _callBloc.add(
      value
          ? CallControlEvent.setHeld(widget.focusedCall.callId, true)
          : CallControlEvent.resumedHoldingOthers(widget.focusedCall.callId),
    );
    dispatchInteractionDebounce();
  }

  void _toggleFocusedCamera(bool value) {
    _callBloc.add(CallControlEvent.cameraEnabled(widget.focusedCall.callId, value));
    dispatchInteractionDebounce();
  }

  /// Handles a camera-button tap when the call was downgraded to audio-only
  /// because camera permission was denied. Re-checks the live permission so a
  /// mid-call grant is honoured: if granted, enables the camera; otherwise
  /// opens app settings.
  Future<void> _onCameraPermissionDeniedPressed() async {
    final appPermissions = context.read<AppPermissions>();
    final granted = await appPermissions.isPermissionGranted(Permission.camera);
    if (!mounted) return;
    if (granted) {
      _toggleFocusedCamera(true);
    } else {
      await appPermissions.toAppSettings();
    }
  }

  void _hangupFocused() {
    _callBloc.add(CallControlEvent.ended(widget.focusedCall.callId));
    dispatchInteractionDebounce();
  }

  /// Answers the focused ringing call with the single intent that holds the
  /// answered others / ends the non-holdable ones (see
  /// [CallControlEvent.answerFocused]).
  void _answerFocused() {
    final activeCalls = widget.activeCalls;
    final incomingRinging = activeCalls.where((call) => call.isIncoming && call.wasAccepted == false).toList();
    final others = activeCalls.whereNot(incomingRinging.contains).toList();
    _callBloc.add(
      CallControlEvent.answerFocused(
        widget.focusedCall.callId,
        hasHoldableOthers: others.any((call) => call.wasAccepted),
        hasNonRingingOthers: others.isNotEmpty,
      ),
    );
    dispatchInteractionDebounce();
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
                                // Global status line: signaling state, media
                                // failure or the worst stream quality across calls.
                                centerTitle: true,
                                title: CallToolbarStatus(
                                  callStatus: widget.callStatus,
                                  networkQuality: activeCalls.worstNetworkQuality,
                                  iceConnectionIssue: activeCalls.firstIceConnectionIssue,
                                  style: style?.callInfo,
                                ),
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
                                                listStyle: style?.list,
                                                onCallTap: (callId) {
                                                  _callBloc.add(CallControlEvent.callSelected(callId));
                                                },
                                              ),
                                            // With multiple calls the list rows carry the per-call
                                            // info, so the central info block is single-call only.
                                            if (activeCalls.length == 1)
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
                                                wasAccepted: focusedCall.wasAccepted,
                                                wasHungUp: focusedCall.wasHungUp,
                                                cameraValue: focusedCall.isCameraActive,
                                                cameraPermissionDenied:
                                                    widget.callConfig.isVideoCallEnabled &&
                                                    focusedCall.videoPermissionDenied,
                                                onCameraPermissionDeniedPressed: _onCameraPermissionDeniedPressed,
                                                inviteToAttendedTransfer: focusedTransfer is InviteToAttendedTransfer,
                                                onCameraChanged: widget.callConfig.isVideoCallEnabled
                                                    ? _toggleFocusedCamera
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
                                                // Hold pauses just the focused call; Resume brings it
                                                // back as the only live one (the other live calls are
                                                // put on hold first). Switching lines = focus the other
                                                // row and press Resume - there is no separate swap.
                                                onHeldChanged: _toggleFocusedHeld,
                                                onHangupPressed: _hangupFocused,

                                                onKeyPressed: (value) {
                                                  _callBloc.add(CallControlEvent.sentDTMF(focusedCall.callId, value));
                                                },
                                              )
                                            else
                                              // Decline / Answer for the focused ringing call -
                                              // always two buttons. Answering holds the answered
                                              // calls (or ends the non-holdable ones); the hint
                                              // names the focused call and spells the side effect.
                                              // The hint and the buttons are one column child so
                                              // the spaceBetween layout keeps them glued together
                                              // at the bottom.
                                              // Edge-cases (covered by the call list above):
                                              // - two incoming ringing calls
                                              // - one outgoing ringing + one incoming ringing
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
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
                                                      hintStyle: style?.hint,
                                                    ),
                                                  IncomingCallActions(
                                                    style: style?.actions,
                                                    inviteToAttendedTransfer: false,
                                                    remoteVideo: focusedCall.remoteVideo && focusedCall.held == false,
                                                    onHangupPressed: _hangupFocused,
                                                    // Answering with other calls present mutates them
                                                    // (hold/end), so it is gated by the interactions
                                                    // debounce like any signaling-dependent action.
                                                    onAcceptPressed:
                                                        nonIncomingRingingCalls.isNotEmpty &&
                                                            (interactionsDebounceActive ||
                                                                widget.callStatus != CallStatus.ready ||
                                                                activeCalls.any((call) => call.updating))
                                                        ? null
                                                        : _answerFocused,
                                                  ),
                                                ],
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

  void _scheduleNextProbe(Duration delay) {
    if (!mounted) return;
    _remoteFrameWatcher = Timer(delay, _probeRemoteFrame);
  }

  Future<void> _probeRemoteFrame() async {
    if (!mounted) return;

    final track = _currentRemoteVideoTrack;
    if (track == null) {
      _scheduleNextProbe(_remoteFrameProbeThrottle * 2);
      return;
    }

    final startTime = DateTime.now();
    try {
      final isBlackOrEmpty = await _isTrackFrameBlackOrEmpty(track).timeout(const Duration(seconds: 5));
      _setHasRenderableRemoteFrame(!isBlackOrEmpty);
    } catch (_) {
      // In case of any errors during frame capture or analysis, we optimistically assume that the remote frame is renderable.
      _setHasRenderableRemoteFrame(true);
    } finally {
      final elapsed = DateTime.now().difference(startTime);
      _logger.fine('Remote frame probe completed in ${elapsed.inMilliseconds}ms, $_hasRenderableRemoteFrame');
      _scheduleNextProbe(_remoteFrameProbeThrottle);
    }
  }

  Future<bool> _isTrackFrameBlackOrEmpty(MediaStreamTrack track) async {
    final capturedFrame = await track.captureFrame();
    return _analyzeFrame(capturedFrame.asUint8List());
  }

  Future<void> _initFrameAnalysisIsolate() async {
    final receivePort = ReceivePort();
    _frameAnalysisReceivePort = receivePort;
    final handshake = Completer<SendPort>();
    receivePort.listen((message) {
      if (!handshake.isCompleted) {
        handshake.complete(message as SendPort);
      } else if (message is bool) {
        _pendingFrameAnalysis?.complete(message);
        _pendingFrameAnalysis = null;
      }
    });
    _frameAnalysisIsolate = await Isolate.spawn(_frameAnalysisIsolateEntry, receivePort.sendPort);
    _frameAnalysisSendPort = await handshake.future;
  }

  void _disposeFrameAnalysisIsolate() {
    _pendingFrameAnalysis?.completeError(StateError('disposed'));
    _pendingFrameAnalysis = null;
    _frameAnalysisSendPort?.send(null);
    _frameAnalysisIsolate?.kill(priority: Isolate.immediate);
    _frameAnalysisReceivePort?.close();
    _frameAnalysisIsolate = null;
    _frameAnalysisSendPort = null;
    _frameAnalysisReceivePort = null;
  }

  Future<bool> _analyzeFrame(Uint8List pngBytes) async {
    await _frameAnalysisIsolateReady;
    final completer = Completer<bool>();
    _pendingFrameAnalysis = completer;
    _frameAnalysisSendPort!.send(pngBytes);
    return completer.future;
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
