part of 'about_bloc.dart';

sealed class AboutEvent {
  const AboutEvent();
}

class AboutStarted extends AboutEvent {
  const AboutStarted();
}