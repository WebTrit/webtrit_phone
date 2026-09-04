import 'package:flutter/material.dart';

import '../bloc/call_bloc.dart';
import '../view/call_screen_styles.dart';
import 'active_call_actions.dart';
import 'call_controls.dart';
import 'focused_action_hint.dart';
import 'incoming_call_actions.dart';

/// Everything the user can press about the focused call: the control grid
/// while the call is live, or Decline/Answer - with the "Acting on" hint when
/// other calls are around - while it rings.
///
/// The area is shared by the orientation layouts: each of them decides where
/// it stands, none of them what is inside. What each control does keeps
/// arriving from the screen above as the callbacks in [params].
class CallActionArea extends StatelessWidget {
  const CallActionArea({super.key, required this.params, this.hangupRowShown = true, this.padded = true});

  final CallControlsParams params;

  /// Whether the control grid keeps its own hangup row (see
  /// [ActiveCallActions.hangupRowShown]); the landscape layout renders the
  /// hangup in a zone of its own instead.
  final bool hangupRowShown;

  /// Whether the ringing Decline/Answer pad themselves to sit centered on a
  /// full-width screen (see [IncomingCallActions.padded]).
  final bool padded;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<CallScreenStyles>()?.primary;

    final activeCalls = params.activeCalls;
    final focusedCall = params.focusedCall;
    final callConfig = params.callConfig;
    final interactionsEnabled = params.interactionsEnabled;

    final activeCall = activeCalls.current;
    final heldCalls = activeCalls.nonCurrent;

    final nonIncomingRingingCalls = activeCalls.nonIncomingRinging;
    final nonIncomingRingingCanBeHolded = nonIncomingRingingCalls.where((call) => call.wasAccepted == true).toList();

    final focusedIsRinging = focusedCall.isIncomingRinging;
    final focusedTransfer = focusedCall.transfer;

    if (!focusedIsRinging) {
      return ActiveCallActions(
        style: style?.actions,
        hangupRowShown: hangupRowShown,
        padded: padded,
        keypadShown: params.keypadShown,
        dtmfInput: params.dtmfInput,
        onKeypadToggle: (shown) => params.onKeypadToggle(shown),
        // Blocks signaling-dependent actions (hold, transfer, camera).
        // False during: interaction debounce, signaling not ready, SDP renegotiation.
        enableInteractions: interactionsEnabled,
        cameraValue: focusedCall.isCameraActive,
        cameraPermissionDenied: callConfig.isVideoCallEnabled && focusedCall.videoPermissionDenied,
        onCameraPermissionDeniedPressed: params.onCameraPermissionDeniedPressed,
        onCameraChanged: callConfig.isVideoCallEnabled ? params.onCameraChanged : null,
        mutedValue: focusedCall.muted,
        onMutedChanged: params.onMutedChanged,
        audioDevice: params.audioDevice,
        availableAudioDevices: params.availableAudioDevices,
        onAudioDeviceChanged: params.onAudioDeviceChanged,
        transferableCalls: heldCalls,
        onBlindTransferInitiated: callConfig.isBlindTransferEnabled
            ? (!focusedCall.wasAccepted || focusedTransfer != null ? null : params.onBlindTransferInitiated)
            : null,
        // TODO (Serdun): Simplify complex condition in the widget tree.
        onAttendedTransferInitiated: callConfig.isAttendedTransferEnabled
            ? (!focusedCall.wasAccepted || focusedTransfer != null ? null : params.onAttendedTransferInitiated)
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
            ? (!activeCall.wasAccepted || focusedTransfer != null ? null : params.onAttendedTransferSubmitted)
            : null,
        heldValue: focusedCall.held,
        // Hold pauses just the focused call; Resume brings it
        // back as the only live one (the other live calls are
        // put on hold first). Switching lines = focus the other
        // row and press Resume - there is no separate swap.
        onHeldChanged: params.onHeldChanged,
        onHangupPressed: params.onHangup,

        onKeyPressed: params.onKeyPressed,
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
          padded: padded,
          inviteToAttendedTransfer: false,
          remoteVideo: focusedCall.remoteVideo && focusedCall.held == false,
          onHangupPressed: params.onHangup,
          // Answering with other calls present mutates them
          // (hold/end), so it is gated by the interactions
          // debounce like any signaling-dependent action.
          onAcceptPressed: nonIncomingRingingCalls.isNotEmpty && !interactionsEnabled ? null : params.onAccept,
        ),
      ],
    );
  }
}
