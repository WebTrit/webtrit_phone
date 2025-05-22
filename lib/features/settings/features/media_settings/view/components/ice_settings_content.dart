import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/settings/features/media_settings/media_settings.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/ice_settings.dart';

class IceSettingsContent extends StatelessWidget {
  const IceSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MediaSettingsCubit>();

    return BlocBuilder<MediaSettingsCubit, MediaSettingsState>(
      buildWhen: (p, c) => p.iceSettings != c.iceSettings,
      builder: (context, state) {
        final iceSettings = state.iceSettings;

        return Column(
          spacing: 16,
          children: [
            ChoosableSection<IceNetworkFilter>(
              title: context.l10n.settings_iceSettings_Section_netfilter_title,
              buildOptionTitle: (option) {
                if (option == IceNetworkFilter.ipv4) {
                  return Text(context.l10n.settings_iceSettings_Section_netfilter_skipv4);
                }
                if (option == IceNetworkFilter.ipv6) {
                  return Text(context.l10n.settings_iceSettings_Section_netfilter_skipv6);
                }

                return Text(context.l10n.settings_iceSettings_Section_noskip);
              },
              options: const [IceNetworkFilter.ipv4, IceNetworkFilter.ipv6],
              selected: iceSettings.iceNetworkFilter,
              onSelect: (option) => cubit.setIceSettings(iceSettings.copyWithNetworkFilter(option)),
            ),
            ChoosableSection<IceTransportFilter>(
              title: context.l10n.settings_iceSettings_Section_trfilter_title,
              buildOptionTitle: (option) {
                if (option == IceTransportFilter.tcp) {
                  return Text(context.l10n.settings_iceSettings_Section_trfilter_skipTcp);
                }
                if (option == IceTransportFilter.udp) {
                  return Text(context.l10n.settings_iceSettings_Section_trfilter_skipUdp);
                }

                return Text(context.l10n.settings_iceSettings_Section_noskip);
              },
              options: const [IceTransportFilter.tcp, IceTransportFilter.udp],
              selected: iceSettings.iceTransportFilter,
              onSelect: (option) => cubit.setIceSettings(iceSettings.copyWithTransportFilter(option)),
            ),
          ],
        );
      },
    );
  }
}
