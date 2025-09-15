import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call.dart';

class CallActiveScaffold extends StatefulWidget {
  const CallActiveScaffold({
    super.key,
    required this.callStatus,
    required this.activeCalls,
    required this.audioDevice,
    required this.availableAudioDevices,
    required this.callConfig,
    required this.localePlaceholderBuilder,
    required this.remotePlaceholderBuilder,
  });

  final CallStatus callStatus;
  final List<ActiveCall> activeCalls;
  final CallAudioDevice? audioDevice;
  final List<CallAudioDevice> availableAudioDevices;
  final CallConfig callConfig;
  final WidgetBuilder? localePlaceholderBuilder;
  final WidgetBuilder? remotePlaceholderBuilder;

  @override
  CallActiveScaffoldState createState() => CallActiveScaffoldState();
}

class CallActiveScaffoldState extends State<CallActiveScaffold> {
  bool compact = false;

  @override
  Widget build(BuildContext context) {
    final activeCalls = widget.activeCalls;
    final activeCall = activeCalls.current;
    final heldCalls = activeCalls.nonCurrent;

    final activeTransfer = activeCall.transfer;

    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final onTabGradient = themeData.colorScheme.surface;
    final textTheme = themeData.textTheme;
    final switchCameraIconSize = textTheme.titleMedium!.fontSize!;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    final style = themeData.extension<CallScreenStyles>()?.primary;

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            decoration: BoxDecoration(
              gradient: gradients?.tab,
            ),
            child: Stack(
              children: [
                if (activeCall.remoteVideo)
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
                if (activeCall.localVideo)
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
                          Builder(builder: (context) {
                            final videoTrack = activeCall.localStream?.getVideoTracks().first;
                            final videoWidth = videoTrack?.getSettings()['width'] ?? 1080;
                            final videoHeight = videoTrack?.getSettings()['height'] ?? 720;

                            final aspectRatio = videoWidth / videoHeight;
                            const smallerSide = 90.0;
                            final biggerSide = smallerSide * aspectRatio;

                            final frameWidth = orientation == Orientation.portrait ? smallerSide : biggerSide;
                            final frameHeight = orientation == Orientation.portrait ? biggerSide : smallerSide;

                            return Container(
                              decoration: BoxDecoration(color: onTabGradient.withValues(alpha: 0.3)),
                              width: frameWidth,
                              height: frameHeight,
                              child: activeCall.frontCamera == null
                                  ? null
                                  : RTCStreamView(
                                      key: callFrontCameraPreviewKey,
                                      stream: activeCall.localStream,
                                      mirror: activeCall.frontCamera!,
                                      placeholderBuilder: widget.localePlaceholderBuilder,
                                    ),
                            );
                          }),
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
                  Positioned.fill(
                    left: mediaQueryData.padding.left,
                    right: mediaQueryData.padding.right,
                    top: mediaQueryData.padding.top,
                    bottom: mediaQueryData.padding.bottom,
                    child: Column(
                      children: [
                        AppBar(
                          leading: style?.appBar?.showBackButton == false ? null : const ExtBackButton(),
                          backgroundColor: style?.appBar?.backgroundColor,
                          foregroundColor: style?.appBar?.foregroundColor,
                          primary: style?.appBar?.primary ?? false,
                        ),
                        Expanded(
                          child: LayoutBuilder(builder: (context, constraints) {
                            return FittedBox(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth,
                                  minHeight: constraints.minHeight,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (final activeCall in activeCalls)
                                      CallInfo(
                                        transfering: activeTransfer is Transfering,
                                        requestToAttendedTransfer: false,
                                        inviteToAttendedTransfer: activeTransfer is InviteToAttendedTransfer,
                                        isIncoming: activeCall.isIncoming,
                                        held: activeCall.held,
                                        number: activeCall.handle.value,
                                        username: activeCall.displayName,
                                        acceptedTime: activeCall.acceptedTime,
                                        style: style?.callInfo,
                                        processingStatus: activeCall.processingStatus,
                                        callStatus: widget.callStatus,
                                      ),
                                    if (activeTransfer is AttendedTransferConfirmationRequested)
                                      CallInfo(
                                        transfering: false,
                                        requestToAttendedTransfer: true,
                                        inviteToAttendedTransfer: false,
                                        isIncoming: false,
                                        held: false,
                                        number: activeCall.handle.value,
                                        username: activeCall.displayName,
                                        style: style?.callInfo,
                                        callStatus: widget.callStatus,
                                      ),
                                    CallActions(
                                      style: style?.actions,
                                      enableInteractions: widget.callStatus == CallStatus.ready,
                                      isIncoming: activeCall.isIncoming,
                                      remoteVideo: activeCall.remoteVideo,
                                      wasAccepted: activeCall.wasAccepted,
                                      wasHungUp: activeCall.wasHungUp,
                                      cameraValue: activeCall.cameraEnabled,
                                      inviteToAttendedTransfer: activeTransfer is InviteToAttendedTransfer,
                                      onCameraChanged: widget.callConfig.isVideoCallEnabled
                                          ? (bool value) {
                                              context
                                                  .read<CallBloc>()
                                                  .add(CallControlEvent.cameraEnabled(activeCall.callId, value));
                                              setState(() {});
                                            }
                                          : null,
                                      mutedValue: activeCall.muted,
                                      onMutedChanged: (bool value) {
                                        context
                                            .read<CallBloc>()
                                            .add(CallControlEvent.setMuted(activeCall.callId, value));
                                        setState(() {});
                                      },
                                      audioDevice: widget.audioDevice,
                                      availableAudioDevices: widget.availableAudioDevices,
                                      onAudioDeviceChanged: (CallAudioDevice device) {
                                        context
                                            .read<CallBloc>()
                                            .add(CallControlEvent.audioDeviceSet(activeCall.callId, device));
                                      },
                                      transferableCalls: heldCalls,
                                      onBlindTransferInitiated: widget.callConfig.isBlindTransferEnabled
                                          ? (!activeCall.wasAccepted || activeTransfer != null
                                              ? null
                                              : () {
                                                  context
                                                      .read<CallBloc>()
                                                      .add(CallControlEvent.blindTransferInitiated(activeCall.callId));
                                                })
                                          : null,
                                      // TODO (Serdun): Simplify complex condition in the widget tree.
                                      onAttendedTransferInitiated: widget.callConfig.isAttendedTransferEnabled
                                          ? (!activeCall.wasAccepted || activeTransfer != null
                                              ? null
                                              : () {
                                                  context.read<CallBloc>().add(
                                                      CallControlEvent.attendedTransferInitiated(activeCall.callId));
                                                })
                                          : null,
                                      // TODO (Serdun): Simplify complex condition in the widget tree.
                                      onAttendedTransferSubmitted: widget.callConfig.isAttendedTransferEnabled
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
                                        context
                                            .read<CallBloc>()
                                            .add(CallControlEvent.setHeld(activeCall.callId, value));
                                      },
                                      onSwapPressed: activeCalls.length == 2
                                          ? () {
                                              // TODO maybe introduce particular event with particular callkeep method
                                              context
                                                  .read<CallBloc>()
                                                  .add(CallControlEvent.setHeld(activeCall.callId, true));
                                              for (final otherActiveCall in activeCalls) {
                                                if (otherActiveCall.callId != activeCall.callId) {
                                                  context
                                                      .read<CallBloc>()
                                                      .add(CallControlEvent.setHeld(otherActiveCall.callId, false));
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
                                                  context
                                                      .read<CallBloc>()
                                                      .add(CallControlEvent.ended(otherActiveCall.callId));
                                                }
                                              }
                                              context
                                                  .read<CallBloc>()
                                                  .add(CallControlEvent.answered(activeCall.callId));
                                            }
                                          : null,
                                      onHoldAndAcceptPressed: activeCalls.length > 1
                                          ? () {
                                              // TODO maybe introduce particular event with particular callkeep method
                                              for (final otherActiveCall in activeCalls) {
                                                if (otherActiveCall.callId != activeCall.callId) {
                                                  context
                                                      .read<CallBloc>()
                                                      .add(CallControlEvent.setHeld(otherActiveCall.callId, true));
                                                }
                                              }
                                              context
                                                  .read<CallBloc>()
                                                  .add(CallControlEvent.answered(activeCall.callId));
                                            }
                                          : null,
                                      onAcceptPressed: () {
                                        context.read<CallBloc>().add(CallControlEvent.answered(activeCall.callId));
                                      },
                                      onApproveTransferPressed: activeTransfer is AttendedTransferConfirmationRequested
                                          ? () {
                                              context.read<CallBloc>().add(CallControlEvent.attendedRequestApproved(
                                                    referId: activeTransfer.referId,
                                                    referTo: activeTransfer.referTo,
                                                  ));
                                            }
                                          : null,
                                      onDeclineTransferPressed: activeTransfer is AttendedTransferConfirmationRequested
                                          ? () {
                                              context.read<CallBloc>().add(CallControlEvent.attendedRequestDeclined(
                                                    callId: activeCall.callId,
                                                    referId: activeTransfer.referId,
                                                  ));
                                            }
                                          : null,
                                      onKeyPressed: (value) {
                                        context
                                            .read<CallBloc>()
                                            .add(CallControlEvent.sentDTMF(activeCall.callId, value));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 20)
                      ],
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
