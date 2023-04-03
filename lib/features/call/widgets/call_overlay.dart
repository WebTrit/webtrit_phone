import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';

import '../bloc/call_bloc.dart';
import '../models/models.dart';
import '../observers/overlay_navigator_observer.dart';

import 'call_overlay_dialog.dart';

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
  late Offset _callOverlayEntityPosition;

  final _callOverlayEntityConstraints = const BoxConstraints(maxHeight: 148, maxWidth: 148);

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    widget.observer.setPopListener(_callScreenPopped);
    widget.observer.setPushListener(_hideOverlay);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appBarTheme = AppBarTheme.of(context);
      final screenInfo = MediaQuery.of(context);

      const callOverlayEntityMargin = Offset(8, 8);

      final dialogPositionX = callOverlayEntityMargin.dx;
      final dialogPositionY = appBarTheme.toolbarHeight! + screenInfo.padding.top + callOverlayEntityMargin.dy;

      _callOverlayEntityPositionDefault = Offset(dialogPositionX, dialogPositionY);
      _callOverlayEntityPosition = _callOverlayEntityPositionDefault;
    });
  }

  @override
  void dispose() {
    widget.observer.dispose();
    _overlayEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallBloc, CallState>(
      child: widget.child,
      listenWhen: (previous, current) => current.isActive,
      listener: (context, state) {
        if (state.activeCall.isIncoming) {
          _hideOverlay();
          _callOverlayEntityPosition = _callOverlayEntityPositionDefault;
        }
      },
    );
  }

  void _callScreenPopped() {
    var callState = BlocProvider.of<CallBloc>(context).state;
    if (callState.isActive) {
      _showOverlay();
    }
  }

  void _endCall(CallIdValue callId) {
    BlocProvider.of<CallBloc>(context).add(CallControlEvent.ended(callId.uuid));
    _hideOverlay();
  }

  void _showOverlay() {
    _hideOverlay();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: _callOverlayEntityPosition.dx,
        top: _callOverlayEntityPosition.dy,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: (details) => _updateDialogPosition(details, context),
          child: BlocBuilder<CallBloc, CallState>(
            buildWhen: (previous, current) => current.isActive,
            builder: (context, state) => CallOverlayDialog(
              createdTime: state.activeCall.createdTime,
              name: state.activeCall.displayName ?? state.activeCall.handle.value,
              remoteStream: state.activeCall.remoteStream,
              constraints: _callOverlayEntityConstraints,
              isVideoCall: state.activeCall.video,
              onEndCall: () => _endCall(state.activeCall.callId),
            ),
          ),
          onTap: () => GoRouter.of(context).pushNamed(MainRoute.call),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _updateDialogPosition(DragUpdateDetails details, BuildContext context) {
    final overlayCenterTempPosition = _callOverlayEntityPosition + details.delta;
    final overlayCenterPosition = Offset(
      overlayCenterTempPosition.dx + _callOverlayEntityConstraints.maxWidth / 2,
      overlayCenterTempPosition.dy + _callOverlayEntityConstraints.maxHeight / 2,
    );

    if (MediaQuery.of(context).size.contains(overlayCenterPosition)) {
      _callOverlayEntityPosition = overlayCenterTempPosition;
      _overlayEntry?.markNeedsBuild();
    }
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
