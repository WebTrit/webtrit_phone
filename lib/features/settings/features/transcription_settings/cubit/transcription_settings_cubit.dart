import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/services/services.dart';

part 'transcription_settings_state.dart';

part 'transcription_settings_cubit.freezed.dart';

final _logger = Logger('TranscriptionSettingsCubit');

/// Manages the on-device transcription model choice; the view only renders
/// [TranscriptionSettingsState].
///
/// The brand default tier comes from the app config; picking it clears the
/// stored override, any other tier is persisted as the override. The
/// session-wide [TranscriptionModelService] switches the transcription pool,
/// which regenerates every stored transcript.
class TranscriptionSettingsCubit extends Cubit<TranscriptionSettingsState> {
  TranscriptionSettingsCubit({required TranscriptionModelService modelService})
    : _modelService = modelService,
      super(
        TranscriptionSettingsState(defaultModel: modelService.defaultModel, selectedModel: modelService.selectedModel),
      );

  final TranscriptionModelService _modelService;

  /// Guards the rollback: only the newest selection may revert the state, so
  /// an older failed attempt cannot clobber a later successful one.
  int _revision = 0;

  Future<void> setModel(String model) async {
    final previous = state.selectedModel;
    if (model == previous) return;

    final revision = ++_revision;
    emit(state.copyWith(selectedModel: model));
    try {
      await _modelService.setModel(model);
    } catch (e, st) {
      _logger.warning('Failed to apply transcription model $model', e, st);
      if (!isClosed && revision == _revision) emit(state.copyWith(selectedModel: previous));
    }
  }
}
