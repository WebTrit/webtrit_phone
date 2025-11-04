// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/extensions/presence_activity.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/back_button.dart';
import 'package:webtrit_phone/widgets/leading_avatar.dart';

import '../cubit/presence_settings_cubit.dart';
import '../models/presence_settings_preset.dart';

class PresenceSettingsScreen extends StatefulWidget {
  const PresenceSettingsScreen({super.key});

  @override
  State<PresenceSettingsScreen> createState() => _PresenceSettingsScreenState();
}

class _PresenceSettingsScreenState extends State<PresenceSettingsScreen> {
  late final cubit = context.read<PresenceSettingsCubit>();
  late final presets = PresenceSettingsPreset.presets(context.l10n);
  Key equalKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    final titleStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold);
    final contentStyle = Theme.of(context).textTheme.bodyMedium;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings_ListViewTileTitle_presence),
        leading: const ExtBackButton(),
      ),
      body: BlocBuilder<PresenceSettingsCubit, PresenceSettings>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                key: equalKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(l10n.presence_settings_presets_title, style: titleStyle),
                      Spacer(),
                      DropdownMenu<PresenceSettingsPreset?>(
                        controller: TextEditingController(),
                        dropdownMenuEntries: presets
                            .map((e) => DropdownMenuEntry(
                                  value: e,
                                  label: e.name,
                                  labelWidget: Row(
                                    children: [
                                      LeadingAvatar(
                                        username: 'User',
                                        presenceInfo: [
                                          PresenceInfo(
                                            id: 'id',
                                            available: e.available,
                                            note: e.note,
                                            activities: [if (e.activity != null) e.activity!],
                                            statusIcon: null,
                                            device: 'device',
                                            timeOffsetMin: 0,
                                            timestamp: DateTime.now(),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 8),
                                      Text(e.name),
                                    ],
                                  ),
                                ))
                            .toList(),
                        initialSelection: presets.firstWhereOrNull(
                          (element) =>
                              element.available == state.available &&
                              element.note == state.note &&
                              element.activity == state.activity &&
                              element.dndMode == state.dndMode,
                        ),
                        onSelected: (value) {
                          if (value == null) return;
                          final update = state
                              .copyWithAvailable(value.available)
                              .copyWithNote(value.note)
                              .copyWithActivity(value.activity)
                              .copyWithDndMode(value.dndMode);
                          cubit.setPresenceSettings(update);
                          setState(() => equalKey = UniqueKey());
                        },
                        label: Text(l10n.presence_settings_presets_label),
                        menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(colorScheme.surfaceBright)),
                        inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          isCollapsed: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 8),
                  Text(l10n.presence_settings_config_title, style: titleStyle),
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: SwitchListTile(
                            title: Text(l10n.presence_settings_availability_title, style: contentStyle),
                            value: state.available,
                            onChanged: (value) {
                              PresenceSettings update = state.copyWithAvailable(value).copyWithActivity(null);
                              if (value == true) update = update.copyWithDndMode(false);
                              cubit.setPresenceSettings(update);
                            },
                            contentPadding: EdgeInsets.zero,
                            // dense: true,
                          ),
                        ),
                        SizedBox(width: 16),
                        Tooltip(
                          message: l10n.presence_settings_availability_tooltip,
                          triggerMode: TooltipTriggerMode.tap,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(16),
                          showDuration: const Duration(seconds: 10),
                          child: const Icon(Icons.info_outline),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: state.note,
                          decoration: InputDecoration(
                            labelText: l10n.presence_settings_note_label,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) {
                            cubit.setPresenceSettings(state.copyWithNote(value));
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Tooltip(
                        message: l10n.presence_settings_note_tooltip,
                        triggerMode: TooltipTriggerMode.tap,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        showDuration: const Duration(seconds: 10),
                        child: const Icon(Icons.info_outline),
                      )
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownMenu<PresenceActivity?>(
                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                              value: null,
                              label: l10n.presence_activity_none_name,
                            ),
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
                            ]
                          ],
                          initialSelection: state.activity,
                          onSelected: (value) {
                            cubit.setPresenceSettings(state.copyWithActivity(value));
                          },
                          label: Text(l10n.presence_settings_activity_label),
                          menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(colorScheme.surfaceBright)),
                          inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            isCollapsed: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Tooltip(
                        message: l10n.presence_settings_activity_tooltip,
                        triggerMode: TooltipTriggerMode.tap,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        showDuration: const Duration(seconds: 10),
                        child: const Icon(Icons.info_outline),
                      )
                    ],
                  ),
                  // SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
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
                      SizedBox(width: 16),
                      Tooltip(
                        message: l10n.presence_settings_dnd_tooltip,
                        triggerMode: TooltipTriggerMode.tap,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        showDuration: const Duration(seconds: 10),
                        child: const Icon(Icons.info_outline),
                      )
                    ],
                  ),
                  // SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(l10n.presence_settings_statusIcon_title, style: titleStyle),
                      SizedBox(width: 8),
                      Text(
                        state.statusIcon ?? l10n.presence_settings_statusIcon_none,
                        style: contentStyle,
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                    child: Dialog(
                                      shadowColor: Colors.black,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        width: 300,
                                        height: 300,
                                        child: OverflowBox(
                                          alignment: Alignment.topCenter,
                                          maxHeight: 350,
                                          minHeight: 350,
                                          child: EmojiPicker(
                                            config: Config(
                                              emojiViewConfig: EmojiViewConfig(
                                                backgroundColor: Colors.white,
                                                emojiSizeMax: 20,
                                              ),
                                            ),
                                            onEmojiSelected: (category, emoji) {
                                              cubit.setPresenceSettings(state.copyWithStatusIcon(emoji.emoji));
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(Icons.search)),
                      if (state.statusIcon != null)
                        IconButton(
                          onPressed: () => cubit.setPresenceSettings(state.copyWithStatusIcon(null)),
                          icon: Icon(Icons.delete),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
