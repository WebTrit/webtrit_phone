import 'package:flutter/widgets.dart';

import 'overlay_config.dart';
import 'overlay_position.dart';
import 'offset_extension.dart';

class OverlayEntryData {
  OverlayEntryData({
    required Widget child,
    required this.offset,
    this.config = const OverlayConfig(),
    Widget? minimizedChild,
  }) {
    entry = _createOverlayEntry(minimizedChild, child);
  }

  Widget? widget;

  Offset offset;
  OverlayEntry? entry;

  OverlayPosition overlayPosition = OverlayPosition.center;

  OverlayConfig config;

  void removeOverlayIfExit() {
    entry?.remove();
    entry?.dispose();
    entry = null;
  }

  OverlayEntry _createOverlayEntry(Widget? minimizedChild, Widget child) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy,
        left: offset.dx,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: (details) => _updateOverlayOffset(entry!, details, context),
          child: ConstrainedBox(
            constraints: _prepareConstraints(),
            child: _prepareOverlayWidget(minimizedChild, child),
          ),
        ),
      ),
    );
  }

  BoxConstraints _prepareConstraints() {
    return overlayPosition != OverlayPosition.center
        ? config.overlayEntityConstraintsMinimized
        : config.overlayEntityConstraints;
  }

  Widget _prepareOverlayWidget(Widget? minimizedChild, Widget child) {
    return overlayPosition != OverlayPosition.center
        ? ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(overlayPosition == OverlayPosition.left ? 0 : config.clipRadius),
              right: Radius.circular(overlayPosition == OverlayPosition.right ? 0 : config.clipRadius),
            ),
            child: minimizedChild ?? child,
          )
        : child;
  }

  void _updateOverlayOffset(OverlayEntry overlayEntry, DragUpdateDetails details, BuildContext context) {
    final overlayWidth = config.overlayEntityConstraints.maxWidth;
    final overlayHeight = config.overlayEntityConstraints.maxWidth;
    final overlayWidthMinimized = config.overlayEntityConstraintsMinimized.maxWidth;

    final topLeftPosition = offset + details.delta;
    final topRightPosition = topLeftPosition + Offset(overlayWidth, 0);
    final bottomPosition = topLeftPosition + Offset(0, overlayHeight);

    final topRightPositionMinimized = offset + details.delta + Offset(overlayWidthMinimized, 0);

    final screenBound = MediaQuery.of(context).size;

    final isMinimized = overlayPosition != OverlayPosition.center;
    final distanceToRight = screenBound.width - (isMinimized ? topRightPositionMinimized.dx : topRightPosition.dx);

    var outputOffset = offset + details.delta;

    // Collision check for left side
    if (topLeftPosition.dx <= config.sticking) {
      outputOffset = topLeftPosition.copyWith(dx: 0);
      overlayPosition = OverlayPosition.left;
    }
    // Collision check for top side
    if (topLeftPosition.dy <= 0) {
      outputOffset = outputOffset.copyWith(dy: 0);
    }

    // Collision check for the right side
    if (distanceToRight <= config.sticking) {
      outputOffset = topRightPosition.copyWith(dx: screenBound.width - overlayWidthMinimized);
      overlayPosition = OverlayPosition.right;
    }

    // Collision check for bottom side
    if (bottomPosition.dy >= screenBound.height) {
      outputOffset = outputOffset.copyWith(dy: screenBound.height - overlayHeight);
    }

    // Check whether the overlay has no collision with parties
    if (topLeftPosition.dx > config.sticking && distanceToRight > config.sticking) {
      // We check if it was sticking to the right side, if so we compensate the difference for normal logic
      if (overlayPosition == OverlayPosition.right) {
        outputOffset = offset + details.delta - Offset(overlayWidth - overlayWidthMinimized, 0);
      }
      overlayPosition = OverlayPosition.center;
    }

    offset = outputOffset;
    overlayEntry.markNeedsBuild();
  }
}
