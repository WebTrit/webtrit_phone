// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_contact.freezed.dart';

part 'account_contact.g.dart';

@freezed
class AccountContact with _$AccountContact {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AccountContact({
    required String number,
    required String extensionId,
    String? extensionName,
    @JsonKey(name: 'firstname') String? firstName,
    @JsonKey(name: 'lastname') String? lastName,
    String? email,
    String? mobile,
    String? companyName,
    required int sipStatus,
  }) = _AccountContact;

  factory AccountContact.fromJson(Map<String, dynamic> json) => _$AccountContactFromJson(json);
}
