part of 'voicemail_cubit.dart';

enum VoicemailStatus {
  loading,
  loaded,
}

@freezed
class VoicemailState with _$VoicemailState {
  const VoicemailState._();

  const factory VoicemailState({
    required Map<String, String> mediaHeaders,
    @Default(VoicemailStatus.loading) VoicemailStatus status,
    @Default([]) List<Voicemail> items,
    DefaultErrorNotification? error,
  }) = _VoicemailState;

  /// Status to show when the user is refreshing or updating the list of voicemails.
  bool get isRefreshing => status == VoicemailStatus.loading && items.isNotEmpty;

  /// Status to show when the user is loading the list of voicemails.
  bool get isInitializing => status == VoicemailStatus.loading && items.isEmpty && error == null;

  /// Status to show when the user is loading the list of voicemails and there are no items available.
  bool get isLoadedWithEmptyResult => status == VoicemailStatus.loaded && items.isEmpty && error == null;

  /// Status to show when the user is loading the list of voicemails and there is an error.
  bool get isLoadedWithError => status == VoicemailStatus.loaded && error != null;

  /// Status to show when the user is loading the list of voicemails and there are items available.
  bool get isLoadedSuccessfully => status == VoicemailStatus.loaded && error == null && items.isNotEmpty;
}
