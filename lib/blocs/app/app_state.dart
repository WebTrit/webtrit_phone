part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppUnregister extends AppState {
  const AppUnregister();
}

class AppRegister extends AppState {
  const AppRegister();
}
