import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call.dart';

class CallActiveScaffold extends StatefulWidget {
  const CallActiveScaffold({
    super.key,
    required this.speaker,
    required this.activeCall,
    required this.localePlaceholderBuilder,
    required this.remotePlaceholderBuilder,
  });

  final bool? speaker;
  final ActiveCall activeCall;
  final WidgetBuilder? localePlaceholderBuilder;
  final WidgetBuilder? remotePlaceholderBuilder;

  @override
  CallActiveScaffoldState createState() => CallActiveScaffoldState();
}

class CallActiveScaffoldState extends State<CallActiveScaffold> {
  bool compact = false;
  late bool cameraEnabled;

  @override
  void initState() {
    super.initState();
    cameraEnabled = widget.activeCall.video;
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.activeCall.video;

    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final onTabGradient = themeData.colorScheme.background;
    final textTheme = themeData.textTheme;
    final switchCameraIconSize = textTheme.titleMedium!.fontSize!;
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
                        child: RTCVideoView(
                          widget.activeCall.renderers.remote,
                          placeholderBuilder: widget.remotePlaceholderBuilder,
                        ),
                      ),
                    ),
                  ),
                if (video)
                  AnimatedPositioned(
                    right: 10 + mediaQueryData.padding.right,
                    top: 10 + mediaQueryData.padding.top + (compact ? 0 : 100),
                    duration: kThemeChangeDuration,
                    child: GestureDetector(
                      onTap: widget.activeCall.frontCamera == null ? null : _cameraSwitched,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: onTabGradient.withOpacity(0.3)),
                            width: orientation == Orientation.portrait ? 90.0 : 120.0,
                            height: orientation == Orientation.portrait ? 120.0 : 90.0,
                            child: widget.activeCall.frontCamera == null
                                ? null
                                : RTCVideoView(
                                    widget.activeCall.renderers.local,
                                    mirror: widget.activeCall.frontCamera!,
                                    placeholderBuilder: widget.localePlaceholderBuilder,
                                  ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 1,
                            child: widget.activeCall.frontCamera == null
                                ? SizedCircularProgressIndicator(
                                    size: switchCameraIconSize - 2.0,
                                    outerSize: switchCameraIconSize,
                                    color: onTabGradient,
                                    strokeWidth: 2.0,
                                  )
                                : Icon(
                                    Icons.switch_camera,
                                    size: switchCameraIconSize,
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
                      cameraValue: cameraEnabled,
                      onCameraChanged: onCameraChanged,
                      mutedValue: widget.activeCall.muted,
                      onMutedChanged: _onMutedChanged,
                      speakerValue: widget.speaker,
                      onSpeakerChanged: _onSpeakerChanged,
                      heldValue: widget.activeCall.held,
                      onHeldChanged: _onHeldChanged,
                      onHangupPressed: _hangup,
                      onAcceptPressed: _accept,
                      onKeyPressed: _keyPressed,
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
    context.read<CallBloc>().add(CallControlEvent.cameraSwitched(widget.activeCall.callId.uuid));
  }

  void onCameraChanged(bool value) {
    setState(() {
      cameraEnabled = value;
    });

    context.read<CallBloc>().add(CallControlEvent.cameraEnabled(widget.activeCall.callId.uuid, value));
  }

  void _onMutedChanged(bool value) {
    context.read<CallBloc>().add(CallControlEvent.setMuted(widget.activeCall.callId.uuid, value));
  }

  void _onSpeakerChanged(bool value) {
    context.read<CallBloc>().add(CallControlEvent.speakerEnabled(widget.activeCall.callId.uuid, value));
  }

  void _onHeldChanged(bool value) {
    context.read<CallBloc>().add(CallControlEvent.setHeld(widget.activeCall.callId.uuid, value));
  }

  void _hangup() {
    context.read<CallBloc>().add(CallControlEvent.ended(widget.activeCall.callId.uuid));
  }

  void _accept() {
    context.read<CallBloc>().add(CallControlEvent.answered(widget.activeCall.callId.uuid));
  }

  void _keyPressed(String value) {
    context.read<CallBloc>().add(CallControlEvent.sentDTMF(widget.activeCall.callId.uuid, value));
  }
}
