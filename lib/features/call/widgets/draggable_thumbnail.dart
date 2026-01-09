import 'package:flutter/material.dart';

enum StickySide { left, right }

class DraggableThumbnail extends StatefulWidget {
  const DraggableThumbnail({
    super.key,
    required this.child,
    required this.stickyPadding,
    this.initialStickySide = StickySide.right,
    this.initialOffset,
    this.onOffsetUpdate,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets stickyPadding;
  final StickySide initialStickySide;
  final Offset? initialOffset;
  final void Function(Offset details)? onOffsetUpdate;
  final GestureTapCallback? onTap;

  @override
  State<DraggableThumbnail> createState() => _DraggableThumbnailState();
}

class _DraggableThumbnailState extends State<DraggableThumbnail> {
  final _callCardKey = GlobalKey();
  bool _callCardPanning = false;

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

    if (_offset != null && !_callCardPanning) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final callCardRect = _findCallCardRect();
        final translateX = _lastStickTranslateX(_stickyRect, callCardRect);
        final translateY = _boundTranslateY(_stickyRect, callCardRect);
        final offset = callCardRect.translate(translateX, translateY).topLeft;

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
      key: _callCardKey,
      left: left,
      top: top,
      right: right,
      curve: Curves.ease,
      duration: _callCardPanning ? Duration.zero : kRadialReactionDuration,
      child: GestureDetector(
        onTap: widget.onTap,
        onPanStart: (details) {
          // Sync state with actual render position before starting the drag
          final startRect = _findCallCardRect();
          // Validation: Prevent jumping to (0,0) if the render box is invalid or not found.
          if (startRect.isEmpty) return;

          setState(() {
            _offset = startRect.topLeft;
            _callCardPanning = true;
          });
        },
        onPanUpdate: (details) {
          // Guard: Ensure a valid base offset (set in onPanStart) is present before applying the delta.
          if (_offset == null) return;

          // Calculate new position based on state + delta (ignoring render lag)
          final currentSize = _callCardKey.currentContext?.size;
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
          final renderBox = _callCardKey.currentContext?.findRenderObject() as RenderBox?;
          // Validation: If the widget is unmounted or has no size,
          // snapping cannot be calculated correctly. Stop the panning state to reset animations.
          if (renderBox == null || !renderBox.hasSize || renderBox.size.isEmpty) {
            setState(() {
              _callCardPanning = false;
            });
            return;
          }

          // Calculate snapping based on the final dragged position
          final currentSize = renderBox.size;

          // Construct the rectangle representing the widget's position at the moment of release.
          // Use _offset (the last tracked position) combined with the widget's actual size.
          final currentRect = (_offset ?? Offset.zero) & currentSize;

          // Calculate the translation needed to snap the widget to the nearest side (horizontal)
          // and ensure it stays within the safe vertical boundaries..
          final translateX = _stickTranslateX(_stickyRect, currentRect);
          final translateY = _boundTranslateY(_stickyRect, currentRect);

          // Apply the calculated X (snap) and Y (bound) shifts to find the final top-left coordinate.
          final offset = currentRect.translate(translateX, translateY).topLeft;

          widget.onOffsetUpdate?.call(offset);
          setState(() {
            _offset = offset;
            _callCardPanning = false;
          });
        },
        child: widget.child,
      ),
    );
  }

  Rect _findCallCardRect() {
    final callCardContext = _callCardKey.currentContext;
    if (callCardContext == null) return Rect.zero;

    final callCardRenderBox = callCardContext.findRenderObject() as RenderBox?;
    if (callCardRenderBox == null || !callCardRenderBox.hasSize) return Rect.zero;

    final offset = callCardRenderBox.localToGlobal(Offset.zero);
    final size = callCardRenderBox.size;

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
