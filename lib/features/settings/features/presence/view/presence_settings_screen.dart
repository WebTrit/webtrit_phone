// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/extensions/presence_activity.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../cubit/presence_settings_cubit.dart';
import '../models/presence_settings_preset.dart';
import '../widgets/widgets.dart';

class PresenceSettingsScreen extends StatefulWidget {
  const PresenceSettingsScreen({super.key});

  @override
  State<PresenceSettingsScreen> createState() => _PresenceSettingsScreenState();
}

class _PresenceSettingsScreenState extends State<PresenceSettingsScreen> {
  late final cubit = context.read<PresenceSettingsCubit>();
  late final presets = PresenceSettingsPreset.presets(context.l10n);
  String equalKey = 'abc';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    final titleStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold);
    final contentStyle = Theme.of(context).textTheme.bodyMedium;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings_ListViewTileTitle_presence), leading: const ExtBackButton()),
      body: BlocBuilder<PresenceSettingsCubit, PresenceSettings>(
        builder: (context, state) {
          final selectedPreset = presets.firstWhereOrNull(
            (element) =>
                element.available == state.available &&
                element.note == state.note &&
                element.activity == state.activity &&
                element.dndMode == state.dndMode,
          );

          final isBlank = state.isBlank();

          return SemanticId(
            identifier: presenceSettingsScreenId,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                clipBehavior: Clip.none, // if width <=370dp it clips dropdown hint
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(l10n.presence_settings_presets_title, style: titleStyle),
                        Spacer(),
                        LimitedBox(
                          maxWidth: 250,
                          // The control shows the chosen preset and nothing that
                          // says what the choice is about: the caption beside it
                          // is a node of its own, and the frame around it reads
                          // "Custom".
                          child: SemanticAction(
                            label: l10n.presenceSettings_SemanticsLabel_preset,
                            identifier: presenceSettingsPresetId,
                            // The chosen preset is spoken here rather than left
                            // to the field inside the chooser: on the web the
                            // framework drops that field from the tree, and the
                            // choice would go silent with it.
                            child: Semantics(
                              value: isBlank
                                  ? l10n.presence_settings_presets_label
                                  : selectedPreset?.name ?? l10n.presence_settings_presets_label_custom,
                              child: DropdownMenu<PresenceSettingsPreset?>(
                                // The chooser offers a list and nothing else: it
                                // is not a field to type into, and off mobile it
                                // would otherwise become one.
                                selectOnly: true,
                                key: ValueKey('${equalKey}preset'),
                                controller: TextEditingController(),
                                dropdownMenuEntries: presets
                                    .map(
                                      (e) => DropdownMenuEntry(
                                        value: e,
                                        label: e.name,
                                        labelWidget: Row(
                                          children: [
                                            SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: SipPresenceIndicator(
                                                presenceInfo: [
                                                  PresenceInfo(
                                                    id: 'id',
                                                    number: 'number',
                                                    available: e.available,
                                                    note: e.note,
                                                    activities: [if (e.activity != null) e.activity!],
                                                    statusIcon: null,
                                                    device: 'device',
                                                    timeOffsetMin: 0,
                                                    timestamp: DateTime.now(),
                                                    source: PresenceInfoSource.direct,
                                                    arrivalTime: DateTime.now(),
                                                  ),
                                                ],
                                                presenceRect: Rect.fromLTWH(0, 0, 16, 16),
                                                dialogInfo: [],
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Flexible(
                                              child: Text(
                                                e.name,
                                                style: TextStyle(fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                initialSelection: selectedPreset,
                                onSelected: (value) {
                                  if (value == null) return;
                                  final update = state
                                      .copyWithAvailable(value.available)
                                      .copyWithNote(value.note)
                                      .copyWithActivity(value.activity)
                                      .copyWithDndMode(value.dndMode);
                                  cubit.setPresenceSettings(update);
                                  setState(() => equalKey = DateTime.now().microsecondsSinceEpoch.toString());
                                },
                                label: isBlank
                                    ? Text(l10n.presence_settings_presets_label)
                                    : Text(l10n.presence_settings_presets_label_custom),
                                menuStyle: MenuStyle(
                                  backgroundColor: WidgetStateProperty.all(colorScheme.surfaceBright),
                                ),
                                inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  isCollapsed: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ExpansionPanelList.radio(
                      elevation: 0,
                      expandedHeaderPadding: EdgeInsets.zero,
                      initialOpenPanelValue: selectedPreset == null && !isBlank ? 0 : null,
                      children: [
                        ExpansionPanelRadio(
                          value: 0,
                          canTapOnHeader: true,
                          // The whole header is one node with the press on it,
                          // so the id given to its caption is what that node
                          // carries; the caption itself is its name.
                          headerBuilder: (_, isExpanded) => SemanticAction(
                            identifier: presenceSettingsConfigSectionId,
                            child: Text(l10n.presence_settings_config_title, style: titleStyle),
                          ),
                          backgroundColor: Colors.transparent,
                          body: Column(
                            key: ValueKey('${equalKey}config'),
                            children: [
                              SizedBox(height: 8),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SemanticAction(
                                        identifier: presenceSettingsAvailabilityId,
                                        child: SwitchListTile(
                                          title: Text(l10n.presence_settings_availability_title, style: contentStyle),
                                          value: state.available,
                                          onChanged: (value) {
                                            PresenceSettings update = state
                                                .copyWithAvailable(value)
                                                .copyWithActivity(null);
                                            if (value == true) update = update.copyWithDndMode(false);
                                            cubit.setPresenceSettings(update);
                                          },
                                          contentPadding: EdgeInsets.zero,
                                          // dense: true,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    PresenceOptionInfoButton(
                                      option: l10n.presence_settings_availability_title,
                                      message: l10n.presence_settings_availability_tooltip,
                                      identifier: presenceSettingsAvailabilityInfoId,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: SemanticId(
                                      identifier: presenceSettingsNoteId,
                                      child: TextFormField(
                                        initialValue: state.note,
                                        decoration: InputDecoration(
                                          labelText: l10n.presence_settings_note_label,
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                        ),
                                        onChanged: (value) {
                                          cubit.setPresenceSettings(state.copyWithNote(value));
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  PresenceOptionInfoButton(
                                    option: l10n.presence_settings_note_label,
                                    message: l10n.presence_settings_note_tooltip,
                                    identifier: presenceSettingsNoteInfoId,
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    // The caption of the frame around this one is
                                    // read out with it, so it needs no name of its
                                    // own - only an id to be found by.
                                    child: SemanticAction(
                                      identifier: presenceSettingsActivityId,
                                      child: DropdownMenu<PresenceActivity?>(
                                        dropdownMenuEntries: [
                                          DropdownMenuEntry(value: null, label: l10n.presence_activity_none_name),
                                          if (state.available == false) ...[
                                            DropdownMenuEntry(
                                              value: PresenceActivity.away,
                                              label: PresenceActivity.away.l10n(l10n),
                                            ),
                                            DropdownMenuEntry(
                                              value: PresenceActivity.busy,
                                              label: PresenceActivity.busy.l10n(l10n),
                                            ),
                                            DropdownMenuEntry(
                                              value: PresenceActivity.doNotDisturb,
                                              label: PresenceActivity.doNotDisturb.l10n(l10n),
                                            ),
                                            DropdownMenuEntry(
                                              value: PresenceActivity.permanentAbsence,
                                              label: PresenceActivity.permanentAbsence.l10n(l10n),
                                            ),
                                            DropdownMenuEntry(
                                              value: PresenceActivity.sleeping,
                                              label: PresenceActivity.sleeping.l10n(l10n),
                                            ),
                                          ],
                                          if (state.available == true) ...[
                                            DropdownMenuEntry(
                                              value: PresenceActivity.appointment,
                                              label: PresenceActivity.appointment.l10n(l10n),
                                            ),
                                            DropdownMenuEntry(
                                              value: PresenceActivity.inTransit,
                                              label: PresenceActivity.inTransit.l10n(l10n),
                                            ),
                                            DropdownMenuEntry(
                                              value: PresenceActivity.meal,
                                              label: PresenceActivity.meal.l10n(l10n),
                                            ),
                                            DropdownMenuEntry(
                                              value: PresenceActivity.meeting,
                                              label: PresenceActivity.meeting.l10n(l10n),
                                            ),
                                            DropdownMenuEntry(
                                              value: PresenceActivity.travel,
                                              label: PresenceActivity.travel.l10n(l10n),
                                            ),
                                            DropdownMenuEntry(
                                              value: PresenceActivity.vacation,
                                              label: PresenceActivity.vacation.l10n(l10n),
                                            ),
                                          ],
                                        ],
                                        initialSelection: state.activity,
                                        onSelected: (value) {
                                          cubit.setPresenceSettings(state.copyWithActivity(value));
                                        },
                                        label: Text(l10n.presence_settings_activity_label),
                                        menuStyle: MenuStyle(
                                          backgroundColor: WidgetStateProperty.all(colorScheme.surfaceBright),
                                        ),
                                        inputDecorationTheme: InputDecorationTheme(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          isCollapsed: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  PresenceOptionInfoButton(
                                    option: l10n.presence_settings_activity_label,
                                    message: l10n.presence_settings_activity_tooltip,
                                    identifier: presenceSettingsActivityInfoId,
                                  ),
                                ],
                              ),
                              // SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: SemanticAction(
                                      identifier: presenceSettingsDndId,
                                      child: SwitchListTile(
                                        title: Text(l10n.presence_settings_dnd_title, style: contentStyle),
                                        value: state.dndMode,
                                        onChanged: state.available
                                            ? null
                                            : (value) {
                                                cubit.setPresenceSettings(state.copyWithDndMode(value));
                                              },
                                        contentPadding: EdgeInsets.zero,

                                        // dense: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  PresenceOptionInfoButton(
                                    option: l10n.presence_settings_dnd_title,
                                    message: l10n.presence_settings_dnd_tooltip,
                                    identifier: presenceSettingsDndInfoId,
                                  ),
                                ],
                              ),
                              // SizedBox(height: 16),
                              Divider(),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(l10n.presence_settings_statusIcon_title, style: titleStyle),
                                  SizedBox(width: 8),
                                  Text(state.statusIcon ?? l10n.presence_settings_statusIcon_none, style: contentStyle),
                                  Spacer(),
                                  SemanticAction(
                                    label: l10n.presenceSettings_SemanticsLabel_pickStatusIcon,
                                    identifier: presenceSettingsStatusIconPickId,
                                    child: IconButton(
                                      onPressed: () async {
                                        final statusIcon = await StatusIconPickerSheet.show(context);
                                        if (statusIcon == null) return;
                                        cubit.setPresenceSettings(cubit.state.copyWithStatusIcon(statusIcon));
                                      },
                                      icon: Icon(Icons.search),
                                    ),
                                  ),
                                  if (state.statusIcon != null)
                                    SemanticAction(
                                      label: l10n.presenceSettings_SemanticsLabel_clearStatusIcon,
                                      identifier: presenceSettingsStatusIconClearId,
                                      child: IconButton(
                                        onPressed: () => cubit.setPresenceSettings(state.copyWithStatusIcon(null)),
                                        icon: Icon(Icons.delete),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
