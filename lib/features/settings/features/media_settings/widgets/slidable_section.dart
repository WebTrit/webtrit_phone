import 'package:flutter/material.dart';

class SlidableSection<T> extends StatelessWidget {
  const SlidableSection({
    required this.title,
    required this.optionPrefix,
    required this.buildOptionLabel,
    required this.options,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final String title;
  final String optionPrefix;
  final String Function(T?) buildOptionLabel;

  final List<T> options;
  final T? selected;
  final Function(T?) onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 4),
            Expanded(child: Text(title)),
            const SizedBox(width: 4),
          ],
        ),
        Slider(
          value: selected == null ? 0 : options.indexOf(selected as T) + 1,
          secondaryTrackValue: 0.1,
          onChanged: (v) {
            if (v == 0) {
              onSelect(null);
            } else {
              final index = v.round() - 1;
              onSelect(options[index]);
            }
          },
          min: 0,
          max: options.length.toDouble(),
          divisions: options.length + 1,
          label: buildOptionLabel(selected),
        ),
        Row(
          children: [
            const SizedBox(width: 24),
            Text(optionPrefix),
            Text(
              buildOptionLabel(selected),
              style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }
}
