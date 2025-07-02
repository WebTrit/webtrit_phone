import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/caller_id_settings.dart';

import '../caller_id.dart';
import '../widgets/widgets.dart';

class CallerIdSettingsScreen extends StatefulWidget {
  const CallerIdSettingsScreen({super.key});

  @override
  State<CallerIdSettingsScreen> createState() => _CallerIdSettingsScreenState();
}

class _CallerIdSettingsScreenState extends State<CallerIdSettingsScreen> {
  bool showMatcherForm = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_callerId),
      ),
      body: BlocBuilder<CallerIdSettingsCubit, CallerIdSettingsState?>(
        builder: (context, state) {
          if (state == null) return const Center(child: CircularProgressIndicator());

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(
                    l10n.settings_callerId_defaultTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DefaultNumberForm(state: state),
                  Text(
                    l10n.settings_callerId_dialCodeMatching_title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (final matcher in state.settings.matchers) ...[
                    if (matcher is PrefixMatcher) MatcherTile(matcher: matcher),
                  ],
                  if (showMatcherForm == false)
                    Center(
                      child: SizedBox(
                        child: IconButton(
                          onPressed: () => setState(() => showMatcherForm = true),
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    )
                  else
                    MatcherAddingForm(
                      numbers: state.additionalNumbers,
                      addedPrefixes: state.settings.matchers.whereType<PrefixMatcher>().map((e) => e.prefix).toList(),
                      onSave: (prefix, number) {
                        context.read<CallerIdSettingsCubit>().addPrefixMatcher(prefix, number);
                        setState(() => showMatcherForm = false);
                      },
                      onCancel: () => setState(() => showMatcherForm = false),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
