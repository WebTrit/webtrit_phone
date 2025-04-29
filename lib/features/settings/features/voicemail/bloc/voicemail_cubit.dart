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
    _initialize();
  }

  final VoicemailRepository _repository;
  final ValueChanged<String> onCallStarted;

  late final StreamSubscription<List<Voicemail>> _subscription;

  void _initialize() async {
    _subscription = _repository.watchVoicemails().listen((items) {
      emit(state.copyWith(items: items, mediaHeaders: state.mediaHeaders));
    });

    await _repository.fetchVoicemails();
    emit(state.copyWith(status: VoicemailStatus.loaded));
  }

  void cleanDb() {
    _repository.removeAllVoicemails();
  }

  Future<void> loadVoicemailDetail(String messageId) async {}

  void deleteVoicemail(String messageId) async {
    try {
      emit(state.copyWith(status: VoicemailStatus.loading));
      await _repository.removeVoicemail(messageId);
      emit(state.copyWith(status: VoicemailStatus.loaded));
    } catch (e) {
      // TODO(Serdun): Handle error
    }
  }

  void toggleSeenStatus(Voicemail voicemail) async {
    emit(state.copyWith(status: VoicemailStatus.loading));
    await _repository.updateVoicemailSeenStatus(voicemail.id.toString(), !voicemail.seen);
    emit(state.copyWith(status: VoicemailStatus.loaded));
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
