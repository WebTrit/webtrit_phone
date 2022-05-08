part of 'about_app_tab_bloc.dart';

abstract class AboutAppTabEvent extends Equatable {
  const AboutAppTabEvent();
}

class AboutAppTabStarted extends AboutAppTabEvent {
  const AboutAppTabStarted();

  @override
  List<Object?> get props => [];
}
