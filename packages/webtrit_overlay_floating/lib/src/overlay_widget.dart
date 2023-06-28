import 'package:flutter/widgets.dart';

import 'overlay_entry_data.dart';

typedef OverlayAddCallback = void Function(String id, OverlayEntryData overlayEntryData);
typedef OverlayRemoveCallback = void Function(String id);
typedef OverlayDisposeAllCallback = void Function();

class OverlayController {
  OverlayAddCallback? _overlayAddCallback;
  OverlayRemoveCallback? _overlayRemoveCallback;
  OverlayDisposeAllCallback? _overlayDisposeAllCallback;

  set setOverlayAddCallback(OverlayAddCallback? value) => _overlayAddCallback = value;

  set setOverlayRemoveCallback(OverlayRemoveCallback? value) => _overlayRemoveCallback = value;

  set setOverlayDisposeAllCallback(OverlayDisposeAllCallback? value) => _overlayDisposeAllCallback = value;

  void add(String id, OverlayEntryData overlayEntryData) => _overlayAddCallback?.call(id, overlayEntryData);

  void remove(String id) => _overlayRemoveCallback?.call(id);

  void disposeAll() => _overlayDisposeAllCallback?.call();
}

class OverlayWidget extends StatefulWidget {
  const OverlayWidget({
    super.key,
    required this.child,
    required this.controller,
  });

  final Widget child;
  final OverlayController controller;

  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  final _overlayEntries = <String, OverlayEntryData>{};

  @override
  void initState() {
    widget.controller.setOverlayAddCallback = _addOverlayCall;
    widget.controller.setOverlayRemoveCallback = _removeOverlay;
    widget.controller.setOverlayDisposeAllCallback = _disposeAllOverlay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _overlayEntries.clear();
    _disposeAllOverlay();
    super.dispose();
  }

  void _disposeAllOverlay() {
    _overlayEntries.forEach((key, value) {
      value.removeOverlayIfExit();
    });
  }

  void _addOverlayCall(String id, OverlayEntryData overlayEntryData) {
    OverlayEntryData overlayData;

    setState(() {
      if (_overlayEntries.containsKey(id)) {
        overlayData = _overlayEntries[id]!;
      } else {
        overlayData = overlayEntryData;
        _overlayEntries[id] = overlayData;
      }
      Overlay.of(context).insert(overlayData.entry!);
    });
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
}
