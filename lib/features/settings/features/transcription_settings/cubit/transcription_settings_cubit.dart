import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/services/services.dart';

part 'transcription_settings_state.dart';

part 'transcription_settings_cubit.freezed.dart';

final _logger = Logger('TranscriptionSettingsCubit');

/// Manages the on-device transcription model choice; the view only renders
/// [TranscriptionSettingsState].
///
/// The brand default selection comes from the app config; picking it clears
/// the stored override, any other selection is persisted as the override. The
/// session-wide [TranscriptionModelService] switches the transcription pool,
/// which regenerates every stored transcript.
class TranscriptionSettingsCubit extends Cubit<TranscriptionSettingsState> {
  TranscriptionSettingsCubit({required TranscriptionModelService modelService})
    : _modelService = modelService,
      super(
        TranscriptionSettingsState(defaultModel: modelService.defaultModel, selectedModel: modelService.selectedModel),
      ) {
    _modelService.modelDownloadState.addListener(_onDownloadState);
    _onDownloadState();
    _refreshDownloadedModels();
  }

  final TranscriptionModelService _modelService;

  ModelDownloadState? _previousDownloadState;

  void _onDownloadState() {
    final downloadState = _modelService.modelDownloadState.value;
    final previous = _previousDownloadState;
    _previousDownloadState = downloadState;
    if (isClosed) return;
    emit(state.copyWith(downloadState: downloadState));
    // A finished download makes one more tier local; refresh the badges on
    // the transition only (the constructor covers the initial pass).
    if (downloadState is ModelDownloadReady && previous is! ModelDownloadReady) _refreshDownloadedModels();
  }

  Future<void> _refreshDownloadedModels() async {
    final tiers = {
      ...kTranscriptionModelPresets,
      for (final selection in [state.defaultModel, state.selectedModel])
        if (selection is LocalTranscriptionModelTier) selection.name,
    };
    final checks = await Future.wait(
      tiers.map((tier) async {
        try {
          return await _modelService.isModelDownloaded(tier) ? tier : null;
        } catch (e) {
          _logger.fine('Could not check the $tier model file: $e');
          return null;
        }
      }),
    );
    if (!isClosed) emit(state.copyWith(downloadedModels: checks.whereType<String>().toSet()));
  }

  /// Retries the failed model download of the current tier.
  Future<void> retryDownload() => _modelService.prepareModel();

  /// Guards the rollback: only the newest selection may revert the state, so
  /// an older failed attempt cannot clobber a later successful one.
  int _revision = 0;

  Future<void> setModel(LocalTranscriptionModel model) async {
    final previous = state.selectedModel;
    if (model == previous) return;

    final revision = ++_revision;
    emit(state.copyWith(selectedModel: model));
    try {
      await _modelService.setModel(model);
    } catch (e, st) {
      _logger.warning('Failed to apply transcription model $model', e, st);
      // Roll back to what is actually in effect, not to the previous
      // optimistic pick: an older selection may have failed too.
      if (!isClosed && revision == _revision) emit(state.copyWith(selectedModel: _modelService.selectedModel));
    }
  }

  @override
  Future<void> close() {
    _modelService.modelDownloadState.removeListener(_onDownloadState);
    return super.close();
  }
}
