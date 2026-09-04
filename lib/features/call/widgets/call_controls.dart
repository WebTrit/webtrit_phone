import 'package:flutter/foundation.dart';
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
import 'call_controls_landscape.dart';
import 'call_controls_portrait.dart';
import 'call_toolbar_status.dart';
import 'popup_menu.dart';

/// Everything the call layouts present and dispatch, bundled once: the calls
/// on screen, the display state around them, and the intent callbacks the
/// controls fire. One object travels from the screen through the orientation
/// selector into both layouts and the action area, so a new control means one
/// new field instead of a change in every constructor on the way.
class CallControlsParams {
  const CallControlsParams({
    required this.activeCalls,
    required this.focusedCall,
    required this.availableAudioDevices,
    required this.callConfig,
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
    required this.dtmfInput,
    this.audioDevice,
    this.contactResolver,
    this.keypadShown = false,
  });

  final List<ActiveCall> activeCalls;

  /// The call the info block and the action area act on; the roster highlights
  /// its row.
  final ActiveCall focusedCall;

  final List<CallAudioDevice> availableAudioDevices;
  final CallCapabilitiesConfig callConfig;

  /// Whether anything that talks to the server may be pressed at all. It goes
  /// down while a previous action is still settling, while signaling is not
  /// ready and while a call is being renegotiated.
  final bool interactionsEnabled;

  /// Whether there is a picture behind the controls; without one the avatar
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

  final CallAudioDevice? audioDevice;

  /// Resolves the remote number to a contact for the avatar shown in place of
  /// the video.
  final ContactResolver? contactResolver;

  final bool keypadShown;

  /// The digits typed on the open keypad. One buffer for both orientations:
  /// the screen owns it and the displays only listen, so rotation can neither
  /// lose nor duplicate digits, and a keypress repaints the digits alone
  /// instead of rebuilding the whole call screen.
  final ValueListenable<String> dtmfInput;

  /// Whether the picture behind the controls belongs to the focused call -
  /// only then may its avatar stand down. The screen probes frames on the
  /// derived current call, which says nothing about a held or audio-only
  /// focused one; a held focus shows its avatar too, since the screen hides
  /// the video of a held call rather than freeze on its last frame.
  bool get focusedFrameRenderable =>
      hasRenderableRemoteFrame && focusedCall.callId == activeCalls.current.callId && !focusedCall.held;
}

/// Everything the user can press during a call: the toolbar, the call
/// information and the action area, laid out for the current orientation.
///
/// It only presents - what each control does is decided by the screen above
/// and arrives in [params] as callbacks, so this stays a plain description of
/// the call and can be put on a test screen on its own. This widget owns the
/// toolbar and selects the body arrangement through
/// [OrientationLayoutSelector]: [CallControlsPortrait] or
/// [CallControlsLandscape].
class CallControls extends StatelessWidget {
  const CallControls({super.key, required this.callStatus, required this.popupMenuItems, required this.params});

  final CallStatus callStatus;

  /// The view options offered in the toolbar; they belong to the screen, which
  /// owns how the video is fitted and what is behind it.
  final List<PopupMenuEntry<void>> popupMenuItems;

  final CallControlsParams params;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<CallScreenStyles>()?.primary;

    final activeCalls = params.activeCalls;

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
          child: OrientationLayoutSelector(
            portrait: CallControlsPortrait(params: params),
            landscape: CallControlsLandscape(params: params),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
