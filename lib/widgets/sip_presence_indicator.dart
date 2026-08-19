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

    final anyAvailable = presenceInfo.anyAvailable;
    final color = anyAvailable ? badge.availableColor : badge.unavailableColor;

    final activityIcon = _activityIcon(presenceInfo, dialogInfo);

    // The glyph sits inside the badge rather than on top of it: an icon laid
    // over the dot cuts into its outline and the mark reads as smaller and
    // busier than it is.
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
      ),
      child: activityIcon == null
          ? null
          : Center(
              child: Icon(activityIcon, color: badge.iconColor, size: _presenceRect.width * 0.6),
            ),
    );
  }

  IconData? _activityIcon(List<PresenceInfo> presenceInfo, List<DialogInfo> dialogInfo) {
    if (dialogInfo.isNotEmpty) {
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
