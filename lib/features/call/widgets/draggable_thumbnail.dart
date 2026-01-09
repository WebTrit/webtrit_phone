import 'package:flutter/material.dart';

/// Defines the horizontal side of the screen that the thumbnail should snap to
/// when it is released.
///
/// - [StickySide.left] snaps the thumbnail to the left edge of the screen.
/// - [StickySide.right] snaps the thumbnail to the right edge of the screen.
enum StickySide { left, right }

/// A widget that enables its [child] to be dragged freely within the safe
/// area and snaps horizontally to the nearest screen edge upon release.
///
/// Designed to be used as a direct child of a [Stack]; it depends on
/// [AnimatedPositioned] for animated layout and coordinate management.
class DraggableThumbnail extends StatefulWidget {
  /// Creates a [DraggableThumbnail].
  ///
  /// The [child] and [stickyPadding] parameters are required.
  const DraggableThumbnail({
    super.key,

    /// The widget displayed inside the draggable thumbnail.
    ///
    /// This is the visual content (for example, a video preview or avatar) that
    /// the user sees and can drag around.
    required this.child,

    /// Padding that defines the draggable and sticky area around the edges.
    ///
    /// The thumbnail will not move beyond the bounds given by this padding and
    /// will snap to the left or right side within these insets.
    required this.stickyPadding,

    /// The horizontal side the thumbnail should stick to by default.
    ///
    /// Used when no explicit [initialOffset] is provided, or as a fallback
    /// side when the widget needs to decide which edge to snap to.
    this.initialStickySide = StickySide.right,

    /// The initial offset of the thumbnail relative to the top-left corner.
    ///
    /// If provided, this offset determines the starting position of the
    /// thumbnail before any drag operations. If omitted, [initialStickySide]
    /// and [stickyPadding] are used to compute a default position.
    this.initialOffset,

    /// Callback invoked whenever the thumbnail's offset is updated.
    ///
    /// The [Offset] contains the current position of the thumbnail, which can
    /// be used to persist or react to its location.
    this.onOffsetUpdate,

    /// Callback invoked when the thumbnail is tapped.
    ///
    /// This is triggered in addition to the drag interaction and can be used
    /// to, for example, maximize or open the related content.
    this.onTap,
  });

  /// The widget displayed inside the draggable thumbnail.
  final Widget child;

  /// Padding that constrains where the thumbnail can be dragged and stick.
  final EdgeInsets stickyPadding;

  /// The horizontal side to which the thumbnail prefers to stick initially.
  final StickySide initialStickySide;

  /// The initial position of the thumbnail, if explicitly provided.
  final Offset? initialOffset;

  /// Called whenever the thumbnail's offset changes as a result of dragging.
  final void Function(Offset details)? onOffsetUpdate;

  /// Called when the thumbnail is tapped.
  final GestureTapCallback? onTap;

  @override
  State<DraggableThumbnail> createState() => _DraggableThumbnailState();
}

class _DraggableThumbnailState extends State<DraggableThumbnail> {
  final _thumbnailKey = GlobalKey();
  bool _dragging = false;

  late EdgeInsets _mediaQueryPadding;
  late Size _mediaQuerySize;
  late Rect _activeRect;
  late Rect _stickyRect;
  StickySide? _lastStickySide;
  Offset? _offset;

  @override
  void initState() {
    super.initState();

    _offset = widget.initialOffset;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _mediaQueryPadding = MediaQuery.paddingOf(context);
    _mediaQuerySize = MediaQuery.sizeOf(context);
    _activeRect = _mediaQueryPadding.deflateRect(Offset.zero & _mediaQuerySize);
    _stickyRect = widget.stickyPadding.deflateRect(_activeRect);

    if (_offset != null && !_dragging) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final thumbnailRect = _findThumbnailRect();
        final translateX = _lastStickTranslateX(_stickyRect, thumbnailRect);
        final translateY = _boundTranslateY(_stickyRect, thumbnailRect);
        final offset = thumbnailRect.translate(translateX, translateY).topLeft;

        if (_offset != offset) {
          widget.onOffsetUpdate?.call(offset);
          setState(() {
            _offset = offset;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double? left, top, right;
    {
      final offset = _offset;
      if (offset == null) {
        final initialPadding = widget.stickyPadding + _mediaQueryPadding;
        switch (widget.initialStickySide) {
          case StickySide.left:
            left = initialPadding.left;
            top = initialPadding.top;
            right = null;

          case StickySide.right:
            left = null;
            top = initialPadding.top;
            right = initialPadding.right;
        }
      } else {
        left = offset.dx;
        top = offset.dy;
        right = null;
      }
    }

    return AnimatedPositioned(
      key: _thumbnailKey,
      left: left,
      top: top,
      right: right,
      curve: Curves.ease,
      duration: _dragging ? Duration.zero : kRadialReactionDuration,
      child: GestureDetector(
        onTap: widget.onTap,
        onPanStart: (details) {
          // Sync state with actual render position before starting the drag
          final startRect = _findThumbnailRect();
          // Validation: Prevent jumping to (0,0) if the render box is invalid or not found.
          if (startRect.isEmpty) return;

          setState(() {
            _offset = startRect.topLeft;
            _dragging = true;
          });
        },
        onPanUpdate: (details) {
          // Guard: Ensure a valid base offset (set in onPanStart) is present before applying the delta.
          if (_offset == null) return;

          // Calculate new position based on state + delta (ignoring render lag)
          final currentSize = _thumbnailKey.currentContext?.size;
          if (currentSize == null || currentSize.isEmpty) {
            // Size is not yet available; skip this update to avoid invalid bounds
            return;
          }

          // Calculate the proposed new position by applying the user's drag delta to the current state.
          final tentativeOffset = _offset! + details.delta;

          // Create a rectangle for this proposed position to check for boundary collisions.
          final tentativeRect = tentativeOffset & currentSize;

          // Calculate correction offsets (if any) to ensure the widget stays within the screen's safe area (_activeRect).
          final translateX = _boundTranslateX(_activeRect, tentativeRect);
          final translateY = _boundTranslateY(_activeRect, tentativeRect);

          // Apply the boundary corrections to the proposed rectangle to determine the final, valid top-left position.
          final finalOffset = tentativeRect.translate(translateX, translateY).topLeft;

          widget.onOffsetUpdate?.call(finalOffset);
          setState(() {
            _offset = finalOffset;
          });
        },
        onPanEnd: (details) {
          // Retrieve the render object to obtain the current size for snapping calculations.
          final renderBox = _thumbnailKey.currentContext?.findRenderObject() as RenderBox?;
          // Validation: If the widget is unmounted or has no size,
          // snapping cannot be calculated correctly. Stop the panning state to reset animations.
          if (renderBox == null || !renderBox.hasSize || renderBox.size.isEmpty) {
            setState(() {
              _dragging = false;
            });
            return;
          }

          // Calculate snapping based on the final dragged position
          final currentSize = renderBox.size;

          // Construct the rectangle representing the widget's position at the moment of release.
          // Use _offset (the last tracked position) combined with the widget's actual size.
          final currentRect = (_offset ?? Offset.zero) & currentSize;

          // Calculate the translation needed to snap the widget to the nearest side (horizontal)
          // and ensure it stays within the safe vertical boundaries.
          final translateX = _stickTranslateX(_stickyRect, currentRect);
          final translateY = _boundTranslateY(_stickyRect, currentRect);

          // Apply the calculated X (snap) and Y (bound) shifts to find the final top-left coordinate.
          final offset = currentRect.translate(translateX, translateY).topLeft;

          widget.onOffsetUpdate?.call(offset);
          setState(() {
            _offset = offset;
            _dragging = false;
          });
        },
        child: widget.child,
      ),
    );
  }

  Rect _findThumbnailRect() {
    final thumbnailContext = _thumbnailKey.currentContext;
    if (thumbnailContext == null) return Rect.zero;

    final thumbnailRenderBox = thumbnailContext.findRenderObject() as RenderBox?;
    if (thumbnailRenderBox == null || !thumbnailRenderBox.hasSize) return Rect.zero;

    final offset = thumbnailRenderBox.localToGlobal(Offset.zero);
    final size = thumbnailRenderBox.size;

    return Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
  }

  double _stickTranslateX(Rect stickyRect, Rect translateRect) {
    if (translateRect.center.dx < stickyRect.center.dx) {
      _lastStickySide = StickySide.left;
      return stickyRect.left - translateRect.left;
    } else {
      _lastStickySide = StickySide.right;
      return stickyRect.right - translateRect.right;
    }
  }

  double _lastStickTranslateX(Rect stickyRect, Rect translateRect) {
    switch (_lastStickySide) {
      case StickySide.left:
        return stickyRect.left - translateRect.left;
      case StickySide.right:
        return stickyRect.right - translateRect.right;
      default:
        return 0;
    }
  }

  double _boundTranslateX(Rect boundRect, Rect translateRect) {
    if (boundRect.left > translateRect.left) {
      return boundRect.left - translateRect.left;
    } else if (boundRect.right < translateRect.right) {
      return boundRect.right - translateRect.right;
    } else {
      return 0;
    }
  }

  double _boundTranslateY(Rect boundRect, Rect translateRect) {
    if (boundRect.top > translateRect.top) {
      return boundRect.top - translateRect.top;
    } else if (boundRect.bottom < translateRect.bottom) {
      return boundRect.bottom - translateRect.bottom;
    } else {
      return 0;
    }
  }
}
