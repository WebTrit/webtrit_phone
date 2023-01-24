import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/recents/recents_repository.dart';

part 'recents_event.dart';

part 'recents_bloc.freezed.dart';

part 'recents_state.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
  RecentsBloc({
    required this.recentsRepository,
  }) : super(const RecentsState()) {
    on<RecentsStarted>(_onStarted, transformer: restartable());
    on<RecentsDeleted>(_onDeleted);
  }

  final RecentsRepository recentsRepository;

  Future<void> _onStarted(RecentsStarted event, Emitter<RecentsState> emit) async {
    await emit.forEach(
      recentsRepository.watchRecents(),
      onData: (List<Recent> recents) => state.copyWith(recents: recents),
    );
  }

  Future<void> _onDeleted(RecentsDeleted event, Emitter<RecentsState> emit) async {
    await recentsRepository.delete(event.recent);
  }
}
