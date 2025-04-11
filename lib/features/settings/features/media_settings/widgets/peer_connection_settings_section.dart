import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../view/components/heading_section.dart';

class PeerConnectionSettingsSection extends StatelessWidget {
  const PeerConnectionSettingsSection({
    super.key,
    required this.peerConnectionSettings,
    required this.onSettingsChanged,
  });

  final PeerConnectionSettings peerConnectionSettings;
  final ValueChanged<PeerConnectionSettings> onSettingsChanged;

  void _onIncludeInactiveTrack(bool? includeInactiveVideoInOfferAnswer) {
    onSettingsChanged(
      peerConnectionSettings.copyWith(
        negotiationSettings: peerConnectionSettings.negotiationSettings.copyWith(
          includeInactiveVideoInOfferAnswer: includeInactiveVideoInOfferAnswer ?? false,
        ),
      ),
    );
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
        CheckboxListTile(
          value: peerConnectionSettings.negotiationSettings.includeInactiveVideoInOfferAnswer,
          onChanged: _onIncludeInactiveTrack,
          visualDensity: VisualDensity.compact,
          title: Text(context.l10n.settings_videoOffer_option_includeInactive),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
