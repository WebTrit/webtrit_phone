import 'package:flutter/material.dart';

import 'demo_action_overlay.dart';

class DemoActionOverlayController {
  DemoActionOverlayController(this.context)
      : _screenSize = MediaQuery.of(context).size,
        _safePadding = MediaQuery.of(context).padding;

  static const _converterCardSize = Size(120, 120);
  static const _stickyPadding = EdgeInsets.all(8);

  final Map<String, DemoActionOverlay> _convertButtons = {};

  final BuildContext context;
  final Size _screenSize;
  final EdgeInsets _safePadding;

  void addOverlay({
    required String id,
    required Widget child,
    required VoidCallback onTap,
  }) {
    if (_convertButtons[id] != null && !_convertButtons[id]!.visible) {
      _convertButtons[id]!.show(context);
      return;
    }

    final index = _convertButtons.values.where((it) => it.visible).length;
    final offset = _calculateButtonOffset(index);

    final widget = Container(
      constraints: BoxConstraints.tight(_converterCardSize),
      child: child,
    );

    final button = DemoActionOverlay(
      stickyPadding: _stickyPadding,
      offset: offset,
      size: _converterCardSize,
      onTap: onTap,
      child: widget,
    );

    _convertButtons[id] = button;
    button.insert(context);
  }

  void hideAllOverlay() {
    for (var button in _convertButtons.values) {
      button.hide();
    }
  }

  void removeAllOverlay() {
    for (var button in _convertButtons.values) {
      button.remove();
    }
    _convertButtons.clear();
  }

  Offset _calculateButtonOffset(int index) {
    const bottomBarHeight = kBottomNavigationBarHeight;
    final cardAndPadding = _converterCardSize.height + _stickyPadding.bottom;

    final yOffset = cardAndPadding * index;
    final totalHeight = _screenSize.height - bottomBarHeight - _safePadding.bottom;

    return Offset(
      _screenSize.width - _converterCardSize.width - _stickyPadding.right,
      totalHeight - yOffset - cardAndPadding,
    );
  }
}
