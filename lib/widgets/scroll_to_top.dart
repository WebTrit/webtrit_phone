import 'package:flutter/material.dart';

class ScrollToTopOverlay extends StatelessWidget {
  const ScrollToTopOverlay({
    required this.child,
    required this.scrolledAway,
    required this.onScrollToTop,
    super.key,
  });

  final bool scrolledAway;
  final VoidCallback onScrollToTop;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(bottom: 16, right: 16, child: ScrollToTopButton(scrolledAway, onScrollToTop)),
      ],
    );
  }
}

class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton(this.scrolledAway, this.onTap, {super.key});

  final bool scrolledAway;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation.drive(CurveTween(curve: Curves.linear)),
          child: SizeTransition(sizeFactor: animation, child: child),
        );
      },
      switchInCurve: Curves.bounceOut,
      switchOutCurve: Curves.easeInExpo,
      child: scrolledAway
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(8),
              child: IconButton(
                key: const Key('scrollToTopButton'),
                onPressed: onTap,
                icon: const Icon(Icons.arrow_circle_up_outlined),
                padding: const EdgeInsets.all(0),
              ),
            )
          : const SizedBox(),
    );
  }
}
