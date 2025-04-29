part of 'voicemail_cubit.dart';

enum VoicemailStatus {
  initial,
  loading,
  loaded,
  error,
}

@freezed
class VoicemailState with _$VoicemailState {
  const factory VoicemailState({
    @Default(VoicemailStatus.initial) VoicemailStatus status,
    required Map<String, String> mediaHeaders,
    @Default([]) List<Voicemail> items,
  }) = _VoicemailState;
}
