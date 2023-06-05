import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_overlay_floating/webtrit_overlay_floating.dart';

import 'dialogs/call_overlay_dialog.dart';
import 'dialogs/call_overlay_dialog_minimized.dart';

class CallOverlay extends StatefulWidget {
  const CallOverlay({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<CallOverlay> createState() => _CallOverlayState();
}

class _CallOverlayState extends State<CallOverlay> {
  late Offset _callOverlayEntityPositionDefault;

  int key = 0;

  OverlayController overlayController = OverlayController();

  OverlayConfig overlayConfig = const OverlayConfig(
    overlayEntityConstraints: BoxConstraints(maxHeight: 148, maxWidth: 148),
    overlayEntityConstraintsMinimized: BoxConstraints(maxHeight: 148, maxWidth: 40),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _regenerateDefaultPosition();
    });
  }

  void _regenerateDefaultPosition() {
    Random random = Random();
    int x = random.nextInt(500);
    int y = random.nextInt(800);

    final dialogPositionX = x;
    final dialogPositionY = y;

    _callOverlayEntityPositionDefault = Offset(dialogPositionX.toDouble(), dialogPositionY.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverlayWidget(
        controller: overlayController,
        child: widget.child,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              _regenerateDefaultPosition();
              key++;
              final overlayData = OverlayEntryData(
                config: overlayConfig,
                offset: _callOverlayEntityPositionDefault,
                child: CallOverlayDialog(
                  createdTime: DateTime.now(),
                  name: 'Testy',
                  isVideoCall: false,
                  onEndCall: () {},
                ),
                minimizedChild: CallOverlayDialogMinimized(
                  createdTime: DateTime.now(),
                  name: 'Testy',
                  isVideoCall: false,
                  onEndCall: () {},
                ),
              );
              overlayController.add(key.toString(), overlayData);
            },
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              overlayController.remove(key.toString());
              key--;
            },
            tooltip: 'Remove',
            child: const Icon(Icons.remove),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
