import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../view/components/choosable_section.dart';
import '../view/components/heading_section.dart';

class PeerConnectionSettingsSection extends StatelessWidget {
  const PeerConnectionSettingsSection({
    super.key,
    required this.peerConnectionSettings,
    required this.onSettingsChanged,
  });

  final PeerConnectionSettings peerConnectionSettings;
  final ValueChanged<PeerConnectionSettings> onSettingsChanged;

  void _onCalleeVideoOfferPolicyChanged(CalleeVideoOfferPolicy? policy) {
    onSettingsChanged(PeerConnectionSettings(
      negotiationSettings: peerConnectionSettings.negotiationSettings.copyWith(
        calleeVideoOfferPolicy: policy,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadingSection(
          title: context.l10n.settings_connectionSection_title,
          tooltip: context.l10n.settings_connectionSection_tooltip,
          icon: const Icon(Icons.sync_alt),
        ),
        const SizedBox(height: 16.0),
        ChoosableSection<CalleeVideoOfferPolicy>(
          allowNoSelection: false,
          title: context.l10n.settings_videoOffer_title,
          buildOptionTitle: (option) {
            if (option == CalleeVideoOfferPolicy.includeInactiveTrack) {
              return Text(context.l10n.settings_videoOffer_option_includeInactive);
            }
            return Text(context.l10n.settings_videoOffer_option_ignore);
          },
          options: CalleeVideoOfferPolicy.values,
          selected: peerConnectionSettings.negotiationSettings.calleeVideoOfferPolicy,
          onSelect: _onCalleeVideoOfferPolicyChanged,
        ),
      ],
    );
  }
}
