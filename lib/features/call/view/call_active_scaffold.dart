import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call.dart';

class CallActiveScaffold extends StatefulWidget {
  const CallActiveScaffold({
    super.key,
    required this.speaker,
    required this.activeCalls,
    required this.config,
    required this.localePlaceholderBuilder,
    required this.remotePlaceholderBuilder,
  });

  final bool? speaker;
  final List<ActiveCall> activeCalls;
  final CallActiveConfig? config;
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
    final heldCalls = activeCalls.nonCurrent;

    final activeTransfer = activeCall.transfer;
    final maybeTransferRequest = activeTransfer is AttendedTransferConfirmationRequested ? activeTransfer : null;

    final video = activeCall.video;

    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final onTabGradient = themeData.colorScheme.surface;
    final textTheme = themeData.textTheme;
    final switchCameraIconSize = textTheme.titleMedium!.fontSize!;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    final enableAttendedTransfer = widget.config?.enableTransfer ?? true;

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
                        child: RTCStreamView(
                          stream: activeCall.remoteStream,
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
                              context.read<CallBloc>().add(CallControlEvent.cameraSwitched(activeCall.callId));
                            },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: onTabGradient.withOpacity(0.3)),
                            width: orientation == Orientation.portrait ? 90.0 : 120.0,
                            height: orientation == Orientation.portrait ? 120.0 : 90.0,
                            child: activeCall.frontCamera == null
                                ? null
                                : RTCStreamView(
                                    stream: activeCall.localStream,
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
                            transferProcessing: activeTransfer?.processing ?? false,
                            requestToAttendedTransfer: false,
                            inviteToAttendedTransfer: activeCall.transfer?.inviteToAttendedTransfer ?? false,
                            isIncoming: activeCall.isIncoming,
                            held: activeCall.held,
                            username: activeCall.displayName ?? activeCall.handle.value,
                            acceptedTime: activeCall.acceptedTime,
                            color: onTabGradient,
                            callProcessingStatus: CallProcessingStatusView(
                              status: activeCall.status,
                              color: onTabGradient,
                            ),
                          ),
                        if (maybeTransferRequest != null)
                          CallInfo(
                            transferProcessing: false,
                            requestToAttendedTransfer: true,
                            inviteToAttendedTransfer: false,
                            isIncoming: false,
                            held: false,
                            username: maybeTransferRequest.referTo,
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
                      inviteToAttendedTransfer: activeCall.transfer?.inviteToAttendedTransfer ?? false,
                      onCameraChanged: (bool value) {
                        setState(() {
                          cameraEnabled = value;
                        });
                        context.read<CallBloc>().add(CallControlEvent.cameraEnabled(activeCall.callId, value));
                      },
                      mutedValue: activeCall.muted,
                      onMutedChanged: (bool value) {
                        context.read<CallBloc>().add(CallControlEvent.setMuted(activeCall.callId, value));
                      },
                      speakerValue: widget.speaker,
                      onSpeakerChanged: (bool value) {
                        context.read<CallBloc>().add(CallControlEvent.speakerEnabled(activeCall.callId, value));
                      },
                      transferableCalls: heldCalls,
                      onBlindTransferInitiated: !activeCall.wasAccepted || activeTransfer != null
                          ? null
                          : () {
                              context.read<CallBloc>().add(CallControlEvent.blindTransferInitiated(activeCall.callId));
                            },
                      // TODO (Serdun): Simplify complex condition in the widget tree.
                      onAttendedTransferInitiated: enableAttendedTransfer
                          ? (!activeCall.wasAccepted || activeTransfer != null
                              ? null
                              : () {
                                  context
                                      .read<CallBloc>()
                                      .add(CallControlEvent.attendedTransferInitiated(activeCall.callId));
                                })
                          : null,
                      // TODO (Serdun): Simplify complex condition in the widget tree.
                      onAttendedTransferSubmitted: enableAttendedTransfer
                          ? (!activeCall.wasAccepted || activeTransfer != null
                              ? null
                              : (ActiveCall referorCall) {
                                  context.read<CallBloc>().add(
                                        CallControlEvent.attendedTransferSubmitted(
                                          referorCall: referorCall,
                                          replaceCall: activeCall,
                                        ),
                                      );
                                })
                          : null,
                      heldValue: activeCall.held,
                      onHeldChanged: (bool value) {
                        context.read<CallBloc>().add(CallControlEvent.setHeld(activeCall.callId, value));
                      },
                      onSwapPressed: activeCalls.length == 2
                          ? () {
                              // TODO maybe introduce particular event with particular callkeep method
                              context.read<CallBloc>().add(CallControlEvent.setHeld(activeCall.callId, true));
                              for (final otherActiveCall in activeCalls) {
                                if (otherActiveCall.callId != activeCall.callId) {
                                  context.read<CallBloc>().add(CallControlEvent.setHeld(otherActiveCall.callId, false));
                                }
                              }
                            }
                          : null,
                      onHangupPressed: () {
                        context.read<CallBloc>().add(CallControlEvent.ended(activeCall.callId));
                      },
                      onHangupAndAcceptPressed: activeCalls.length > 1
                          ? () {
                              // TODO maybe introduce particular event with particular callkeep method
                              for (final otherActiveCall in activeCalls) {
                                if (otherActiveCall.callId != activeCall.callId) {
                                  context.read<CallBloc>().add(CallControlEvent.ended(otherActiveCall.callId));
                                }
                              }
                              context.read<CallBloc>().add(CallControlEvent.answered(activeCall.callId));
                            }
                          : null,
                      onHoldAndAcceptPressed: activeCalls.length > 1
                          ? () {
                              // TODO maybe introduce particular event with particular callkeep method
                              for (final otherActiveCall in activeCalls) {
                                if (otherActiveCall.callId != activeCall.callId) {
                                  context.read<CallBloc>().add(CallControlEvent.setHeld(otherActiveCall.callId, true));
                                }
                              }
                              context.read<CallBloc>().add(CallControlEvent.answered(activeCall.callId));
                            }
                          : null,
                      onAcceptPressed: () {
                        context.read<CallBloc>().add(CallControlEvent.answered(activeCall.callId));
                      },
                      onApproveTransferPressed: maybeTransferRequest == null
                          ? null
                          : () {
                              context.read<CallBloc>().add(CallControlEvent.attendedRequestApproved(
                                    referId: maybeTransferRequest.referId,
                                    referTo: maybeTransferRequest.referTo,
                                  ));
                            },
                      onDeclineTransferPressed: maybeTransferRequest == null
                          ? null
                          : () {
                              context.read<CallBloc>().add(CallControlEvent.attendedRequestDeclined(
                                    callId: activeCall.callId,
                                    referId: maybeTransferRequest.referId,
                                  ));
                            },
                      onKeyPressed: (value) {
                        context.read<CallBloc>().add(CallControlEvent.sentDTMF(activeCall.callId, value));
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
