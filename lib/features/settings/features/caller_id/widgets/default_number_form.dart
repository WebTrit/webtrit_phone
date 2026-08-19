import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/settings/features/caller_id/caller_id.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'number_dropdown.dart';

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
        color: colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: colorScheme.shadow.withAlpha(25), blurRadius: 32, offset: const Offset(4, 4))],
      ),
      child: Row(
        children: [
          Expanded(child: Text(l10n.settings_callerId_number)),
          const SizedBox(width: 8),
          // The chooser announces the number it shows and nothing that says
          // what the number is for: the caption beside it is a node of its
          // own, and merging the whole row would claim a press target the
          // width of the row while only the chooser answers a press.
          SemanticAction(
            label: l10n.callerId_SemanticsLabel_defaultNumber,
            identifier: callerIdDefaultNumberId,
            child: NumberDropdown<String?>(
              initialSelection: state.settings.defaultNumber,
              value: state.settings.defaultNumber ?? state.mainNumber,
              entries: [
                if (state.mainNumber != null) DropdownMenuEntry<String?>(value: null, label: state.mainNumber!),
                for (final n in state.additionalNumbers) DropdownMenuEntry<String?>(value: n, label: n),
              ],
              onSelected: (value) {
                context.read<CallerIdSettingsCubit>().setDefaultNumber(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
