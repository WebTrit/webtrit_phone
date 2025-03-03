import 'package:flutter/material.dart';
import 'package:webtrit_phone/models/enableble.dart';

class ReorderableSection<T> extends StatelessWidget {
  const ReorderableSection({
    required this.title,
    required this.warningTitle,
    required this.warningMessage,
    required this.buildOptionTitle,
    required this.enabled,
    required this.onEnable,
    required this.items,
    required this.onChange,
    super.key,
  });

  final String title;
  final String warningTitle;
  final String warningMessage;
  final Widget Function(T?) buildOptionTitle;

  final bool enabled;
  final Function(bool) onEnable;
  final List<Enableble<T>> items;
  final Function(List<Enableble<T>>) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 4),
            Expanded(child: Text(title)),
            const SizedBox(width: 4),
            Switch(value: enabled, onChanged: onEnable),
            const SizedBox(width: 8.0),
          ],
        ),
        if (enabled) ...[
          Column(
            children: [
              Text(
                warningTitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              Text(
                warningMessage,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < newIndex) newIndex -= 1;

              final newOptions = List<Enableble<T>>.from(items);
              final profile = newOptions.removeAt(oldIndex);
              newOptions.insert(newIndex, profile);

              onChange(newOptions);
            },
            shrinkWrap: true,
            buildDefaultDragHandles: false,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final item in items)
                ListTile(
                  enabled: enabled,
                  key: ValueKey(item),
                  title: buildOptionTitle(item.option),
                  leading: ReorderableDragStartListener(
                    index: items.indexOf(item),
                    enabled: enabled,
                    child: const Icon(Icons.drag_handle),
                  ),
                  trailing: Checkbox(
                    value: item.enabled,
                    onChanged: enabled
                        ? (v) {
                            if (v == null) return;
                            onChange(items.map((i) {
                              if (i == item) {
                                return (option: i.option, enabled: v);
                              } else {
                                return i;
                              }
                            }).toList());
                          }
                        : null,
                  ),
                  visualDensity: VisualDensity.compact,
                  minTileHeight: 0,
                ),
            ],
          ),
        ],
      ],
    );
  }
}
