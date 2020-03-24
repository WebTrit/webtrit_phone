import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:webtrit_phone/repositories/recents_repository.dart';

import './recents.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
  final RecentsRepository recentsRepository;
  StreamSubscription _recentsSubscription;

  @override
  RecentsState get initialState => RecentsInitial();

  RecentsBloc({
    @required this.recentsRepository,
  }) : assert(recentsRepository != null);

  @override
  Stream<RecentsState> mapEventToState(RecentsEvent event) async* {
    if (event is RecentsFetched) {
      yield* _mapRecentsFetchedToState(event);
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

  Stream<RecentsState> _mapRecentsFetchedToState(RecentsFetched event) async* {
    yield RecentsLoadInProgress();
    _recentsSubscription?.cancel();
    _recentsSubscription = recentsRepository.recents().listen(
          (recents) => add(RecentsUpdated(recents: recents)),
        );

    try {
      await recentsRepository.fetch();
    } catch (error) {
      yield RecentsFetchFailure();
    }
  }

  Stream<RecentsState> _mapRecentsRefreshedToState(RecentsRefreshed event) async* {
    try {
      await recentsRepository.fetch();
    } catch (error) {
      yield RecentsRefreshFailure();
    }
  }

  Stream<RecentsState> _mapRecentsAddToState(RecentsAdd event) async* {
    await recentsRepository.add(event.recent);
  }

  Stream<RecentsState> _mapRecentsDeleteToState(RecentsDelete event) async* {
    await recentsRepository.delete(event.recent);
  }

  Stream<RecentsState> _mapRecentsUpdatedToState(RecentsUpdated event) async* {
    final newSate = RecentsLoadSuccess(recents: event.recents);
    if (state == newSate) {
      yield RecentsLoadUnchangedSuccess();
    } else {
      yield newSate;
    }
  }
}
