import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'favorites_bloc.freezed.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required this.favoritesRepository,
  }) : super(const FavoritesState()) {
    on<FavoritesStarted>(_onStarted, transformer: restartable());
    on<FavoritesRemoved>(_onRemoved);
  }

  final FavoritesRepository favoritesRepository;

  Future<void> _onStarted(FavoritesStarted event, Emitter<FavoritesState> emit) async {
    await emit.forEach(
      favoritesRepository.favorites(),
      onData: (List<Favorite> favorites) => FavoritesState(
        favorites: favorites,
      ),
    );
  }

  Future<void> _onRemoved(FavoritesRemoved event, Emitter<FavoritesState> emit) async {
    await favoritesRepository.remove(event.favorite);
  }
}
