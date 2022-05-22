import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

class CallActions extends StatefulWidget {
  final bool cameraEnabledByDefault;
  final void Function(bool enabled)? onCameraPressed;
  final bool microphoneEnabledByDefault;
  final void Function(bool enabled)? onMicrophonePressed;
  final bool speakerphoneEnabledByDefault;
  final void Function(bool enabled)? onSpeakerphonePressed;
  final void Function()? onHangupPressed;
  final void Function()? onAcceptPressed;

  const CallActions({
    Key? key,
    this.cameraEnabledByDefault = true,
    this.onCameraPressed,
    this.microphoneEnabledByDefault = true,
    this.onMicrophonePressed,
    this.speakerphoneEnabledByDefault = true,
    this.onSpeakerphonePressed,
    this.onHangupPressed,
    this.onAcceptPressed,
  }) : super(key: key);

  @override
  CallActionsState createState() => CallActionsState();
}

class CallActionsState extends State<CallActions> {
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

    final textButtonThemeData = TextButtonTheme.of(context);
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size.square(56),
        ).merge(textButtonThemeData.style),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            message: _cameraEnabled ? 'Disable camera' : 'Enable camera',
            child: TextButton(
              style: textButtonStyles?.callAction,
              child: _cameraEnabled ? const Icon(Icons.videocam) : const Icon(Icons.videocam_off),
              onPressed: () {
                setState(() {
                  _cameraEnabled = !_cameraEnabled;
                });
                widget.onCameraPressed?.call(_cameraEnabled);
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Tooltip(
            message: _microphoneEnabled ? 'Mute microphone' : 'Unmute microphone',
            child: TextButton(
              style: textButtonStyles?.callAction,
              child: _microphoneEnabled ? const Icon(Icons.mic) : const Icon(Icons.mic_off),
              onPressed: () {
                setState(() {
                  _microphoneEnabled = !_microphoneEnabled;
                });
                widget.onMicrophonePressed?.call(_microphoneEnabled);
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Tooltip(
            message: _speakerphoneEnabled ? 'Disable speakerphone' : 'Enable speakerphone',
            child: TextButton(
              style: textButtonStyles?.callAction,
              child: _speakerphoneEnabled ? const Icon(Icons.volume_up) : const Icon(Icons.volume_off),
              onPressed: () {
                setState(() {
                  _speakerphoneEnabled = !_speakerphoneEnabled;
                });
                widget.onSpeakerphonePressed?.call(_speakerphoneEnabled);
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Tooltip(
            message: 'Hangup',
            child: TextButton(
              onPressed: widget.onHangupPressed,
              style: textButtonStyles?.callHangup,
              child: const Icon(Icons.call_end),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Tooltip(
            message: 'Accept',
            child: TextButton(
              onPressed: widget.onAcceptPressed,
              style: textButtonStyles?.callStart,
              child: const Icon(Icons.call),
            ),
          ),
        ],
      ),
    );
  }
}
