import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/app/notifications/models/notification.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'voicemail_state.dart';

part 'voicemail_cubit.freezed.dart';

class VoicemailCubit extends Cubit<VoicemailState> {
  VoicemailCubit({
    required VoicemailRepository repository,
    required Map<String, String> mediaHeaders,
    required this.onCallStarted,
    required this.onSubmitNotification,
  })  : _repository = repository,
        super(VoicemailState(mediaHeaders: mediaHeaders)) {
    _initialize();
  }

  final VoicemailRepository _repository;
  final ValueChanged<String> onCallStarted;
  final ValueChanged<Notification> onSubmitNotification;

  late final StreamSubscription<List<Voicemail>> _subscription;

  void _initialize() async {
    _subscription = _repository.watchVoicemails().listen((items) {
      emit(state.copyWith(items: items, mediaHeaders: state.mediaHeaders));
    });

    fetchVoicemails();
  }

  void fetchVoicemails() async {
    try {
      emit(state.copyWith(status: VoicemailStatus.loading, error: null));
      await _repository.fetchVoicemails();
      emit(state.copyWith(status: VoicemailStatus.loaded));
    } catch (e) {
      final error = DefaultErrorNotification(e);
      emit(state.copyWith(status: VoicemailStatus.loaded, error: error));
      onSubmitNotification(error);
    }
  }

  void removeAllVoicemails() {
    _repository.removeAllVoicemails();
  }

  void deleteVoicemail(String messageId) async {
    try {
      emit(state.copyWith(status: VoicemailStatus.loading));
      await _repository.removeVoicemail(messageId);
      emit(state.copyWith(status: VoicemailStatus.loaded));
    } catch (e) {
      onSubmitNotification(DefaultErrorNotification(e));
    }
  }

  void toggleSeenStatus(Voicemail voicemail) async {
    try {
      emit(state.copyWith(status: VoicemailStatus.loading));
      await _repository.updateVoicemailSeenStatus(voicemail.id.toString(), !voicemail.seen);
      emit(state.copyWith(status: VoicemailStatus.loaded));
    } catch (e) {
      onSubmitNotification(DefaultErrorNotification(e));
    }
  }

  void startCall(Voicemail voicemail) {
    onCallStarted(voicemail.sender);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
