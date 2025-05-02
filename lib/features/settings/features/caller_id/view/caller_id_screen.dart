import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../caller_id.dart';

class CallerIDSettingsScreen extends StatefulWidget {
  const CallerIDSettingsScreen({super.key});

  @override
  State<CallerIDSettingsScreen> createState() => _CallerIDSettingsScreenState();
}

class _CallerIDSettingsScreenState extends State<CallerIDSettingsScreen> {
  late final cubit = context.read<CallerIDSettingsCubit>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_caller_id),
        leading: const ExtBackButton(),
      ),
      body: BlocBuilder<CallerIDSettingsCubit, CallerIDSettingsState>(
        builder: (context, state) {
          final showID = state.showID;
          final selectedID = state.selectedID;
          final availableIDs = state.availableIDs;
          final defaultID = state.defaultID;

          return SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Material(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            context.l10n.settings_caller_id_show,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Switch(value: showID, onChanged: cubit.setShow),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(indent: 16, endIndent: 16),
                  const SizedBox(height: 8),
                  IgnorePointer(
                    ignoring: !showID,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: showID ? 1 : 0.5,
                      child: Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          spacing: 8,
                          children: [null, ...availableIDs].map((id) {
                            final selected = id == selectedID;

                            return Material(
                              color: selected ? colorScheme.primary : colorScheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              child: ListTile(
                                selected: selected,
                                title: Text(id ?? '$defaultID (${context.l10n.settings_caller_id_default})'),
                                onTap: () => cubit.setSelected(id),
                                leading: const Icon(Icons.numbers),
                                textColor: colorScheme.onSurface,
                                selectedColor: colorScheme.onPrimary,
                              ),
                            );
                          }).toList(),
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
