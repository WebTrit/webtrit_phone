import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webtrit_api/webtrit_api.dart';

import '../../../../../models/voicemail/user_voicemail.dart';
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

  Future<void> loadVoicemailDetail(String messageId) async {
    // if (state.detailedMap.containsKey(messageId)) return;
    //
    // try {
    //   final voicemail = await _repository.getVoicemail(messageId, Locale.fromSubtags(languageCode: "en"));
    //   final updatedMap = Map<String, UserVoicemail>.from(state.detailedMap)..[messageId] = voicemail;
    //   emit(state.copyWith(detailedMap: updatedMap));
    //   getAttachementVoicemail(messageId);
    // } catch (e) {
    //   // handle error
    // }
  }
  Future<void> getAttachementVoicemail(String messageId) async {
    // if (state.attachmentMap.containsKey(messageId)) return;
    //
    // try {
    //   final attachment = await _repository.getVoicemailAttachment(messageId);
    //   final updatedMap = Map<String, String>.from(state.attachmentMap)..[messageId] = attachment;
    //   emit(state.copyWith(attachmentMap: updatedMap));
    //
    // } catch (e) {
    //   // emit(VoicemailState.error(e.toString()));
    // }
  }
}
