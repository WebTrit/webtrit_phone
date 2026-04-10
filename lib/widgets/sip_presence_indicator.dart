import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

class SipPresenceIndicator extends StatelessWidget {
  const SipPresenceIndicator({super.key, required this.presenceInfo, required Rect presenceRect})
    : _presenceRect = presenceRect;

  final List<PresenceInfo> presenceInfo;
  final Rect _presenceRect;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).extension<LeadingAvatarStyles>()?.primary ?? LeadingAvatarStyle();

    final anyAvailable = presenceInfo.anyAvailable;
    final color = anyAvailable
        ? (style.presenceBadge?.availableColor ?? colorScheme.tertiary)
        : (style.presenceBadge?.unavailableColor ?? colorScheme.onSurfaceVariant);

    final primaryActivity = presenceInfo.primaryActivity;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
          ),
        ),
        if (primaryActivity != null)
          Positioned(
            top: -_presenceRect.width * 0.2,
            right: 0,
            child: DecoratedIcon(
              decoration: IconDecoration(
                border: IconBorder(color: Theme.of(context).scaffoldBackgroundColor, width: 2.5),
              ),
              icon: Icon(
                switch (primaryActivity) {
                  PresenceActivity.busy => Icons.event_busy,
                  PresenceActivity.doNotDisturb => Icons.phone_disabled_rounded,
                  PresenceActivity.sleeping => Icons.nights_stay_rounded,
                  PresenceActivity.permanentAbsence => Icons.person_off_rounded,
                  PresenceActivity.onThePhone => Icons.phone_in_talk_rounded,
                  PresenceActivity.meal => Icons.restaurant,
                  PresenceActivity.meeting => Icons.calendar_month,
                  PresenceActivity.appointment => Icons.diversity_3_sharp,
                  PresenceActivity.vacation => Icons.beach_access,
                  PresenceActivity.travel => Icons.flight,
                  PresenceActivity.inTransit => Icons.drive_eta,
                  PresenceActivity.away => Icons.directions_walk,
                },
                color: color,
                size: _presenceRect.width * 0.6,
              ),
            ),
          ),
      ],
    );
  }
}
