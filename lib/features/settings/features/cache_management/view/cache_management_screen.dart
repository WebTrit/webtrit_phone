import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// Central place to inspect and free the app's local caches.
///
/// Renders one entry per registered [CacheSection] with its current on-disk
/// size and a clear action; sizes are re-measured after clearing.
class CacheManagementScreen extends StatefulWidget {
  const CacheManagementScreen({required this.sections, super.key});

  final List<CacheSection> sections;

  /// Formats a byte count into a short human-readable size.
  @visibleForTesting
  static String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';

    const units = ['KB', 'MB', 'GB'];
    var value = bytes.toDouble();
    var unit = -1;
    do {
      value /= 1024;
      unit++;
    } while (value >= 1024 && unit < units.length - 1);

    return '${value.toStringAsFixed(1)} ${units[unit]}';
  }

  @override
  State<CacheManagementScreen> createState() => _CacheManagementScreenState();
}

class _CacheManagementScreenState extends State<CacheManagementScreen> {
  late final Map<String, Future<int>> _sizes = {
    for (final section in widget.sections) section.id: section.totalSizeBytes(),
  };
  final Set<String> _clearing = {};

  Future<void> _onClear(CacheSection section) async {
    setState(() => _clearing.add(section.id));
    try {
      await section.clear();
    } finally {
      if (mounted) {
        setState(() {
          _clearing.remove(section.id);
          _sizes[section.id] = section.totalSizeBytes();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.cacheManagement_Widget_screenTitle), leading: const ExtBackButton()),
      body: widget.sections.isEmpty
          ? Center(child: Text(context.l10n.cacheManagement_Label_empty))
          : ListView(
              children: [
                for (final section in widget.sections) ...[
                  _CacheSectionTile(
                    section: section,
                    size: _sizes[section.id]!,
                    clearing: _clearing.contains(section.id),
                    onClear: () => _onClear(section),
                  ),
                  const Divider(height: 1),
                ],
              ],
            ),
    );
  }
}

class _CacheSectionTile extends StatelessWidget {
  const _CacheSectionTile({required this.section, required this.size, required this.clearing, required this.onClear});

  final CacheSection section;
  final Future<int> size;
  final bool clearing;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.storage),
          title: Text(context.parseL10n(section.titleL10n)),
          subtitle: Text(context.parseL10n(section.descriptionL10n), style: theme.textTheme.bodySmall),
          trailing: FutureBuilder<int>(
            future: size,
            builder: (context, snapshot) => snapshot.hasData
                ? Text(CacheManagementScreen.formatBytes(snapshot.data!), style: theme.textTheme.titleSmall)
                : const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 4),
            child: TextButton.icon(
              icon: const Icon(Icons.delete_outline, size: 18),
              label: Text(context.l10n.cacheManagement_Button_clear),
              onPressed: clearing ? null : onClear,
            ),
          ),
        ),
      ],
    );
  }
}
