import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

class PresenceSettingsPreset {
  const PresenceSettingsPreset({
    required this.name,
    required this.available,
    required this.note,
    required this.activity,
    required this.dndMode,
  });

  final String name;
  final bool available;
  final String note;
  final PresenceActivity? activity;
  final bool dndMode;

  static List<PresenceSettingsPreset> presets(AppLocalizations localization) => [
        PresenceSettingsPreset(
          name: localization.presence_preset_unavailable_name,
          available: false,
          note: '',
          activity: null,
          dndMode: false,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_away_name,
          available: false,
          note: localization.presence_preset_away_note,
          activity: PresenceActivity.away,
          dndMode: false,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_dnd_name,
          available: false,
          note: localization.presence_preset_dnd_note,
          activity: PresenceActivity.doNotDisturb,
          dndMode: true,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_sleeping_name,
          available: false,
          note: localization.presence_preset_sleeping_note,
          activity: PresenceActivity.sleeping,
          dndMode: false,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_absent_name,
          available: false,
          note: localization.presence_preset_absent_note,
          activity: PresenceActivity.permanentAbsence,
          dndMode: false,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_available_name,
          available: true,
          note: '',
          activity: null,
          dndMode: false,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_meal_name,
          available: true,
          note: localization.presence_preset_meal_note,
          activity: PresenceActivity.meal,
          dndMode: false,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_inTransit_name,
          available: true,
          note: localization.presence_preset_inTransit_note,
          activity: PresenceActivity.inTransit,
          dndMode: false,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_meeting_name,
          available: true,
          note: localization.presence_preset_meeting_note,
          activity: PresenceActivity.meeting,
          dndMode: false,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_vacation_name,
          available: true,
          note: localization.presence_preset_vacation_note,
          activity: PresenceActivity.vacation,
          dndMode: false,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_travel_name,
          available: true,
          note: localization.presence_preset_travel_note,
          activity: PresenceActivity.travel,
          dndMode: false,
        ),
        PresenceSettingsPreset(
          name: localization.presence_preset_appointment_name,
          available: true,
          note: localization.presence_preset_appointment_note,
          activity: PresenceActivity.appointment,
          dndMode: false,
        ),
      ];
}
