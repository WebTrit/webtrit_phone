import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webtrit_api/webtrit_api.dart';

import '../../../../../repositories/voicemail/voice_mail_repository.dart';

part 'voicemail_state.dart';

part 'voicemail_cubit.freezed.dart';

class VoicemailCubit extends Cubit<VoicemailState> {
  VoicemailCubit(this._repository) : super(const VoicemailState()) {
    loadVoicemails();
  }

  final VoicemailRepository _repository;

  Future<void> loadVoicemails() async {
    // emit(const VoicemailState.loading());
    try {
      final items = await _repository.getVoicemailList(Locale.fromSubtags(languageCode: "en"));
      emit(VoicemailState(items: items));
    } catch (e) {
      // emit(VoicemailState.error(e.toString()));
    }
  }
}
