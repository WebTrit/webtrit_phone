import 'package:flutter/material.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

class SipPresenceIndicator extends StatelessWidget {
  const SipPresenceIndicator({
    super.key,
    required this.presenceInfo,
    required this.dialogInfo,
    required Rect presenceRect,
  }) : _presenceRect = presenceRect;

  final List<PresenceInfo> presenceInfo;
  final List<DialogInfo> dialogInfo;
  final Rect _presenceRect;

  @override
  Widget build(BuildContext context) {
    final badge = LeadingAvatarStyles.of(context).presenceBadge!;

    final presence = ContactPresence.resolve(presenceInfo: presenceInfo, dialogInfo: dialogInfo);

    // The glyph says what is going on, the colour says whether to call now -
    // so a state stays readable for anyone who cannot tell the fills apart.
    final color = switch (presence) {
      ContactPresence.onCall || ContactPresence.busy => badge.busyColor,
      ContactPresence.available => badge.availableColor,
      ContactPresence.unavailable => badge.unavailableColor,
    };

    final activityIcon = _activityIcon(presence, presenceInfo);

    // The glyph sits inside the mark rather than on top of it: an icon laid
    // over the dot cuts into its outline and the mark reads as smaller and
    // busier than it is. Ring and glyph are proportional to the mark, so the
    // availability colour keeps the same share of it at every size - this
    // widget is also rendered at 16 px in the presence pickers, where a fixed
    // ring plus a fixed glyph would leave the colour a sliver.
    final side = _presenceRect.width;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: side * 0.1),
      ),
      child: activityIcon == null
          ? null
          : Center(
              child: Icon(activityIcon, color: badge.iconColor, size: side * 0.55),
            ),
    );
  }

  IconData? _activityIcon(ContactPresence presence, List<PresenceInfo> presenceInfo) {
    if (presence == ContactPresence.onCall) {
      return Icons.phone_in_talk_rounded;
    }

    final activity = presenceInfo.primaryActivity;
    if (activity != null) {
      return switch (activity) {
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
      };
    }

    return null;
  }
}
