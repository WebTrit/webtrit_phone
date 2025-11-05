import 'package:flutter/material.dart';

class InlineSelectableSection<T> extends StatelessWidget {
  const InlineSelectableSection({
    this.title,
    this.tooltip,
    required this.buildOptionTitle,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final String? title;
  final String? tooltip;
  final Widget Function(T?) buildOptionTitle;

  final bool selected;
  final Function(bool) onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null) ...[
          Row(
            children: [
              const SizedBox(width: 4),
              Expanded(child: Text(title!)),
              const SizedBox(width: 4),
              Checkbox(
                value: selected,
                onChanged: (value) {
                  if (value != null) onSelect(value);
                },
              ),
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
          ),
          // const SizedBox(height: 8.0),
        ],
      ],
    );
  }
}
