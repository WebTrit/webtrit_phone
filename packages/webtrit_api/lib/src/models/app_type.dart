import 'package:json_annotation/json_annotation.dart';

enum AppType {
  smart,
  web,
  linux,
  macos,
  windows,
  android,
  @JsonValue('android_hms')
  androidHms,
  ios,
}
