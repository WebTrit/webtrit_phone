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

  late int openedTile = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Theme(
          data: theme.copyWith(
            expansionTileTheme: ExpansionTileThemeData(
              tilePadding: const EdgeInsets.symmetric(horizontal: 8),
              childrenPadding: const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
              backgroundColor: colorScheme.surface,
              collapsedBackgroundColor: colorScheme.surface,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              ExpansionTile(
                key: UniqueKey(),
                initiallyExpanded: openedTile == 0,
                title: HeadingSection(
                  title: l10n.settings_encoding_Section_preset_title,
                  tooltip: l10n.settings_encoding_Section_preset_tooltip,
                  icon: const Icon(Icons.segment_outlined),
                ),
                onExpansionChanged: (newState) => setState(() {
                  openedTile = newState ? 0 : -1;
                }),
                children: [
                  const EncodingPresetContent(),
                  BlocBuilder<MediaSettingsCubit, MediaSettingsState>(
                    buildWhen: (p, c) => p.encodingPreset != c.encodingPreset,
                    builder: (context, state) {
                      final encodingPreset = state.encodingPreset;

                      if (encodingPreset == EncodingPreset.custom) {
                        return const Column(children: [Divider(height: 24), EncodingCustomContent()]);
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
              ExpansionTile(
                key: UniqueKey(),
                initiallyExpanded: openedTile == 1,
                title: HeadingSection(
                  title: l10n.settings_audioProcessing_Section_title,
                  tooltip: l10n.settings_audioProcessing_Section_tooltip,
                  icon: const Icon(Icons.multitrack_audio),
                ),
                onExpansionChanged: (newState) => setState(() {
                  openedTile = newState ? 1 : -1;
                }),
                children: const [AudioProcessingContent()],
              ),
              ExpansionTile(
                key: UniqueKey(),
                initiallyExpanded: openedTile == 2,
                title: HeadingSection(
                  title: l10n.settings_videoCapturing_Section_title,
                  tooltip: l10n.settings_videoCapturing_Section_tooltip,
                  icon: const Icon(Icons.video_settings_rounded),
                ),
                onExpansionChanged: (newState) => setState(() {
                  openedTile = newState ? 2 : -1;
                }),
                children: const [VideoCapturingContent()],
              ),
              ExpansionTile(
                key: UniqueKey(),
                initiallyExpanded: openedTile == 3,
                title: HeadingSection(
                  title: l10n.settings_iceSettings_Section_title,
                  tooltip: l10n.settings_iceSettings_Section_tooltip,
                  icon: const Icon(Icons.bubble_chart),
                ),
                onExpansionChanged: (newState) => setState(() {
                  openedTile = newState ? 3 : -1;
                }),
                children: const [IceSettingsContent()],
              ),
              ExpansionTile(
                key: UniqueKey(),
                initiallyExpanded: openedTile == 4,
                title: HeadingSection(
                  title: l10n.settings_connectionSection_title,
                  tooltip: l10n.settings_connectionSection_tooltip,
                  icon: const Icon(Icons.sync_alt),
                ),
                onExpansionChanged: (newState) => setState(() {
                  openedTile = newState ? 4 : -1;
                }),
                children: const [PeerConnectionSettingsContent()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
