import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'recent_bloc.freezed.dart';

part 'recent_event.dart';

part 'recent_state.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  RecentBloc(
    this.callId, {
    required this.callLogsRepository,
    required this.recentsRepository,
    required this.dateFormat,
  }) : super(const RecentState()) {
    on<RecentStarted>(_onStarted, transformer: restartable());
    on<CallLogEntryDeleted>(_onCallLogEntryDeleted);
  }

  final int callId;
  final CallLogsRepository callLogsRepository;
  final RecentsRepository recentsRepository;
  final DateFormat dateFormat;

  FutureOr<void> _onStarted(RecentStarted event, Emitter<RecentState> emit) async {
    final recent = await recentsRepository.getRecentByCallId(callId);
    emit(state.copyWith(recent: recent));

    await emit.forEach(
      callLogsRepository.watchHistoryByNumber(recent.callLogEntry.number),
      onData: (recents) => state.copyWith(callLog: recents),
    );
  }

  FutureOr<void> _onCallLogEntryDeleted(CallLogEntryDeleted event, Emitter<RecentState> emit) async {
    await recentsRepository.deleteByCallId(event.callLogEntry.id);
  }
}
