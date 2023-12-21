import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'recents_bloc.freezed.dart';

part 'recents_event.dart';

part 'recents_state.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
  RecentsBloc({
    required this.callBloc,
    required this.recentsRepository,
    required this.appPreferences,
  }) : super(RecentsState(filter: appPreferences.getActiveRecentsVisibilityFilter())) {
    on<RecentsStarted>(_onStarted, transformer: restartable());
    on<RecentsFiltered>(_onFiltered);
    on<RecentsDeleted>(_onDeleted);
    on<ManageRecentTransfer>(_onManageTransfer);

    callBlocStreamSubscription = callBloc.stream.listen((state) {
      if (callBloc.state.hasTransfer) {
        add(const ManageRecentTransfer(true));
      } else {
        add(const ManageRecentTransfer(false));
      }
    });
  }

  final RecentsRepository recentsRepository;
  final AppPreferences appPreferences;

  final CallBloc callBloc;
  StreamSubscription? callBlocStreamSubscription;

  @override
  Future<void> close() async {
    await callBlocStreamSubscription?.cancel();

    await super.close();
  }

  Future<void> _onStarted(RecentsStarted event, Emitter<RecentsState> emit) async {
    await emit.forEach(
      recentsRepository.watchRecents(),
      onData: (List<Recent> recents) => state.copyWith(recents: recents),
    );
  }

  Future<void> _onDeleted(RecentsDeleted event, Emitter<RecentsState> emit) async {
    await recentsRepository.delete(event.recent);
  }

  Future<void> _onFiltered(RecentsFiltered event, Emitter<RecentsState> emit) async {
    await appPreferences.setActiveRecentsVisibilityFilter(event.filter);

    emit(state.copyWith(filter: event.filter));
  }

  FutureOr<void> _onManageTransfer(ManageRecentTransfer event, Emitter<RecentsState> emit) async {
    emit(state.copyWith(transfer: event.enabled));
  }
}
