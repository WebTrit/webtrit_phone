import 'package:flutter/material.dart';

class ChoosableSection<T> extends StatelessWidget {
  const ChoosableSection({
    required this.title,
    required this.buildOptionTitle,
    required this.options,
    required this.selected,
    required this.onSelect,
    this.buildOptionTooltipMessage,
    super.key,
  });

  final String? title;
  final Widget Function(T?) buildOptionTitle;
  final String Function(T?)? buildOptionTooltipMessage;

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
          trailing: buildOptionTooltipMessage != null ? Tooltip(
            message: buildOptionTooltipMessage!(null),
            triggerMode: TooltipTriggerMode.tap,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            showDuration: const Duration(seconds: 10),
            child: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ) : null,
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
            trailing: buildOptionTooltipMessage != null ? Tooltip(
              message: buildOptionTooltipMessage!(option),
              triggerMode: TooltipTriggerMode.tap,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              showDuration: const Duration(seconds: 10),
              child: Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ) : null,
          ),
      ],
    );
  }
}
