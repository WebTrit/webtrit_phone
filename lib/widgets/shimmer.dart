import 'package:flutter/material.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({super.key, this.duration = const Duration(milliseconds: 1500), this.baseColor, this.highlightColor});

  final Duration duration;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void didUpdateWidget(covariant Shimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleAnimationUpdate(oldWidget);
  }

  void _handleAnimationUpdate(Shimmer oldWidget) {
    if (oldWidget.duration != widget.duration) {
      final double currentValue = _controller.value;
      _controller.duration = widget.duration;
      // Restart from the current position to ensure the speed change is instantaneous.
      _controller.forward(from: currentValue);
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBaseColor = _getEffectiveBaseColor(context);
    final effectiveHighlightColor = _getEffectiveHighlightColor(context);

    return TweenAnimationBuilder<Color?>(
      duration: const Duration(milliseconds: 500),
      tween: ColorTween(begin: effectiveBaseColor, end: effectiveBaseColor),
      builder: (context, animatedBaseColor, _) => TweenAnimationBuilder<Color?>(
        duration: const Duration(milliseconds: 500),
        tween: ColorTween(begin: effectiveHighlightColor, end: effectiveHighlightColor),
        builder: (context, animatedHighlightColor, _) => AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => CustomPaint(
            painter: _ShimmerPainter(
              animationValue: _controller.value,
              baseColor: animatedBaseColor ?? effectiveBaseColor,
              highlightColor: animatedHighlightColor ?? effectiveHighlightColor,
            ),
          ),
        ),
      ),
    );
  }

  /// Uses [ColorScheme.surfaceContainerHighest] to ensure the shimmer looks
  /// correct on both light and dark themes automatically.
  Color _getEffectiveBaseColor(BuildContext context) =>
      widget.baseColor ?? Theme.of(context).colorScheme.surfaceContainerHighest;

  /// Uses [ColorScheme.surface] with opacity to create a subtle highlight contrast.
  Color _getEffectiveHighlightColor(BuildContext context) =>
      widget.highlightColor ?? Theme.of(context).colorScheme.surface.withValues(alpha: 0.8);
}

class _ShimmerPainter extends CustomPainter {
  _ShimmerPainter({required this.animationValue, required this.baseColor, required this.highlightColor});

  final double animationValue;
  final Color baseColor;
  final Color highlightColor;

  static const List<double> _gradientStops = [0.1, 0.5, 0.9];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final basePaint = Paint()..color = baseColor;
    canvas.drawRect(rect, basePaint);

    // Calculate the translation logic (dx)
    final dx = -size.width + (size.width * 3 * animationValue);
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [baseColor, highlightColor, baseColor],
      stops: _gradientStops,
    );

    // Reusing the list of colors is fine, but gradients must be recreated
    // to apply the shader to the new rect coordinates.
    final shaderRect = Rect.fromLTWH(dx, 0, size.width, size.height);
    final shimmerPaint = Paint()..shader = gradient.createShader(shaderRect);

    canvas.drawRect(rect, shimmerPaint);
  }

  @override
  bool shouldRepaint(covariant _ShimmerPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue ||
      oldDelegate.baseColor != baseColor ||
      oldDelegate.highlightColor != highlightColor;
}
