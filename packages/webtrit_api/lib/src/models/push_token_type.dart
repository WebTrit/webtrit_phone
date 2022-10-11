import 'package:json_annotation/json_annotation.dart';

@JsonEnum(
  fieldRename: FieldRename.snake,
)
enum PushTokenType {
  fcm,
  hms,
  apns,
  apkvoip,
}
