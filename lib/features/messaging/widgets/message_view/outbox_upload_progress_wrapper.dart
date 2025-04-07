import 'package:flutter/material.dart';
import 'package:webtrit_phone/widgets/animated_progress_line.dart';

class OutboxUploadProgressWrapper extends StatelessWidget {
  const OutboxUploadProgressWrapper({
    required this.uploadProgress,
    required this.child,
    this.fill = false,
    super.key,
  });

  final double? uploadProgress;
  final Widget child;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (fill) Positioned.fill(child: child) else child,
        if (uploadProgress != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedProgressLine(uploadProgress!),
          ),
      ],
    );
  }
}
