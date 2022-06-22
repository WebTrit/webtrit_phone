import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../call.dart';

class CallActiveScaffold extends StatefulWidget {
  const CallActiveScaffold({
    Key? key,
    required this.activeCall,
    required this.localRenderer,
    required this.remoteRenderer,
  }) : super(key: key);

  final ActiveCall activeCall;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;

  @override
  CallActiveScaffoldState createState() => CallActiveScaffoldState();
}

class CallActiveScaffoldState extends State<CallActiveScaffold> {
  bool compact = false;
  bool frontCamera = true;

  @override
  Widget build(BuildContext context) {
    final video = widget.activeCall.video;

    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final onTabGradient = themeData.colorScheme.background;
    final textTheme = themeData.textTheme;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            decoration: BoxDecoration(
              gradient: gradients?.tab,
            ),
            child: Stack(
              children: [
                if (video)
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: widget.activeCall.wasAccepted ? _compactSwitched : null,
                      behavior: HitTestBehavior.translucent,
                      child: SizedBox(
                        width: mediaQueryData.size.width,
                        height: mediaQueryData.size.height,
                        child: RTCVideoView(widget.remoteRenderer),
                      ),
                    ),
                  ),
                if (video)
                  AnimatedPositioned(
                    right: 10 + mediaQueryData.padding.right,
                    top: 10 + mediaQueryData.padding.top + (compact ? 0 : 100),
                    duration: kThemeChangeDuration,
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
                if (!compact)
                  Positioned(
                    left: 0 + mediaQueryData.padding.left,
                    right: 0 + mediaQueryData.padding.right,
                    top: 10 + mediaQueryData.padding.top,
                    child: CallInfo(
                      isIncoming: widget.activeCall.isIncoming,
                      username: widget.activeCall.displayName ?? widget.activeCall.handle.value,
                      acceptedTime: widget.activeCall.acceptedTime,
                      color: onTabGradient,
                    ),
                  ),
                if (!compact)
                  Positioned(
                    left: 0 + mediaQueryData.padding.left,
                    right: 0 + mediaQueryData.padding.right,
                    bottom: 20 + mediaQueryData.padding.bottom,
                    child: CallActions(
                      isIncoming: widget.activeCall.isIncoming,
                      video: widget.activeCall.video,
                      wasAccepted: widget.activeCall.wasAccepted,
                      wasHungUp: widget.activeCall.wasHungUp,
                      onCameraPressed: _cameraPressed,
                      onMicrophonePressed: _microphonePressed,
                      speakerphoneEnabledByDefault: widget.activeCall.video,
                      onSpeakerphonePressed: _speakerphonePressed,
                      onHangupPressed: _hangup,
                      onAcceptPressed: _accept,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _compactSwitched() {
    setState(() {
      compact = !compact;
    });
  }

  void _cameraSwitched() {
    setState(() {
      frontCamera = !frontCamera;
    });

    context.read<CallBloc>().add(CallControlEvent.cameraSwitched(widget.activeCall.callId.uuid));
  }

  void _cameraPressed(enabled) {
    context.read<CallBloc>().add(CallControlEvent.cameraEnabled(widget.activeCall.callId.uuid, enabled));
  }

  void _microphonePressed(enabled) {
    context.read<CallBloc>().add(CallControlEvent.setMuted(widget.activeCall.callId.uuid, !enabled));
  }

  void _speakerphonePressed(enabled) {
    context.read<CallBloc>().add(CallControlEvent.speakerphoneEnabled(widget.activeCall.callId.uuid, enabled));
  }

  void _hangup() {
    context.read<CallBloc>().add(CallControlEvent.ended(widget.activeCall.callId.uuid));
  }

  void _accept() {
    context.read<CallBloc>().add(CallControlEvent.answered(widget.activeCall.callId.uuid));
  }
}
