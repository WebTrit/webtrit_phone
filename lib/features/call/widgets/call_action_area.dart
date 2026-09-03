import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:webtrit_phone/models/models.dart';

import '../bloc/call_bloc.dart';
import '../models/models.dart';
import '../view/call_screen_styles.dart';
import 'active_call_actions.dart';
import 'focused_action_hint.dart';
import 'incoming_call_actions.dart';

/// Everything the user can press about the focused call: the control grid
/// while the call is live, or Decline/Answer - with the "Acting on" hint when
/// other calls are around - while it rings.
///
/// The area is shared by the orientation layouts: each of them decides where
/// it stands, none of them what is inside. What each control does keeps
/// arriving from the screen above as callbacks.
class CallActionArea extends StatelessWidget {
  const CallActionArea({
    super.key,
    required this.activeCalls,
    required this.focusedCall,
    required this.audioDevice,
    required this.availableAudioDevices,
    required this.callConfig,
    required this.keypadShown,
    required this.interactionsEnabled,
    required this.onKeypadToggle,
    required this.onCameraChanged,
    required this.onCameraPermissionDeniedPressed,
    required this.onMutedChanged,
    required this.onAudioDeviceChanged,
    required this.onBlindTransferInitiated,
    required this.onAttendedTransferInitiated,
    required this.onAttendedTransferSubmitted,
    required this.onHeldChanged,
    required this.onKeyPressed,
    required this.onHangup,
    required this.onAccept,
  });

  final List<ActiveCall> activeCalls;

  /// The call the area acts on (see `CallState.focusedCall`).
  final ActiveCall focusedCall;

  final CallAudioDevice? audioDevice;
  final List<CallAudioDevice> availableAudioDevices;
  final CallCapabilitiesConfig callConfig;

  final bool keypadShown;

  /// Whether anything that talks to the server may be pressed at all. It goes
  /// down while a previous action is still settling, while signaling is not
  /// ready and while a call is being renegotiated.
  final bool interactionsEnabled;

  final ValueChanged<bool> onKeypadToggle;
  final ValueChanged<bool> onCameraChanged;
  final VoidCallback onCameraPermissionDeniedPressed;
  final ValueChanged<bool> onMutedChanged;
  final ValueChanged<CallAudioDevice> onAudioDeviceChanged;
  final VoidCallback onBlindTransferInitiated;
  final VoidCallback onAttendedTransferInitiated;
  final ValueChanged<ActiveCall> onAttendedTransferSubmitted;
  final ValueChanged<bool> onHeldChanged;
  final ValueChanged<String> onKeyPressed;
  final VoidCallback onHangup;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<CallScreenStyles>()?.primary;

    final activeCall = activeCalls.current;
    final heldCalls = activeCalls.nonCurrent;

    final incomingRingingCalls = activeCalls.incomingRinging;
    final nonIncomingRingingCalls = activeCalls.whereNot((call) => incomingRingingCalls.contains(call)).toList();
    final nonIncomingRingingCanBeHolded = nonIncomingRingingCalls.where((call) => call.wasAccepted == true).toList();

    final focusedIsRinging = focusedCall.isIncoming && !focusedCall.wasAccepted;
    final focusedTransfer = focusedCall.transfer;

    if (!focusedIsRinging) {
      return ActiveCallActions(
        style: style?.actions,
        keypadShown: keypadShown,
        onKeypadToggle: (shown) => onKeypadToggle(shown),
        // Blocks signaling-dependent actions (hold, transfer, camera).
        // False during: interaction debounce, signaling not ready, SDP renegotiation.
        enableInteractions: interactionsEnabled,
        isIncoming: focusedCall.isIncoming,
        wasAccepted: focusedCall.wasAccepted,
        wasHungUp: focusedCall.wasHungUp,
        cameraValue: focusedCall.isCameraActive,
        cameraPermissionDenied: callConfig.isVideoCallEnabled && focusedCall.videoPermissionDenied,
        onCameraPermissionDeniedPressed: onCameraPermissionDeniedPressed,
        inviteToAttendedTransfer: focusedTransfer is InviteToAttendedTransfer,
        onCameraChanged: callConfig.isVideoCallEnabled ? onCameraChanged : null,
        mutedValue: focusedCall.muted,
        onMutedChanged: onMutedChanged,
        audioDevice: audioDevice,
        availableAudioDevices: availableAudioDevices,
        onAudioDeviceChanged: onAudioDeviceChanged,
        transferableCalls: heldCalls,
        onBlindTransferInitiated: callConfig.isBlindTransferEnabled
            ? (!focusedCall.wasAccepted || focusedTransfer != null ? null : onBlindTransferInitiated)
            : null,
        // TODO (Serdun): Simplify complex condition in the widget tree.
        onAttendedTransferInitiated: callConfig.isAttendedTransferEnabled
            ? (!focusedCall.wasAccepted || focusedTransfer != null ? null : onAttendedTransferInitiated)
            : null,
        // TODO (Serdun): Simplify complex condition in the widget tree.
        // The submit acts on the consultation call (the derived
        // `current`), not the focused one: focus may sit on the
        // held original call being transferred (an incoming call
        // grabs the selection at ring time), and using it as the
        // replace target would produce a self-referential REFER.
        //
        // KNOWN LIMITATION: `current` is still a positional guess
        // ("the live non-held call"), which breaks once a third,
        // unrelated call is concurrently active - it can point at
        // that call instead of the real consultation call. Left out
        // of scope here: server config typically caps concurrent
        // lines at 3 (not hardcoded in the app - see linesCount),
        // and this heuristic is unchanged from pre-1.16.0 behavior (not
        // a new regression). A proper fix needs an explicit
        // referor<->consultation link, not a positional guess -
        // see git history for a prior (closed) attempt.
        onAttendedTransferSubmitted: callConfig.isAttendedTransferEnabled
            ? (!activeCall.wasAccepted || focusedTransfer != null ? null : onAttendedTransferSubmitted)
            : null,
        heldValue: focusedCall.held,
        // Hold pauses just the focused call; Resume brings it
        // back as the only live one (the other live calls are
        // put on hold first). Switching lines = focus the other
        // row and press Resume - there is no separate swap.
        onHeldChanged: onHeldChanged,
        onHangupPressed: onHangup,

        onKeyPressed: onKeyPressed,
      );
    }

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
    return Column(
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
                : [for (final call in nonIncomingRingingCalls) call.displayName ?? call.handle.value],
            style: style?.callInfo,
            hintStyle: style?.hint,
          ),
        IncomingCallActions(
          style: style?.actions,
          inviteToAttendedTransfer: false,
          remoteVideo: focusedCall.remoteVideo && focusedCall.held == false,
          onHangupPressed: onHangup,
          // Answering with other calls present mutates them
          // (hold/end), so it is gated by the interactions
          // debounce like any signaling-dependent action.
          onAcceptPressed: nonIncomingRingingCalls.isNotEmpty && !interactionsEnabled ? null : onAccept,
        ),
      ],
    );
  }
}
