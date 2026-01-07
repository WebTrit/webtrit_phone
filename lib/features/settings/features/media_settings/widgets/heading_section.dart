import 'package:flutter/material.dart';

class HeadingSection extends StatelessWidget {
  const HeadingSection({
    required this.title,
    required this.icon,
    this.selected = false,
    this.tooltip,
    this.padding = const EdgeInsets.all(8),
    this.gap = 8,
    this.tooltipIcon = const Icon(Icons.info_outline),
    this.tooltipPadding = const EdgeInsets.all(16),
    this.tooltipMargin = const EdgeInsets.all(16),
    this.tooltipTriggerMode = TooltipTriggerMode.tap,
    this.tooltipShowDuration = const Duration(seconds: 10),
    super.key,
  });

  final String title;
  final Widget icon;
  final bool selected;
  final String? tooltip;
  final EdgeInsetsGeometry padding;
  final double gap;
  final Widget tooltipIcon;
  final EdgeInsetsGeometry tooltipPadding;
  final EdgeInsetsGeometry tooltipMargin;
  final TooltipTriggerMode tooltipTriggerMode;
  final Duration tooltipShowDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = selected ? theme.colorScheme.primary : null;

    final textStyle = theme.textTheme.titleMedium!.copyWith(color: activeColor);

    return Padding(
      padding: padding,
      child: Row(
        children: [
          IconTheme(
            data: IconTheme.of(context).copyWith(color: activeColor),
            child: icon,
          ),
          SizedBox(width: gap),
          Expanded(child: Text(title, style: textStyle)),
          if (tooltip != null) ...[
            SizedBox(width: gap),
            Tooltip(
              message: tooltip,
              triggerMode: tooltipTriggerMode,
              padding: tooltipPadding,
              margin: tooltipMargin,
              showDuration: tooltipShowDuration,
              child: tooltipIcon,
            ),
          ],
        ],
      ),
    );
  }
}
