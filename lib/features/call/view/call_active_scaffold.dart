import 'dart:async';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
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
    required this.keepControlsVisible,
    this.contactResolver,
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

  /// Whether the call controls have to stay on screen: it stops both the idle
  /// timer and the tap that hides them from taking them away. Why they have to
  /// is decided by the caller.
  final bool keepControlsVisible;

  /// Resolves the remote number to a contact so the avatar shown in place of the
  /// video can use the contact photo; without it the avatar falls back to initials.
  final ContactResolver? contactResolver;

  @override
  CallActiveScaffoldState createState() => CallActiveScaffoldState();
}

class CallActiveScaffoldState extends State<CallActiveScaffold> {
  static const Duration _remoteFrameProbeDelay = Duration(seconds: 1);

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

  /// Whether the in-call keypad is open. Owned here rather than inside the
  /// actions grid: the layout around the open keypad changes too (the avatar
  /// hides), so a single owner keeps both in sync.
  bool _inCallKeypadShown = false;

  Timer? _remoteFrameWatcher;
  bool _hasRenderableRemoteFrame = false;
  late final FrameAnalysisWorker _frameAnalysisWorker;

  static const Duration _debounceDuration = Duration(seconds: 2);
  DateTime? _debounceReleaseTime;
  Timer? _debounceTimer;
  StreamSubscription? _debounceByStateSubscription;

  @override
  void initState() {
    super.initState();
    // Cache the CallBloc reference to avoid context lookups in callbacks.
    _callBloc = context.read<CallBloc>();

    _compactController = CompactAutoResetController(initiallyActive: _autoHide);
    _frameAnalysisWorker = FrameAnalysisWorker()..start();
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
    // Covers both a change of the call itself and a change of the demand to
    // keep the controls, which arrives as a new value from above.
    _syncAutoHide(reason: 'didUpdateWidget');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The in-call keypad exists only in portrait; rotating away closes it
    // (a rebuild follows this callback, so no setState is needed).
    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      _inCallKeypadShown = false;
    }
  }

  /// Whether the controls may hide themselves as things stand.
  bool get _autoHide => widget.activeCalls.shouldAutoHideControls(keepControlsVisible: widget.keepControlsVisible);

  /// Turns the auto-hide of the call controls on or off.
  void _syncAutoHide({required String reason}) {
    _compactController.setActive(_autoHide, reason: reason);
    // Controls that must stay visible and are already hidden have to come back:
    // the controller expands on its own only when the auto-hide changes state.
    if (widget.keepControlsVisible) _compactController.setCompact(false, reason: reason);
  }

  /// Shows or hides the call controls on a tap anywhere on the call screen -
  /// the picture, the bare toolbar, the space around the controls - or only
  /// ever shows them while they are required to stay.
  void _toggleControls() {
    if (widget.keepControlsVisible) {
      _compactController.setCompact(false, reason: 'the controls are required to stay');
    } else {
      _compactController.toggle();
    }
  }

  @override
  void dispose() {
    _disposeRemoteFrameWatcher();
    _frameAnalysisWorker.dispose();
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

  /// Hands the consultation call over to the referor. The call that gets
  /// replaced is the derived `current` one rather than the focused one - see
  /// the note at the submit button.
  void _submitAttendedTransfer(ActiveCall referorCall) {
    _callBloc.add(
      CallControlEvent.attendedTransferSubmitted(referorCall: referorCall, replaceCall: widget.activeCalls.current),
    );
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
    // The media overlay follows the derived `current` call; the controls below
    // act on the focused one and take what they need for themselves.
    final activeCall = widget.activeCalls.current;

    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final style = Theme.of(context).extension<CallScreenStyles>()?.primary;

    // One gesture owns showing and hiding the controls, and it wraps the whole
    // screen rather than sitting inside it: a layer under the controls would
    // never see a tap on the toolbar, which paints over it and swallows it.
    // The controls themselves keep their own taps - a child that handles a tap
    // wins it before this one does.
    return GestureDetector(
      onTap: _toggleControls,
      child: ThemedScaffold(
        background: style?.background,
        extendBodyBehindAppBar: true,
        // The orientation itself is read where it is used, from the ambient
        // data; this builder is here to rebuild the layers when it changes.
        body: OrientationBuilder(
          builder: (context, _) {
            return Stack(
              children: [
                if (_hasRenderableRemoteFrame)
                  RemoteVideoViewOverlay(
                    remoteStream: activeCall.remoteStream,
                    videoFit: _videoFit,
                    remotePlaceholderBuilder: widget.remotePlaceholderBuilder,
                    backgroundMode: _backgroundMode,
                    hasRenderableRemoteFrame: _hasRenderableRemoteFrame,
                    // Its important to hide video if held to avoid showing frozen/last frames when held,
                    // and especially for case when both sides turn on hold and after one side unholds video started to show for another 'holded' side.
                    hideVideo: activeCall.held,
                  ),
                // The controls are handed to the builder rather than built
                // inside it: showing and hiding them is a property of the layer
                // around them, and there is no reason to rebuild the controls
                // themselves every time it flips.
                AnimatedBuilder(
                  animation: _compactController,
                  builder: (context, child) =>
                      HideableLayer(hidden: _compactController.compact, padding: mediaQueryData.padding, child: child!),
                  child: CallControls(
                    callStatus: widget.callStatus,
                    activeCalls: widget.activeCalls,
                    focusedCall: widget.focusedCall,
                    audioDevice: widget.audioDevice,
                    availableAudioDevices: widget.availableAudioDevices,
                    callConfig: widget.callConfig,
                    contactResolver: widget.contactResolver,
                    popupMenuItems: _buildPopupMenuItems,
                    keypadShown: _inCallKeypadShown,
                    // Blocks everything that talks to the server: while a
                    // previous action is still settling, while signaling is
                    // not ready, and while a call is being renegotiated.
                    interactionsEnabled:
                        interactionsDebounceActive == false &&
                        widget.callStatus == CallStatus.ready &&
                        widget.activeCalls.any((call) => call.updating) == false,
                    hasRenderableRemoteFrame: _hasRenderableRemoteFrame,
                    onCallSelected: (callId) => _callBloc.add(CallControlEvent.callSelected(callId)),
                    onKeypadToggle: (shown) => setState(() => _inCallKeypadShown = shown),
                    onCameraChanged: _toggleFocusedCamera,
                    onCameraPermissionDeniedPressed: _onCameraPermissionDeniedPressed,
                    onMutedChanged: (value) =>
                        _callBloc.add(CallControlEvent.setMuted(widget.focusedCall.callId, value)),
                    onAudioDeviceChanged: (device) =>
                        _callBloc.add(CallControlEvent.audioDeviceSet(widget.focusedCall.callId, device)),
                    onBlindTransferInitiated: () =>
                        _callBloc.add(CallControlEvent.blindTransferInitiated(widget.focusedCall.callId)),
                    onAttendedTransferInitiated: () =>
                        _callBloc.add(CallControlEvent.attendedTransferInitiated(widget.focusedCall.callId)),
                    onAttendedTransferSubmitted: _submitAttendedTransfer,
                    onHeldChanged: _toggleFocusedHeld,
                    onKeyPressed: (value) => _callBloc.add(CallControlEvent.sentDTMF(widget.focusedCall.callId, value)),
                    onHangup: _hangupFocused,
                    onAccept: _answerFocused,
                  ),
                ),
              ],
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
      _scheduleNextProbe(_remoteFrameProbeDelay);
      return;
    }

    final startTime = DateTime.now();
    try {
      final isBlackOrEmpty = await _isTrackFrameBlackOrEmpty(track).timeout(const Duration(seconds: 10));
      _setHasRenderableRemoteFrame(!isBlackOrEmpty);
    } catch (_) {
      // In case of any errors during frame capture or analysis, we optimistically assume that the remote frame is renderable.
      _setHasRenderableRemoteFrame(true);
    } finally {
      final elapsed = DateTime.now().difference(startTime);
      _logger.fine('Remote frame probe completed in ${elapsed.inMilliseconds}ms, $_hasRenderableRemoteFrame');
      _scheduleNextProbe(_remoteFrameProbeDelay);
    }
  }

  Future<bool> _isTrackFrameBlackOrEmpty(MediaStreamTrack track) async {
    final capturedFrame = await track.captureFrame();
    return _frameAnalysisWorker.analyzeFrame(capturedFrame.asUint8List());
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
