part of 'help_tab_bloc.dart';

abstract class HelpTabEvent extends Equatable {
  const HelpTabEvent();
}

class HelpTabStarted extends HelpTabEvent {
  const HelpTabStarted();

  @override
  List<Object?> get props => [];
}
