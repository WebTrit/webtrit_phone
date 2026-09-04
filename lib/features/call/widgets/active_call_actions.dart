import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

final _logger = Logger('ActiveCallActions');

class ActiveCallActions extends StatefulWidget {
  const ActiveCallActions({
    super.key,
    required this.enableInteractions,
    required this.cameraValue,
    this.cameraPermissionDenied = false,
    this.onCameraPermissionDeniedPressed,
    this.onCameraChanged,
    required this.mutedValue,
    this.onMutedChanged,
    required this.audioDevice,
    required this.availableAudioDevices,
    required this.onAudioDeviceChanged,
    this.transferableCalls = const [],
    required this.onBlindTransferInitiated,
    required this.onAttendedTransferInitiated,
    required this.onAttendedTransferSubmitted,
    required this.heldValue,
    this.onHeldChanged,
    this.onHangupPressed,
    this.onKeyPressed,
    this.keypadShown = false,
    required this.dtmfInput,
    this.onKeypadToggle,
    this.hangupRowShown = true,
    this.padded = true,
    this.style,
  });

  final bool enableInteractions;
  final bool cameraValue;

  /// Whether camera permission was denied for this call (audio-only downgrade).
  /// When set, the camera button shows a settings hint instead of toggling.
  final bool cameraPermissionDenied;

  /// Invoked when the camera button is tapped while [cameraPermissionDenied].
  /// The handler re-checks the live permission and either enables the camera
  /// (now granted) or opens app settings (still denied).
  final VoidCallback? onCameraPermissionDeniedPressed;
  final ValueChanged<bool>? onCameraChanged;
  final bool mutedValue;
  final ValueChanged<bool>? onMutedChanged;
  final CallAudioDevice? audioDevice;
  final List<CallAudioDevice> availableAudioDevices;
  final Function(CallAudioDevice device) onAudioDeviceChanged;
  final List<ActiveCall> transferableCalls;
  final VoidCallback? onBlindTransferInitiated;
  final VoidCallback? onAttendedTransferInitiated;
  final void Function(ActiveCall call)? onAttendedTransferSubmitted;
  final bool heldValue;
  final ValueChanged<bool>? onHeldChanged;
  final void Function()? onHangupPressed;
  final void Function(String value)? onKeyPressed;

  /// Whether the in-call keypad is shown. The state is owned by the parent:
  /// the surrounding layout renders differently around the open keypad (the
  /// avatar hides), so a single owner keeps the two in sync.
  final bool keypadShown;

  /// The digits typed on the open keypad, owned by the screen (one buffer for
  /// both orientations); the in-grid display only listens to it, so a
  /// keypress never rebuilds the grid.
  final ValueListenable<String> dtmfInput;

  /// Requests the in-call keypad to be shown or hidden.
  final ValueChanged<bool>? onKeypadToggle;

  /// Whether the hangup (and hide-keypad) row renders inside this grid. The
  /// portrait screen keeps it here; the landscape layout pulls the hangup out
  /// into a zone of its own, and the grid drops the row together with the
  /// self-centering padding - the zone gives it exactly its own space.
  final bool hangupRowShown;

  /// Whether the grid pads itself to sit centered on a full-width screen. A
  /// layout that hands it exactly the space it needs turns this off and does
  /// the placing itself.
  final bool padded;

  final CallScreenActionsStyle? style;

  @override
  State<ActiveCallActions> createState() => _ActiveCallActionsState();
}

class _ActiveCallActionsState extends State<ActiveCallActions> {
  final _keypadTextFieldKey = GlobalKey();
  final _keypadScrollController = ScrollController();

  late TextEditingController _keypadTextEditingController;

  late MediaQueryData _mediaQueryData;
  late ThemeData _themeData;

  late InputDecorations? _inputDecorations;
  late TextStyle? _textStyle;

  double? _iconSize;

  late bool _isOrientationPortrait;
  late double _dimension;
  late double _actionsDelimiterDimension;
  late double _hangupDelimiterDimension;
  late double _horizontalPadding;

  late final WidgetStatesController _speakerStatesController = WidgetStatesController();
  late final WidgetStatesController _heldStatesController = WidgetStatesController();
  late final WidgetStatesController _mutedStatesController = WidgetStatesController();
  late final WidgetStatesController _cameraStatesController = WidgetStatesController();

  @override
  void initState() {
    super.initState();
    _keypadTextEditingController = TextEditingController(text: widget.dtmfInput.value);
    widget.dtmfInput.addListener(_syncDtmfDisplay);
  }

  @override
  void didUpdateWidget(covariant ActiveCallActions oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The screen owns the one digit buffer for both orientations; the in-grid
    // display only listens to it, so it survives rotation and empties exactly
    // when the buffer does.
    if (!identical(oldWidget.dtmfInput, widget.dtmfInput)) {
      oldWidget.dtmfInput.removeListener(_syncDtmfDisplay);
      widget.dtmfInput.addListener(_syncDtmfDisplay);
      _syncDtmfDisplay();
    }
    // The dimensions depend on this flag, and didChangeDependencies does not
    // run for an in-place widget update - without this a flipped flag keeps
    // the padding of the other mode.
    if (oldWidget.hangupRowShown != widget.hangupRowShown || oldWidget.padded != widget.padded) computeDimensions();
  }

  @override
  void dispose() {
    widget.dtmfInput.removeListener(_syncDtmfDisplay);
    _keypadTextEditingController.dispose();
    _keypadScrollController.dispose();
    super.dispose();
  }

  /// Mirrors the screen-owned buffer into the display and keeps the newest
  /// digits in view. A read-only field never scrolls to its caret on an
  /// external controller write, so the display is scrolled to the end by
  /// hand once the new text has been laid out.
  void _syncDtmfDisplay() {
    final digits = widget.dtmfInput.value;
    _keypadTextEditingController.value = TextEditingValue(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
    WidgetsBinding.instance.addPostFrameCallback(_scrollDtmfDisplayToEnd);
  }

  /// Runs after the frame that laid the new text out; anything earlier has no
  /// scroll extent for it yet.
  void _scrollDtmfDisplayToEnd(Duration _) {
    if (!mounted || !_keypadScrollController.hasClients) return;
    _keypadScrollController.jumpTo(_keypadScrollController.position.maxScrollExtent);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mediaQueryData = MediaQuery.of(context);
    _themeData = Theme.of(context);
    computeDimensions();
  }

  void computeDimensions() {
    _inputDecorations = _themeData.extension<InputDecorations>();
    final baseKeypadInputStyle = _themeData.textTheme.displaySmall?.copyWith(color: _themeData.colorScheme.surface);
    final configuredKeypadInputStyle = widget.style?.keypadInputTextStyle;
    _textStyle = baseKeypadInputStyle?.merge(configuredKeypadInputStyle) ?? configuredKeypadInputStyle;

    _iconSize = _themeData.textTheme.headlineLarge?.fontSize;

    _isOrientationPortrait = _mediaQueryData.orientation == Orientation.portrait;
    _dimension = min(_mediaQueryData.size.width, _mediaQueryData.size.height) / 5;
    if (_isOrientationPortrait) {
      _actionsDelimiterDimension = _dimension / 5;
      _hangupDelimiterDimension = _actionsDelimiterDimension;
      _horizontalPadding = widget.padded ? _dimension / 2 : 0;
    } else {
      _actionsDelimiterDimension = _dimension / 9;
      _hangupDelimiterDimension = _actionsDelimiterDimension;
      _horizontalPadding = widget.padded ? _dimension * 3 : 0;
    }
    if (mounted) setState(() {});
  }

  // --- Intent helpers -------------------------------------------------------
  // Callbacks in the widget tree are single-expression; multi-step logic
  // lives here.

  /// Appends the pressed key to the DTMF display and forwards it upstream.
  ///
  /// Sending a tone is signaling-dependent: while interactions are blocked the
  /// press is ignored whole, so the display never shows a digit the other side
  /// did not receive. The keypad can stay open across such a window (e.g. a
  /// renegotiation), which is why the guard lives here and not only on the
  /// button that opens it.
  void _enterKeypadKey(String key) {
    if (!widget.enableInteractions) return;
    final onKeyPressed = widget.onKeyPressed;
    if (onKeyPressed == null) return;
    // The screen appends the digit to the shared buffer and hands it back
    // down as [ActiveCallActions.dtmfInput]; nothing is written locally, so
    // the display can never drift from what was actually sent.
    onKeyPressed(key);
  }

  /// Closes the in-call keypad; the screen drops the collected digits with it.
  void _hideKeypad() {
    widget.onKeypadToggle?.call(false);
  }

  /// Switches between the built-in speakerphone and the earpiece.
  void _toggleSpeakerphone() {
    final speakerOn = widget.audioDevice?.type == CallAudioDeviceType.speaker;
    if (speakerOn) {
      final earpieceDevice = widget.availableAudioDevices.getEarpiece;
      if (earpieceDevice != null) {
        widget.onAudioDeviceChanged(earpieceDevice);
      } else {
        _logger.warning('Earpiece device not found while trying to disable speakerphone');
      }
    } else {
      final speakerDevice = widget.availableAudioDevices.getSpeaker;
      if (speakerDevice != null) {
        widget.onAudioDeviceChanged(speakerDevice);
      } else {
        _logger.warning('Speaker device not found while trying to enable speakerphone');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    // Camera can trigger SDP renegotiation when adding a new track, so it is gated.
    final onCameraChanged = widget.enableInteractions ? widget.onCameraChanged : null;
    // The permission-denied tap can enable the camera (-> SDP renegotiation), so it is gated too.
    final onCameraPermissionDeniedPressed = widget.enableInteractions ? widget.onCameraPermissionDeniedPressed : null;
    // Mute is local-only (no SDP change), so it stays active during renegotiation.
    final onMutedChanged = widget.onMutedChanged;
    // Speaker switching is local-only (no SDP change), so it stays active during renegotiation.
    final audioDevice = widget.audioDevice;
    final onAudioDeviceChanged = widget.onAudioDeviceChanged;
    final speakerOn = audioDevice?.type == CallAudioDeviceType.speaker;
    // Transfer button itself is local (opens a popup), only the actions inside are signaling-dependent.
    final onBlindTransferInitiated = widget.onBlindTransferInitiated;
    final onAttendedTransferInitiated = widget.onAttendedTransferInitiated;
    // Hold/resume sends signaling requests and triggers renegotiation.
    final onHeldChanged = widget.enableInteractions ? widget.onHeldChanged : null;
    final onKeyPressed = widget.enableInteractions ? widget.onKeyPressed : null;

    // Always allow the user to hang up or answer the call
    final onHangupPressed = widget.onHangupPressed;

    // The camera button flips between three intents (see cameraPermissionDenied).
    final onCameraPressed = widget.cameraPermissionDenied
        ? onCameraPermissionDeniedPressed
        : (onCameraChanged != null ? () => onCameraChanged(!widget.cameraValue) : null);

    // The keypad opens when DTMF input is wired, in either orientation.
    final canShowKeypad = onKeyPressed != null;

    // With no transfer intent wired the trigger renders disabled; each branch
    // of the menu has its own set of items, so each has its own condition.
    final transferInitAvailable = onBlindTransferInitiated != null || onAttendedTransferInitiated != null;
    final transferToCallAvailable = onBlindTransferInitiated != null || widget.onAttendedTransferSubmitted != null;

    // Icons
    final actionPadIconSize = themeData.textTheme.headlineMedium!.fontSize;

    // States
    final isAudioSelected = audioDevice?.type != CallAudioDeviceType.earpiece;

    // Keypad
    final foregroundColor =
        widget.style?.key?.foregroundColor?.resolve(const <WidgetState>{}) ?? Theme.of(context).colorScheme.surface;

    final keypadTextStyle = DefaultTextStyle.of(context).style
        .copyWith(fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize, height: 1.0, color: foregroundColor);

    final subKeypadTextStyle = DefaultTextStyle.of(context).style.copyWith(
      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
      height: 1.0,
      color: foregroundColor.withValues(alpha: 0.6),
    );

    final TextButtonsTable buttonsTable;

    late List<Widget> actions;
    if (widget.keypadShown) {
      actions = _buildKeypadActions(keypadTextStyle, subKeypadTextStyle);
    } else {
      actions = [
        // row
        CallActionButton(
          key: callActionsMuteKey,
          identifier: callActionsMuteId,
          label: widget.mutedValue
              ? context.l10n.call_CallActionsTooltip_unmute
              : context.l10n.call_CallActionsTooltip_mute,
          onPressed: onMutedChanged != null ? () => onMutedChanged(!widget.mutedValue) : null,
          statesController: _mutedStatesController..update(WidgetState.selected, widget.mutedValue),
          style: widget.style?.muted,
          child: Icon(widget.mutedValue ? Icons.mic_off : Icons.mic, size: actionPadIconSize),
        ),
        CallActionButton(
          key: callActionsVideoCallKey,
          identifier: callActionsVideoCallId,
          label: widget.cameraPermissionDenied
              ? context.l10n.call_CallActionsTooltip_cameraPermissionDenied
              : widget.cameraValue
              ? context.l10n.call_CallActionsTooltip_disableCamera
              : context.l10n.call_CallActionsTooltip_enableCamera,
          onPressed: onCameraPressed,
          statesController: _cameraStatesController..update(WidgetState.selected, widget.cameraValue),
          style: widget.style?.camera,
          child: Icon(widget.cameraValue ? Icons.videocam : Icons.videocam_off, size: actionPadIconSize),
        ),
        if (widget.availableAudioDevices.onlyBuiltIn)
          CallActionButton(
            key: callActionsSpeakerKey,
            identifier: callActionsSpeakerId,
            label: speakerOn
                ? context.l10n.call_CallActionsTooltip_disableSpeaker
                : context.l10n.call_CallActionsTooltip_enableSpeaker,
            onPressed: _toggleSpeakerphone,
            statesController: _speakerStatesController..update(WidgetState.selected, speakerOn),
            style: widget.style?.speaker,
            child: Icon(speakerOn ? Icons.volume_up : Icons.phone_in_talk, size: actionPadIconSize),
          ),
        if (!widget.availableAudioDevices.onlyBuiltIn)
          CallActionMenuButton<CallAudioDevice>(
            identifier: callActionsAudioDeviceId,
            label: context.l10n.call_CallActionsTooltip_changeAudioDevice,
            offset: Offset(_dimension + 8, 0),
            statesController: _speakerStatesController..update(WidgetState.selected, isAudioSelected),
            style: widget.style?.speaker,
            onSelected: onAudioDeviceChanged,
            items: _buildAudioDeviceItems(themeData),
            child: Icon(switch (audioDevice?.type) {
              CallAudioDeviceType.speaker => Icons.volume_up,
              CallAudioDeviceType.bluetooth => Icons.bluetooth_audio,
              CallAudioDeviceType.wiredHeadset => Icons.headset,
              CallAudioDeviceType.earpiece => Icons.phone_in_talk,
              CallAudioDeviceType.streaming => Icons.usb,
              _ => Icons.volume_off,
            }, size: actionPadIconSize),
          ),
        // delimiter
        const SizedBox(),
        SizedBox.square(dimension: _actionsDelimiterDimension),
        const SizedBox(),
        if (widget.transferableCalls.isNotEmpty)
          CallActionMenuButton(
            key: callActionsTransferMenuKey,
            identifier: callActionsTransferMenuId,
            label: context.l10n.call_CallActionsTooltip_transfer,
            enabled: transferToCallAvailable,
            offset: Offset(_dimension + 8, 0),
            style: widget.style?.transfer,
            items: _buildTransferToCallItems(themeData),
            child: Icon(Icons.phone_forwarded, size: actionPadIconSize),
          ),
        if (widget.transferableCalls.isEmpty)
          CallActionMenuButton(
            key: callActionsTransferMenuKey,
            identifier: callActionsTransferMenuId,
            label: context.l10n.call_CallActionsTooltip_transfer,
            enabled: transferInitAvailable,
            offset: Offset(_dimension + 8, 0),
            style: widget.style?.transfer,
            items: _buildTransferInitItems(themeData),
            child: Icon(Icons.phone_forwarded, size: actionPadIconSize),
          ),
        CallActionButton(
          key: callActionsHoldKey,
          identifier: callActionsHoldId,
          label: widget.heldValue
              ? context.l10n.call_CallActionsTooltip_unhold
              : context.l10n.call_CallActionsTooltip_hold,
          onPressed: onHeldChanged == null ? null : () => onHeldChanged(!widget.heldValue),
          statesController: _heldStatesController..update(WidgetState.selected, widget.heldValue),
          style: widget.style?.held,
          child: Icon(widget.heldValue ? Icons.play_arrow : Icons.pause, size: actionPadIconSize),
        ),
        CallActionButton(
          key: callActionsKeypadKey,
          identifier: callActionsKeypadId,
          label: context.l10n.call_CallActionsTooltip_showKeypad,
          onPressed: canShowKeypad ? () => widget.onKeypadToggle?.call(true) : null,
          style: widget.style?.key,
          child: Icon(Icons.dialpad, size: actionPadIconSize),
        ),
        // hangup delimiter
        if (widget.hangupRowShown) ...[
          const SizedBox(),
          SizedBox.square(dimension: _hangupDelimiterDimension),
          const SizedBox(),
        ],
        //
      ];
    }

    buttonsTable = TextButtonsTable(
      minimumSize: Size.square(_dimension),
      children: [
        // actions rows
        ...actions,
        // hangup row
        if (widget.hangupRowShown) ...[
          const SizedBox(),
          CallHangupButton(onPressed: onHangupPressed, style: widget.style?.hangup),
          widget.keypadShown
              ? CallHideKeypadButton(onPressed: _hideKeypad, style: widget.style?.key)
              : const SizedBox(),
        ],
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: IconTheme(
        data: IconThemeData(size: _iconSize),
        child: Column(
          children: [
            // The landscape layout shows the typed digits in the info zone
            // instead, next to the person they are being sent to.
            if (widget.keypadShown && widget.hangupRowShown) ...[
              TextField(
                key: _keypadTextFieldKey,
                controller: _keypadTextEditingController,
                scrollController: _keypadScrollController,
                decoration: _inputDecorations?.keypad,
                style: _textStyle,
                textAlign: TextAlign.center,
                readOnly: true,
                canRequestFocus: false,
              ),
              SizedBox.square(dimension: _actionsDelimiterDimension),
            ],
            buttonsTable,
          ],
        ),
      ),
    );
  }

  /// The 12 DTMF keys, three per row with the row delimiters in between.
  List<Widget> _buildKeypadActions(TextStyle keypadTextStyle, TextStyle subKeypadTextStyle) {
    return KeypadKey.numbers.indexed
        .map((e) {
          final (i, k) = e;
          return [
            KeypadKeyButton(
              text: k.text,
              subtext: k.subtext,
              onKeyPressed: _enterKeypadKey,
              style: KeypadKeyStyle(
                buttonStyle: widget.style?.key,
                textStyle: keypadTextStyle,
                subtextStyle: subKeypadTextStyle,
              ),
            ),
            if ((i + 1) % 3 == 0) ...[
              const SizedBox(),
              SizedBox.square(dimension: _actionsDelimiterDimension),
              const SizedBox(),
            ],
          ];
        })
        .expand((e) => e)
        .toList(growable: false);
  }

  /// Menu items of the audio-device picker, one per available device.
  List<PopupMenuEntry<CallAudioDevice>> _buildAudioDeviceItems(ThemeData themeData) {
    return widget.availableAudioDevices
        .map((device) {
          final CallAudioDevice(:name, :type, :id) = device;
          return CallPopupMenuItem<CallAudioDevice>(
            value: device,
            text: switch (type) {
              CallAudioDeviceType.speaker => context.l10n.call_CallActionsTooltip_device_speaker,
              CallAudioDeviceType.earpiece => context.l10n.call_CallActionsTooltip_device_earpiece,
              CallAudioDeviceType.wiredHeadset => context.l10n.call_CallActionsTooltip_device_wiredHeadset,
              CallAudioDeviceType.bluetooth => name ?? context.l10n.call_CallActionsTooltip_device_bluetooth,
              CallAudioDeviceType.streaming => name ?? context.l10n.call_CallActionsTooltip_device_streaming,
              _ => name ?? context.l10n.call_CallActionsTooltip_device_unknown,
            },
            icon: Icon(
              switch (type) {
                CallAudioDeviceType.speaker => Icons.volume_up,
                CallAudioDeviceType.bluetooth => Icons.bluetooth_audio,
                CallAudioDeviceType.wiredHeadset => Icons.headset,
                CallAudioDeviceType.earpiece => Icons.phone_in_talk,
                CallAudioDeviceType.streaming => Icons.usb,
                _ => Icons.device_unknown,
              },
              size: 20,
              color: themeData.textTheme.bodyMedium!.color,
            ),
            textStyle: themeData.textTheme.bodyMedium,
          );
        })
        .toList(growable: false);
  }

  /// Menu items of the transfer popup while other calls can be transfer
  /// targets: one per transferable call, plus the free-number option.
  List<PopupMenuEntry<dynamic>> _buildTransferToCallItems(ThemeData themeData) {
    final popupMenuIconSize = themeData.textTheme.bodyLarge!.fontSize;
    final onAttendedTransferSubmitted = widget.onAttendedTransferSubmitted;
    return [
      // Numbered by position rather than by looking the call up: a call
      // compares by value across all of its fields, so a search would be both
      // slow and wrong the day two calls happen to look alike.
      for (final (index, call) in widget.transferableCalls.indexed)
        if (onAttendedTransferSubmitted != null)
          CallPopupMenuItem(
            key: callActionsTransferMenuNumberKey,
            identifier: numberedId(callActionsTransferMenuNumberId, index),
            // Transfer is signaling-dependent, disable during renegotiation.
            enabled: widget.enableInteractions,
            onTap: () => onAttendedTransferSubmitted.call(call),
            text: call.displayName ?? call.handle.value,
            icon: Icon(
              Icons.phone_paused_outlined,
              size: popupMenuIconSize,
              color: themeData.textTheme.bodyMedium!.color,
            ),
            textStyle: themeData.textTheme.bodyMedium,
          ),
      // The same id as the entry that starts an unattended transfer when there
      // is nothing to transfer to: it is the same action, offered in the other
      // shape of this menu, and the two shapes never appear together.
      if (widget.onBlindTransferInitiated != null)
        CallPopupMenuItem(
          identifier: callActionsTransferMenuBlindInitId,
          // Transfer is signaling-dependent, disable during renegotiation.
          enabled: widget.enableInteractions,
          onTap: widget.onBlindTransferInitiated,
          text: context.l10n.call_CallActionsTooltip_transfer_choose,
          icon: Icon(
            Icons.phone_forwarded_outlined,
            size: popupMenuIconSize,
            color: themeData.textTheme.bodyMedium!.color,
          ),
          textStyle: themeData.textTheme.bodyMedium,
        ),
    ];
  }

  /// Menu items of the transfer popup with no other calls around: start an
  /// unattended or an attended transfer.
  List<PopupMenuEntry<dynamic>> _buildTransferInitItems(ThemeData themeData) {
    final popupMenuIconSize = themeData.textTheme.bodyLarge!.fontSize;
    return [
      if (widget.onBlindTransferInitiated != null)
        CallPopupMenuItem(
          key: callActionsTransferMenuBlindInitKey,
          identifier: callActionsTransferMenuBlindInitId,
          // Transfer is signaling-dependent, disable during renegotiation.
          enabled: widget.enableInteractions,
          onTap: widget.onBlindTransferInitiated,
          text: context.l10n.call_CallActionsTooltip_unattended_transfer,
          icon: Icon(
            Icons.phone_forwarded_outlined,
            size: popupMenuIconSize,
            color: themeData.textTheme.bodyMedium!.color,
          ),
          textStyle: themeData.textTheme.bodyMedium,
        ),
      if (widget.onAttendedTransferInitiated != null)
        CallPopupMenuItem(
          key: callActionsTransferMenuAttendedInitKey,
          identifier: callActionsTransferMenuAttendedInitId,
          // Transfer is signaling-dependent, disable during renegotiation.
          enabled: widget.enableInteractions,
          onTap: widget.onAttendedTransferInitiated,
          text: context.l10n.call_CallActionsTooltip_attended_transfer,
          icon: Icon(
            Icons.phone_forwarded_outlined,
            size: popupMenuIconSize,
            color: themeData.textTheme.bodyMedium!.color,
          ),
          textStyle: themeData.textTheme.bodyMedium,
        ),
    ];
  }
}
