part of 'about_bloc.dart';

@freezed
class AboutState with _$AboutState {
  const AboutState._();

  const factory AboutState({
    @Default(false) bool progress,
    required String appName,
    required String packageName,
    required String storeBuildVersion,
    required String storeBuildNumber,
    required Uri coreUrl,
    Version? coreVersion,
  }) = _AboutState;

  String get storeVersion => '$storeBuildVersion-$storeBuildNumber';
}
