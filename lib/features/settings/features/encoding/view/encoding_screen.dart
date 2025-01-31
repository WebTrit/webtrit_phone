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
            // TODO: l10n
            tooltip: 'Reset',
            onPressed: () => cubit.setNew(EncodingSettings.blank()),
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
      body: BlocBuilder<EncodingSettingsCubit, EncodingSettings>(
        builder: (context, settings) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HeadingSection(
                  title: 'Codec bitrate settings',
                  tooltip:
                      'Adjust the bitrate settings for audio and video codecs, lower values will reduce the bandwidth usage but affect the quality, higher values will increase the quality but also the bandwidth usage.',
                  icon: Icon(Icons.one_k_plus_sharp),
                ),
                const SizedBox(height: 16.0),
                SlidableSection<int>(
                  title: 'Audio target bitrate: ',
                  optionPrefix: 'Bitrate: ',
                  buildOptionLabel: (option) {
                    if (option == null) return 'Auto';
                    return '$option kbps';
                  },
                  options: EncodingSettings.audioBitrateOptions,
                  selected: settings.audioBitrate,
                  onSelect: (option) => cubit.setNew(settings.copyWithAudioBitrate(option)),
                ),
                const SizedBox(height: 16.0),
                SlidableSection<int>(
                  title: 'Video target bitrate: ',
                  optionPrefix: 'Bitrate: ',
                  buildOptionLabel: (option) {
                    if (option == null) return 'Auto';
                    return '$option kbps';
                  },
                  options: EncodingSettings.videoBitrateOptions,
                  selected: settings.videoBitrate,
                  onSelect: (option) => cubit.setNew(settings.copyWithVideoBitrate(option)),
                ),
                const SizedBox(height: 24),
                const HeadingSection(
                  title: 'Audio packetization',
                  tooltip:
                      'Adjust audio packetization-time in milliseconds, can be used to reduce audio latency or fix Network MTU size issues',
                  icon: Icon(Icons.vertical_split_rounded),
                ),
                const SizedBox(height: 16.0),
                SlidableSection<int>(
                  title: 'Audio target ptime: ',
                  optionPrefix: 'Ptime: ',
                  buildOptionLabel: (option) {
                    if (option == null) return 'Auto';
                    return '$option ms';
                  },
                  options: EncodingSettings.ptimeOptions,
                  selected: settings.ptime,
                  onSelect: (option) {
                    var newSettings = settings.copyWithPtime(option);
                    cubit.setNew(newSettings);
                    if (option != null && settings.maxptime != null && option > settings.maxptime!) {
                      newSettings = newSettings.copyWithMaxptime(option);
                      cubit.setNew(newSettings);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                SlidableSection<int>(
                  title: 'Audio ptime limit: ',
                  optionPrefix: 'Ptime: ',
                  buildOptionLabel: (option) {
                    if (option == null) return 'Auto';
                    return '$option ms';
                  },
                  options: EncodingSettings.ptimeOptions,
                  selected: settings.maxptime,
                  onSelect: (option) {
                    var newSettings = settings.copyWithMaxptime(option);
                    cubit.setNew(newSettings);
                    if (option != null && settings.ptime != null && option < settings.ptime!) {
                      newSettings = newSettings.copyWithPtime(option);
                      cubit.setNew(newSettings);
                    }
                  },
                ),
                const SizedBox(height: 24),
                const HeadingSection(
                  title: 'Opus codec tuning',
                  tooltip:
                      'Adjust the opus specific codec settings, can be used to reduce bandwidth usage or improve audio quality',
                  icon: Icon(Icons.settings),
                ),
                const SizedBox(height: 16.0),
                SlidableSection<int>(
                  title: 'Opus bandwidth override: ',
                  optionPrefix: 'Bandwidth: ',
                  buildOptionLabel: (option) {
                    if (option == null) return 'Auto';
                    return '${option}hz';
                  },
                  options: EncodingSettings.opusBandwidthLimitOptions,
                  selected: settings.opusBandwidthLimit,
                  onSelect: (option) => cubit.setNew(settings.copyWithOpusBandwidthLimit(option)),
                ),
                const SizedBox(height: 16.0),
                ChoosableSection<bool>(
                  title: 'Opus channels override: ',
                  buildOptionTitle: (option) {
                    if (option == null) return const Text('Auto');
                    return Text(option ? 'Stereo' : 'Mono');
                  },
                  options: const [true, false],
                  selected: settings.opusStereo,
                  onSelect: (option) => cubit.setNew(settings.copyWithOpusStereo(option)),
                ),
                const SizedBox(height: 24),
                const HeadingSection(
                  title: 'RTP Profiles priority and exclusion',
                  tooltip:
                      'Can be used to override the audio and video profiles priority order or exclude some profiles from SDP negotiation list',
                  icon: Icon(Icons.sip),
                ),
                const SizedBox(height: 16.0),
                ReorderableSection<RTPCodecProfile>(
                  title: 'Audio RTP Profiles override',
                  buildOptionTitle: (option) {
                    if (option == null) return const Text('Auto');
                    return Text(option.name);
                  },
                  enabled: settings.audioProfiles != null,
                  onEnable: (enabled) {
                    if (enabled) {
                      var profiles = EncodingSettings.defaultAudioProfilesOrder;
                      cubit.setNew(settings.copyWithAudioProfiles(profiles));
                    } else {
                      cubit.setNew(settings.copyWithAudioProfiles(null));
                    }
                  },
                  items: settings.audioProfiles ?? [],
                  onChange: (items) => cubit.setNew(settings.copyWithAudioProfiles(items)),
                ),
                const SizedBox(height: 16.0),
                ReorderableSection<RTPCodecProfile>(
                  title: 'Video RTP Profiles override',
                  buildOptionTitle: (option) {
                    if (option == null) return const Text('Auto');
                    return Text(option.name);
                  },
                  enabled: settings.videoProfiles != null,
                  onEnable: (enabled) {
                    if (enabled) {
                      var profiles = EncodingSettings.defaultVideoProfilesOrder;
                      cubit.setNew(settings.copyWithVideoProfiles(profiles));
                    } else {
                      cubit.setNew(settings.copyWithVideoProfiles(null));
                    }
                  },
                  items: settings.videoProfiles ?? [],
                  onChange: (items) => cubit.setNew(settings.copyWithVideoProfiles(items)),
                ),
                const SizedBox(height: 16.0),
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
    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Tooltip(
          message: tooltip,
          triggerMode: TooltipTriggerMode.tap,
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.all(8.0),
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

  final String title;
  final Widget Function(T?) buildOptionTitle;

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
            Text(title),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 8.0),
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
            Text(title),
            const Spacer(),
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
    required this.buildOptionTitle,
    required this.enabled,
    required this.onEnable,
    required this.items,
    required this.onChange,
    super.key,
  });

  final String title;

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
            Text(title),
            const Spacer(),
            Switch(value: enabled, onChanged: onEnable),
            const SizedBox(width: 8.0),
          ],
        ),
        if (enabled) ...[
          Column(
            children: [
              // TODO: l10n
              Text(
                'Warning:',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              Text(
                'Overriding may affect the compatibility with other devices or media systems and cause call errors, use only if you know what you are doing.',
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
