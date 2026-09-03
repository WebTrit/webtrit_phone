import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/call_bloc.dart';
import '../extensions/extensions.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import '../view/call_screen_styles.dart';
import 'call_action_area.dart';
import 'call_info_block.dart';
import 'call_remote_avatar.dart';
import 'call_toolbar_status.dart';
import 'popup_menu.dart';

/// Everything the user can press during a call: the toolbar, the call
/// information and the action area, laid out for the current orientation.
///
/// It only presents - what each control does is decided by the screen above and
/// arrives here as a callback, so this stays a plain description of the call
/// and can be put on a test screen on its own. The information and the action
/// pieces themselves live in [CallInfoBlock] and [CallActionArea], shared with
/// the landscape layout; this widget owns the toolbar and where the pieces
/// stand in portrait.
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
  final List<PopupMenuEntry<void>> popupMenuItems;

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
                  CallInfoBlock(activeCalls: activeCalls, focusedCall: focusedCall, onCallSelected: onCallSelected),
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
                              radius: CallRemoteAvatar.preferredRadius(mediaQueryData),
                              contactResolver: contactResolver,
                            ),
                          ),
                        ),
                      )
                    else
                      CallRemoteAvatar(
                        activeCall: activeCall,
                        radius: CallRemoteAvatar.preferredRadius(mediaQueryData),
                        contactResolver: contactResolver,
                      ),
                  CallActionArea(
                    activeCalls: activeCalls,
                    focusedCall: focusedCall,
                    audioDevice: audioDevice,
                    availableAudioDevices: availableAudioDevices,
                    callConfig: callConfig,
                    keypadShown: keypadShown,
                    interactionsEnabled: interactionsEnabled,
                    onKeypadToggle: onKeypadToggle,
                    onCameraChanged: onCameraChanged,
                    onCameraPermissionDeniedPressed: onCameraPermissionDeniedPressed,
                    onMutedChanged: onMutedChanged,
                    onAudioDeviceChanged: onAudioDeviceChanged,
                    onBlindTransferInitiated: onBlindTransferInitiated,
                    onAttendedTransferInitiated: onAttendedTransferInitiated,
                    onAttendedTransferSubmitted: onAttendedTransferSubmitted,
                    onHeldChanged: onHeldChanged,
                    onKeyPressed: onKeyPressed,
                    onHangup: onHangup,
                    onAccept: onAccept,
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
