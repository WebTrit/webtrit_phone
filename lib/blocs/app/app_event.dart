part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogined extends AppEvent {
  const AppLogined({
    required this.token,
  });

  final String token;

  @override
  List<Object> get props => [token];
}

class AppLogouted extends AppEvent {
  const AppLogouted();
}
