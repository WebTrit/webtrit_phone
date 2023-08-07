import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class CallActions extends StatefulWidget {
  const CallActions({
    Key? key,
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
    this.onTransferPressed,
    required this.heldValue,
    this.onHeldChanged,
    this.onHangupPressed,
    this.onAcceptPressed,
    this.onKeyPressed,
  }) : super(key: key);

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
  final VoidCallback? onTransferPressed;
  final bool heldValue;
  final ValueChanged<bool>? onHeldChanged;
  final void Function()? onHangupPressed;
  final void Function()? onAcceptPressed;
  final void Function(String value)? onKeyPressed;

  @override
  State<CallActions> createState() => _CallActionsState();
}

class _CallActionsState extends State<CallActions> {
  bool _keypadShow = false;

  TextButtonStyles? _textButtonStyles;
  double? _iconSize;

  late bool _isOrientationPortrait;
  late double _dimension;
  late double _actionsDelimiterDimension;
  late double _hangupDelimiterDimension;
  late double _horizontalPadding;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final themeData = Theme.of(context);
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
    final onCameraChanged = widget.onCameraChanged;
    final onMutedChanged = widget.onMutedChanged;
    final speakerValue = widget.speakerValue;
    final onSpeakerChanged = widget.onSpeakerChanged;
    final onTransferPressed = widget.onTransferPressed;
    final onHeldChanged = widget.onHeldChanged;

    late final TextButtonsTable buttonsTable;
    if (widget.isIncoming && !widget.wasAccepted) {
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
      late List<Widget> actions;
      if (_keypadShow) {
        actions = KeypadKey.numbers.indexed
            .map((e) {
              final (i, k) = e;
              return [
                KeypadKeyButton(
                  text: k.text,
                  subtext: k.subtext,
                  onKeyPressed: widget.onKeyPressed!,
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
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_transfer,
            child: TextButton(
              onPressed: onTransferPressed,
              style: _textButtonStyles?.callAction,
              child: const Icon(Icons.phone_forwarded),
            ),
          ),
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
        child: buttonsTable,
      ),
    );
  }
}
