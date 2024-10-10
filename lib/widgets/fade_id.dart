import 'package:flutter/widgets.dart';

const Duration _kDuration = Duration(milliseconds: 250);

class FadeIn extends StatefulWidget {
  const FadeIn({super.key, this.child, this.duration = _kDuration});

  final Widget? child;
  final Duration duration;

  @override
  FadeInState createState() => FadeInState();
}

class FadeInState extends State<FadeIn> with TickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: widget.duration);

  @override
  void initState() {
    super.initState();

    // Used addPostFrameCallback instead of regular call to avoid glich on multiple widgets in a list
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _controller, child: widget.child);
  }
}
