part of 'transcription_settings_cubit.dart';

/// The brand default model tier, the currently effective selection, which
/// tiers already have a model file on disk and the live download state.
@freezed
class TranscriptionSettingsState with _$TranscriptionSettingsState {
  const TranscriptionSettingsState({
    required this.defaultModel,
    required this.selectedModel,
    this.downloadedModels = const {},
    this.downloadState = const ModelDownloadIdle(),
  });

  /// Brand default tier from the app config; marked in the list and used to
  /// clear the user override when picked.
  @override
  final String defaultModel;

  /// Currently effective tier.
  @override
  final String selectedModel;

  /// Tiers whose model file is already on disk (no download needed).
  @override
  final Set<String> downloadedModels;

  /// Download/readiness state of the active tier's model.
  @override
  final ModelDownloadState downloadState;
}
