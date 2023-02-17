part of 'about_bloc.dart';

abstract class AboutEvent {
  const AboutEvent();
}

class AboutStarted extends AboutEvent {
  const AboutStarted();
}

class AboutErrorDismissed extends AboutEvent {
  const AboutErrorDismissed();
}
