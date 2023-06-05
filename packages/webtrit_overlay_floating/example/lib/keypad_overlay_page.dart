import 'package:flutter/material.dart';

import 'package:webtrit_overlay_floating/webtrit_overlay_floating.dart';

import 'dialogs/keypad_overlay_dialog.dart';

class KeypadOverlayPage extends StatefulWidget {
  const KeypadOverlayPage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<KeypadOverlayPage> createState() => _KeypadOverlayPageState();
}

class _KeypadOverlayPageState extends State<KeypadOverlayPage> {
  late Offset _callOverlayEntityPositionDefault;

  OverlayController overlayController = OverlayController();
  late OverlayConfig overlayConfig = OverlayConfig(
    overlayEntityConstraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: MediaQuery.of(context).size.height - 300,
    ),
    draggability: false,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _regenerateDefaultPosition();
    });
  }

  void _regenerateDefaultPosition() {
    _callOverlayEntityPositionDefault = const Offset(0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverlayWidget(
        controller: overlayController,
        child: widget.child,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              _regenerateDefaultPosition();
              final overlayData = OverlayEntryData(
                offset: _callOverlayEntityPositionDefault,
                config: overlayConfig,
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 300,
                  child: const Center(
                    child: SizedBox(
                      width: 400,
                      height: 500,
                      child: KeypadOverlayDialog(),
                    ),
                  ),
                ),
              );
              overlayController.add("Keypad", overlayData);
            },
            tooltip: 'Add',
            child: const Icon(Icons.key),
          ),
          const SizedBox(
            width: 32,
          ),
          FloatingActionButton(
            onPressed: () {
              overlayController.remove("Keypad");
            },
            tooltip: '',
            child: const Icon(Icons.key_off),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
