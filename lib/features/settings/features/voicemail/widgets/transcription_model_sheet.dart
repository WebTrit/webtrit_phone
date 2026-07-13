import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

/// Bottom sheet with the on-device transcription model tiers.
///
/// Offers the fast/balanced/accurate presets plus, when the app-config
/// default (or the stored selection) is a tier outside the presets, that
/// tier as an extra option so the current state is always visible.
class TranscriptionModelSheet extends StatelessWidget {
  const TranscriptionModelSheet({
    required this.defaultModel,
    required this.selectedModel,
    required this.onSelected,
    super.key,
  });

  /// Brand default tier from the app config; marked in the list and used to
  /// clear the user override when picked.
  final String defaultModel;

  /// Currently effective tier.
  final String selectedModel;

  final ValueChanged<String> onSelected;

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
    onSelected(model);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final options = [..._presetTiers];
    for (final extra in [defaultModel, selectedModel]) {
      if (!options.contains(extra)) options.add(extra);
    }

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(context.l10n.voicemail_TranscriptionModel_title, style: theme.textTheme.titleMedium),
          ),
          RadioGroup<String>(
            groupValue: selectedModel,
            onChanged: (model) => _onChanged(context, model),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final model in options)
                  RadioListTile<String>(
                    value: model,
                    title: Text(
                      model == defaultModel
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
      ),
    );
  }
}
