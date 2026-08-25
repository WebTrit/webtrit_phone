import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
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

  /// BLF dialog states of the contact; an established call among them marks
  /// the contact as on a call via the activity icon of the hybrid indicator.
  /// A phone that is merely ringing is not one, so reported calls are not
  /// counted, they are read - see `DialogInfo.isEstablished`.
  final List<DialogInfo>? dialogInfo;

  @override
  Widget build(BuildContext context) {
    final presenceParams = PresenceViewParams.of(context);
    final style = LeadingAvatarStyles.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;

        if (presenceParams.hybridPresenceSupport) {
          final presenceInfo = this.presenceInfo;
          if (presenceInfo == null) return const SizedBox.shrink();

          final dialogInfo = this.dialogInfo ?? const <DialogInfo>[];
          final rect = BadgeLayout.onCircleEdgeSquare(size: size, sizeFactor: style.presenceBadge!.sizeFactor!);
          return Semantics(
            // A colour and a glyph say nothing out loud, so the state is
            // named here: it merges into the row's label and is read right
            // after the contact's name.
            label: _presenceLabel(context, presenceInfo, dialogInfo),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fromRect(
                  rect: rect,
                  child: SipPresenceIndicator(presenceInfo: presenceInfo, dialogInfo: dialogInfo, presenceRect: rect),
                ),
              ],
            ),
          );
        }

        final registered = this.registered;
        if (registered == null) return const SizedBox.shrink();

        // The legacy registration dot stays tucked inside the avatar: unlike the
        // presence mark it carries no ring, so on the row background half of it
        // would read as a partial dot.
        final rect = BadgeLayout.bottomRightSquare(size: size, sizeFactor: style.registeredBadge!.sizeFactor!);
        return Semantics(
          // Same reason as the presence mark above: a bare coloured dot is
          // silent, so the registration state is named here and read right
          // after the contact's name.
          label: registered
              ? context.l10n.presence_badge_state_registered
              : context.l10n.presence_badge_state_unregistered,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fromRect(
                rect: rect,
                child: _RegisteredDot(registered: registered, style: style),
              ),
            ],
          ),
        );
      },
    );
  }

  /// The state in words, for anyone who does not see the mark.
  ///
  /// A published activity wins over the plain state - "on vacation" is what
  /// the contact chose to say, and it is more use than "available" - except
  /// while they are in a call, which outranks whatever they published earlier.
  ///
  /// This follows the GLYPH, not the colour: an established call is spoken
  /// even though it deliberately leaves the colour alone.
  String _presenceLabel(BuildContext context, List<PresenceInfo> presenceInfo, List<DialogInfo> dialogInfo) {
    final l10n = context.l10n;
    if (dialogInfo.established != null) return l10n.presence_badge_state_onCall;

    final activity = presenceInfo.primaryActivity;
    if (activity != null) return activity.l10n(l10n);

    return presenceInfo.anyAvailable ? l10n.presence_badge_state_available : l10n.presence_badge_state_unavailable;
  }
}

class _RegisteredDot extends StatelessWidget {
  const _RegisteredDot({required this.registered, required this.style});

  final bool registered;
  final LeadingAvatarStyle style;

  @override
  Widget build(BuildContext context) {
    final rs = Theme.of(context).extension<RegisteredStatusStyles>()?.primary;

    final badge = style.registeredBadge!;
    final color = registered
        ? (badge.registeredColor ?? rs?.registered)
        : (badge.unregisteredColor ?? rs?.unregistered);

    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
