import 'package:flutter/material.dart';
import 'package:webtrit_overlay_floating/src/offset_extension.dart';
import 'package:webtrit_overlay_floating/src/overlay_position.dart';

class OverlayCollisionUtils {
  (Offset, OverlayPosition) calculateCollisionForMinimizedState({
    required Size screenBound,
    required Offset offset,
    required Offset delta,
    required Offset bottomPosition,
    required Offset topRightPosition,
    required Offset topLeftPosition,
    required Offset topRightPositionMinimized,
    required double overlayWidth,
    required double overlayHeight,
    required double overlayWidthMinimized,
    required double sticking,
    required OverlayPosition position,
  }) {
    var outputOffset = offset + delta;

    final isMinimized = position != OverlayPosition.center;
    final distanceToRight = screenBound.width - (isMinimized ? topRightPositionMinimized.dx : topRightPosition.dx);

    // Collision check for left side
    if (topLeftPosition.dx <= sticking) {
      outputOffset = outputOffset.copyWith(dx: 0);
      position = OverlayPosition.left;
    }
    // Collision check for top side
    if (topLeftPosition.dy <= sticking) {
      outputOffset = outputOffset.copyWith(dy: sticking);
    }

    // Collision check for the right side
    if (distanceToRight <= sticking) {
      outputOffset = outputOffset.copyWith(dx: screenBound.width - overlayWidthMinimized);
      position = OverlayPosition.right;
    }

    // Collision check for bottom side
    if (bottomPosition.dy >= screenBound.height) {
      outputOffset = outputOffset.copyWith(dy: screenBound.height - overlayHeight);
    }

    // Check whether the overlay has no collision with parties
    if (topLeftPosition.dx > sticking && distanceToRight > sticking) {
      // We check if it was sticking to the right side, if so we compensate the difference for normal logic
      if (position == OverlayPosition.right) {
        outputOffset = offset + delta - Offset(overlayWidth - overlayWidthMinimized, 0);
      }
      position = OverlayPosition.center;
    }

    return (outputOffset, position);
  }

  (Offset, OverlayPosition) calculateCollision({
    required Size screenBound,
    required Offset offset,
    required Offset delta,
    required Offset bottomPosition,
    required Offset topRightPosition,
    required Offset topLeftPosition,
    required double overlayWidth,
    required double overlayHeight,
    required double sticking,
  }) {
    final distanceToRight = screenBound.width - topRightPosition.dx;

    var outputOffset = offset + delta;
    var position = OverlayPosition.center;

    // Collision check for left side
    if (topLeftPosition.dx <= sticking) {
      outputOffset = topLeftPosition.copyWith(dx: 0);
      position = OverlayPosition.left;
    }
    // Collision check for top side
    if (topLeftPosition.dy <= 0) {
      outputOffset = outputOffset.copyWith(dy: 0);
    }

    // Collision check for the right side
    if (distanceToRight <= sticking) {
      outputOffset = outputOffset.copyWith(dx: screenBound.width - overlayWidth);
      position = OverlayPosition.right;
    }

    // Collision check for bottom side
    if (bottomPosition.dy >= screenBound.height) {
      outputOffset = outputOffset.copyWith(dy: screenBound.height - overlayHeight);
    }

    // Check whether the overlay has no collision with parties
    if (topLeftPosition.dx > sticking && distanceToRight > sticking) {
      outputOffset = outputOffset.copyWith(dx: offset.dx + delta.dx);
      position = OverlayPosition.center;
    }

    return (outputOffset, position);
  }
}
