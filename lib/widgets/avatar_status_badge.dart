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

  /// Presence states feeding the status mark. Empty or `null` means nothing
  /// has been published about the contact yet - then [registered] is used
  /// instead, and if that is unknown too, no mark is shown at all.
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

        final presenceInfo = this.presenceInfo ?? const <PresenceInfo>[];
        final dialogInfo = this.dialogInfo ?? const <DialogInfo>[];

        if (presenceParams.hybridPresenceSupport) {
          // One mark, one size, whichever signal it came from. A published
          // status is richer, so it is preferred; without one, registration
          // still answers the only question that matters at a glance - is
          // their phone reachable at all - and it is drawn the same way, so a
          // row never changes shape depending on which signal arrived.
          final registered = this.registered;
          final ContactPresence? state;
          if (presenceInfo.isNotEmpty || dialogInfo.established != null) {
            state = ContactPresence.resolve(presenceInfo: presenceInfo, dialogInfo: dialogInfo);
          } else if (registered != null) {
            state = registered ? ContactPresence.available : ContactPresence.unavailable;
          } else {
            // Neither signal has arrived. Nothing known, nothing drawn: a mark
            // here would sit on every row right after the app opens and crowd
            // out the marks that do mean something.
            state = null;
          }
          if (state == null) return const SizedBox.shrink();

          final rect = BadgeLayout.onCircleEdgeSquare(size: size, sizeFactor: style.presenceBadge!.sizeFactor!);
          return Semantics(
            // A colour and a glyph say nothing out loud, so the state is
            // named here: it merges into the row's label and is read right
            // after the contact's name.
            label: _presenceLabel(context, presenceInfo, state),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fromRect(
                  rect: rect,
                  child: PresenceMark(presence: state, presenceRect: rect),
                ),
              ],
            ),
          );
        }

        final registered = this.registered;
        if (registered == null) return const SizedBox.shrink();

        // The legacy registration dot, for deployments without hybrid
        // presence. It stays tucked inside the avatar: unlike the status mark
        // it carries no ring, so on the row background half of it would read
        // as a partial dot.
        final rect = BadgeLayout.bottomRightSquare(size: size, sizeFactor: style.registeredBadge!.sizeFactor!);
        final l10n = context.l10n;

        return Semantics(
          label: registered ? l10n.presence_badge_state_available : l10n.presence_badge_state_unavailable,
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
  /// Deliberately more precise than the mark: the mark speaks in classes
  /// because a glyph that small cannot carry twelve activities, while a spoken
  /// label has no such limit and names what the contact actually published -
  /// "on vacation" rather than merely "away". A call being reported outranks
  /// whatever they published earlier.
  String _presenceLabel(BuildContext context, List<PresenceInfo> presenceInfo, ContactPresence presence) {
    final l10n = context.l10n;
    if (presence == ContactPresence.onCall) return l10n.presence_badge_state_onCall;

    final activity = presenceInfo.primaryActivity;
    if (activity != null) return activity.l10n(l10n);

    return switch (presence) {
      ContactPresence.available => l10n.presence_badge_state_available,
      _ => l10n.presence_badge_state_unavailable,
    };
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
