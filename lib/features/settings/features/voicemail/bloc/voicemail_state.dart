part of 'voicemail_cubit.dart';

enum VoicemailStatus {
  loading,
  loaded,
  error,
}

@freezed
class VoicemailState with _$VoicemailState {
  const factory VoicemailState({
    @Default(VoicemailStatus.loading) VoicemailStatus status,
    required Map<String, String> mediaHeaders,
    @Default([]) List<Voicemail> items,
  }) = _VoicemailState;
}
