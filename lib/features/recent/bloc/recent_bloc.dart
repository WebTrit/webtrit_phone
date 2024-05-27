import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'recent_bloc.freezed.dart';

part 'recent_event.dart';

part 'recent_state.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  RecentBloc(
    this.recentId, {
    required this.recentsRepository,
    required this.dateFormat,
  }) : super(const RecentState()) {
    on<RecentStarted>(_onStarted, transformer: restartable());
    on<RecentDeleted>(_onDeleted);
  }

  final RecentId recentId;
  final RecentsRepository recentsRepository;
  final DateFormat dateFormat;

  FutureOr<void> _onStarted(RecentStarted event, Emitter<RecentState> emit) async {
    final recent = await recentsRepository.getRecent(recentId);
    emit(state.copyWith(recent: recent));

    await emit.forEach(
      recentsRepository.watchHistory(recent),
      onData: (recents) => state.copyWith(
        recents: recents,
      ),
    );
  }

  FutureOr<void> _onDeleted(RecentDeleted event, Emitter<RecentState> emit) async {
    await recentsRepository.delete(event.recent);
  }
}
