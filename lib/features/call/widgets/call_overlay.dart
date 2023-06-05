import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_overlay_floating/webtrit_overlay_floating.dart';
import 'package:webtrit_phone/app/routes.dart';

import '../bloc/call_bloc.dart';
import '../observers/overlay_navigator_observer.dart';

import 'call_overlay_dialog.dart';
import 'call_overlay_dialog_minimized.dart';

class CallOverlay extends StatefulWidget {
  const CallOverlay({
    super.key,
    required this.child,
    required this.observer,
  });

  final Widget child;
  final OverlayNavigatorObserver observer;

  @override
  State<CallOverlay> createState() => _CallOverlayState();
}

class _CallOverlayState extends State<CallOverlay> {
  late Offset _callOverlayEntityPositionDefault;
  final _overlayController = OverlayController();

  @override
  void initState() {
    super.initState();
    widget.observer.setPopListener(_showCallOverlay);
    widget.observer.setPushListener(_overlayController.disposeAll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appBarTheme = AppBarTheme.of(context);
      final screenInfo = MediaQuery.of(context);

      const callOverlayEntityMargin = Offset(8, 8);

      final dialogPositionX = callOverlayEntityMargin.dx;
      final dialogPositionY = appBarTheme.toolbarHeight! + screenInfo.padding.top + callOverlayEntityMargin.dy;

      _callOverlayEntityPositionDefault = Offset(dialogPositionX, dialogPositionY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallBloc, CallState>(
      child: OverlayWidget(
        controller: _overlayController,
        child: widget.child,
      ),
      listener: (context, state) {
        if (!state.isActive) {
          _overlayController.disposeAll();
        }
      },
    );
  }

  void _showCallOverlay() {
    var state = BlocProvider.of<CallBloc>(context).state;
    if (state.isActive) {
      final overlayData = OverlayEntryData(
        offset: _callOverlayEntityPositionDefault,
        config: const OverlayConfig(
          overlayEntityConstraints: BoxConstraints(maxHeight: 148, maxWidth: 148),
          overlayEntityConstraintsMinimized: BoxConstraints(maxHeight: 148, maxWidth: 40),
        ),
        child: CallOverlayDialog(
          createdTime: state.activeCall.createdTime,
          name: state.activeCall.displayName ?? state.activeCall.handle.value,
          remoteStream: state.activeCall.remoteStream,
          isVideoCall: state.activeCall.video,
          onTap: () => GoRouter.of(context).pushNamed(MainRoute.call),
        ),
        minimizedChild: CallOverlayDialogMinimized(
          createdTime: state.activeCall.createdTime,
          name: state.activeCall.displayName ?? state.activeCall.handle.value,
          remoteStream: state.activeCall.remoteStream,
          isVideoCall: state.activeCall.video,
          onTap: () => GoRouter.of(context).pushNamed(MainRoute.call),
        ),
      );
      _overlayController.add(state.activeCall.callId.value, overlayData);
    }
  }
}
