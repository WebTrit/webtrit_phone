import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/settings/features/media_settings/media_settings.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class AudioProcessingContent extends StatelessWidget {
  const AudioProcessingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MediaSettingsCubit>();

    return BlocBuilder<MediaSettingsCubit, MediaSettingsState>(
      buildWhen: (p, c) => p.audioProcessingSettings != c.audioProcessingSettings,
      builder: (context, state) {
        final audioProcessingSettings = state.audioProcessingSettings;

        return Column(
          spacing: 16,
          children: [
            InlineChoosableSection<bool>(
              title: context.l10n.settings_audioProcessing_Section_VP_title,
              buildOptionTitle: (option) {
                if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
                if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

                return Text(context.l10n.settings_encoding_Section_value_auto);
              },
              options: const [true, false],
              selected: audioProcessingSettings.bypassVoiceProcessing,
              onSelect: (option) =>
                  cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithBypassVoiceProcessing(option)),
            ),
            InlineChoosableSection<bool>(
              title: context.l10n.settings_audioProcessing_Section_EC_title,
              buildOptionTitle: (option) {
                if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
                if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

                return Text(context.l10n.settings_encoding_Section_value_auto);
              },
              options: const [true, false],
              selected: audioProcessingSettings.echoCancellation,
              onSelect: (option) =>
                  cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithEchoCancellation(option)),
            ),
            InlineChoosableSection<bool>(
              title: context.l10n.settings_audioProcessing_Section_AGC_title,
              buildOptionTitle: (option) {
                if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
                if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

                return Text(context.l10n.settings_encoding_Section_value_auto);
              },
              options: const [true, false],
              selected: audioProcessingSettings.autoGainControl,
              onSelect: (option) =>
                  cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithAutoGainControl(option)),
            ),
            InlineChoosableSection<bool>(
              title: context.l10n.settings_audioProcessing_Section_NS_title,
              buildOptionTitle: (option) {
                if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
                if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

                return Text(context.l10n.settings_encoding_Section_value_auto);
              },
              options: const [true, false],
              selected: audioProcessingSettings.noiseSuppression,
              onSelect: (option) =>
                  cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithNoiseSuppression(option)),
            ),
            InlineChoosableSection<bool>(
              title: context.l10n.settings_audioProcessing_Section_HPF_title,
              buildOptionTitle: (option) {
                if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
                if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

                return Text(context.l10n.settings_encoding_Section_value_auto);
              },
              options: const [true, false],
              selected: audioProcessingSettings.highpassFilter,
              onSelect: (option) =>
                  cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithHighpassFilter(option)),
            ),
            InlineChoosableSection<bool>(
              title: context.l10n.settings_audioProcessing_Section_AM_title,
              buildOptionTitle: (option) {
                if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
                if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

                return Text(context.l10n.settings_encoding_Section_value_auto);
              },
              options: const [true, false],
              selected: audioProcessingSettings.audioMirroring,
              onSelect: (option) =>
                  cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithAudioMirroring(option)),
            ),
          ],
        );
      },
    );
  }
}
