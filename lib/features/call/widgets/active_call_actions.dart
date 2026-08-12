import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

export 'call_actions_style.dart';
export 'call_actions_styles.dart';

final _logger = Logger('ActiveCallActions');

class ActiveCallActions extends StatefulWidget {
  const ActiveCallActions({
    super.key,
    required this.enableInteractions,
    required this.isIncoming,
    required this.wasAccepted,
    required this.wasHungUp,
    required this.cameraValue,
    this.cameraPermissionDenied = false,
    this.onCameraPermissionDeniedPressed,
    required this.inviteToAttendedTransfer,
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
    this.onKeypadToggle,
    this.style,
  });

  final bool enableInteractions;
  final bool isIncoming;
  final bool wasAccepted;
  final bool wasHungUp;
  final bool cameraValue;

  /// Whether camera permission was denied for this call (audio-only downgrade).
  /// When set, the camera button shows a settings hint instead of toggling.
  final bool cameraPermissionDenied;

  /// Invoked when the camera button is tapped while [cameraPermissionDenied].
  /// The handler re-checks the live permission and either enables the camera
  /// (now granted) or opens app settings (still denied).
  final VoidCallback? onCameraPermissionDeniedPressed;
  final bool inviteToAttendedTransfer;
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

  /// Requests the in-call keypad to be shown or hidden.
  final ValueChanged<bool>? onKeypadToggle;

  final CallScreenActionsStyle? style;

  @override
  State<ActiveCallActions> createState() => _ActiveCallActionsState();
}

class _ActiveCallActionsState extends State<ActiveCallActions> {
  final _keypadTextFieldKey = GlobalKey();

  EditableTextState? get _keypadTextFieldEditableTextState =>
      (_keypadTextFieldKey.currentState as TextSelectionGestureDetectorBuilderDelegate).editableTextKey.currentState;

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
    _keypadTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _keypadTextEditingController.dispose();
    super.dispose();
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
      _horizontalPadding = _dimension / 2;
    } else {
      _actionsDelimiterDimension = _dimension / 9;
      _hangupDelimiterDimension = _actionsDelimiterDimension;
      _horizontalPadding = _dimension * 3;
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

    final newText = _keypadTextEditingController.text + key;
    final newSelection = TextSelection.collapsed(offset: newText.length);
    final value = _keypadTextEditingController.value.copyWith(text: newText, selection: newSelection);
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    onKeyPressed(key);
  }

  /// Closes the in-call keypad, dropping the collected DTMF input.
  void _hideKeypad() {
    _keypadTextEditingController.clear();
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

    // The keypad opens only in portrait and only when DTMF input is wired.
    final canShowKeypad = onKeyPressed != null && _isOrientationPortrait;

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

    final keypadTextStyle = DefaultTextStyle.of(context).style.copyWith(
      fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
      height: 1.0,
      color: foregroundColor,
    );

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
        const SizedBox(),
        SizedBox.square(dimension: _hangupDelimiterDimension),
        const SizedBox(),
        //
      ];
    }

    buttonsTable = TextButtonsTable(
      minimumSize: Size.square(_dimension),
      children: [
        // actions rows
        ...actions,
        // hangup row
        const SizedBox(),
        CallActionButton(
          key: callActionsHangupKey,
          identifier: callActionsHangupId,
          label: context.l10n.call_CallActionsTooltip_hangup,
          onPressed: onHangupPressed,
          style: widget.style?.hangup,
          child: Icon(Icons.call_end, size: actionPadIconSize),
        ),
        widget.keypadShown
            ? CallActionButton(
                identifier: callActionsHideKeypadId,
                label: context.l10n.call_CallActionsTooltip_hideKeypad,
                onPressed: _hideKeypad,
                style: widget.style?.key,
                child: Icon(Icons.dialpad, size: actionPadIconSize),
              )
            : const SizedBox(),
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: IconTheme(
        data: IconThemeData(size: _iconSize),
        child: Column(
          children: [
            if (widget.keypadShown) ...[
              TextField(
                key: _keypadTextFieldKey,
                controller: _keypadTextEditingController,
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
  List<PopupMenuItem<CallAudioDevice>> _buildAudioDeviceItems(ThemeData themeData) {
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
  List<PopupMenuItem<dynamic>> _buildTransferToCallItems(ThemeData themeData) {
    final popupMenuIconSize = themeData.textTheme.bodyLarge!.fontSize;
    final onAttendedTransferSubmitted = widget.onAttendedTransferSubmitted;
    return [
      for (final call in widget.transferableCalls)
        if (onAttendedTransferSubmitted != null)
          CallPopupMenuItem(
            key: callActionsTransferMenuNumberKey,
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
      if (widget.onBlindTransferInitiated != null)
        CallPopupMenuItem(
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
  List<PopupMenuItem<dynamic>> _buildTransferInitItems(ThemeData themeData) {
    final popupMenuIconSize = themeData.textTheme.bodyLarge!.fontSize;
    return [
      if (widget.onBlindTransferInitiated != null)
        CallPopupMenuItem(
          key: callActionsTransferMenuBlindInitKey,
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
