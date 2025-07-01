import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/settings/features/caller_id/caller_id.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class DefaultNumberForm extends StatelessWidget {
  const DefaultNumberForm({required this.state, super.key});

  final CallerIdSettingsState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      child: Row(
        children: [
          Expanded(child: Text(l10n.settings_callerId_number)),
          const SizedBox(width: 8),
          DropdownMenu<String?>(
            initialSelection: state.settings.defaultNumber,
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.surfaceContainerLow),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              isCollapsed: true,
            ),
            dropdownMenuEntries: [
              DropdownMenuEntry<String?>(
                value: null,
                label: state.mainNumber,
              ),
              for (final n in state.additionalNumbers)
                DropdownMenuEntry<String>(
                  value: n,
                  label: n,
                ),
            ],
            onSelected: (value) {
              context.read<CallerIdSettingsCubit>().setDefaultNumber(value);
            },
          ),
        ],
      ),
    );
  }
}
