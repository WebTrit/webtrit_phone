import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'voicemail_state.dart';

part 'voicemail_cubit.freezed.dart';

class VoicemailCubit extends Cubit<VoicemailState> {
  VoicemailCubit(this._repository, Map<String, String> mediaHeaders)
      : super(VoicemailState(mediaHeaders: mediaHeaders)) {
    _subscription = _repository.watchVoicemails().listen((items) {
      emit(VoicemailState(items: items, mediaHeaders: state.mediaHeaders));
    });
    loadVoicemails();
  }

  final VoicemailRepository _repository;
  late final StreamSubscription<List<Voicemail>> _subscription;

  void cleanDb() {
    _repository.removeAllVoicemails();
  }

  Future<void> loadVoicemails() async {
    try {
      await _repository.fetchVoicemails();
    } catch (e) {
      // TODO(Serdun): Handle error
    }
  }

  Future<void> loadVoicemailDetail(String messageId) async {}

  void deleteVoicemail(String messageId) async {
    try {
      await _repository.removeVoicemail(messageId);
    } catch (e) {
      // TODO(Serdun): Handle error
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  void toggleSeenStatus(Voicemail voicemail) {
    _repository.updateVoicemailSeenStatus(voicemail.id.toString(), !voicemail.seen);
  }
}
