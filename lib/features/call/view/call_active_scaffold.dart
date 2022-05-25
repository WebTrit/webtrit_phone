import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../call.dart';

class CallActiveScaffold extends StatefulWidget {
  const CallActiveScaffold({
    Key? key,
    required this.state,
    required this.localRenderer,
    required this.remoteRenderer,
  }) : super(key: key);

  final ActiveCallState state;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;

  @override
  CallActiveScaffoldState createState() => CallActiveScaffoldState();
}

class CallActiveScaffoldState extends State<CallActiveScaffold> {
  bool frontCamera = true;
  Timer? durationTimer;
  Duration? duration;

  @override
  void initState() {
    super.initState();
    durationTimer = Timer.periodic(const Duration(seconds: 1), _onDurationTimer);
  }

  @override
  void dispose() {
    durationTimer?.cancel();
    super.dispose();
  }

  void _onDurationTimer(Timer timer) {
    final acceptedTime = widget.state.acceptedTime;
    if (acceptedTime != null) {
      setState(() {
        duration = DateTime.now().difference(acceptedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final acceptActionEnabled = widget.state.isIncoming && widget.state.wasAccepted != true;
    final direction = widget.state.isIncoming ? 'Incoming call from' : 'Outgoing call to';
    final username = widget.state.number;
    final duration = this.duration;

    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final onTabGradient = themeData.colorScheme.background;
    final textTheme = themeData.textTheme;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    EdgeInsets padding = mediaQueryData.padding;
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            decoration: BoxDecoration(
              gradient: gradients?.tab,
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: mediaQueryData.size.width,
                    height: mediaQueryData.size.height,
                    child: RTCVideoView(widget.remoteRenderer),
                  ),
                ),
                Positioned(
                  right: 20 + mediaQueryData.padding.right,
                  top: 20 + mediaQueryData.padding.top,
                  child: GestureDetector(
                    onTap: _cameraSwitched,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: onTabGradient.withOpacity(0.3)),
                          width: orientation == Orientation.portrait ? 90.0 : 120.0,
                          height: orientation == Orientation.portrait ? 120.0 : 90.0,
                          child: RTCVideoView(
                            widget.localRenderer,
                            mirror: true,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 1,
                          child: Icon(
                            Icons.switch_camera,
                            size: textTheme.titleMedium!.fontSize,
                            color: onTabGradient,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0 + mediaQueryData.padding.left,
                  right: 0 + mediaQueryData.padding.right,
                  top: 30 + mediaQueryData.padding.top,
                  child: Column(
                    children: [
                      Text(
                        direction,
                        style: textTheme.bodyLarge!.copyWith(color: onTabGradient),
                      ),
                      Text(
                        username,
                        style: textTheme.displaySmall!.copyWith(color: onTabGradient),
                      ),
                      if (duration != null)
                        Text(
                          duration.format(),
                          style: textTheme.bodyMedium!.copyWith(
                            color: onTabGradient,
                            fontFeatures: [
                              const FontFeature.tabularFigures(),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0 + mediaQueryData.padding.left,
                  right: 0 + mediaQueryData.padding.right,
                  bottom: 20 + mediaQueryData.padding.bottom,
                  child: CallActions(
                    onCameraPressed: _cameraPressed,
                    onMicrophonePressed: _microphonePressed,
                    speakerphoneEnabledByDefault: widget.state.video,
                    onSpeakerphonePressed: _speakerphonePressed,
                    onHangupPressed: _hangup,
                    onAcceptPressed: acceptActionEnabled ? _accept : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _cameraSwitched() {
    setState(() {
      frontCamera = !frontCamera;
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
