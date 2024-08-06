import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/call/call.dart';

class DemoActionOverlay {
  DemoActionOverlay({
    required this.child,
    required this.stickyPadding,
    required this.size,
    this.onTap,
    Offset? offset,
  })  : _offset = offset,
        _visible = true;

  final Widget child;

  final EdgeInsets stickyPadding;
  final GestureTapCallback? onTap;
  final Size size;

  Offset? _offset;
  OverlayEntry? _entry;
  bool _visible;

  bool get inserted => _entry != null;

  bool get visible => _visible;

  void insert(BuildContext context) {
    if (inserted) return;

    _entry = OverlayEntry(
      builder: (context) => DraggableThumbnail(
        stickyPadding: stickyPadding,
        initialOffset: _offset,
        onOffsetUpdate: (offset) => _offset = offset,
        onTap: onTap,
        child: child,
      ),
    );
    Overlay.of(context).insert(_entry!);
  }

  void remove() {
    _entry?.remove();
    _entry = null;
  }

  void hide() {
    remove();
    _visible = false;
  }

  void show(BuildContext context) {
    _visible = true;
    if (_offset != null) {
      insert(context);
    }
  }
}
