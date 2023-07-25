import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webtrit_api/src/models/numbers.dart';

part 'user_contact.freezed.dart';

part 'user_contact.g.dart';

@freezed
class UserContact with _$UserContact {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserContact({
    String? companyName,
    String? email,
    String? firstName,
    String? lastName,
    Numbers? numbers,
    UserContactSip? sip,
  }) = _UserContact;

  factory UserContact.fromJson(Map<String, Object?> json) => _$UserContactFromJson(json);
}

@freezed
class UserContactSip with _$UserContactSip {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserContactSip({
    String? displayName,
    String? status,
  }) = _UserContactSip;

  factory UserContactSip.fromJson(Map<String, Object?> json) => _$UserContactSipFromJson(json);
}
