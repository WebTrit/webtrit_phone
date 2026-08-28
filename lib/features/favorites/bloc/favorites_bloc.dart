import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/common/refreshable.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required this.favoritesRepository}) : super(const FavoritesState()) {
    on<FavoritesStarted>(_onStarted, transformer: restartable());
    on<FavoritesRefreshed>(_onRefreshed, transformer: droppable());
    on<FavoritesRemoved>(_onRemoved);
    on<FavoritesShifted>(_onShifted);
  }

  final FavoritesRepository favoritesRepository;

  Future<void> _onStarted(FavoritesStarted event, Emitter<FavoritesState> emit) async {
    await emit.forEach(
      favoritesRepository.watchAllWithContacts(),
      onData: (List<FavoriteWithContact> favorites) => state.copyWith(favorites: favorites),
    );
  }

  /// Dropped rather than queued: a second pull while one is still in flight
  /// asks the same question, and answering it twice only delays the answer.
  Future<void> _onRefreshed(FavoritesRefreshed event, Emitter<FavoritesState> emit) async {
    final repository = favoritesRepository;
    if (repository is! Refreshable) return;

    emit(state.copyWith(refreshing: true));
    try {
      await (repository as Refreshable).refresh();
    } finally {
      if (!isClosed) emit(state.copyWith(refreshing: false));
    }
  }

  Future<void> _onRemoved(FavoritesRemoved event, Emitter<FavoritesState> emit) async {
    await favoritesRepository.remove(event.favorite);
  }

  Future<void> _onShifted(FavoritesShifted event, Emitter<FavoritesState> emit) async {
    await favoritesRepository.shift(event.favorite, event.position);
  }
}
