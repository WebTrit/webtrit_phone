import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'call_log_bloc.freezed.dart';

part 'call_log_event.dart';

part 'call_log_state.dart';

class CallLogBloc extends Bloc<CallLogEvent, CallLogState> {
  CallLogBloc(
    this.number, {
    required this.callLogsRepository,
    required this.recentsRepository,
    required this.contactRepository,
    required this.dateFormat,
  }) : super(CallLogState(number: number)) {
    on<CallLogStarted>(_onStarted, transformer: restartable());
    on<CallLogEntryDeleted>(_onCallLogEntryDeleted);
  }

  final String number;
  final CallLogsRepository callLogsRepository;
  final RecentsRepository recentsRepository;
  final ContactsRepository contactRepository;
  final DateFormat dateFormat;

  FutureOr<void> _onStarted(CallLogStarted event, Emitter<CallLogState> emit) async {
    final contact = await contactRepository.getContactByPhoneNumber(number);
    emit(state.copyWith(contact: contact));

    await emit.forEach(
      callLogsRepository.watchHistoryByNumber(number),
      onData: (recents) => state.copyWith(callLog: recents),
    );
  }

  FutureOr<void> _onCallLogEntryDeleted(CallLogEntryDeleted event, Emitter<CallLogState> emit) async {
    await recentsRepository.deleteByCallId(event.callLogEntry.id);
  }
}
