import 'package:flutter/widgets.dart';

import 'overlay_collision_utils.dart';
import 'overlay_config.dart';
import 'overlay_position.dart';
import 'offset_extension.dart';

class OverlayEntryData {
  OverlayEntryData({
    required Widget child,
    required Offset offset,
    required OverlayConfig config,
    Widget? minimizedChild,
  })  : _offset = offset,
        _config = config {
    entry = _createOverlayEntry(minimizedChild, child);
  }

  Widget? widget;
  OverlayEntry? entry;

  Offset _offset;
  OverlayPosition _overlayPosition = OverlayPosition.center;

  final OverlayCollisionUtils _collisionUtils = OverlayCollisionUtils();
  final OverlayConfig _config;

  get config => _config;

  get offset => _offset;

  get position => _overlayPosition;

  void removeOverlayIfExit() {
    entry?.remove();
    entry?.dispose();
    entry = null;
  }

  OverlayEntry _createOverlayEntry(Widget? minimizedChild, Widget child) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: _offset.dy,
        left: _offset.dx,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: (details) => _config.draggability ? _updateOverlayOffset(entry!, details, context) : null,
          child: ConstrainedBox(
            constraints: _prepareConstraints(),
            child: _prepareOverlayWidget(child, minimizedChild),
          ),
        ),
      ),
    );
  }

  BoxConstraints _prepareConstraints() {
    return _overlayPosition != OverlayPosition.center
        ? _config.overlayEntityConstraintsMinimized ?? _config.overlayEntityConstraints
        : _config.overlayEntityConstraints;
  }

  Widget _prepareOverlayWidget(
    Widget child,
    Widget? minimizedChild,
  ) {
    assert(
        !(minimizedChild != null && _config.overlayEntityConstraintsMinimized == null ||
            minimizedChild == null && _config.overlayEntityConstraintsMinimized != null),
        'For a minimized widget, the size must be specified in the config');

    return _overlayPosition == OverlayPosition.center || minimizedChild == null
        ? child
        : ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(_overlayPosition == OverlayPosition.left ? 0 : _config.clipRadius),
              right: Radius.circular(_overlayPosition == OverlayPosition.right ? 0 : _config.clipRadius),
            ),
            child: minimizedChild,
          );
  }

  void _updateOverlayOffset(OverlayEntry overlayEntry, DragUpdateDetails details, BuildContext context) {
    final overlayWidth = _config.overlayEntityConstraints.maxWidth;
    final overlayHeight = _config.overlayEntityConstraints.maxHeight;

    final topLeftPosition = _offset + details.delta;
    final topRightPosition = topLeftPosition + Offset(overlayWidth, 0);
    final bottomPosition = topLeftPosition + Offset(0, overlayHeight);

    final screenBound = MediaQuery.of(context).size;

    if (_config.overlayEntityConstraintsMinimized != null) {
      final overlayWidthMinimized = _config.overlayEntityConstraintsMinimized?.maxWidth;
      final topRightPositionMinimized = _offset + details.delta + Offset(overlayWidthMinimized!, 0);

      final collision = _collisionUtils.calculateCollisionForMinimizedState(
        screenBound: screenBound,
        offset: _offset,
        delta: details.delta,
        bottomPosition: bottomPosition,
        topRightPosition: topRightPosition,
        topLeftPosition: topLeftPosition,
        topRightPositionMinimized: topRightPositionMinimized,
        overlayWidth: overlayWidth,
        overlayHeight: overlayHeight,
        overlayWidthMinimized: overlayWidthMinimized,
        sticking: _config.sticking,
        position: _overlayPosition,
      );

      _offset = collision.$1;
      _overlayPosition = collision.$2;
    } else {
      final collision = _collisionUtils.calculateCollision(
        screenBound: screenBound,
        offset: _offset,
        delta: details.delta,
        bottomPosition: bottomPosition,
        topRightPosition: topRightPosition,
        topLeftPosition: topLeftPosition,
        overlayWidth: overlayWidth,
        overlayHeight: overlayHeight,
        sticking: _config.sticking,
      );

      _offset = collision.$1;
      _overlayPosition = collision.$2;
    }
    overlayEntry.markNeedsBuild();
  }
}
