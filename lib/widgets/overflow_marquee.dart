import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

/// Reveals a child that is wider than the space it was given by sliding it
/// sideways and back.
///
/// A single-line caption that does not fit is normally cut with an ellipsis,
/// which hides exactly the part the reader needs. Wrapping it here keeps the
/// row one line high and still shows the whole text: the content waits, travels
/// until its far end is visible, waits again and returns.
///
/// Nothing moves while the child fits, so the wrapper is free to sit on text
/// that only overflows in some translations. It also steps aside entirely when
/// the platform asks for reduced motion - the child is then laid out normally
/// and clips itself the way it would without the wrapper.
///
/// The travel repeats for as long as the child is on screen, deliberately: a
/// reader who arrives at the screen a minute later has the same claim on the
/// hidden part of the caption as the one who was there when it was built. The
/// cost is a repaint of the caption per frame, which is why the offset is
/// applied while painting and the strip has a repaint boundary of its own.
///
/// The child is measured at its own width, so it has to be content that has
/// one: a single-line [Text], a row of chips, an icon and a label. Anything
/// that expands to fill what it is offered - [Expanded], a [Row] with flex
/// children, `width: double.infinity` - has no natural width to measure and
/// fails against unbounded constraints.
class OverflowMarquee extends StatefulWidget {
  const OverflowMarquee({super.key, required this.child, this.velocity = 24.0, this.pause = const Duration(seconds: 2)})
    : assert(velocity > 0, 'velocity must be positive');

  final Widget child;

  /// Travel speed in logical pixels per second. Constant speed rather than a
  /// constant duration, so a caption that barely overflows does not crawl
  /// while a long one races.
  final double velocity;

  /// Hold at each end, giving the reader time to read what just arrived.
  final Duration pause;

  @override
  State<OverflowMarquee> createState() => _OverflowMarqueeState();
}

class _OverflowMarqueeState extends State<OverflowMarquee> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this)..addStatusListener(_onStatusChanged);

  Timer? _pauseTimer;
  double _overflow = 0.0;
  bool _motionAllowed = true;

  bool get _canRun => mounted && _overflow > 0 && _motionAllowed;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final motionAllowed = !MediaQuery.disableAnimationsOf(context);
    if (motionAllowed == _motionAllowed) return;
    _motionAllowed = motionAllowed;
    _restart();
  }

  @override
  void didUpdateWidget(OverflowMarquee oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.velocity != oldWidget.velocity || widget.pause != oldWidget.pause) _restart();
  }

  @override
  void dispose() {
    _pauseTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// Reported from layout: how much of the child stays out of sight.
  void _onOverflowChanged(double overflow) {
    if (overflow == _overflow) return;
    setState(() => _overflow = overflow);
    _restart();
  }

  void _restart() {
    _controller.stop();
    _controller.value = 0;
    _schedulePass();
  }

  void _schedulePass() {
    _pauseTimer?.cancel();
    if (!_canRun) return;
    _pauseTimer = Timer(widget.pause, _startPass);
  }

  void _startPass() {
    if (!_canRun) return;
    _controller.duration = Duration(milliseconds: math.max(1, (_overflow / widget.velocity * 1000).round()));
    if (_controller.value == 0) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _onStatusChanged(AnimationStatus status) {
    if (status.isAnimating) return;
    _schedulePass();
  }

  @override
  Widget build(BuildContext context) {
    // Out of the way when motion is off: the child keeps its own overflow
    // treatment instead of being clipped by a wrapper that cannot move.
    if (!_motionAllowed) return widget.child;

    return ClipRect(
      // The travel repaints on every frame; the row, the list and the screen
      // around it have no reason to repaint with it.
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) =>
              _MarqueeViewport(progress: _controller.value, onOverflowChanged: _onOverflowChanged, child: child!),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Lays the child out at its natural width, keeps the width it was given and
/// shifts the child by [progress] of whatever sticks out.
class _MarqueeViewport extends SingleChildRenderObjectWidget {
  const _MarqueeViewport({required this.progress, required this.onOverflowChanged, required Widget super.child});

  final double progress;
  final ValueChanged<double> onOverflowChanged;

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderMarqueeViewport(
    progress: progress,
    onOverflowChanged: onOverflowChanged,
    textDirection: Directionality.of(context),
  );

  @override
  void updateRenderObject(BuildContext context, _RenderMarqueeViewport renderObject) {
    renderObject
      ..progress = progress
      ..onOverflowChanged = onOverflowChanged
      ..textDirection = Directionality.of(context);
  }
}

class _RenderMarqueeViewport extends RenderShiftedBox {
  _RenderMarqueeViewport({
    required double progress,
    required this.onOverflowChanged,
    required TextDirection textDirection,
  }) : _progress = progress,
       _textDirection = textDirection,
       super(null);

  double _progress;

  /// A frame of the travel only moves an already measured child, so it repaints
  /// instead of laying out again. Through layout it would dirty the row, the
  /// list and the viewport above it on every single tick.
  set progress(double value) {
    if (_progress == value) return;
    _progress = value;
    markNeedsPaint();
  }

  ValueChanged<double> onOverflowChanged;

  TextDirection _textDirection;

  set textDirection(TextDirection value) {
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsPaint();
  }

  double _overflow = 0.0;
  double _reportedOverflow = 0.0;

  /// How far the child is currently pushed out of the visible strip.
  Offset get _shift {
    final travelled = _overflow * _progress.clamp(0.0, 1.0);
    // The text reads from its start, so that end is the one on screen at rest:
    // left in a left-to-right layout, right in a right-to-left one.
    return Offset(_textDirection == TextDirection.rtl ? travelled - _overflow : -travelled, 0);
  }

  @override
  void performLayout() {
    final child = this.child;
    if (child == null) {
      size = constraints.smallest;
      return;
    }

    child.layout(constraints.copyWith(minWidth: 0, maxWidth: double.infinity), parentUsesSize: true);
    size = constraints.constrain(child.size);
    _overflow = math.max(0.0, child.size.width - size.width);

    if (_overflow == _reportedOverflow) return;
    _reportedOverflow = _overflow;
    // The owner turns this into an animation, which cannot be started from
    // inside a layout pass.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (attached) onOverflowChanged(_overflow);
    });
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child != null) context.paintChild(child, offset + _shift);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final child = this.child;
    if (child == null) return false;

    return result.addWithPaintOffset(
      offset: _shift,
      position: position,
      hitTest: (result, position) => child.hitTest(result, position: position),
    );
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.translateByDouble(_shift.dx, _shift.dy, 0, 1);
  }
}
