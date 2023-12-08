import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Unfocuser extends StatefulWidget {
  const Unfocuser({
    super.key,
    this.child,
    this.minScrollDistanceToIgnore = 10.0,
  });

  final Widget? child;
  final double minScrollDistanceToIgnore;

  @override
  UnfocuserState createState() => UnfocuserState();
}

class UnfocuserState extends State<Unfocuser> {
  Offset? _touchStartPosition;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) {
        _touchStartPosition = e.position;
      },
      onPointerUp: (e) {
        var touchStopPosition = e.position;
        if (widget.minScrollDistanceToIgnore > 0.0 && _touchStartPosition != null) {
          var difference = _touchStartPosition! - touchStopPosition;
          _touchStartPosition = null;
          if (difference.distance > widget.minScrollDistanceToIgnore) {
            return;
          }
        }

        var rb = context.findRenderObject() as RenderBox;
        var result = BoxHitTestResult();
        rb.hitTest(result, position: touchStopPosition);

        if (result.path.any((entry) => entry.target.runtimeType == IgnoreUnfocuserRenderBox)) {
          return;
        }

        primaryFocus?.unfocus();
      },
      child: widget.child,
    );
  }
}

class IgnoreUnfocuser extends SingleChildRenderObjectWidget {
  const IgnoreUnfocuser({super.key, super.child});

  @override
  IgnoreUnfocuserRenderBox createRenderObject(BuildContext context) {
    return IgnoreUnfocuserRenderBox();
  }
}

class IgnoreUnfocuserRenderBox extends RenderPointerListener {}
