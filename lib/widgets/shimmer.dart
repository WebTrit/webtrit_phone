import 'package:flutter/material.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({super.key});

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final colorScheme = Theme.of(context).colorScheme;

        // Using onSurface with alpha allows the shimmer to look correct
        // on both light (dark grey) and dark (light grey) themes automatically.
        // Base color is subtle, highlight is slightly more opaque.
        return CustomPaint(
          painter: _ShimmerPainter(
            animationValue: _controller.value,
            baseColor: colorScheme.onSurface.withValues(alpha: 0.05),
            highlightColor: colorScheme.onSurface.withValues(alpha: 0.15),
          ),
        );
      },
    );
  }
}

class _ShimmerPainter extends CustomPainter {
  _ShimmerPainter({required this.animationValue, required this.baseColor, required this.highlightColor});

  final double animationValue;
  final Color baseColor;
  final Color highlightColor;

  static const List<double> _gradientStops = [0.3, 0.5, 0.7];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final basePaint = Paint()..color = baseColor;
    canvas.drawRect(rect, basePaint);

    // Draw Shimmer
    // Calculate the translation logic (dx)
    final dx = -size.width + (size.width * 3 * animationValue);

    // Reusing the list of colors is fine, but gradients must be recreated
    // to apply the shader to the new rect coordinates if using simple linear gradient,
    // or we create the shader with a specific Rect.
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [baseColor, highlightColor, baseColor],
      stops: _gradientStops,
    );

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
