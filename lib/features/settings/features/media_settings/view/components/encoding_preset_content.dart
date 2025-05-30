import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/settings/features/media_settings/media_settings.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';

class EncodingPresetContent extends StatelessWidget {
  const EncodingPresetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MediaSettingsCubit>();

    return BlocBuilder<MediaSettingsCubit, MediaSettingsState>(
      buildWhen: (p, c) => p.encodingPreset != c.encodingPreset,
      builder: (context, state) {
        final encodingPreset = state.encodingPreset;

        return Column(
          children: [
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
                  EncodingPreset.bypass => context.l10n.settings_encoding_Section_preset_bypass,
                });
              },
              options: EncodingPreset.values,
              selected: encodingPreset,
              onSelect: (option) => cubit.setEncodingPreset(option),
            ),
          ],
        );
      },
    );
  }
}
