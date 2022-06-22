import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

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
    this.onHangupPressed,
    this.onAcceptPressed,
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
  final void Function()? onHangupPressed;
  final void Function()? onAcceptPressed;

  @override
  State<CallActions> createState() => _CallActionsState();
}

class _CallActionsState extends State<CallActions> {
  late bool _cameraEnabled;
  late bool _microphoneEnabled;
  late bool _speakerphoneEnabled;

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
    final dimension = min(mediaQueryData.size.width, mediaQueryData.size.height) / 5;

    late final double actionsDelimiterDimension;
    late final double hangupDelimiterDimension;
    late final double horizontalPadding;
    if (mediaQueryData.orientation == Orientation.portrait) {
      actionsDelimiterDimension = dimension / 3;
      hangupDelimiterDimension = widget.video ? actionsDelimiterDimension : dimension * 3;
      horizontalPadding = dimension / 2;
    } else {
      actionsDelimiterDimension = dimension / 9;
      hangupDelimiterDimension = actionsDelimiterDimension;
      horizontalPadding = dimension * 3;
    }

    late final TextButtonsTable buttonsTable;
    if (widget.isIncoming && !widget.wasAccepted) {
      buttonsTable = TextButtonsTable(
        minimumSize: Size.square(dimension),
        children: [
          Tooltip(
            message: 'Hangup',
            child: TextButton(
              onPressed: widget.onHangupPressed,
              style: textButtonStyles?.callHangup,
              child: const Icon(Icons.call_end),
            ),
          ),
          const SizedBox(),
          Tooltip(
            message: 'Accept',
            child: TextButton(
              onPressed: widget.onAcceptPressed,
              style: textButtonStyles?.callStart,
              child: Icon(widget.video ? Icons.videocam : Icons.call),
            ),
          ),
        ],
      );
    } else {
      buttonsTable = TextButtonsTable(
        minimumSize: Size.square(dimension),
        children: [
          // row 1
          Tooltip(
            message: _microphoneEnabled ? 'Mute microphone' : 'Unmute microphone',
            child: TextButton(
              onPressed: () {
                setState(() {
                  _microphoneEnabled = !_microphoneEnabled;
                });
                widget.onMicrophonePressed?.call(_microphoneEnabled);
              },
              style: textButtonStyles?.callAction,
              child: _microphoneEnabled ? const Icon(Icons.mic) : const Icon(Icons.mic_off),
            ),
          ),
          Tooltip(
            message: _cameraEnabled ? 'Disable camera' : 'Enable camera',
            child: TextButton(
              onPressed: !widget.video
                  ? null
                  : () {
                      setState(() {
                        _cameraEnabled = !_cameraEnabled;
                      });
                      widget.onCameraPressed?.call(_cameraEnabled);
                    },
              style: textButtonStyles?.callAction,
              child: _cameraEnabled ? const Icon(Icons.videocam) : const Icon(Icons.videocam_off),
            ),
          ),
          Tooltip(
            message: _speakerphoneEnabled ? 'Disable speakerphone' : 'Enable speakerphone',
            child: TextButton(
              onPressed: () {
                setState(() {
                  _speakerphoneEnabled = !_speakerphoneEnabled;
                });
                widget.onSpeakerphonePressed?.call(_speakerphoneEnabled);
              },
              style: textButtonStyles?.callAction,
              child: _speakerphoneEnabled ? const Icon(Icons.volume_up) : const Icon(Icons.volume_off),
            ),
          ),
          //
          const SizedBox(),
          SizedBox.square(dimension: actionsDelimiterDimension),
          const SizedBox(),
          //
          Tooltip(
            message: 'Transfer',
            child: TextButton(
              onPressed: () {
                context.showErrorSnackBar(context.l10n.notImplemented);
              },
              style: textButtonStyles?.callAction,
              child: const Icon(Icons.phone_forwarded),
            ),
          ),
          Tooltip(
            message: 'Hold',
            child: TextButton(
              onPressed: () {
                context.showErrorSnackBar(context.l10n.notImplemented);
              },
              style: textButtonStyles?.callAction,
              child: const Icon(Icons.pause),
            ),
          ),
          Tooltip(
            message: 'Keypad',
            child: TextButton(
              onPressed: () {
                context.showErrorSnackBar(context.l10n.notImplemented);
              },
              style: textButtonStyles?.callAction,
              child: const Icon(Icons.dialpad),
            ),
          ),
          //
          const SizedBox(),
          SizedBox.square(dimension: hangupDelimiterDimension),
          const SizedBox(),
          //
          const SizedBox(),
          Tooltip(
            message: 'Hangup',
            child: TextButton(
              onPressed: widget.onHangupPressed,
              style: textButtonStyles?.callHangup,
              child: const Icon(Icons.call_end),
            ),
          ),
          const SizedBox(),
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
