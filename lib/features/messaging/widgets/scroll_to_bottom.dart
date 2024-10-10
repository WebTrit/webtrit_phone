import 'package:flutter/material.dart';

class ScrollToBottomOverlay extends StatelessWidget {
  const ScrollToBottomOverlay({
    required this.child,
    required this.scrolledAway,
    required this.onScrollToBottom,
    super.key,
  });

  final bool scrolledAway;
  final VoidCallback onScrollToBottom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(bottom: 16, right: 16, child: ScrollToBottomButton(scrolledAway, onScrollToBottom)),
      ],
    );
  }
}

class ScrollToBottomButton extends StatelessWidget {
  const ScrollToBottomButton(this.scrolledAway, this.onTap, {super.key});

  final bool scrolledAway;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
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
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(8),
              child: IconButton(
                key: const Key('scrollToBottomButton'),
                onPressed: onTap,
                icon: const Icon(Icons.expand_circle_down_outlined),
                padding: const EdgeInsets.all(0),
              ),
            )
          : const SizedBox(),
    );
  }
}
