import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/settings/features/media_settings/media_settings.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/video_capturing_settings.dart';

class VideoCapturingContent extends StatelessWidget {
  const VideoCapturingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MediaSettingsCubit>();

    return BlocBuilder<MediaSettingsCubit, MediaSettingsState>(
      buildWhen: (p, c) => p.videoCapturingSettings != c.videoCapturingSettings,
      builder: (context, state) {
        final videoCapturingSettings = state.videoCapturingSettings;
        return Column(
          spacing: 16,
          children: [
            SlidableSection<Resolution>(
              title: context.l10n.settings_videoCapturing_Section_resolution_title,
              optionPrefix: context.l10n.settings_videoCapturing_Section_resolution_prefix,
              buildOptionLabel: (option) {
                if (option == null) return context.l10n.settings_encoding_Section_value_auto;
                return option.str;
              },
              options: Resolution.values,
              selected: videoCapturingSettings.resolution,
              onSelect: (option) => cubit.setVideoCapturingSettings(videoCapturingSettings.copyWithResolution(option)),
            ),
            SlidableSection<Framerate>(
              title: context.l10n.settings_videoCapturing_Section_framerate_title,
              optionPrefix: context.l10n.settings_videoCapturing_Section_framerate_prefix,
              buildOptionLabel: (option) {
                if (option == null) return context.l10n.settings_encoding_Section_value_auto;
                return option.str;
              },
              options: Framerate.values,
              selected: videoCapturingSettings.framerate,
              onSelect: (option) => cubit.setVideoCapturingSettings(videoCapturingSettings.copyWithFramerate(option)),
            ),
          ],
        );
      },
    );
  }
}
