part of 'about_bloc.dart';

abstract class AboutEvent {
  const AboutEvent();
}

@Freezed(copyWith: false)
class AboutStarted with _$AboutStarted implements AboutEvent {
  const factory AboutStarted() = _AboutStarted;
}
