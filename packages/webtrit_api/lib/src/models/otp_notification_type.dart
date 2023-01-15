import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum OtpNotificationType {
  email;

  bool get isEmail => this == email;
}
