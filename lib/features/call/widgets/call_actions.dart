import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

export 'call_actions_style.dart';
export 'call_actions_styles.dart';

class CallActions extends StatefulWidget {
  const CallActions({
    super.key,
    required this.enableInteractions,
    required this.isIncoming,
    required this.video,
    required this.wasAccepted,
    required this.wasHungUp,
    required this.cameraValue,
    required this.inviteToAttendedTransfer,
    this.onCameraChanged,
    required this.mutedValue,
    this.onMutedChanged,
    this.speakerValue,
    this.onSpeakerChanged,
    this.transferableCalls = const [],
    required this.onBlindTransferInitiated,
    required this.onAttendedTransferInitiated,
    required this.onAttendedTransferSubmitted,
    required this.heldValue,
    this.onHeldChanged,
    this.onSwapPressed,
    this.onHangupPressed,
    this.onHangupAndAcceptPressed,
    this.onHoldAndAcceptPressed,
    this.onAcceptPressed,
    this.onApproveTransferPressed,
    this.onDeclineTransferPressed,
    this.onKeyPressed,
    this.style,
  });

  final bool enableInteractions;
  final bool isIncoming;
  final bool video;
  final bool wasAccepted;
  final bool wasHungUp;
  final bool cameraValue;
  final bool inviteToAttendedTransfer;
  final ValueChanged<bool>? onCameraChanged;
  final bool mutedValue;
  final ValueChanged<bool>? onMutedChanged;
  final bool? speakerValue;
  final ValueChanged<bool>? onSpeakerChanged;
  final List<ActiveCall> transferableCalls;
  final VoidCallback? onBlindTransferInitiated;
  final VoidCallback? onAttendedTransferInitiated;
  final void Function(ActiveCall call)? onAttendedTransferSubmitted;
  final bool heldValue;
  final ValueChanged<bool>? onHeldChanged;
  final void Function()? onSwapPressed;
  final void Function()? onHangupPressed;
  final void Function()? onHangupAndAcceptPressed;
  final void Function()? onHoldAndAcceptPressed;
  final void Function()? onAcceptPressed;
  final void Function()? onApproveTransferPressed;
  final void Function()? onDeclineTransferPressed;
  final void Function(String value)? onKeyPressed;

  final CallActionsStyle? style;

  @override
  State<CallActions> createState() => _CallActionsState();
}

class _CallActionsState extends State<CallActions> {
  bool _keypadShow = false;

  final _keypadTextFieldKey = GlobalKey();

  EditableTextState? get _keypadTextFieldEditableTextState =>
      (_keypadTextFieldKey.currentState as TextSelectionGestureDetectorBuilderDelegate).editableTextKey.currentState;

  late TextEditingController _keypadTextEditingController;

  late InputDecorations? _inputDecorations;
  late TextStyle? _textStyle;

  double? _iconSize;

  late bool _isOrientationPortrait;
  late double _dimension;
  late double _actionsDelimiterDimension;
  late double _hangupDelimiterDimension;
  late double _horizontalPadding;

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

    final themeData = Theme.of(context);

    _inputDecorations = themeData.extension<InputDecorations>();
    _textStyle = themeData.textTheme.displaySmall?.copyWith(
      color: themeData.colorScheme.surface,
    );

    _iconSize = themeData.textTheme.headlineLarge?.fontSize;

    final mediaQueryData = MediaQuery.of(context);
    _isOrientationPortrait = mediaQueryData.orientation == Orientation.portrait;
    _dimension = min(mediaQueryData.size.width, mediaQueryData.size.height) / 5;
    if (_isOrientationPortrait) {
      _actionsDelimiterDimension = _dimension / 5;
      if (widget.video) {
        _hangupDelimiterDimension = _actionsDelimiterDimension;
      } else {
        _hangupDelimiterDimension = _actionsDelimiterDimension * 3 + _dimension * 2;
      }
      _horizontalPadding = _dimension / 2;
    } else {
      _actionsDelimiterDimension = _dimension / 9;
      _hangupDelimiterDimension = _actionsDelimiterDimension;
      _horizontalPadding = _dimension * 3;
      if (_keypadShow) {
        setState(() {
          _keypadShow = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final onCameraChanged = widget.enableInteractions ? widget.onCameraChanged : null;
    final onMutedChanged = widget.enableInteractions ? widget.onMutedChanged : null;
    final speakerValue = widget.enableInteractions ? widget.speakerValue : null;
    final onSpeakerChanged = widget.enableInteractions ? widget.onSpeakerChanged : null;
    final onBlindTransferInitiated = widget.enableInteractions ? widget.onBlindTransferInitiated : null;
    final onAttendedTransferInitiated = widget.enableInteractions ? widget.onAttendedTransferInitiated : null;
    final onAttendedTransferSubmitted = widget.enableInteractions ? widget.onAttendedTransferSubmitted : null;
    final onHeldChanged = widget.enableInteractions ? widget.onHeldChanged : null;
    final onSwapPressed = widget.enableInteractions ? widget.onSwapPressed : null;
    final onHangupAndAcceptPressed = widget.enableInteractions ? widget.onHangupAndAcceptPressed : null;
    final onKeyPressed = widget.enableInteractions ? widget.onKeyPressed : null;
    final onApproveTransferPressed = widget.enableInteractions ? widget.onApproveTransferPressed : null;
    final onHoldAndAcceptPressed = widget.enableInteractions ? widget.onHoldAndAcceptPressed : null;
    final onDeclineTransferPressed = widget.enableInteractions ? widget.onDeclineTransferPressed : null;

    // Always allow the user to hang up or answer the call
    final onAcceptPressed = widget.onAcceptPressed;
    final onHangupPressed = widget.onHangupPressed;

    // Icons
    final actionPadIconSize = themeData.textTheme.headlineMedium!.fontSize;
    final popupMenuIconSize = themeData.textTheme.bodyLarge!.fontSize;

    final style = CallActionsStyle.merge(widget.style, Theme.of(context).extension<CallActionsStyles>()?.primary);

    final TextButtonsTable buttonsTable;
    if (widget.isIncoming && !widget.wasAccepted) {
      if (widget.onHangupAndAcceptPressed == null && widget.onHoldAndAcceptPressed == null) {
        buttonsTable = TextButtonsTable(
          minimumSize: Size.square(_dimension),
          children: [
            Tooltip(
              message: widget.inviteToAttendedTransfer
                  ? context.l10n.call_CallActionsTooltip_decline_inviteToAttendedTransfer
                  : context.l10n.call_CallActionsTooltip_hangup,
              child: TextButton(
                onPressed: onHangupPressed,
                style: style.hangup,
                child: Icon(
                  Icons.call_end,
                  size: actionPadIconSize,
                ),
              ),
            ),
            const SizedBox(),
            Tooltip(
              message: widget.inviteToAttendedTransfer
                  ? context.l10n.call_CallActionsTooltip_accept_inviteToAttendedTransfer
                  : context.l10n.call_CallActionsTooltip_accept,
              child: TextButton(
                onPressed: onAcceptPressed,
                style: style.callStart,
                child: Icon(
                  widget.video ? Icons.videocam : Icons.call,
                  size: actionPadIconSize,
                ),
              ),
            ),
          ],
        );
      } else {
        buttonsTable = TextButtonsTable(
          minimumSize: Size.square(_dimension),
          children: [
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_hangupAndAccept,
              child: TextButton(
                onPressed: onHangupAndAcceptPressed,
                style: style.callStart,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.call_end,
                      size: actionPadIconSize,
                    ),
                    Icon(
                      widget.video ? Icons.videocam : Icons.call,
                      size: actionPadIconSize,
                    ),
                  ],
                ),
              ),
            ),
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_hangup,
              child: TextButton(
                onPressed: onHangupPressed,
                style: style.hangup,
                child: Icon(
                  Icons.call_end,
                  size: actionPadIconSize,
                ),
              ),
            ),
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_holdAndAccept,
              child: TextButton(
                onPressed: onHoldAndAcceptPressed,
                style: style.callStart,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.pause,
                      size: actionPadIconSize,
                    ),
                    Icon(
                      widget.video ? Icons.videocam : Icons.call,
                      size: actionPadIconSize,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    } else if (onApproveTransferPressed != null || onDeclineTransferPressed != null) {
      buttonsTable = TextButtonsTable(
        minimumSize: Size.square(_dimension),
        children: [
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_hangup,
            child: TextButton(
              onPressed: onDeclineTransferPressed,
              style: style.hangup,
              child: Icon(
                Icons.call_end,
                size: actionPadIconSize,
              ),
            ),
          ),
          const SizedBox(),
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_accept,
            child: TextButton(
              onPressed: onApproveTransferPressed,
              style: style.callStart,
              child: Icon(
                Icons.phone_forwarded,
                size: actionPadIconSize,
              ),
            ),
          ),
        ],
      );
    } else {
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
                    final value = _keypadTextEditingController.value.copyWith(
                      text: newText,
                      selection: newSelection,
                    );
                    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(
                        value, SelectionChangedCause.keyboard);

                    onKeyPressed!(key);
                  },
                  style: style.key,
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
              onPressed: onMutedChanged == null ? null : () => onMutedChanged(!widget.mutedValue),
              style: widget.mutedValue ? style.mutedActive : style.muted,
              child: Icon(
                Icons.mic_off,
                size: actionPadIconSize,
              ),
            ),
          ),
          Tooltip(
            message: widget.cameraValue
                ? context.l10n.call_CallActionsTooltip_disableCamera
                : context.l10n.call_CallActionsTooltip_enableCamera,
            child: TextButton(
              onPressed: !widget.video
                  ? null
                  : onCameraChanged == null
                      ? null
                      : () => onCameraChanged(!widget.cameraValue),
              style: !widget.cameraValue ? style.cameraActive : style.camera,
              child: Icon(
                Icons.videocam_off,
                size: actionPadIconSize,
              ),
            ),
          ),
          Tooltip(
            message: speakerValue == true
                ? context.l10n.call_CallActionsTooltip_disableSpeaker
                : context.l10n.call_CallActionsTooltip_enableSpeaker,
            child: TextButton(
              onPressed:
                  speakerValue == null || onSpeakerChanged == null ? null : () => onSpeakerChanged(!speakerValue),
              style: speakerValue == true ? style.speakerActive : style.speaker,
              child: Icon(
                Icons.volume_up,
                size: actionPadIconSize,
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
                    )
                ],
                child: IgnorePointer(
                  child: TextButton(
                    onPressed: () {},
                    style: style.transfer,
                    child: Icon(
                      Icons.phone_forwarded,
                      size: actionPadIconSize,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.transferableCalls.isEmpty)
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_transfer,
              child: CallPopupMenuButton(
                offset: Offset(_dimension + 8, 0),
                items: [
                  if (onBlindTransferInitiated != null)
                    CallPopupMenuItem(
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
                    )
                ],
                child: IgnorePointer(
                  child: TextButton(
                    onPressed: onBlindTransferInitiated == null && onAttendedTransferInitiated == null ? null : () {},
                    style: style.transfer,
                    child: Icon(
                      Icons.phone_forwarded,
                      size: actionPadIconSize,
                    ),
                  ),
                ),
              ),
            ),
          if (onSwapPressed == null)
            Tooltip(
              message: widget.heldValue
                  ? context.l10n.call_CallActionsTooltip_unhold
                  : context.l10n.call_CallActionsTooltip_hold,
              child: TextButton(
                onPressed: onHeldChanged == null ? null : () => onHeldChanged(!widget.heldValue),
                style: widget.heldValue ? style.heldActive : style.held,
                child: Icon(
                  Icons.pause,
                  size: actionPadIconSize,
                ),
              ),
            ),
          if (onSwapPressed != null)
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_swap,
              child: TextButton(
                onPressed: onSwapPressed,
                style: style.speaker,
                child: Icon(
                  Icons.swap_calls,
                  size: actionPadIconSize,
                ),
              ),
            ),
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_showKeypad,
            child: TextButton(
              onPressed: onKeyPressed == null || !_isOrientationPortrait
                  ? null
                  : () {
                      setState(() {
                        _keypadShow = true;
                      });
                    },
              style: style.keypad,
              child: Icon(
                Icons.dialpad,
                size: actionPadIconSize,
              ),
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
              onPressed: onHangupPressed,
              style: style.hangup,
              child: Icon(
                Icons.call_end,
                size: actionPadIconSize,
              ),
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
                    style: style.keypadActive,
                    child: Icon(
                      Icons.dialpad,
                      size: actionPadIconSize,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      );
    }
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
