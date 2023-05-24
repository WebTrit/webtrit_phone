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

  final _overlayEntries = <String, OverlayEntryData>{};

  @override
  void initState() {
    super.initState();
    widget.observer.setPopListener(_showCallOverlay);
    widget.observer.setPushListener(_disposeAllOverlay);

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
  void dispose() {
    widget.observer.dispose();
    _overlayEntries.clear();
    _disposeAllOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallBloc, CallState>(
      child: widget.child,
      listener: (context, state) {
        if (!state.isActive) {
          _disposeAllOverlay();
        }
      },
    );
  }

  void _showCallOverlay() {
    var callState = BlocProvider.of<CallBloc>(context).state;
    if (callState.isActive) {
      _addOverlayCall(callState.activeCall.callId.value);
    }
  }

  void _removeOverlay(String id) {
    setState(() {
      if (_overlayEntries.containsKey(id)) {
        OverlayEntryData overlayData = _overlayEntries[id]!;
        overlayData.entry?.remove();
        _overlayEntries.remove(id);
      }
    });
  }

  void _disposeAllOverlay() {
    _overlayEntries.forEach((key, value) {
      value.removeOverlayIfExit();
    });
  }

  void _endCall(CallIdValue callId) {
    BlocProvider.of<CallBloc>(context).add(CallControlEvent.ended(callId.uuid));
    _removeOverlay(callId.value);
  }

  void _addOverlayCall(String id) {
    OverlayEntryData overlayData;

    setState(() {
      if (_overlayEntries.containsKey(id)) {
        overlayData = _overlayEntries[id]!;
      } else {
        overlayData = OverlayEntryData(position: _callOverlayEntityPositionDefault);
        _overlayEntries[id] = overlayData;
      }
      overlayData.attachOverlayEntry(
        child: BlocBuilder<CallBloc, CallState>(
          buildWhen: (previous, current) => current.isActive,
          builder: (context, state) => CallOverlayDialog(
            createdTime: state.activeCall.createdTime,
            name: state.activeCall.displayName ?? state.activeCall.handle.value,
            remoteStream: state.activeCall.remoteStream,
            isVideoCall: state.activeCall.video,
            transferring: state.activeCall.transferring,
            onEndCall: () => _endCall(state.activeCall.callId),
          ),
        ),
      );

      Overlay.of(context).insert(overlayData.entry!);
    });
  }
}

class OverlayEntryData {
  Widget? widget;
  Offset position;
  OverlayEntry? entry;

  OverlayEntryData({
    required this.position,
  });

  void removeOverlayIfExit() {
    entry?.remove();
    entry?.dispose();
    entry = null;
  }

  final _callOverlayEntityConstraints = const BoxConstraints(maxHeight: 148, maxWidth: 148);

  void attachOverlayEntry({
    required Widget child,
  }) {
    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy,
        left: position.dx,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: (details) => _updateOverlayPosition(entry!, details, context),
          onTap: () => GoRouter.of(context).pushNamed(MainRoute.call),
          child: ConstrainedBox(constraints: _callOverlayEntityConstraints, child: child),
        ),
      ),
    );
  }

  void _updateOverlayPosition(OverlayEntry overlayEntry, DragUpdateDetails details, BuildContext context) {
    final overlayCenterTempPosition = position + details.delta;
    final overlayCenterPosition = Offset(
      overlayCenterTempPosition.dx + _callOverlayEntityConstraints.maxWidth / 2,
      overlayCenterTempPosition.dy + _callOverlayEntityConstraints.maxHeight / 2,
    );

    if (MediaQuery.of(context).size.contains(overlayCenterPosition)) {
      position = overlayCenterTempPosition;
      overlayEntry.markNeedsBuild();
    }
  }
}
