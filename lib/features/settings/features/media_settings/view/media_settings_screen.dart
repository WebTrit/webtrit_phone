import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'components/components.dart';
import '../media_settings.dart';

class MediaSettingsScreen extends StatefulWidget {
  const MediaSettingsScreen({super.key});

  @override
  State<MediaSettingsScreen> createState() => _MediaSettingsScreenState();
}

class _MediaSettingsScreenState extends State<MediaSettingsScreen> {
  late final cubit = context.read<MediaSettingsCubit>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    final contentPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8);
    final borderRadius = BorderRadius.circular(12.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings_ListViewTileTitle_mediaSettings),
        leading: const ExtBackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_backup_restore),
            tooltip: l10n.settings_encoding_AppBar_reset_tooltip,
            onPressed: () => cubit.reset(),
            color: colorScheme.onSurface,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: contentPadding,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: ExpansionPanelList.radio(
            elevation: 0,
            children: [
              ExpansionPanelRadio(
                value: 0,
                canTapOnHeader: true,
                headerBuilder: (_, isExpanded) => HeadingSection(
                  title: l10n.settings_encoding_Section_preset_title,
                  tooltip: l10n.settings_encoding_Section_preset_tooltip,
                  icon: const Icon(Icons.segment_outlined),
                  selected: isExpanded,
                ),
                body: Padding(
                  padding: contentPadding,
                  child: Column(
                    children: [
                      const EncodingPresetContent(),
                      BlocBuilder<MediaSettingsCubit, MediaSettingsState>(
                        buildWhen: (p, c) => p.encodingPreset != c.encodingPreset,
                        builder: (context, state) {
                          if (state.encodingPreset == EncodingPreset.custom) {
                            return const Column(children: [Divider(height: 24), EncodingCustomContent()]);
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionPanelRadio(
                value: 1,
                canTapOnHeader: true,
                headerBuilder: (_, isExpanded) => HeadingSection(
                  title: l10n.settings_audioProcessing_Section_title,
                  tooltip: l10n.settings_audioProcessing_Section_tooltip,
                  icon: const Icon(Icons.multitrack_audio),
                  selected: isExpanded,
                ),
                body: Padding(padding: contentPadding, child: AudioProcessingContent()),
              ),
              ExpansionPanelRadio(
                value: 2,
                canTapOnHeader: true,
                headerBuilder: (_, isExpanded) => HeadingSection(
                  title: l10n.settings_videoCapturing_Section_title,
                  tooltip: l10n.settings_videoCapturing_Section_tooltip,
                  icon: const Icon(Icons.video_settings_rounded),
                  selected: isExpanded,
                ),
                body: Padding(padding: contentPadding, child: VideoCapturingContent()),
              ),
              ExpansionPanelRadio(
                value: 3,
                canTapOnHeader: true,
                headerBuilder: (_, isExpanded) => HeadingSection(
                  title: l10n.settings_iceSettings_Section_title,
                  tooltip: l10n.settings_iceSettings_Section_tooltip,
                  icon: const Icon(Icons.bubble_chart),
                  selected: isExpanded,
                ),
                body: Padding(padding: contentPadding, child: IceSettingsContent()),
              ),
              ExpansionPanelRadio(
                value: 4,
                canTapOnHeader: true,
                headerBuilder: (_, isExpanded) => HeadingSection(
                  title: l10n.settings_connectionSection_title,
                  tooltip: l10n.settings_connectionSection_tooltip,
                  icon: const Icon(Icons.sync_alt),
                  selected: isExpanded,
                ),
                body: Padding(padding: contentPadding, child: PeerConnectionSettingsContent()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
