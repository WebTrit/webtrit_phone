import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/call/call.dart';

class DemoActionOverlay {
  DemoActionOverlay({
    required this.screenSize,
    required this.safePadding,
    required this.stickyPadding,
    GestureTapCallback? onTap,
  });

  static const _converterCardSize = Size(120, 120);
  static const _stickyPadding = EdgeInsets.all(8);

  final Size screenSize;
  final EdgeInsets safePadding;

  final EdgeInsets stickyPadding;

  Offset? _offset;
  OverlayEntry? _entry;

  bool get inserted => _entry != null;

  void insert({
    required BuildContext context,
    required Widget child,
    GestureTapCallback? onTap,
  }) {
    if (inserted) return;

    _entry = OverlayEntry(
      builder: (context) => DraggableThumbnail(
        stickyPadding: stickyPadding,
        initialOffset: _offset ?? _calculateButtonOffset(),
        onOffsetUpdate: (offset) => _offset = offset,
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints.tight(_converterCardSize),
          child: child,
        ),
      ),
    );

    Overlay.of(context).insert(_entry!);
  }

  void remove() {
    _entry?.remove();
    _entry = null;
  }

  Offset _calculateButtonOffset() {
    const bottomBarHeight = kBottomNavigationBarHeight;
    final cardAndPadding = _converterCardSize.height + _stickyPadding.bottom;
    final totalHeight = screenSize.height - bottomBarHeight - safePadding.bottom;

    return Offset(
      screenSize.width - _converterCardSize.width - _stickyPadding.right,
      totalHeight - cardAndPadding,
    );
  }
}
