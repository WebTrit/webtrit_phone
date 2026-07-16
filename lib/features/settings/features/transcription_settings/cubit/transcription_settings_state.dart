part of 'transcription_settings_cubit.dart';

/// The brand default selection, the currently effective selection, which
/// tiers already have a model file on disk and the live download state.
@freezed
class TranscriptionSettingsState with _$TranscriptionSettingsState {
  const TranscriptionSettingsState({
    required this.defaultModel,
    required this.selectedModel,
    this.downloadedModels = const {},
    this.downloadState = const ModelDownloadIdle(),
  });

  /// Brand default selection from the app config; marked in the list and
  /// used to clear the user override when picked.
  @override
  final LocalTranscriptionModel defaultModel;

  /// Currently effective selection.
  @override
  final LocalTranscriptionModel selectedModel;

  /// Tiers whose model file is already on disk (no download needed).
  @override
  final Set<String> downloadedModels;

  /// Download/readiness state of the active tier's model.
  @override
  final ModelDownloadState downloadState;
}
