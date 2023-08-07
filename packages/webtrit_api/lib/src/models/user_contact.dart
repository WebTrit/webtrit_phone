import 'package:freezed_annotation/freezed_annotation.dart';

import 'common.dart';

part 'user_contact.freezed.dart';

part 'user_contact.g.dart';

@freezed
class UserContact with _$UserContact {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserContact({
    SipStatus? sipStatus,
    required Numbers numbers,
    String? email,
    String? firstName,
    String? lastName,
    String? aliasName,
    String? companyName,
  }) = _UserContact;

  factory UserContact.fromJson(Map<String, Object?> json) => _$UserContactFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum SipStatus {
  registered,
  notregistered,
}
