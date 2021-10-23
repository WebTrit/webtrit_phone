import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/recents_repository.dart';

part 'recents_event.dart';

part 'recents_state.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
  final RecentsRepository recentsRepository;
  StreamSubscription? _recentsSubscription;

  RecentsBloc({
    required this.recentsRepository,
  }) : super(const RecentsInitial());

  @override
  Stream<RecentsState> mapEventToState(RecentsEvent event) async* {
    if (event is RecentsInitialLoaded) {
      yield* _mapRecentsInitialLoadedToState(event);
    } else if (event is RecentsRefreshed) {
      yield* _mapRecentsRefreshedToState(event);
    } else if (event is RecentsAdd) {
      yield* _mapRecentsAddToState(event);
    } else if (event is RecentsDelete) {
      yield* _mapRecentsDeleteToState(event);
    } else if (event is RecentsUpdated) {
      yield* _mapRecentsUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _recentsSubscription?.cancel();
    return super.close();
  }

  Stream<RecentsState> _mapRecentsInitialLoadedToState(RecentsInitialLoaded event) async* {
    yield const RecentsInitial();
    _recentsSubscription?.cancel();
    _recentsSubscription = recentsRepository.recents().listen(
          (recents) => add(RecentsUpdated(recents: recents)),
        );

    try {
      await recentsRepository.load();
    } catch (error) {
      yield const RecentsInitialLoadFailure();
    }
  }

  Stream<RecentsState> _mapRecentsRefreshedToState(RecentsRefreshed event) async* {
    try {
      await recentsRepository.load();
    } catch (error) {
      yield const RecentsRefreshFailure();
    }
  }

  Stream<RecentsState> _mapRecentsAddToState(RecentsAdd event) async* {
    await recentsRepository.add(event.recent);
  }

  Stream<RecentsState> _mapRecentsDeleteToState(RecentsDelete event) async* {
    await recentsRepository.delete(event.recent);
  }

  Stream<RecentsState> _mapRecentsUpdatedToState(RecentsUpdated event) async* {
    yield RecentsLoadSuccess(recents: event.recents);
  }
}
