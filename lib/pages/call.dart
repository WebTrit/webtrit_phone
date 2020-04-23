import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';

class CallPage extends StatefulWidget {
  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  bool _frontCamera = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            color: Colors.black,
            child: SafeArea(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      child: Center(
                        child: Text(
                          'Remote Video',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: GestureDetector(
                      onTap: _cameraSwitched,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.red),
                            ),
                            width: 100,
                            height: 100,
                            child: Center(
                              child: Text(
                                'Local ${_frontCamera ? 'Front' : 'Back'} Video',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 1,
                            child: Container(
                              child: Icon(
                                Icons.switch_camera,
                                size: Theme.of(context).textTheme.subhead.fontSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: _CallActions(
                      onCameraPressed: _cameraPressed,
                      onMicrophonePressed: _microphonePressed,
                      onSpeakerphonePressed: _speakerphonePressed,
                      onHangupPressed: _hangup,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _cameraSwitched() {
    setState(() {
      _frontCamera = !_frontCamera;
    });
  }

  void _cameraPressed(enabled) {}

  void _microphonePressed(enabled) {}

  void _speakerphonePressed(enabled) {}

  void _hangup() {
    BlocProvider.of<CallBloc>(context).add(CallHungUpLocal(reason: 'some local reason'));
  }
}

class _CallActions extends StatefulWidget {
  final bool cameraEnabledByDefault;
  final void Function(bool enabled) onCameraPressed;
  final bool microphoneEnabledByDefault;
  final void Function(bool enabled) onMicrophonePressed;
  final bool speakerphoneEnabledByDefault;
  final void Function(bool enabled) onSpeakerphonePressed;
  final void Function() onHangupPressed;
  final void Function() onAcceptPressed;

  _CallActions({
    Key key,
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
  _CallActionsState createState() => _CallActionsState();
}

class _CallActionsState extends State<_CallActions> {
  bool _cameraEnabled;
  bool _microphoneEnabled;
  bool _speakerphoneEnabled;

  @override
  void initState() {
    super.initState();
    _cameraEnabled = widget.cameraEnabledByDefault;
    _microphoneEnabled = widget.microphoneEnabledByDefault;
    _speakerphoneEnabled = widget.speakerphoneEnabledByDefault;
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      shape: CircleBorder(),
      minWidth: 56,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Tooltip(
            message: _cameraEnabled ? 'Disable camera' : 'Enable camera',
            child: FlatButton(
              color: Colors.white,
              child: _cameraEnabled ? Icon(Icons.videocam) : Icon(Icons.videocam_off),
              onPressed: () {
                setState(() {
                  _cameraEnabled = !_cameraEnabled;
                });
                widget.onCameraPressed?.call(_cameraEnabled);
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Tooltip(
            message: _microphoneEnabled ? 'Mute microphone' : 'Unmute microphone',
            child: FlatButton(
              color: Colors.white,
              child: _microphoneEnabled ? const Icon(Icons.mic) : const Icon(Icons.mic_off),
              onPressed: () {
                setState(() {
                  _microphoneEnabled = !_microphoneEnabled;
                });
                widget.onMicrophonePressed?.call(_microphoneEnabled);
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Tooltip(
            message: _speakerphoneEnabled ? 'Disable speakerphone' : 'Enable speakerphone',
            child: FlatButton(
              color: Colors.white,
              child: _speakerphoneEnabled ? const Icon(Icons.volume_up) : const Icon(Icons.volume_off),
              onPressed: () {
                setState(() {
                  _speakerphoneEnabled = !_speakerphoneEnabled;
                });
                widget.onSpeakerphonePressed?.call(_speakerphoneEnabled);
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Tooltip(
            message: 'Hangup',
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: const Icon(Icons.call_end),
              onPressed: widget.onHangupPressed,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Tooltip(
            message: 'Accept',
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              disabledColor: Colors.grey,
              child: const Icon(Icons.call),
              onPressed: widget.onAcceptPressed,
            ),
          ),
        ],
      ),
    );
  }
}
