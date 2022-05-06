part of 'language_tab_bloc.dart';

abstract class LanguageTabEvent extends Equatable {
  const LanguageTabEvent();
}

class LanguageTabStarted extends LanguageTabEvent {
  const LanguageTabStarted();

  @override
  List<Object?> get props => [];
}
