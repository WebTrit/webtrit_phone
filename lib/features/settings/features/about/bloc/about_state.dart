part of 'about_bloc.dart';

@freezed
class AboutState with _$AboutState {
  const AboutState({
    this.progress = false,
    this.embeddedLinks = const [],
    required this.packageName,
    required this.appIdentifier,
    required this.coreUrl,
    required this.userAgent,
    this.fcmPushToken,
    this.coreVersion,
  });

  @override
  final bool progress;

  @override
  final List<String> embeddedLinks;

  @override
  final String packageName;

  @override
  final String appIdentifier;

  @override
  final Uri coreUrl;

  @override
  final String userAgent;

  @override
  final String? fcmPushToken;

  @override
  final Version? coreVersion;
}
