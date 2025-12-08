import 'package:webtrit_phone/l10n/app_localizations.g.dart';

import 'package:webtrit_phone/models/presence/presence_activity.dart';

extension PresenceActivityL10n on PresenceActivity {
  String l10n(AppLocalizations l10n) {
    return switch (this) {
      PresenceActivity.away => l10n.presence_activity_away_name,
      PresenceActivity.busy => l10n.presence_activity_busy_name,
      PresenceActivity.doNotDisturb => l10n.presence_activity_doNotDisturb_name,
      PresenceActivity.sleeping => l10n.presence_activity_sleeping_name,
      PresenceActivity.permanentAbsence => l10n.presence_activity_permanentAbsence_name,
      PresenceActivity.onThePhone => l10n.presence_activity_onThePhone_name,
      PresenceActivity.meal => l10n.presence_activity_meal_name,
      PresenceActivity.meeting => l10n.presence_activity_meeting_name,
      PresenceActivity.appointment => l10n.presence_activity_appointment_name,
      PresenceActivity.vacation => l10n.presence_activity_vacation_name,
      PresenceActivity.travel => l10n.presence_activity_travel_name,
      PresenceActivity.inTransit => l10n.presence_activity_inTransit_name,
    };
  }
}
