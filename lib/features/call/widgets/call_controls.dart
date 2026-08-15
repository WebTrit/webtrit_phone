import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/call_bloc.dart';
import '../extensions/extensions.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import '../view/call_screen_styles.dart';
import 'active_call_actions.dart';
import 'call_info.dart';
import 'call_list.dart';
import 'call_remote_avatar.dart';
import 'call_toolbar_status.dart';
import 'focused_action_hint.dart';
import 'incoming_call_actions.dart';
import 'popup_menu.dart';

/// Everything the user can press during a call: the toolbar, the call
/// information and the action area, laid out for the current orientation.
///
/// It only presents - what each control does is decided by the screen above and
/// arrives here as a callback, so this stays a plain description of the call
/// and can be put on a test screen on its own.
class CallControls extends StatelessWidget {
  const CallControls({
    super.key,
    required this.callStatus,
    required this.activeCalls,
    required this.focusedCall,
    required this.audioDevice,
    required this.availableAudioDevices,
    required this.callConfig,
    required this.contactResolver,
    required this.popupMenuItems,
    required this.keypadShown,
    required this.interactionsEnabled,
    required this.hasRenderableRemoteFrame,
    required this.onCallSelected,
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

  final CallStatus callStatus;
  final List<ActiveCall> activeCalls;

  /// The call the info block and the action area act on; the list highlights
  /// its row.
  final ActiveCall focusedCall;

  final CallAudioDevice? audioDevice;
  final List<CallAudioDevice> availableAudioDevices;
  final CallCapabilitiesConfig callConfig;

  /// Resolves the remote number to a contact for the avatar shown in place of
  /// the video.
  final ContactResolver? contactResolver;

  /// The view options offered in the toolbar; they belong to the screen, which
  /// owns how the video is fitted and what is behind it.
  final List<PopupMenuItem<void>> popupMenuItems;

  final bool keypadShown;

  /// Whether anything that talks to the server may be pressed at all. It goes
  /// down while a previous action is still settling, while signaling is not
  /// ready and while a call is being renegotiated.
  final bool interactionsEnabled;

  /// Whether there is a picture behind these controls; without one the avatar
  /// takes its place.
  final bool hasRenderableRemoteFrame;

  final ValueChanged<String> onCallSelected;
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
    final activeCall = activeCalls.current;
    final heldCalls = activeCalls.nonCurrent;

    final incomingRingingCalls = activeCalls.where((call) => call.isIncoming && call.wasAccepted == false).toList();
    final nonIncomingRingingCalls = activeCalls.whereNot((call) => incomingRingingCalls.contains(call)).toList();
    final nonIncomingRingingCanBeHolded = nonIncomingRingingCalls.where((call) => call.wasAccepted == true).toList();

    final focusedIsRinging = focusedCall.isIncoming && !focusedCall.wasAccepted;
    final focusedTransfer = focusedCall.transfer;

    final mediaQueryData = MediaQuery.of(context);
    final style = Theme.of(context).extension<CallScreenStyles>()?.primary;

    return Column(
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
            callStatus: callStatus,
            networkQuality: activeCalls.worstNetworkQuality,
            iceConnectionIssue: activeCalls.firstIceConnectionIssue,
            style: style?.callInfo,
          ),
          actions: [
            if (activeCalls.shouldAutoCompact)
              SemanticAction.button(
                label: context.l10n.call_settings_additional_options,
                identifier: callActionsOptionsId,
                child: CallPopupMenuButton<void>(items: popupMenuItems, child: const Icon(Icons.more_vert)),
              ),
          ],
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isPortrait = mediaQueryData.orientation == Orientation.portrait;
              final content = Column(
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
                      onCallTap: onCallSelected,
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
                  // Nothing to render in the video area (audio-only call,
                  // remote camera off, or a held call): the remote party's
                  // avatar takes its place, between the info block and the
                  // action area. The avatar takes only the height LEFT OVER
                  // by the info block and the action area and scales itself
                  // down into it - so growing content (e.g. the open in-call
                  // keypad) shrinks the avatar, never the controls.
                  if (!hasRenderableRemoteFrame && !keypadShown)
                    if (isPortrait)
                      Flexible(
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CallRemoteAvatar(
                              activeCall: activeCall,
                              radius: _avatarRadius(mediaQueryData),
                              contactResolver: contactResolver,
                            ),
                          ),
                        ),
                      )
                    else
                      CallRemoteAvatar(
                        activeCall: activeCall,
                        radius: _avatarRadius(mediaQueryData),
                        contactResolver: contactResolver,
                      ),
                  if (!focusedIsRinging)
                    ActiveCallActions(
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
                    ),
                ],
              );

              // Portrait has the room: controls render at natural size and
              // the avatar flexes into what is left. Landscape keeps the
              // legacy scale-to-fit of the whole block - heights there are
              // too small for the natural layout.
              if (isPortrait) {
                return SizedBox(width: constraints.maxWidth, height: constraints.maxHeight, child: content);
              }
              return FittedBox(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth, minHeight: constraints.minHeight),
                  child: content,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

/// Preferred radius of the avatar shown in place of the remote video; the
/// avatar scales itself down when the space left over by the info block and the
/// action area is smaller than this.
double _avatarRadius(MediaQueryData mediaQueryData) {
  return (mediaQueryData.size.shortestSide * 0.30).clamp(24.0, 150.0);
}
