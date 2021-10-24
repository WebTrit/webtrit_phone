import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  late Future<List<void>> _renderersInitialized;

  bool _frontCamera = true;

  @override
  void initState() {
    super.initState();

    _renderersInitialized = _renderersInitialize();
  }

  @override
  void dispose() {
    _renderersDispose();

    super.dispose();
  }

  Future<List<void>> _renderersInitialize() {
    return Future.wait([
      _localRenderer.initialize(),
      _remoteRenderer.initialize(),
    ]);
  }

  Future<List<void>> _renderersDispose() {
    return Future.wait([
      _localRenderer.dispose(),
      _remoteRenderer.dispose(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _renderersInitialized,
      builder: (context, AsyncSnapshot<List<void>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _build(context);
        } else {
          return Scaffold(
            body: Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _build(BuildContext context) {
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
          final username = state.number;
          return Scaffold(
            body: OrientationBuilder(
              builder: (context, orientation) {
                return Container(
                  color: Colors.black,
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            decoration: const BoxDecoration(color: Colors.black54),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: RTCVideoView(_remoteRenderer),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          top: 20,
                          child: GestureDetector(
                            onTap: _cameraSwitched,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(color: Colors.black54),
                                  width: orientation == Orientation.portrait ? 90.0 : 120.0,
                                  height: orientation == Orientation.portrait ? 120.0 : 90.0,
                                  child: RTCVideoView(_localRenderer, mirror: true),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 1,
                                  child: Icon(
                                    Icons.switch_camera,
                                    size: Theme.of(context).textTheme.subtitle1!.fontSize,
                                    color: Colors.white,
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
                            children: [
                              Text(
                                direction,
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                username,
                                style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
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
        if (state is CallFailure) {
          return Scaffold(
            body: Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    state.reason,
                    style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Tooltip(
                      message: 'Ok',
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        ),
                        onPressed: () => context.read<CallBloc>().add(const CallFailureApproved()),
                        child: const Text('Ok'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        throw StateError(''); // TODO fix if logic
      },
    );
  }

  void _cameraSwitched() {
    setState(() {
      _frontCamera = !_frontCamera;
    });

    context.read<CallBloc>().add(const CallCameraSwitched());
  }

  void _cameraPressed(enabled) {
    context.read<CallBloc>().add(CallCameraEnabled(enabled));
  }

  void _microphonePressed(enabled) {
    context.read<CallBloc>().add(CallMicrophoneEnabled(enabled));
  }

  void _speakerphonePressed(enabled) {
    context.read<CallBloc>().add(CallSpeakerphoneEnabled(enabled));
  }

  void _hangup() {
    context.read<CallBloc>().add(const CallLocalHungUp(reason: 'some local reason'));
  }

  void _accept() {
    context.read<CallBloc>().add(const CallIncomingAccepted());
  }
}

class _CallActions extends StatefulWidget {
  final bool cameraEnabledByDefault;
  final void Function(bool enabled)? onCameraPressed;
  final bool microphoneEnabledByDefault;
  final void Function(bool enabled)? onMicrophonePressed;
  final bool speakerphoneEnabledByDefault;
  final void Function(bool enabled)? onSpeakerphonePressed;
  final void Function()? onHangupPressed;
  final void Function()? onAcceptPressed;

  const _CallActions({
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
  _CallActionsState createState() => _CallActionsState();
}

class _CallActionsState extends State<_CallActions> {
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
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.black,
          backgroundColor: Colors.white,
          minimumSize: const Size.square(56),
          shape: const CircleBorder(),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            message: _cameraEnabled ? 'Disable camera' : 'Enable camera',
            child: TextButton(
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
              child: const Icon(Icons.call_end),
              onPressed: widget.onHangupPressed,
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Tooltip(
            message: 'Accept',
            child: TextButton(
              child: const Icon(Icons.call),
              onPressed: widget.onAcceptPressed,
              style: TextButton.styleFrom(
                primary: Colors.white,
              ).copyWith(
                backgroundColor: _TextButtonBackground(Colors.green, Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class _TextButtonBackground extends MaterialStateProperty<Color> {
  _TextButtonBackground(this.enabled, this.disabled);

  final Color enabled;
  final Color disabled;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabled;
    } else {
      return enabled;
    }
  }

  @override
  String toString() {
    return '{disabled: $disabled, otherwise: $enabled}';
  }
}
