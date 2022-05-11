import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.webtritApiClient,
    required this.secureStorage,
    required this.appDatabase,
  }) : super(const AppLogout()) {
    on<AppLogined>(_onLogined, transformer: sequential());
    on<AppLogouted>(_onLogouted, transformer: sequential());
  }

  final WebtritApiClient webtritApiClient;
  final SecureStorage secureStorage;
  final AppDatabase appDatabase;

  void _onLogined(AppLogined event, Emitter<AppState> emit) async {
    await secureStorage.writeToken(event.token);

    emit(const AppLogin());
  }

  void _onLogouted(AppLogouted event, Emitter<AppState> emit) async {
    final token = await secureStorage.readToken();
    if (token != null) {
      await secureStorage.deleteToken();
      await webtritApiClient.sessionLogout(token);
    }
    appDatabase.deleteEverything();

    emit(const AppLogout());
  }
}
