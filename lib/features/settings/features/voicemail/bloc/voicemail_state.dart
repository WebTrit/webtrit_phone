part of 'voicemail_cubit.dart';

@freezed
class VoicemailState with _$VoicemailState {
  const factory VoicemailState({
    required Map<String, String> mediaHeaders,
    @Default([]) List<Voicemail> items,
  }) = _VoicemailState;
}
