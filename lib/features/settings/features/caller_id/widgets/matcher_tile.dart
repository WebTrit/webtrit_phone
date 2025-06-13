import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/caller_id_settings.dart';
import 'package:webtrit_phone/features/settings/features/caller_id/caller_id.dart';

class MatcherTile extends StatelessWidget {
  const MatcherTile({required this.matcher, super.key});

  final PrefixMatcher matcher;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withAlpha(25),
            blurRadius: 32,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: ListTile(
        title: Text('${l10n.settings_callerId_dialcode} ${matcher.prefix}'),
        subtitle: Text('${l10n.settings_callerId_number} ${matcher.number}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline_sharp),
          onPressed: () {
            context.read<CallerIdSettingsCubit>().removePrefixMatcher(matcher.prefix);
          },
        ),
      ),
    );
  }
}
