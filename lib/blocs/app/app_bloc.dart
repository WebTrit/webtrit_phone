import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppUnregister()) {
    on<AppRegistered>(_onRegistered, transformer: sequential());
    on<AppUnregistered>(_onUnregistered, transformer: sequential());
  }

  void _onRegistered(AppRegistered event, Emitter<AppState> emit) {
    emit(const AppRegister());
  }

  void _onUnregistered(AppUnregistered event, Emitter<AppState> emit) {
    emit(const AppUnregister());
  }
}
