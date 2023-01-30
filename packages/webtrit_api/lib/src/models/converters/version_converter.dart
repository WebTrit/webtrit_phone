import 'package:json_annotation/json_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

class VersionConverter implements JsonConverter<Version, String> {
  const VersionConverter();

  @override
  Version fromJson(String versionJson) => Version.parse(versionJson);

  @override
  String toJson(Version version) => version.toString();
}
