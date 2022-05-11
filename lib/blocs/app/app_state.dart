part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppLogout extends AppState {
  const AppLogout();
}

class AppLogin extends AppState {
  const AppLogin();
}
