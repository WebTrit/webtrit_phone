import 'dart:math';

import 'package:collection/collection.dart';
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
    this.cameraEnabledByDefault = true,
    this.onCameraPressed,
    this.microphoneEnabledByDefault = true,
    this.onMicrophonePressed,
    this.speakerphoneEnabledByDefault = true,
    this.onSpeakerphonePressed,
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
  final bool cameraEnabledByDefault;
  final void Function(bool enabled)? onCameraPressed;
  final bool microphoneEnabledByDefault;
  final void Function(bool enabled)? onMicrophonePressed;
  final bool speakerphoneEnabledByDefault;
  final void Function(bool enabled)? onSpeakerphonePressed;
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
  late bool _cameraEnabled;
  late bool _microphoneEnabled;
  late bool _speakerphoneEnabled;
  bool _keypadShow = false;

  @override
  void initState() {
    super.initState();
    _cameraEnabled = widget.cameraEnabledByDefault;
    _microphoneEnabled = widget.microphoneEnabledByDefault;
    _speakerphoneEnabled = widget.speakerphoneEnabledByDefault;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final TextButtonStyles? textButtonStyles = themeData.extension<TextButtonStyles>();

    final mediaQueryData = MediaQuery.of(context);
    final isOrientationPortrait = mediaQueryData.orientation == Orientation.portrait;
    final dimension = min(mediaQueryData.size.width, mediaQueryData.size.height) / 5;

    late final double actionsDelimiterDimension;
    late final double hangupDelimiterDimension;
    late final double horizontalPadding;
    if (isOrientationPortrait) {
      actionsDelimiterDimension = dimension / 3;
      if (widget.video) {
        hangupDelimiterDimension = actionsDelimiterDimension;
      } else {
        hangupDelimiterDimension = actionsDelimiterDimension * 3 + dimension * 2;
      }
      horizontalPadding = dimension / 2;
    } else {
      actionsDelimiterDimension = dimension / 9;
      hangupDelimiterDimension = actionsDelimiterDimension;
      horizontalPadding = dimension * 3;
      if (_keypadShow) {
        setState(() {
          _keypadShow = false;
        });
      }
    }

    final onTransferPressed = widget.onTransferPressed;
    final onHeldChanged = widget.onHeldChanged;

    late final TextButtonsTable buttonsTable;
    if (widget.isIncoming && !widget.wasAccepted) {
      buttonsTable = TextButtonsTable(
        minimumSize: Size.square(dimension),
        children: [
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_hangup,
            child: TextButton(
              onPressed: widget.onHangupPressed,
              style: textButtonStyles?.callHangup,
              child: const Icon(Icons.call_end),
            ),
          ),
          const SizedBox(),
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_accept,
            child: TextButton(
              onPressed: widget.onAcceptPressed,
              style: textButtonStyles?.callStart,
              child: Icon(widget.video ? Icons.videocam : Icons.call),
            ),
          ),
        ],
      );
    } else {
      late List<Widget> actions;
      if (_keypadShow) {
        actions = KeypadKey.numbers.expandIndexed((i, k) {
          return [
            KeypadKeyButton(
              text: k.text,
              subtext: k.subtext,
              onKeyPressed: widget.onKeyPressed!,
              style: textButtonStyles?.callAction,
            ),
            if ((i + 1) % 3 == 0) ...[
              const SizedBox(),
              SizedBox.square(dimension: actionsDelimiterDimension),
              const SizedBox(),
            ],
          ];
        }).toList(growable: false);
      } else {
        actions = [
          // row
          Tooltip(
            message: _microphoneEnabled
                ? context.l10n.call_CallActionsTooltip_muteMicrophone
                : context.l10n.call_CallActionsTooltip_unmuteMicrophone,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _microphoneEnabled = !_microphoneEnabled;
                });
                widget.onMicrophonePressed?.call(_microphoneEnabled);
              },
              style: _microphoneEnabled ? textButtonStyles?.callActiveAction : textButtonStyles?.callAction,
              child: const Icon(Icons.mic_off),
            ),
          ),
          Tooltip(
            message: _cameraEnabled
                ? context.l10n.call_CallActionsTooltip_disableCamera
                : context.l10n.call_CallActionsTooltip_enableCamera,
            child: TextButton(
              onPressed: !widget.video
                  ? null
                  : () {
                      setState(() {
                        _cameraEnabled = !_cameraEnabled;
                      });
                      widget.onCameraPressed?.call(_cameraEnabled);
                    },
              style: !_cameraEnabled ? textButtonStyles?.callActiveAction : textButtonStyles?.callAction,
              child: const Icon(Icons.videocam_off),
            ),
          ),
          Tooltip(
            message: _speakerphoneEnabled
                ? context.l10n.call_CallActionsTooltip_disableSpeakerphone
                : context.l10n.call_CallActionsTooltip_enableSpeakerphone,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _speakerphoneEnabled = !_speakerphoneEnabled;
                });
                widget.onSpeakerphonePressed?.call(_speakerphoneEnabled);
              },
              style: _speakerphoneEnabled ? textButtonStyles?.callActiveAction : textButtonStyles?.callAction,
              child: const Icon(Icons.volume_up),
            ),
          ),
          // delimiter
          const SizedBox(),
          SizedBox.square(dimension: actionsDelimiterDimension),
          const SizedBox(),
          // row
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_transfer,
            child: TextButton(
              onPressed: onTransferPressed,
              style: textButtonStyles?.callAction,
              child: const Icon(Icons.phone_forwarded),
            ),
          ),
          Tooltip(
            message: widget.heldValue
                ? context.l10n.call_CallActionsTooltip_unhold
                : context.l10n.call_CallActionsTooltip_hold,
            child: TextButton(
              onPressed: onHeldChanged == null ? null : () => onHeldChanged(!widget.heldValue),
              style: widget.heldValue ? textButtonStyles?.callActiveAction : textButtonStyles?.callAction,
              child: const Icon(Icons.pause),
            ),
          ),
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_showKeypad,
            child: TextButton(
              onPressed: widget.onKeyPressed == null || !isOrientationPortrait
                  ? null
                  : () {
                      setState(() {
                        _keypadShow = true;
                      });
                    },
              style: textButtonStyles?.callAction,
              child: const Icon(Icons.dialpad),
            ),
          ),
          // hangup delimiter
          const SizedBox(),
          SizedBox.square(dimension: hangupDelimiterDimension),
          const SizedBox(),
          //
        ];
      }

      buttonsTable = TextButtonsTable(
        minimumSize: Size.square(dimension),
        children: [
          // actions rows
          ...actions,
          // hangup row
          const SizedBox(),
          Tooltip(
            message: context.l10n.call_CallActionsTooltip_hangup,
            child: TextButton(
              onPressed: widget.onHangupPressed,
              style: textButtonStyles?.callHangup,
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
                    style: textButtonStyles?.callActiveAction,
                    child: const Icon(Icons.dialpad),
                  ),
                )
              : const SizedBox(),
        ],
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: IconTheme(
        data: IconThemeData(size: themeData.textTheme.headlineLarge?.fontSize),
        child: buttonsTable,
      ),
    );
  }
}
