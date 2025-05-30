import 'package:flutter/material.dart';

class InlineChoosableSection<T> extends StatelessWidget {
  const InlineChoosableSection({
    required this.title,
    required this.buildOptionTitle,
    required this.options,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final String? title;
  final Widget Function(T?) buildOptionTitle;

  final List<T> options;
  final T? selected;
  final Function(T?) onSelect;

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
              ToggleButtons(
                borderRadius: BorderRadius.circular(12),
                isSelected: [selected == null, ...options.map((option) => selected == option)],
                children: [buildOptionTitle(null), for (final option in options) buildOptionTitle(option)],
                onPressed: (index) {
                  if (index == 0) {
                    onSelect(null);
                  } else {
                    onSelect(options[index - 1]);
                  }
                },
              )
            ],
          ),
          // const SizedBox(height: 8.0),
        ],
      ],
    );
  }
}
