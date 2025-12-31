import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

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
  /// Manages the visibility state of call controls (Compact vs. Expanded) and
  /// handles the auto-hide timer logic based on user activity and call state.
  late final CompactAutoResetController _compactController;

  /// Controls the object fit mode (cover or contain) for the remote video stream.
  ///
  /// Consider moving this to a global state (e.g., BLoC or Some config provider).
  RTCVideoViewObjectFit _videoFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;

  /// Controls whether the blurred background is rendered when the video fits the screen.
  ///
  /// Consider moving this to a global state (e.g., BLoC or Some config provider).
  bool _enableBlurredBackground = true;

  @override
  void initState() {
    super.initState();
    // Synchronize the auto-hide logic with the initial call list configuration.
    _compactController = CompactAutoResetController(initiallyActive: widget.activeCalls.shouldAutoCompact);
  }

  @override
  void didUpdateWidget(covariant CallActiveScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Synchronize the auto-hide logic with the latest call list configuration.
    _compactController.setActive(widget.activeCalls.shouldAutoCompact, reason: 'didUpdateWidget');
  }

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
            decoration: BoxDecoration(gradient: gradients?.tab),
            child: Stack(
              children: [
                if (activeCall.remoteVideo)
                  RemoteVideoViewOverlay(
                    activeCallWasAccepted: activeCall.wasAccepted,
                    remoteStream: activeCall.remoteStream,
                    videoFit: _videoFit,
                    onTap: _compactController.toggle,
                    remotePlaceholderBuilder: widget.remotePlaceholderBuilder,
                    enableBlurredBackground: _enableBlurredBackground,
                  ),
                if (activeCall.cameraEnabled)
                  AnimatedBuilder(
                    animation: _compactController,
                    builder: (context, _) => LocalCameraPreviewOverlay(
                      compact: _compactController.compact,
                      orientation: orientation,
                      padding: mediaQueryData.padding,
                      onTabGradient: onTabGradient,
                      switchCameraIconSize: switchCameraIconSize,
                      frontCamera: activeCall.frontCamera,
                      localStream: activeCall.localStream,
                      localPlaceholderBuilder: widget.localePlaceholderBuilder,
                      onSwitchCameraPressed: activeCall.frontCamera == null
                          ? null
                          : () => context.read<CallBloc>().add(CallControlEvent.cameraSwitched(activeCall.callId)),
                    ),
                  ),
                AnimatedBuilder(
                  animation: _compactController,
                  builder: (context, _) => _compactController.compact
                      ? const SizedBox.expand()
                      : Positioned.fill(
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
                                actions: [
                                  if (activeCall.remoteVideo)
                                    PopupMenuButton<void>(
                                      icon: const Icon(Icons.more_vert),
                                      itemBuilder: _buildPopupMenuItems,
                                    ),
                                ],
                              ),
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
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
                                                  ? (bool value) => context.read<CallBloc>().add(
                                                      CallControlEvent.cameraEnabled(activeCall.callId, value),
                                                    )
                                                  : null,
                                              mutedValue: activeCall.muted,
                                              onMutedChanged: (bool value) => context.read<CallBloc>().add(
                                                CallControlEvent.setMuted(activeCall.callId, value),
                                              ),
                                              audioDevice: widget.audioDevice,
                                              availableAudioDevices: widget.availableAudioDevices,
                                              onAudioDeviceChanged: (CallAudioDevice device) {
                                                context.read<CallBloc>().add(
                                                  CallControlEvent.audioDeviceSet(activeCall.callId, device),
                                                );
                                              },
                                              transferableCalls: heldCalls,
                                              onBlindTransferInitiated: widget.callConfig.isBlindTransferEnabled
                                                  ? (!activeCall.wasAccepted || activeTransfer != null
                                                        ? null
                                                        : () {
                                                            context.read<CallBloc>().add(
                                                              CallControlEvent.blindTransferInitiated(
                                                                activeCall.callId,
                                                              ),
                                                            );
                                                          })
                                                  : null,
                                              // TODO (Serdun): Simplify complex condition in the widget tree.
                                              onAttendedTransferInitiated: widget.callConfig.isAttendedTransferEnabled
                                                  ? (!activeCall.wasAccepted || activeTransfer != null
                                                        ? null
                                                        : () {
                                                            context.read<CallBloc>().add(
                                                              CallControlEvent.attendedTransferInitiated(
                                                                activeCall.callId,
                                                              ),
                                                            );
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
                                                context.read<CallBloc>().add(
                                                  CallControlEvent.setHeld(activeCall.callId, value),
                                                );
                                              },
                                              onSwapPressed: activeCalls.length == 2
                                                  ? () {
                                                      // TODO maybe introduce particular event with particular callkeep method
                                                      context.read<CallBloc>().add(
                                                        CallControlEvent.setHeld(activeCall.callId, true),
                                                      );
                                                      for (final otherActiveCall in activeCalls) {
                                                        if (otherActiveCall.callId != activeCall.callId) {
                                                          context.read<CallBloc>().add(
                                                            CallControlEvent.setHeld(otherActiveCall.callId, false),
                                                          );
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
                                                          context.read<CallBloc>().add(
                                                            CallControlEvent.ended(otherActiveCall.callId),
                                                          );
                                                        }
                                                      }
                                                      context.read<CallBloc>().add(
                                                        CallControlEvent.answered(activeCall.callId),
                                                      );
                                                    }
                                                  : null,
                                              onHoldAndAcceptPressed: activeCalls.length > 1
                                                  ? () {
                                                      // TODO maybe introduce particular event with particular callkeep method
                                                      for (final otherActiveCall in activeCalls) {
                                                        if (otherActiveCall.callId != activeCall.callId) {
                                                          context.read<CallBloc>().add(
                                                            CallControlEvent.setHeld(otherActiveCall.callId, true),
                                                          );
                                                        }
                                                      }
                                                      context.read<CallBloc>().add(
                                                        CallControlEvent.answered(activeCall.callId),
                                                      );
                                                    }
                                                  : null,
                                              onAcceptPressed: () {
                                                context.read<CallBloc>().add(
                                                  CallControlEvent.answered(activeCall.callId),
                                                );
                                              },
                                              onApproveTransferPressed:
                                                  activeTransfer is AttendedTransferConfirmationRequested
                                                  ? () {
                                                      context.read<CallBloc>().add(
                                                        CallControlEvent.attendedRequestApproved(
                                                          referId: activeTransfer.referId,
                                                          referTo: activeTransfer.referTo,
                                                        ),
                                                      );
                                                    }
                                                  : null,
                                              onDeclineTransferPressed:
                                                  activeTransfer is AttendedTransferConfirmationRequested
                                                  ? () {
                                                      context.read<CallBloc>().add(
                                                        CallControlEvent.attendedRequestDeclined(
                                                          callId: activeCall.callId,
                                                          referId: activeTransfer.referId,
                                                        ),
                                                      );
                                                    }
                                                  : null,
                                              onKeyPressed: (value) {
                                                context.read<CallBloc>().add(
                                                  CallControlEvent.sentDTMF(activeCall.callId, value),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<PopupMenuEntry<void>> _buildPopupMenuItems(BuildContext context) {
    return [
      PopupMenuItem(
        onTap: _onVideoFitTogglePressed,
        child: Row(
          children: [
            Icon(_videoFit.toggleIcon, color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 12),
            Text(_videoFit == RTCVideoViewObjectFit.RTCVideoViewObjectFitContain ? 'Cover' : 'Fit'),
          ],
        ),
      ),
      PopupMenuItem(
        onTap: _onBlurTogglePressed,
        child: Row(
          children: [
            Icon(_enableBlurredBackground ? Icons.blur_off : Icons.blur_on, color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 12),
            Text(_enableBlurredBackground ? 'Disable Blur' : 'Enable Blur'),
          ],
        ),
      ),
    ];
  }

  void _onVideoFitTogglePressed() {
    setState(() => _videoFit = _videoFit.toggled);
  }

  void _onBlurTogglePressed() {
    setState(() => _enableBlurredBackground = !_enableBlurredBackground);
  }

  @override
  void dispose() {
    _compactController.dispose();
    super.dispose();
  }
}
