import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/widgets/rtc_video_view.dart';

class CallPage extends StatefulWidget {
  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  RTCVideoRendererExt _localRenderer = RTCVideoRendererExt();
  RTCVideoRendererExt _remoteRenderer = RTCVideoRendererExt();

  bool _frontCamera = true;

  @override
  void initState() {
    super.initState();

    _localRenderer.initialize();
    _remoteRenderer.initialize();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is CallIdle) {
          _localRenderer.srcObject = null;
          _remoteRenderer.srcObject = null;

          return Scaffold(
            body: Container(
              color: Colors.black,
            ),
          );
        }
        if (state is CallActive) {
          _localRenderer.srcObject = state.localStream;
          _remoteRenderer.srcObject = state.remoteStream;

          final acceptActionEnabled = state is CallIncoming && state.accepted != true;
          final direction = state is CallIncoming ? 'Incoming call from' : 'Outgoing call to';
          final username = state.username;
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
                            child: RTCVideoViewExt(_remoteRenderer),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          top: 20,
                          child: GestureDetector(
                            onTap: _cameraSwitched,
                            child: Stack(
                              children: <Widget>[
                                ValueListenableBuilder<RTCVideoValue>(
                                  valueListenable: _localRenderer,
                                  builder: (BuildContext context, RTCVideoValue value, Widget child) {
                                    if (value.isEmpty) {
                                      return Container();
                                    } else {
                                      final size = MediaQuery.of(context).size;
                                      final sizeWidthRatio = (orientation == Orientation.portrait ? 3 : 5);
                                      final localVideoViewWidth = size.width / sizeWidthRatio;
                                      final localVideoViewHeight = localVideoViewWidth / value.aspectRatio;
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.red),
                                        ),
                                        width: localVideoViewWidth,
                                        height: localVideoViewHeight,
                                        child: child,
                                      );
                                    }
                                  },
                                  child: RTCVideoViewExt(_localRenderer),
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
                          top: 30,
                          child: Column(
                            children: <Widget>[
                              Text(
                                direction,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                username,
                                style: Theme.of(context).textTheme.display2.copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
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
                            onAcceptPressed: acceptActionEnabled ? _accept : null,
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
      },
    );
  }

  void _cameraSwitched() {
    setState(() {
      _frontCamera = !_frontCamera;
    });

    BlocProvider.of<CallBloc>(context).add(CallCameraSwitched());
  }

  void _cameraPressed(enabled) {}

  void _microphonePressed(enabled) {}

  void _speakerphonePressed(enabled) {}

  void _hangup() {
    BlocProvider.of<CallBloc>(context).add(CallLocalHungUp(reason: 'some local reason'));
  }

  void _accept() {
    BlocProvider.of<CallBloc>(context).add(CallIncomingAccepted());
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
              disabledColor: Colors.grey,
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
