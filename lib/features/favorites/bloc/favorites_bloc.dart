import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required this.favoritesRepository,
  }) : super(const FavoritesState()) {
    on<FavoritesStarted>(_handleFavoritesStarted, transformer: restartable());
    on<FavoritesRemoved>(_handleFavoritesRemoved);
  }

  final FavoritesRepository favoritesRepository;

  Future<void> _handleFavoritesStarted(FavoritesStarted event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(status: FavoritesStatus.inProgress));
    await emit.forEach(
      favoritesRepository.favorites(),
      onData: (List<Favorite> favorites) => FavoritesState(
        status: FavoritesStatus.success,
        favorites: favorites,
      ),
    );
  }

  Future<void> _handleFavoritesRemoved(FavoritesRemoved event, Emitter<FavoritesState> emit) async {
    await favoritesRepository.remove(event.favorite);
  }
}
