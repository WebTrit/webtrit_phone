import 'dart:async';

import 'package:flutter/foundation.dart' show ValueChanged;

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/models/notification.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'voicemail_state.dart';

part 'voicemail_cubit.freezed.dart';

class VoicemailCubit extends Cubit<VoicemailState> {
  VoicemailCubit({
    required VoicemailRepository repository,
    required this.onCallStarted,
    required this.onSubmitNotification,
  })  : _repository = repository,
        super(const VoicemailState()) {
    _initialize();
  }

  final VoicemailRepository _repository;
  final ValueChanged<String> onCallStarted;
  final ValueChanged<Notification> onSubmitNotification;

  late final StreamSubscription<List<Voicemail>> _subscription;

  void _initialize() async {
    _subscription = _repository.watchVoicemails().listen((items) {
      _safeEmit(state.copyWith(items: items, error: null, status: VoicemailStatus.loaded));
    });

    fetchVoicemails();
  }

  void fetchVoicemails() async {
    try {
      _safeEmit(state.copyWith(status: VoicemailStatus.loading, error: null));
      await _repository.fetchVoicemails();
      _safeEmit(state.copyWith(status: VoicemailStatus.loaded));
    } on EndpointNotSupportedException catch (e) {
      final error = DefaultErrorNotification(e);
      _safeEmit(state.copyWith(status: VoicemailStatus.featureNotSupported, error: error));
    } catch (e) {
      final error = DefaultErrorNotification(e);
      _safeEmit(state.copyWith(status: VoicemailStatus.loaded, error: error));
      onSubmitNotification(error);
    }
  }

  void removeAllVoicemails() async {
    try {
      _safeEmit(state.copyWith(status: VoicemailStatus.loading));
      await _repository.removeAllVoicemails();
      _safeEmit(state.copyWith(status: VoicemailStatus.loaded));
    } catch (e) {
      onSubmitNotification(DefaultErrorNotification(e));
      emit(state.copyWith(status: VoicemailStatus.loaded));
    }
  }

  void removeVoicemail(String messageId) async {
    try {
      _safeEmit(state.copyWith(status: VoicemailStatus.loading));
      await _repository.removeVoicemail(messageId);
      _safeEmit(state.copyWith(status: VoicemailStatus.loaded));
    } catch (e) {
      onSubmitNotification(DefaultErrorNotification(e));
      _safeEmit(state.copyWith(status: VoicemailStatus.loaded));
    }
  }

  void toggleSeenStatus(Voicemail voicemail) async {
    try {
      _safeEmit(state.copyWith(status: VoicemailStatus.loading));
      await _repository.updateVoicemailSeenStatus(voicemail.id.toString(), !voicemail.seen);
      _safeEmit(state.copyWith(status: VoicemailStatus.loaded));
    } catch (e) {
      onSubmitNotification(DefaultErrorNotification(e));
      _safeEmit(state.copyWith(status: VoicemailStatus.loaded));
    }
  }

  void startCall(Voicemail voicemail) {
    onCallStarted(voicemail.sender);
  }

  /// Safely emits a new state if the cubit is not closed.
  ///
  /// This prevents the "Bad state: Cannot emit new states after calling close"
  /// error, which can occur when asynchronous operations complete after
  /// the cubit has been closed (e.g., when a screen is disposed).
  void _safeEmit(VoicemailState newState) {
    if (!isClosed) emit(newState);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
