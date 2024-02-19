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
    required this.activeCalls,
    required this.localePlaceholderBuilder,
    required this.remotePlaceholderBuilder,
  });

  final bool? speaker;
  final List<ActiveCall> activeCalls;
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
    cameraEnabled = widget.activeCalls.current.video;
  }

  @override
  Widget build(BuildContext context) {
    final activeCalls = widget.activeCalls;
    final activeCall = activeCalls.current;

    final video = activeCall.video;

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
                      onTap: activeCall.wasAccepted ? _compactSwitched : null,
                      behavior: HitTestBehavior.translucent,
                      child: SizedBox(
                        width: mediaQueryData.size.width,
                        height: mediaQueryData.size.height,
                        child: RTCVideoView(
                          activeCall.renderers.remote,
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
                      onTap: activeCall.frontCamera == null
                          ? null
                          : () {
                              context.read<CallBloc>().add(CallControlEvent.cameraSwitched(activeCall.callId.uuid));
                            },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: onTabGradient.withOpacity(0.3)),
                            width: orientation == Orientation.portrait ? 90.0 : 120.0,
                            height: orientation == Orientation.portrait ? 120.0 : 90.0,
                            child: activeCall.frontCamera == null
                                ? null
                                : RTCVideoView(
                                    activeCall.renderers.local,
                                    mirror: activeCall.frontCamera!,
                                    placeholderBuilder: widget.localePlaceholderBuilder,
                                  ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 1,
                            child: activeCall.frontCamera == null
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
                    child: Column(
                      children: [
                        AppBar(
                          leading: const ExtBackButton(),
                          backgroundColor: Colors.transparent,
                          foregroundColor: onTabGradient,
                          primary: false,
                        ),
                        for (final activeCall in activeCalls)
                          CallInfo(
                            transferProcessing: activeCall.transfer?.isProcessing == true,
                            isIncoming: activeCall.isIncoming,
                            held: activeCall.held,
                            username: activeCall.displayName ?? activeCall.handle.value,
                            acceptedTime: activeCall.acceptedTime,
                            color: onTabGradient,
                          ),
                      ],
                    ),
                  ),
                if (!compact)
                  Positioned(
                    left: 0 + mediaQueryData.padding.left,
                    right: 0 + mediaQueryData.padding.right,
                    bottom: 20 + mediaQueryData.padding.bottom,
                    child: CallActions(
                      isIncoming: activeCall.isIncoming,
                      video: activeCall.video,
                      wasAccepted: activeCall.wasAccepted,
                      wasHungUp: activeCall.wasHungUp,
                      cameraValue: cameraEnabled,
                      onCameraChanged: (bool value) {
                        setState(() {
                          cameraEnabled = value;
                        });
                        context.read<CallBloc>().add(CallControlEvent.cameraEnabled(activeCall.callId.uuid, value));
                      },
                      mutedValue: activeCall.muted,
                      onMutedChanged: (bool value) {
                        context.read<CallBloc>().add(CallControlEvent.setMuted(activeCall.callId.uuid, value));
                      },
                      speakerValue: widget.speaker,
                      onSpeakerChanged: (bool value) {
                        context.read<CallBloc>().add(CallControlEvent.speakerEnabled(activeCall.callId.uuid, value));
                      },
                      onTransferPressed: !activeCall.wasAccepted || activeCall.transfer != null
                          ? null
                          : () {
                              context
                                  .read<CallBloc>()
                                  .add(CallControlEvent.blindTransferInitiated(activeCall.callId.uuid));
                            },
                      heldValue: activeCall.held,
                      onHeldChanged: (bool value) {
                        context.read<CallBloc>().add(CallControlEvent.setHeld(activeCall.callId.uuid, value));
                      },
                      onSwapPressed: activeCalls.length == 2
                          ? () {
                              // TODO maybe introduce particular event with particular callkeep method
                              context.read<CallBloc>().add(CallControlEvent.setHeld(activeCall.callId.uuid, true));
                              for (final otherActiveCall in activeCalls) {
                                if (otherActiveCall.callId != activeCall.callId) {
                                  context
                                      .read<CallBloc>()
                                      .add(CallControlEvent.setHeld(otherActiveCall.callId.uuid, false));
                                }
                              }
                            }
                          : null,
                      onHangupPressed: () {
                        context.read<CallBloc>().add(CallControlEvent.ended(activeCall.callId.uuid));
                      },
                      onHangupAndAcceptPressed: activeCalls.length > 1
                          ? () {
                              // TODO maybe introduce particular event with particular callkeep method
                              for (final otherActiveCall in activeCalls) {
                                if (otherActiveCall.callId != activeCall.callId) {
                                  context.read<CallBloc>().add(CallControlEvent.ended(otherActiveCall.callId.uuid));
                                }
                              }
                              context.read<CallBloc>().add(CallControlEvent.answered(activeCall.callId.uuid));
                            }
                          : null,
                      onHoldAndAcceptPressed: activeCalls.length > 1
                          ? () {
                              // TODO maybe introduce particular event with particular callkeep method
                              for (final otherActiveCall in activeCalls) {
                                if (otherActiveCall.callId != activeCall.callId) {
                                  context
                                      .read<CallBloc>()
                                      .add(CallControlEvent.setHeld(otherActiveCall.callId.uuid, true));
                                }
                              }
                              context.read<CallBloc>().add(CallControlEvent.answered(activeCall.callId.uuid));
                            }
                          : null,
                      onAcceptPressed: () {
                        context.read<CallBloc>().add(CallControlEvent.answered(activeCall.callId.uuid));
                      },
                      onKeyPressed: (value) {
                        context.read<CallBloc>().add(CallControlEvent.sentDTMF(activeCall.callId.uuid, value));
                      },
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
}
