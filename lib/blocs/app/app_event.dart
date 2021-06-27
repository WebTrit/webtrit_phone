part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppRegistered extends AppEvent {
  const AppRegistered();
}

class AppUnregistered extends AppEvent {
  const AppUnregistered();
}
