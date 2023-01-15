import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum AppType {
  smart,
  web,
  linux,
  macos,
  windows,
  android,
  androidHms,
  ios,
}
