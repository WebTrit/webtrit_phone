import 'package:flutter/material.dart';

/// The badge that says the microphone is not available to the app.
///
/// It sits over the account avatar in the app bar, hanging off its top-right corner,
/// which is why it carries its own background: it is read against whatever is under it.
class MicrophoneOffBadge extends StatelessWidget {
  const MicrophoneOffBadge({super.key, this.size = 14});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: colorScheme.error, shape: BoxShape.circle),
      child: Icon(Icons.mic_off, color: colorScheme.onError, size: size),
    );
  }
}
