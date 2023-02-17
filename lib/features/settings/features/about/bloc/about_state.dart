part of 'about_bloc.dart';

@freezed
class AboutState with _$AboutState {
  const AboutState._();

  const factory AboutState({
    @Default(false) bool progress,
    required String appName,
    required String packageName,
    required String version,
    required String buildNumber,
    required Uri coreUrl,
    Version? coreVersion,
    Object? error,
  }) = _AboutState;

  String get appVersion => '$version-$buildNumber';
}
