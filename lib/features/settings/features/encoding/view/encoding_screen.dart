import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/enableble.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../encoding.dart';

class EncodingSettingsScreen extends StatefulWidget {
  const EncodingSettingsScreen({super.key});

  @override
  State<EncodingSettingsScreen> createState() => _EncodingSettingsScreenState();
}

class _EncodingSettingsScreenState extends State<EncodingSettingsScreen> {
  late final cubit = context.read<EncodingSettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_encoding),
        leading: const ExtBackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_backup_restore),
            tooltip: context.l10n.settings_encoding_AppBar_reset_tooltip,
            onPressed: () => cubit.reset(),
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
      body: BlocBuilder<EncodingSettingsCubit, EncodingSettingState>(
        builder: (context, state) {
          final preset = state.preset;
          final settings = state.settings;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HeadingSection(
                  title: context.l10n.settings_encoding_Section_preset_title,
                  tooltip: context.l10n.settings_encoding_Section_preset_tooltip,
                  icon: const Icon(Icons.segment_outlined),
                ),
                const SizedBox(height: 16.0),
                ChoosableSection<EncodingPreset>(
                  title: null,
                  buildOptionTitle: (option) {
                    return Text(switch (option) {
                      null => context.l10n.settings_encoding_Section_preset_default,
                      EncodingPreset.eco => context.l10n.settings_encoding_Section_preset_eco,
                      EncodingPreset.balance => context.l10n.settings_encoding_Section_preset_balance,
                      EncodingPreset.quality => context.l10n.settings_encoding_Section_preset_quality,
                      EncodingPreset.fullFlex => context.l10n.settings_encoding_Section_preset_full_flex,
                      EncodingPreset.custom => context.l10n.settings_encoding_Section_preset_custom,
                    });
                  },
                  options: EncodingPreset.values,
                  selected: preset,
                  onSelect: (option) => cubit.setPreset(option),
                ),
                if (preset == EncodingPreset.custom)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),
                      HeadingSection(
                        title: context.l10n.settings_encoding_Section_bitrate_title,
                        tooltip: context.l10n.settings_encoding_Section_bitrate_tooltip,
                        icon: const Icon(Icons.one_k_plus_sharp),
                      ),
                      const SizedBox(height: 16.0),
                      SlidableSection<int>(
                        title: context.l10n.settings_encoding_Section_target_audio_bitrate,
                        optionPrefix: context.l10n.settings_encoding_Section_bitrate_prefix,
                        buildOptionLabel: (option) {
                          if (option == null) return context.l10n.settings_encoding_Section_value_auto;
                          return '$option ${context.l10n.settings_encoding_Section_measure_kbps}';
                        },
                        options: EncodingSettings.audioBitrateOptions,
                        selected: settings.audioBitrate,
                        onSelect: (option) => cubit.setSettings(settings.copyWithAudioBitrate(option)),
                      ),
                      const SizedBox(height: 16.0),
                      SlidableSection<int>(
                        title: context.l10n.settings_encoding_Section_target_video_bitrate,
                        optionPrefix: context.l10n.settings_encoding_Section_bitrate_prefix,
                        buildOptionLabel: (option) {
                          if (option == null) return context.l10n.settings_encoding_Section_value_auto;
                          return '$option ${context.l10n.settings_encoding_Section_measure_kbps}';
                        },
                        options: EncodingSettings.videoBitrateOptions,
                        selected: settings.videoBitrate,
                        onSelect: (option) => cubit.setSettings(settings.copyWithVideoBitrate(option)),
                      ),
                      const SizedBox(height: 24),
                      HeadingSection(
                        title: context.l10n.settings_encoding_Section_packetization_title,
                        tooltip: context.l10n.settings_encoding_Section_packetization_tooltip,
                        icon: const Icon(Icons.vertical_split_rounded),
                      ),
                      const SizedBox(height: 16.0),
                      SlidableSection<int>(
                        title: context.l10n.settings_encoding_Section_audio_ptime,
                        optionPrefix: context.l10n.settings_encoding_Section_ptime_prefix,
                        buildOptionLabel: (option) {
                          if (option == null) return context.l10n.settings_encoding_Section_value_auto;
                          return '$option ${context.l10n.settings_encoding_Section_measure_ms}';
                        },
                        options: EncodingSettings.ptimeOptions,
                        selected: settings.ptime,
                        onSelect: (option) {
                          var newSettings = settings.copyWithPtime(option);
                          cubit.setSettings(newSettings);
                          if (option != null && settings.maxptime != null && option > settings.maxptime!) {
                            newSettings = newSettings.copyWithMaxptime(option);
                            cubit.setSettings(newSettings);
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      SlidableSection<int>(
                        title: context.l10n.settings_encoding_Section_audio_ptime_limit,
                        optionPrefix: context.l10n.settings_encoding_Section_ptime_prefix,
                        buildOptionLabel: (option) {
                          if (option == null) return context.l10n.settings_encoding_Section_value_auto;
                          return '$option ${context.l10n.settings_encoding_Section_measure_ms}';
                        },
                        options: EncodingSettings.ptimeOptions,
                        selected: settings.maxptime,
                        onSelect: (option) {
                          var newSettings = settings.copyWithMaxptime(option);
                          cubit.setSettings(newSettings);
                          if (option != null && settings.ptime != null && option < settings.ptime!) {
                            newSettings = newSettings.copyWithPtime(option);
                            cubit.setSettings(newSettings);
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      HeadingSection(
                        title: context.l10n.settings_encoding_Section_opus_title,
                        tooltip: context.l10n.settings_encoding_Section_opus_tooltip,
                        icon: const Icon(Icons.settings),
                      ),
                      const SizedBox(height: 16.0),
                      SlidableSection<int>(
                        title: context.l10n.settings_encoding_Section_opus_bandwidth,
                        optionPrefix: context.l10n.settings_encoding_Section_bandwidth_prefix,
                        buildOptionLabel: (option) {
                          if (option == null) return context.l10n.settings_encoding_Section_value_auto;
                          return '$option ${context.l10n.settings_encoding_Section_measure_hz}';
                        },
                        options: EncodingSettings.opusBandwidthLimitOptions,
                        selected: settings.opusBandwidthLimit,
                        onSelect: (option) => cubit.setSettings(settings.copyWithOpusBandwidthLimit(option)),
                      ),
                      const SizedBox(height: 16.0),
                      ChoosableSection<bool>(
                        title: context.l10n.settings_encoding_Section_opus_channels,
                        buildOptionTitle: (option) {
                          if (option == true) return Text(context.l10n.settings_encoding_Section_value_stereo);
                          if (option == false) return Text(context.l10n.settings_encoding_Section_value_mono);

                          return Text(context.l10n.settings_encoding_Section_value_auto);
                        },
                        options: const [true, false],
                        selected: settings.opusStereo,
                        onSelect: (option) => cubit.setSettings(settings.copyWithOpusStereo(option)),
                      ),
                      const SizedBox(height: 16.0),
                      ChoosableSection<bool>(
                        title: context.l10n.settings_encoding_Section_opus_dtx,
                        buildOptionTitle: (option) {
                          if (option == true) return Text(context.l10n.settings_encoding_Section_value_enable);
                          if (option == false) return Text(context.l10n.settings_encoding_Section_value_disable);

                          return Text(context.l10n.settings_encoding_Section_value_auto);
                        },
                        options: const [true, false],
                        selected: settings.opusDtx,
                        onSelect: (option) => cubit.setSettings(settings.copyWithOpusDtx(option)),
                      ),
                      const SizedBox(height: 24),
                      HeadingSection(
                        title: context.l10n.settings_encoding_Section_rtp_override_title,
                        tooltip: context.l10n.settings_encoding_Section_rtp_override_tooltip,
                        icon: const Icon(Icons.sip),
                      ),
                      const SizedBox(height: 16.0),
                      ReorderableSection<RTPCodecProfile>(
                        title: context.l10n.settings_encoding_Section_rtp_override_audio,
                        warningTitle: context.l10n.settings_encoding_Section_rtp_override_warning_title,
                        warningMessage: context.l10n.settings_encoding_Section_rtp_override_warning_message,
                        buildOptionTitle: (option) {
                          if (option == null) return Text(context.l10n.settings_encoding_Section_value_auto);
                          return Text(option.name);
                        },
                        enabled: settings.audioProfiles != null,
                        onEnable: (enabled) {
                          if (enabled) {
                            var profiles = EncodingSettings.defaultAudioProfilesOrder;
                            cubit.setSettings(settings.copyWithAudioProfiles(profiles));
                          } else {
                            cubit.setSettings(settings.copyWithAudioProfiles(null));
                          }
                        },
                        items: settings.audioProfiles ?? [],
                        onChange: (items) => cubit.setSettings(settings.copyWithAudioProfiles(items)),
                      ),
                      const SizedBox(height: 16.0),
                      ReorderableSection<RTPCodecProfile>(
                        title: context.l10n.settings_encoding_Section_rtp_override_video,
                        warningTitle: context.l10n.settings_encoding_Section_rtp_override_warning_title,
                        warningMessage: context.l10n.settings_encoding_Section_rtp_override_warning_message,
                        buildOptionTitle: (option) {
                          if (option == null) return Text(context.l10n.settings_encoding_Section_value_auto);
                          return Text(option.name);
                        },
                        enabled: settings.videoProfiles != null,
                        onEnable: (enabled) {
                          if (enabled) {
                            var profiles = EncodingSettings.defaultVideoProfilesOrder;
                            cubit.setSettings(settings.copyWithVideoProfiles(profiles));
                          } else {
                            cubit.setSettings(settings.copyWithVideoProfiles(null));
                          }
                        },
                        items: settings.videoProfiles ?? [],
                        onChange: (items) => cubit.setSettings(settings.copyWithVideoProfiles(items)),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HeadingSection extends StatelessWidget {
  const HeadingSection({
    required this.title,
    required this.tooltip,
    required this.icon,
    super.key,
  });

  final String title;
  final String tooltip;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600);

    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: textStyle)),
        const SizedBox(width: 8),
        Tooltip(
          message: tooltip,
          triggerMode: TooltipTriggerMode.tap,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          showDuration: const Duration(seconds: 10),
          child: const Icon(Icons.info_outline),
        )
      ],
    );
  }
}

class ChoosableSection<T> extends StatelessWidget {
  const ChoosableSection({
    required this.title,
    required this.buildOptionTitle,
    required this.options,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final String? title;
  final Widget Function(T?) buildOptionTitle;

  final List<T> options;
  final T? selected;
  final Function(T?) onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null) ...[
          Row(
            children: [
              const SizedBox(width: 4),
              Expanded(child: Text(title!)),
              const SizedBox(width: 4),
            ],
          ),
          const SizedBox(height: 8.0),
        ],
        ListTile(
          selected: selected == null,
          title: buildOptionTitle(null),
          onTap: () => onSelect(null),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Icon(selected == null ? Icons.radio_button_checked : Icons.radio_button_unchecked),
          // contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          minTileHeight: 0,
        ),
        for (final option in options)
          ListTile(
            selected: selected == option,
            title: buildOptionTitle(option),
            onTap: () => onSelect(option),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            leading: Icon(selected == option ? Icons.radio_button_checked : Icons.radio_button_unchecked),
            // contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            minTileHeight: 0,
          ),
      ],
    );
  }
}

class SlidableSection<T> extends StatelessWidget {
  const SlidableSection({
    required this.title,
    required this.optionPrefix,
    required this.buildOptionLabel,
    required this.options,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final String title;
  final String optionPrefix;
  final String Function(T?) buildOptionLabel;

  final List<T> options;
  final T? selected;
  final Function(T?) onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 4),
            Expanded(child: Text(title)),
            const SizedBox(width: 4),
          ],
        ),
        Slider(
          value: selected == null ? 0 : options.indexOf(selected as T) + 1,
          secondaryTrackValue: 0.1,
          onChanged: (v) {
            if (v == 0) {
              onSelect(null);
            } else {
              final index = v.round() - 1;
              onSelect(options[index]);
            }
          },
          min: 0,
          max: options.length.toDouble(),
          divisions: options.length + 1,
          label: buildOptionLabel(selected),
        ),
        Row(
          children: [
            const SizedBox(width: 24),
            Text(optionPrefix),
            Text(
              buildOptionLabel(selected),
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }
}

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
