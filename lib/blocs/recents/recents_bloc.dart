import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:webtrit_phone/repositories/recents_repository.dart';

import './recents.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
  final RecentsRepository recentsRepository;

  @override
  RecentsState get initialState => RecentsInitial();

  RecentsBloc({
    @required this.recentsRepository,
  }) : assert(recentsRepository != null);

  @override
  Stream<RecentsState> mapEventToState(RecentsEvent event) async* {
    if (event is RecentsFetched) {
      yield* _mapRecentsFetchedToState(event);
    }
    if (event is RecentsRefreshed) {
      yield* _mapRecentsRefreshedToState(event);
    }
  }

  Stream<RecentsState> _mapRecentsFetchedToState(RecentsFetched event) async* {
    yield RecentsLoadInProgress();
    try {
      final recents = await recentsRepository.getRecents();
      yield RecentsLoadSuccess(recents: recents);
    } catch (error) {
      yield RecentsFetchFailure();
    }
  }

  Stream<RecentsState> _mapRecentsRefreshedToState(RecentsRefreshed event) async* {
    try {
      final recents = await recentsRepository.getRecents();
      yield RecentsLoadSuccess(recents: recents);
    } catch (error) {
      yield RecentsRefreshFailure();
    }
  }
}
