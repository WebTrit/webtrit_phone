import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../models/voicemail/user_voicemail.dart';
import '../../../../../repositories/voicemail/voice_mail_repository.dart';

part 'voicemail_state.dart';

part 'voicemail_cubit.freezed.dart';

class VoicemailCubit extends Cubit<VoicemailState> {
  VoicemailCubit(this._repository) : super(const VoicemailState()) {
    _subscription = _repository.watchVoicemails().listen((items) {
      emit(VoicemailState(items: items));
    });
    loadVoicemails();
  }

  final VoicemailRepository _repository;
  late final StreamSubscription<List<Voicemail>> _subscription;

  Future<void> loadVoicemails() async {
    try {
      await _repository.getVoicemailList(Locale.fromSubtags(languageCode: "en"));
      // no need to emit manually, stream will handle it
    } catch (e) {
      // emit(VoicemailState.error(e.toString()));
    }
  }

  Future<void> loadVoicemailDetail(String messageId) async {}

  Future<void> getAttachementVoicemail(String messageId) async {}

  void deleteVoicemail(String messageId) async {
    try {
      await _repository.deleteVoicemail(messageId, Locale.fromSubtags(languageCode: "en"));
    } catch (e) {
      // emit(VoicemailState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
