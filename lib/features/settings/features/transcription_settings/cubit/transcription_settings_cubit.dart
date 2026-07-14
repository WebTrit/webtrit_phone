import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'transcription_settings_state.dart';

part 'transcription_settings_cubit.freezed.dart';

final _logger = Logger('TranscriptionSettingsCubit');

/// Manages the on-device transcription model choice; the view only renders
/// [TranscriptionSettingsState].
///
/// The brand default tier comes from the app config; picking it clears the
/// stored override, any other tier is persisted as the override. The
/// repository behind [TranscriptionModelRepository] also switches the
/// transcription pool, which regenerates every stored transcript.
class TranscriptionSettingsCubit extends Cubit<TranscriptionSettingsState> {
  TranscriptionSettingsCubit({
    required TranscriptionModelRepository modelRepository,
    required TranscriptionConfig transcriptionConfig,
  }) : _modelRepository = modelRepository,
       super(
         TranscriptionSettingsState(
           defaultModel: transcriptionConfig.localModel,
           selectedModel: modelRepository.getTranscriptionModel() ?? transcriptionConfig.localModel,
         ),
       );

  final TranscriptionModelRepository _modelRepository;

  Future<void> setModel(String model) async {
    final previous = state.selectedModel;
    if (model == previous) return;

    emit(state.copyWith(selectedModel: model));
    try {
      final override = model == state.defaultModel ? null : model;
      await _modelRepository.setTranscriptionModel(override);
    } catch (e, st) {
      _logger.warning('Failed to apply transcription model $model', e, st);
      if (!isClosed) emit(state.copyWith(selectedModel: previous));
    }
  }
}
