import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/data/data.dart';

part 'app_bloc.freezed.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.secureStorage,
    required this.appDatabase,
  }) : super(AppState(
          coreUrl: secureStorage.readCoreUrl(),
          token: secureStorage.readToken(),
          webRegistrationInitialUrl: secureStorage.readWebRegistrationInitialUrl(),
        )) {
    on<AppLogined>(_onLogined, transformer: sequential());
    on<AppLogouted>(_onLogouted, transformer: sequential());
  }

  final SecureStorage secureStorage;
  final AppDatabase appDatabase;

  void _onLogined(AppLogined event, Emitter<AppState> emit) async {
    await secureStorage.writeCoreUrl(event.coreUrl);
    await secureStorage.writeToken(event.token);

    emit(state.copyWith(
      coreUrl: event.coreUrl,
      token: event.token,
    ));
  }

  void _onLogouted(AppLogouted event, Emitter<AppState> emit) async {
    await secureStorage.deleteCoreUrl();
    await secureStorage.deleteToken();

    await appDatabase.deleteEverything();

    emit(state.copyWith(
      coreUrl: null,
      token: null,
    ));
  }
}
