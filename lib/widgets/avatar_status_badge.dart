import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

import '../utils/utils.dart';
import 'sip_presence_indicator.dart';

/// Contact status badge for the `LeadingAvatar` badge slot.
///
/// Owns the choice between the two status generations - the legacy
/// SIP-registration dot and the hybrid presence indicator - based on
/// [PresenceViewParams], so neither the avatar nor its callers need to know
/// which one a deployment uses. Sizes itself relative to the slot it is
/// given, matching the avatar's bottom-right badge geometry.
class AvatarStatusBadge extends StatelessWidget {
  const AvatarStatusBadge({super.key, this.registered, this.presenceInfo, this.dialogInfo});

  /// The badge for the given data, or `null` when there is no status data at
  /// all - so the avatar mounts nothing instead of an empty badge.
  static AvatarStatusBadge? maybe({bool? registered, List<PresenceInfo>? presenceInfo, List<DialogInfo>? dialogInfo}) {
    if (registered == null && presenceInfo == null && dialogInfo == null) return null;
    return AvatarStatusBadge(registered: registered, presenceInfo: presenceInfo, dialogInfo: dialogInfo);
  }

  /// SIP registration state feeding the legacy dot; `null` means the state
  /// is unknown, and without hybrid presence support no badge is shown.
  final bool? registered;

  /// Presence states feeding the hybrid indicator; `null` means presence is
  /// not tracked for this contact, and with hybrid presence support no badge
  /// is shown.
  final List<PresenceInfo>? presenceInfo;

  /// BLF dialog states of the contact; a non-empty list marks the contact as
  /// on a call via the activity icon of the hybrid indicator.
  final List<DialogInfo>? dialogInfo;

  @override
  Widget build(BuildContext context) {
    final presenceParams = PresenceViewParams.of(context);
    final style = Theme.of(context).extension<LeadingAvatarStyles>()?.primary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;

        if (presenceParams.hybridPresenceSupport) {
          final presenceInfo = this.presenceInfo;
          if (presenceInfo == null) return const SizedBox.shrink();

          final rect = BadgeLayout.bottomRightSquare(size: size, sizeFactor: style?.presenceBadge?.sizeFactor ?? 0.325);
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fromRect(
                rect: rect,
                child: SipPresenceIndicator(
                  presenceInfo: presenceInfo,
                  dialogInfo: dialogInfo ?? const [],
                  presenceRect: rect,
                ),
              ),
            ],
          );
        }

        final registered = this.registered;
        if (registered == null) return const SizedBox.shrink();

        final rect = BadgeLayout.bottomRightSquare(size: size, sizeFactor: style?.registeredBadge?.sizeFactor ?? 0.2);
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fromRect(
              rect: rect,
              child: _RegisteredDot(registered: registered, style: style),
            ),
          ],
        );
      },
    );
  }
}

class _RegisteredDot extends StatelessWidget {
  const _RegisteredDot({required this.registered, required this.style});

  final bool registered;
  final LeadingAvatarStyle? style;

  @override
  Widget build(BuildContext context) {
    final rs = Theme.of(context).extension<RegisteredStatusStyles>()?.primary;

    final color = registered
        ? (style?.registeredBadge?.registeredColor ?? rs?.registered)
        : (style?.registeredBadge?.unregisteredColor ?? rs?.unregistered);

    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
