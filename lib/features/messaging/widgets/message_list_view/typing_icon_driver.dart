import 'package:flutter/material.dart';

class TypingIconDriver extends StatefulWidget {
  const TypingIconDriver({super.key});

  @override
  State<TypingIconDriver> createState() => _TypingIconDriverState();
}

class _TypingIconDriverState extends State<TypingIconDriver> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));

  @override
  initState() {
    super.initState();
    _controller.repeat();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(angle: _controller.value * 2 * 3.14, child: child);
      },
      child: const Icon(Icons.hdr_weak_sharp, size: 12, color: Colors.grey),
    );
  }
}
