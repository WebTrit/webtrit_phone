part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class MainStarted extends MainEvent {
  const MainStarted();

  @override
  List<Object?> get props => [];
}
