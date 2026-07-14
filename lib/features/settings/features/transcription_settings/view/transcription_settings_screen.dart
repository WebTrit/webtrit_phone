import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../cubit/transcription_settings_cubit.dart';

/// Central place to manage the on-device transcription: the model tier list.
///
/// Offers the fast/balanced/accurate presets plus, when the app-config
/// default (or the stored selection) is a tier outside the presets, that
/// tier as an extra option so the current state is always visible.
class TranscriptionSettingsScreen extends StatelessWidget {
  const TranscriptionSettingsScreen({super.key});

  String _titleFor(BuildContext context, String model) {
    return switch (model) {
      'base' => context.l10n.transcriptionSettings_Model_fastTitle,
      'small' => context.l10n.transcriptionSettings_Model_balancedTitle,
      'medium' => context.l10n.transcriptionSettings_Model_accurateTitle,
      _ => model,
    };
  }

  String? _subtitleFor(BuildContext context, String model) {
    return switch (model) {
      'base' => context.l10n.transcriptionSettings_Model_fastSubtitle,
      'small' => context.l10n.transcriptionSettings_Model_balancedSubtitle,
      'medium' => context.l10n.transcriptionSettings_Model_accurateSubtitle,
      _ => null,
    };
  }

  void _onChanged(BuildContext context, String? model) {
    if (model == null) return;
    context.read<TranscriptionSettingsCubit>().setModel(model);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.transcriptionSettings_Widget_screenTitle),
        leading: const ExtBackButton(),
      ),
      body: BlocBuilder<TranscriptionSettingsCubit, TranscriptionSettingsState>(
        builder: (context, state) {
          final options = [...kTranscriptionModelPresets];
          for (final extra in [state.defaultModel, state.selectedModel]) {
            if (!options.contains(extra)) options.add(extra);
          }

          return ListView(
            children: [
              RadioGroup<String>(
                groupValue: state.selectedModel,
                onChanged: (model) => _onChanged(context, model),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final model in options)
                      RadioListTile<String>(
                        value: model,
                        title: Text(
                          model == state.defaultModel
                              ? '${_titleFor(context, model)} (${context.l10n.transcriptionSettings_Model_defaultLabel})'
                              : _titleFor(context, model),
                        ),
                        subtitle: _subtitleFor(context, model) != null ? Text(_subtitleFor(context, model)!) : null,
                        secondary: state.downloadedModels.contains(model)
                            ? Tooltip(
                                message: context.l10n.transcriptionSettings_Model_downloadedLabel,
                                child: const Icon(Icons.download_done),
                              )
                            : null,
                      ),
                  ],
                ),
              ),
              _DownloadStatus(downloadState: state.downloadState),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Text(context.l10n.transcriptionSettings_Model_note, style: theme.textTheme.bodySmall),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Live state of the active tier's model download: a progress bar while it
/// runs, a retry affordance when it failed, nothing otherwise.
class _DownloadStatus extends StatelessWidget {
  const _DownloadStatus({required this.downloadState});

  final ModelDownloadState downloadState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final downloadState = this.downloadState;

    return switch (downloadState) {
      ModelDownloading() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              downloadState.progress != null
                  ? '${context.l10n.transcriptionSettings_Download_inProgress}'
                        ' (${(downloadState.progress! * 100).round()}%)'
                  : context.l10n.transcriptionSettings_Download_inProgress,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(value: downloadState.progress),
          ],
        ),
      ),
      ModelDownloadFailed() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.transcriptionSettings_Download_failed,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
              ),
            ),
            TextButton(
              onPressed: () => context.read<TranscriptionSettingsCubit>().retryDownload(),
              child: Text(context.l10n.transcriptionSettings_Download_retry),
            ),
          ],
        ),
      ),
      ModelDownloadIdle() || ModelDownloadReady() => const SizedBox.shrink(),
    };
  }
}
