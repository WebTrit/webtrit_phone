import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/recents/recents_repository.dart';

part 'recents_event.dart';

part 'recents_state.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
  RecentsBloc({
    required this.recentsRepository,
  }) : super(const RecentsInitial()) {
    on<RecentsInitialLoaded>(_handleRecentsInitialLoaded, transformer: restartable());
    on<RecentsDelete>(_handleRecentsDelete);
  }

  final RecentsRepository recentsRepository;

  Future<void> _handleRecentsInitialLoaded(RecentsInitialLoaded event, Emitter<RecentsState> emit) async {
    await emit.forEach(
      recentsRepository.recents(),
      onData: (List<Recent> recents) => RecentsLoadSuccess(recents: recents),
    );
  }

  Future<void> _handleRecentsDelete(RecentsDelete event, Emitter<RecentsState> emit) async {
    await recentsRepository.delete(event.recent);
  }
}
