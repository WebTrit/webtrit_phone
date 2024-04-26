import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class CallActions extends StatefulWidget {
  const CallActions({
    super.key,
    required this.isIncoming,
    required this.video,
    required this.wasAccepted,
    required this.wasHungUp,
    required this.cameraValue,
    this.onCameraChanged,
    required this.mutedValue,
    this.onMutedChanged,
    this.speakerValue,
    this.onSpeakerChanged,
    this.transferableCalls = const [],
    required this.onBlindTransfer,
    required this.onAttendedTransfer,
    required this.heldValue,
    this.onHeldChanged,
    this.onSwapPressed,
    this.onHangupPressed,
    this.onHangupAndAcceptPressed,
    this.onHoldAndAcceptPressed,
    this.onAcceptPressed,
    this.onKeyPressed,
  });

  final bool isIncoming;
  final bool video;
  final bool wasAccepted;
  final bool wasHungUp;
  final bool cameraValue;
  final ValueChanged<bool>? onCameraChanged;
  final bool mutedValue;
  final ValueChanged<bool>? onMutedChanged;
  final bool? speakerValue;
  final ValueChanged<bool>? onSpeakerChanged;
  final List<ActiveCall> transferableCalls;
  final VoidCallback? onBlindTransfer;
  final void Function(ActiveCall call)? onAttendedTransfer;
  final bool heldValue;
  final ValueChanged<bool>? onHeldChanged;
  final void Function()? onSwapPressed;
  final void Function()? onHangupPressed;
  final void Function()? onHangupAndAcceptPressed;
  final void Function()? onHoldAndAcceptPressed;
  final void Function()? onAcceptPressed;
  final void Function(String value)? onKeyPressed;

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

  TextButtonStyles? _textButtonStyles;
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
      color: themeData.colorScheme.background,
    );

    _textButtonStyles = themeData.extension<TextButtonStyles>();
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

    final onCameraChanged = widget.onCameraChanged;
    final onMutedChanged = widget.onMutedChanged;
    final speakerValue = widget.speakerValue;
    final onSpeakerChanged = widget.onSpeakerChanged;
    final onBlindTransfer = widget.onBlindTransfer;
    final onAttendedTransfer = widget.onAttendedTransfer;
    final onHeldChanged = widget.onHeldChanged;
    final onSwapPressed = widget.onSwapPressed;

    final TextButtonsTable buttonsTable;
    if (widget.isIncoming && !widget.wasAccepted) {
      if (widget.onHangupAndAcceptPressed == null && widget.onHoldAndAcceptPressed == null) {
        buttonsTable = TextButtonsTable(
          minimumSize: Size.square(_dimension),
          children: [
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_hangup,
              child: TextButton(
                onPressed: widget.onHangupPressed,
                style: _textButtonStyles?.callHangup,
                child: const Icon(Icons.call_end),
              ),
            ),
            const SizedBox(),
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_accept,
              child: TextButton(
                onPressed: widget.onAcceptPressed,
                style: _textButtonStyles?.callStart,
                child: Icon(widget.video ? Icons.videocam : Icons.call),
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
                onPressed: widget.onHangupAndAcceptPressed,
                style: _textButtonStyles?.callStart,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.call_end),
                    Icon(widget.video ? Icons.videocam : Icons.call),
                  ],
                ),
              ),
            ),
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_hangup,
              child: TextButton(
                onPressed: widget.onHangupPressed,
                style: _textButtonStyles?.callHangup,
                child: const Icon(Icons.call_end),
              ),
            ),
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_holdAndAccept,
              child: TextButton(
                onPressed: widget.onHoldAndAcceptPressed,
                style: _textButtonStyles?.callStart,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.pause),
                    Icon(widget.video ? Icons.videocam : Icons.call),
                  ],
                ),
              ),
            ),
          ],
        );
      }
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

                    widget.onKeyPressed!(key);
                  },
                  style: _textButtonStyles?.callAction,
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
              style: widget.mutedValue ? _textButtonStyles?.callActiveAction : _textButtonStyles?.callAction,
              child: const Icon(Icons.mic_off),
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
              style: !widget.cameraValue ? _textButtonStyles?.callActiveAction : _textButtonStyles?.callAction,
              child: const Icon(Icons.videocam_off),
            ),
          ),
          Tooltip(
            message: speakerValue == true
                ? context.l10n.call_CallActionsTooltip_disableSpeaker
                : context.l10n.call_CallActionsTooltip_enableSpeaker,
            child: TextButton(
              onPressed:
                  speakerValue == null || onSpeakerChanged == null ? null : () => onSpeakerChanged(!speakerValue),
              style: speakerValue == true ? _textButtonStyles?.callActiveAction : _textButtonStyles?.callAction,
              child: const Icon(Icons.volume_up),
            ),
          ),
          // delimiter
          const SizedBox(),
          SizedBox.square(dimension: _actionsDelimiterDimension),
          const SizedBox(),
          // row
          if (widget.transferableCalls.isEmpty)
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_transfer,
              child: TextButton(
                onPressed: onBlindTransfer,
                style: _textButtonStyles?.callAction,
                child: const Icon(Icons.phone_forwarded),
              ),
            ),
          if (widget.transferableCalls.isNotEmpty)
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_transfer,
              child: CallPopupMenuButton(
                offset: Offset(_dimension + 8, 0),
                items: [
                  for (final call in widget.transferableCalls)
                    CallPopupMenuItem(
                      onTap: () => onAttendedTransfer?.call(call),
                      text: call.displayName ?? call.handle.value,
                      icon: Icon(
                        Icons.phone_paused_outlined,
                        size: themeData.textTheme.bodyLarge!.fontSize,
                        color: themeData.textTheme.bodyMedium!.color,
                      ),
                      textStyle: themeData.textTheme.bodyMedium,
                    ),
                  CallPopupMenuItem(
                    onTap: onBlindTransfer,
                    text: context.l10n.call_CallActionsTooltip_transfer_choose,
                    icon: Icon(
                      Icons.phone_forwarded_outlined,
                      size: themeData.textTheme.bodyLarge!.fontSize,
                      color: themeData.textTheme.bodyMedium!.color,
                    ),
                    textStyle: themeData.textTheme.bodyMedium,
                  )
                ],
                child: IgnorePointer(
                  child: TextButton(
                    onPressed: () {},
                    style: _textButtonStyles?.callAction,
                    child: const Icon(Icons.phone_forwarded),
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
                style: widget.heldValue ? _textButtonStyles?.callActiveAction : _textButtonStyles?.callAction,
                child: const Icon(Icons.pause),
              ),
            ),
          if (onSwapPressed != null)
            Tooltip(
              message: context.l10n.call_CallActionsTooltip_swap,
              child: TextButton(
                onPressed: onSwapPressed,
                style: _textButtonStyles?.callAction,
                child: const Icon(Icons.swap_calls),
              ),
            ),
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_showKeypad,
            child: TextButton(
              onPressed: widget.onKeyPressed == null || !_isOrientationPortrait
                  ? null
                  : () {
                      setState(() {
                        _keypadShow = true;
                      });
                    },
              style: _textButtonStyles?.callAction,
              child: const Icon(Icons.dialpad),
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
              onPressed: widget.onHangupPressed,
              style: _textButtonStyles?.callHangup,
              child: const Icon(Icons.call_end),
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
                    style: _textButtonStyles?.callActiveAction,
                    child: const Icon(Icons.dialpad),
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
