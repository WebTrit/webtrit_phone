import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'voicemail_state.dart';

part 'voicemail_cubit.freezed.dart';

class VoicemailCubit extends Cubit<VoicemailState> {
  VoicemailCubit({
    required VoicemailRepository repository,
    required Map<String, String> mediaHeaders,
    required this.onCallStarted,
  })  : _repository = repository,
        super(VoicemailState(mediaHeaders: mediaHeaders)) {
    loadVoicemails();
  }

  final VoicemailRepository _repository;
  final ValueChanged<String> onCallStarted;
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

  void toggleSeenStatus(Voicemail voicemail) {
    _repository.updateVoicemailSeenStatus(voicemail.id.toString(), !voicemail.seen);
  }

  void startCall(Voicemail voicemail) {
    onCallStarted(voicemail.sender);
  }

  void message(Voicemail voicemail) {}

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
