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
    required this.remoteVideo,
    required this.wasAccepted,
    required this.wasHungUp,
    required this.cameraValue,
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
    this.onSwapPressed,
    this.onHangupPressed,
    this.onKeyPressed,
    this.style,
  });

  final bool enableInteractions;
  final bool isIncoming;
  final bool remoteVideo;
  final bool wasAccepted;
  final bool wasHungUp;
  final bool cameraValue;
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
  final void Function()? onSwapPressed;
  final void Function()? onHangupPressed;
  final void Function(String value)? onKeyPressed;

  final CallScreenActionsStyle? style;

  @override
  State<ActiveCallActions> createState() => _ActiveCallActionsState();
}

class _ActiveCallActionsState extends State<ActiveCallActions> {
  bool _keypadShow = false;

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
  void didUpdateWidget(covariant ActiveCallActions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remoteVideo != widget.remoteVideo) computeDimensions();
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
    _textStyle = _themeData.textTheme.displaySmall?.copyWith(color: _themeData.colorScheme.surface);

    _iconSize = _themeData.textTheme.headlineLarge?.fontSize;

    _isOrientationPortrait = _mediaQueryData.orientation == Orientation.portrait;
    _dimension = min(_mediaQueryData.size.width, _mediaQueryData.size.height) / 5;
    if (_isOrientationPortrait) {
      _actionsDelimiterDimension = _dimension / 5;
      if (widget.remoteVideo) {
        _hangupDelimiterDimension = _actionsDelimiterDimension;
      } else {
        _hangupDelimiterDimension = _actionsDelimiterDimension * 3 + _dimension * 2;
      }
      _horizontalPadding = _dimension / 2;
    } else {
      _actionsDelimiterDimension = _dimension / 9;
      _hangupDelimiterDimension = _actionsDelimiterDimension;
      _horizontalPadding = _dimension * 3;
      if (_keypadShow) _keypadShow = false;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final onCameraChanged = widget.enableInteractions ? widget.onCameraChanged : null;
    // Mute and speaker are local-only (no SDP change), so they stay active during renegotiation.
    final onMutedChanged = widget.onMutedChanged;
    final audioDevice = widget.audioDevice;
    final onAudioDeviceChanged = widget.onAudioDeviceChanged;
    final speakerOn = audioDevice?.type == CallAudioDeviceType.speaker;
    final onBlindTransferInitiated = widget.enableInteractions ? widget.onBlindTransferInitiated : null;
    final onAttendedTransferInitiated = widget.enableInteractions ? widget.onAttendedTransferInitiated : null;
    final onAttendedTransferSubmitted = widget.enableInteractions ? widget.onAttendedTransferSubmitted : null;
    final onHeldChanged = widget.enableInteractions ? widget.onHeldChanged : null;
    final onSwapPressed = widget.enableInteractions ? widget.onSwapPressed : null;
    final onKeyPressed = widget.enableInteractions ? widget.onKeyPressed : null;

    // Always allow the user to hang up or answer the call
    final onHangupPressed = widget.onHangupPressed;

    // Icons
    final actionPadIconSize = themeData.textTheme.headlineMedium!.fontSize;
    final popupMenuIconSize = themeData.textTheme.bodyLarge!.fontSize;

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
    if (_keypadShow) {
      actions = KeypadKey.numbers.indexed
          .map((e) {
            final (i, k) = e;
            return [
              KeypadKeyButton(
                text: k.text,
                subtext: k.subtext,
                onKeyPressed: (key) {
                  final newText = _keypadTextEditingController.text + key;
                  final newSelection = TextSelection.collapsed(offset: newText.length);
                  final value = _keypadTextEditingController.value.copyWith(text: newText, selection: newSelection);
                  _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

                  onKeyPressed!(key);
                },
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
    } else {
      actions = [
        // row
        Tooltip(
          message: widget.mutedValue
              ? context.l10n.call_CallActionsTooltip_unmute
              : context.l10n.call_CallActionsTooltip_mute,
          child: TextButton(
            key: callActionsMuteKey,
            onPressed: onMutedChanged != null ? () => onMutedChanged(!widget.mutedValue) : null,
            statesController: _mutedStatesController..update(WidgetState.selected, widget.mutedValue),
            style: widget.style?.muted,
            child: Icon(widget.mutedValue ? Icons.mic_off : Icons.mic, size: actionPadIconSize),
          ),
        ),
        Tooltip(
          key: callActionsVideoCallKey,
          message: widget.cameraValue
              ? context.l10n.call_CallActionsTooltip_disableCamera
              : context.l10n.call_CallActionsTooltip_enableCamera,
          child: TextButton(
            onPressed: () => onCameraChanged?.call(!widget.cameraValue),
            statesController: _cameraStatesController..update(WidgetState.selected, widget.cameraValue),
            style: widget.style?.camera,
            child: Icon(widget.cameraValue ? Icons.videocam : Icons.videocam_off, size: actionPadIconSize),
          ),
        ),
        if (widget.availableAudioDevices.onlyBuiltIn)
          Tooltip(
            key: callActionsSpeakerKey,
            message: speakerOn ?? false
                ? context.l10n.call_CallActionsTooltip_disableSpeaker
                : context.l10n.call_CallActionsTooltip_enableSpeaker,
            child: TextButton(
              onPressed: () {
                final speakerDevice = widget.availableAudioDevices.getSpeaker;
                final earpieceDevice = widget.availableAudioDevices.getEarpiece;
                if (speakerOn == true) {
                  if (earpieceDevice != null) {
                    onAudioDeviceChanged?.call(earpieceDevice);
                  } else {
                    _logger.warning('Earpiece device not found while trying to disable speakerphone');
                  }
                } else {
                  if (speakerDevice != null) {
                    onAudioDeviceChanged?.call(speakerDevice);
                  } else {
                    _logger.warning('Speaker device not found while trying to enable speakerphone');
                  }
                }
              },
              statesController: _speakerStatesController..update(WidgetState.selected, speakerOn ?? false),
              style: widget.style?.speaker,
              child: Icon((speakerOn ?? false) ? Icons.volume_up : Icons.phone_in_talk, size: actionPadIconSize),
            ),
          ),
        if (!widget.availableAudioDevices.onlyBuiltIn)
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_changeAudioDevice,
            child: CallPopupMenuButton<CallAudioDevice>(
              offset: Offset(_dimension + 8, 0),
              items: widget.availableAudioDevices
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
                  .toList(growable: false),
              onSelected: onAudioDeviceChanged,
              child: IgnorePointer(
                child: TextButton(
                  /// Use an empty callback instead of null to prevent the button from
                  /// entering the 'disabled' state, which would override the custom
                  /// style with default disabled theme colors.
                  onPressed: () {},
                  statesController: _speakerStatesController..update(WidgetState.selected, isAudioSelected),
                  style: widget.style?.speaker,
                  child: Icon(switch (audioDevice?.type) {
                    CallAudioDeviceType.speaker => Icons.volume_up,
                    CallAudioDeviceType.bluetooth => Icons.bluetooth_audio,
                    CallAudioDeviceType.wiredHeadset => Icons.headset,
                    CallAudioDeviceType.earpiece => Icons.phone_in_talk,
                    CallAudioDeviceType.streaming => Icons.usb,
                    _ => Icons.volume_off,
                  }, size: actionPadIconSize),
                ),
              ),
            ),
          ),
        // delimiter
        const SizedBox(),
        SizedBox.square(dimension: _actionsDelimiterDimension),
        const SizedBox(),
        if (widget.transferableCalls.isNotEmpty)
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_transfer,
            child: CallPopupMenuButton(
              offset: Offset(_dimension + 8, 0),
              items: [
                for (final call in widget.transferableCalls)
                  if (onAttendedTransferSubmitted != null)
                    CallPopupMenuItem(
                      key: callActionsTransferMenuNumberKey,
                      onTap: () => onAttendedTransferSubmitted.call(call),
                      text: call.displayName ?? call.handle.value,
                      icon: Icon(
                        Icons.phone_paused_outlined,
                        size: popupMenuIconSize,
                        color: themeData.textTheme.bodyMedium!.color,
                      ),
                      textStyle: themeData.textTheme.bodyMedium,
                    ),
                if (onBlindTransferInitiated != null)
                  CallPopupMenuItem(
                    onTap: onBlindTransferInitiated,
                    text: context.l10n.call_CallActionsTooltip_transfer_choose,
                    icon: Icon(
                      Icons.phone_forwarded_outlined,
                      size: popupMenuIconSize,
                      color: themeData.textTheme.bodyMedium!.color,
                    ),
                    textStyle: themeData.textTheme.bodyMedium,
                  ),
              ],
              child: IgnorePointer(
                child: TextButton(
                  onPressed: () {},
                  style: widget.style?.transfer,
                  child: Icon(Icons.phone_forwarded, size: actionPadIconSize),
                ),
              ),
            ),
          ),
        if (widget.transferableCalls.isEmpty)
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_transfer,
            child: CallPopupMenuButton(
              key: callActionsTransferMenuKey,
              offset: Offset(_dimension + 8, 0),
              items: [
                if (onBlindTransferInitiated != null)
                  CallPopupMenuItem(
                    key: callActionsTransferMenuBlindInitKey,
                    onTap: onBlindTransferInitiated,
                    text: context.l10n.call_CallActionsTooltip_unattended_transfer,
                    icon: Icon(
                      Icons.phone_forwarded_outlined,
                      size: popupMenuIconSize,
                      color: themeData.textTheme.bodyMedium!.color,
                    ),
                    textStyle: themeData.textTheme.bodyMedium,
                  ),
                if (onAttendedTransferInitiated != null)
                  CallPopupMenuItem(
                    onTap: onAttendedTransferInitiated,
                    text: context.l10n.call_CallActionsTooltip_attended_transfer,
                    icon: Icon(
                      Icons.phone_forwarded_outlined,
                      size: popupMenuIconSize,
                      color: themeData.textTheme.bodyMedium!.color,
                    ),
                    textStyle: themeData.textTheme.bodyMedium,
                  ),
              ],
              child: IgnorePointer(
                child: TextButton(
                  onPressed: onBlindTransferInitiated == null && onAttendedTransferInitiated == null ? null : () {},
                  style: widget.style?.transfer,
                  child: Icon(Icons.phone_forwarded, size: actionPadIconSize),
                ),
              ),
            ),
          ),
        if (onSwapPressed == null)
          Tooltip(
            key: callActionsHoldKey,
            message: widget.heldValue
                ? context.l10n.call_CallActionsTooltip_unhold
                : context.l10n.call_CallActionsTooltip_hold,
            child: TextButton(
              onPressed: onHeldChanged == null ? null : () => onHeldChanged(!widget.heldValue),
              statesController: _heldStatesController..update(WidgetState.selected, widget.heldValue),
              style: widget.style?.held,
              child: Icon(Icons.pause, size: actionPadIconSize),
            ),
          ),
        if (onSwapPressed != null)
          Tooltip(
            key: callActionsSwapKey,
            message: context.l10n.call_CallActionsTooltip_swap,
            child: TextButton(
              onPressed: onSwapPressed,
              style: widget.style?.speaker,
              child: Icon(Icons.swap_calls, size: actionPadIconSize),
            ),
          ),
        Tooltip(
          key: callActionsKeypadKey,
          message: context.l10n.call_CallActionsTooltip_showKeypad,
          child: TextButton(
            onPressed: onKeyPressed == null || !_isOrientationPortrait
                ? null
                : () {
                    setState(() {
                      _keypadShow = true;
                    });
                  },
            style: widget.style?.key,
            child: Icon(Icons.dialpad, size: actionPadIconSize),
          ),
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
        Tooltip(
          message: context.l10n.call_CallActionsTooltip_hangup,
          child: TextButton(
            key: callActionsHangupKey,
            onPressed: onHangupPressed,
            style: widget.style?.hangup,
            child: Icon(Icons.call_end, size: actionPadIconSize),
          ),
        ),
        _keypadShow
            ? Tooltip(
                message: context.l10n.call_CallActionsTooltip_hideKeypad,
                child: TextButton(
                  onPressed: () {
                    _keypadTextEditingController.clear();

                    setState(() {
                      _keypadShow = false;
                    });
                  },
                  style: widget.style?.key,
                  child: Icon(Icons.dialpad, size: actionPadIconSize),
                ),
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
            if (_keypadShow) ...[
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
}
