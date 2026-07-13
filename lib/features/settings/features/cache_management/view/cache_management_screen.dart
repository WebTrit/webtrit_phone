import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../cubit/cache_management_cubit.dart';
import '../utils/cache_usage_formatter.dart';

/// Central place to inspect and free the app's local caches.
///
/// Renders one entry per registered cache section with its current usage and
/// a clear action; measuring and clearing live in [CacheManagementCubit].
class CacheManagementScreen extends StatelessWidget {
  const CacheManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.cacheManagement_Widget_screenTitle), leading: const ExtBackButton()),
      body: BlocBuilder<CacheManagementCubit, CacheManagementState>(
        builder: (context, state) {
          if (state.sections.isEmpty) {
            return Center(child: Text(context.l10n.cacheManagement_Label_empty));
          }
          return ListView(
            children: [
              for (final section in state.sections) ...[
                _CacheSectionTile(
                  section: section,
                  onClear: () => context.read<CacheManagementCubit>().clearSection(section.id),
                ),
                const Divider(height: 1),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _CacheSectionTile extends StatelessWidget {
  const _CacheSectionTile({required this.section, required this.onClear});

  final CacheSectionState section;
  final VoidCallback onClear;

  String _formatUsage(BuildContext context, CacheUsage usage) {
    return switch (usage.unit) {
      CacheUsageUnit.bytes => formatBytes(usage.amount),
      CacheUsageUnit.items => context.l10n.cacheManagement_Label_itemsCount(usage.amount),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final usage = section.usage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.storage),
          title: Text(context.parseL10n(section.titleL10n)),
          subtitle: Text(context.parseL10n(section.descriptionL10n), style: theme.textTheme.bodySmall),
          trailing: usage != null
              ? Text(_formatUsage(context, usage), style: theme.textTheme.titleSmall)
              : const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 4),
            child: TextButton.icon(
              icon: const Icon(Icons.delete_outline, size: 18),
              label: Text(context.l10n.cacheManagement_Button_clear),
              onPressed: section.clearing ? null : onClear,
            ),
          ),
        ),
      ],
    );
  }
}
