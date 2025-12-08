part of 'about_bloc.dart';

@freezed
class AboutState with _$AboutState {
  const AboutState({
    this.progress = false,
    this.embeddedLinks = const [],
    required this.appName,
    required this.packageName,
    required this.storeBuildVersion,
    required this.storeBuildNumber,
    required this.appVersion,
    required this.appIdentifier,
    required this.coreUrl,
    this.fcmPushToken,
    this.coreVersion,
  });

  @override
  final bool progress;

  @override
  final List<String> embeddedLinks;

  @override
  final String appName;

  @override
  final String packageName;

  @override
  final String storeBuildVersion;

  @override
  final String storeBuildNumber;

  @override
  final String appVersion;

  @override
  final String appIdentifier;

  @override
  final Uri coreUrl;

  @override
  final String? fcmPushToken;

  @override
  final Version? coreVersion;

  String get storeVersion => '$storeBuildVersion-$storeBuildNumber';
}
