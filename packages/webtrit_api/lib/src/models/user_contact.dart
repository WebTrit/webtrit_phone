import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webtrit_api/src/models/contact_numbers.dart';

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
    ContactNumbers? numbers,
    Sip? sip,
  }) = _UserContact;

  factory UserContact.fromJson(Map<String, Object?> json) => _$UserContactFromJson(json);
}

@freezed
class Sip with _$Sip {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Sip({
    String? displayName,
    String? status,
  }) = _Sip;

  factory Sip.fromJson(Map<String, Object?> json) => _$SipFromJson(json);
}

