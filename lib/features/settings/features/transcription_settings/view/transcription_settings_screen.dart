import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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

  static const _presetTiers = ['base', 'small', 'medium'];

  String _titleFor(BuildContext context, String model) {
    return switch (model) {
      'base' => context.l10n.voicemail_TranscriptionModel_fastTitle,
      'small' => context.l10n.voicemail_TranscriptionModel_balancedTitle,
      'medium' => context.l10n.voicemail_TranscriptionModel_accurateTitle,
      _ => model,
    };
  }

  String? _subtitleFor(BuildContext context, String model) {
    return switch (model) {
      'base' => context.l10n.voicemail_TranscriptionModel_fastSubtitle,
      'small' => context.l10n.voicemail_TranscriptionModel_balancedSubtitle,
      'medium' => context.l10n.voicemail_TranscriptionModel_accurateSubtitle,
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
      appBar: AppBar(title: Text(context.l10n.voicemail_TranscriptionModel_title), leading: const ExtBackButton()),
      body: BlocBuilder<TranscriptionSettingsCubit, TranscriptionSettingsState>(
        builder: (context, state) {
          final options = [..._presetTiers];
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
                              ? '${_titleFor(context, model)} (${context.l10n.voicemail_TranscriptionModel_defaultLabel})'
                              : _titleFor(context, model),
                        ),
                        subtitle: _subtitleFor(context, model) != null ? Text(_subtitleFor(context, model)!) : null,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Text(context.l10n.voicemail_TranscriptionModel_note, style: theme.textTheme.bodySmall),
              ),
            ],
          );
        },
      ),
    );
  }
}
