part of 'voicemail_cubit.dart';

enum VoicemailStatus { loading, loaded, featureNotSupported }

// TODO(Serdun): DiagnosticableTreeMixin is required only because `foundation.dart`
// is imported transitively through DefaultErrorNotification (via material.dart).
// Remove this mixin once that indirect dependency is eliminated.
@freezed
class VoicemailState with _$VoicemailState, DiagnosticableTreeMixin {
  const VoicemailState({this.status = VoicemailStatus.loading, this.items = const [], this.error});

  @override
  final VoicemailStatus status;

  @override
  final List<Voicemail> items;

  @override
  final DefaultErrorNotification? error;

  /// Status to show when the user is refreshing or updating the list of voicemails.
  bool get isRefreshing => status == VoicemailStatus.loading && items.isNotEmpty;

  /// Status to show when the user is loading the list of voicemails.
  bool get isInitializing => status == VoicemailStatus.loading && items.isEmpty && error == null;

  /// Status to show when the user is loading the list of voicemails and there are no items available.
  bool get isLoadedWithEmptyResult => status == VoicemailStatus.loaded && items.isEmpty && error == null;

  /// Status to show when the user is loading the list of voicemails and there is an error.
  bool get isLoadedWithError => status == VoicemailStatus.loaded && error != null && items.isEmpty;

  /// Status show when feature is not supported, adapter not supported.
  bool get isFeatureNotSupported => status == VoicemailStatus.featureNotSupported;

  /// Status to show when the user is loading the list of voicemails and there are items available.
  bool get isVoicemailsExists => items.isNotEmpty;
}
