import 'package:flutter/material.dart';

class HeadingSection extends StatelessWidget {
  const HeadingSection({required this.title, this.tooltip, required this.icon, super.key});

  final String title;
  final String? tooltip;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600);

    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: textStyle)),
        if (tooltip != null) ...[
          const SizedBox(width: 8),
          Tooltip(
            message: tooltip,
            triggerMode: TooltipTriggerMode.tap,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            showDuration: const Duration(seconds: 10),
            child: const Icon(Icons.info_outline),
          ),
        ],
      ],
    );
  }
}
