part of 'about_bloc.dart';

@freezed
class AboutState with _$AboutState {
  const AboutState({
    this.progress = false,
    this.embeddedResources = const [],
    required this.packageName,
    required this.appIdentifier,
    required this.coreUrl,
    required this.userAgent,
    required this.appInfo,
    required this.deviceInfo,
    required this.callkeepVersion,
    this.fcmPushToken,
    this.coreVersion,
    this.bundleVersion,
  });

  @override
  final bool progress;

  /// Every embedded resource this build is configured with, in configuration
  /// order. Carried as the resources themselves rather than their addresses:
  /// the About screen opens one, and that needs the whole resource.
  @override
  final List<EmbeddedData> embeddedResources;

  @override
  final String packageName;

  @override
  final String appIdentifier;

  @override
  final Uri coreUrl;

  @override
  final String userAgent;

  @override
  final String appInfo;

  @override
  final String deviceInfo;

  @override
  final String callkeepVersion;

  @override
  final String? fcmPushToken;

  @override
  final Version? coreVersion;

  /// Version of the deployment bundle (e.g. the Add-on Mart package version).
  /// `null` = the backend does not provide it; the About screen hides the row.
  @override
  final String? bundleVersion;
}
