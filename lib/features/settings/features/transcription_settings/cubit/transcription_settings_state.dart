part of 'transcription_settings_cubit.dart';

/// The brand default model tier and the currently effective selection.
@freezed
class TranscriptionSettingsState with _$TranscriptionSettingsState {
  const TranscriptionSettingsState({required this.defaultModel, required this.selectedModel});

  /// Brand default tier from the app config; marked in the list and used to
  /// clear the user override when picked.
  @override
  final String defaultModel;

  /// Currently effective tier.
  @override
  final String selectedModel;
}
