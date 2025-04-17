part of 'voicemail_cubit.dart';

@freezed
class VoicemailState with _$VoicemailState {
  const factory VoicemailState({@Default([]) List<UserVoicemailItem> items}) = _VoicemailState;
}
