import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';

part 'config.g.dart';

@freezed
class Config with _$Config {
  const factory Config({
    String? name,
    String? version,
    @Default(false) bool autoUpdate,
    required Mapping mapping,
    required Hosts hosts,
    Output? output,
  }) = _Config;

  factory Config.fromJson(Map<String, Object?> json) => _$ConfigFromJson(json);
}

@freezed
class Output with _$Output {
  const factory Output({
    Path? theme,
    Path? primaryOnboardingLogo,
    Path? secondaryOnboardingLogo,
    Path? pushNotificationIcon,
    Path? adaptiveIconBackground,
    Path? adaptiveIconForeground,
    Path? androidLauncherIcon,
    Path? iosLauncherIcon,
    Path? webLauncherIcon,
  }) = _Output;

  factory Output.fromJson(Map<String, Object?> json) => _$OutputFromJson(json);
}

@freezed
class Path with _$Path {
  const factory Path({
    String? path,
    String? name,
  }) = _Path;

  factory Path.fromJson(Map<String, Object?> json) => _$PathFromJson(json);
}

extension PathExtension on Path {
  String getFullPath() {
    return path! + '/' + name!;
  }
}

@freezed
class Hosts with _$Hosts {
  const factory Hosts({
    String? stage,
    required String prod,
  }) = _Hosts;

  factory Hosts.fromJson(Map<String, Object?> json) => _$HostsFromJson(json);
}

@freezed
class Mapping with _$Mapping {
  const factory Mapping({
    String? themeId,
    String? applicationId,
    String? themePath,
    String? applicationPath,
  }) = _CredentialBean;

  factory Mapping.fromJson(Map<String, Object?> json) => _$MappingFromJson(json);
}

enum MappingType { remote, local }

extension MappingTypeExtension on Mapping {
  String get getThemeId => themeId!;

  String get getApplicationId => applicationId!;

  MappingType getType() {
    if (_isNotNullOrEmpty(themeId) && _isNotNullOrEmpty(applicationId)) {
      return MappingType.remote;
    }

    if (_isNotNullOrEmpty(themePath) && _isNotNullOrEmpty(applicationPath)) {
      return MappingType.local;
    }

    throw Exception('Not valid config field');
  }

  bool _isNotNullOrEmpty(String? str) {
    return !_isNullOrEmpty(str);
  }

  bool _isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }
}
