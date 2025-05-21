import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/settings/features/media_settings/media_settings.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class PeerConnectionSettingsContent extends StatelessWidget {
  const PeerConnectionSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MediaSettingsCubit>();

    return BlocBuilder<MediaSettingsCubit, MediaSettingsState>(
      buildWhen: (p, c) => p.pearConnectionSettings != c.pearConnectionSettings,
      builder: (context, state) {
        final peerConnectionSettings = state.pearConnectionSettings;

        return Column(
          spacing: 16,
          children: [
            CheckboxListTile(
              value: peerConnectionSettings.negotiationSettings.includeInactiveVideoInOfferAnswer,
              onChanged: (value) => cubit.setPeerConnectionSettings(
                peerConnectionSettings.copyWith(
                  negotiationSettings: peerConnectionSettings.negotiationSettings.copyWith(
                    includeInactiveVideoInOfferAnswer: value ?? false,
                  ),
                ),
              ),
              visualDensity: VisualDensity.compact,
              title: Text(context.l10n.settings_videoOffer_option_includeInactive),
            ),
          ],
        );
      },
    );
  }
}
