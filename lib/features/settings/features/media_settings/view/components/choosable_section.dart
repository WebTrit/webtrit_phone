import 'package:flutter/material.dart';

class ChoosableSection<T> extends StatelessWidget {
  const ChoosableSection({
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
            ],
          ),
          const SizedBox(height: 8.0),
        ],
        ListTile(
          selected: selected == null,
          title: buildOptionTitle(null),
          onTap: () => onSelect(null),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Icon(selected == null ? Icons.radio_button_checked : Icons.radio_button_unchecked),
          // contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          minTileHeight: 0,
        ),
        for (final option in options)
          ListTile(
            selected: selected == option,
            title: buildOptionTitle(option),
            onTap: () => onSelect(option),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            leading: Icon(selected == option ? Icons.radio_button_checked : Icons.radio_button_unchecked),
            // contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            minTileHeight: 0,
          ),
      ],
    );
  }
}
