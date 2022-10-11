import 'package:json_annotation/json_annotation.dart';

part 'account_contacts.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class AccountContactsResponse {
  const AccountContactsResponse({
    required this.data,
  });

  factory AccountContactsResponse.fromJson(Map<String, dynamic> json) => _$AccountContactsResponseFromJson(json);

  final List<AccountContact> data;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class AccountContact {
  const AccountContact({
    required this.number,
    required this.extensionId,
    this.extensionName,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.companyName,
    required this.sipStatus,
  });

  factory AccountContact.fromJson(Map<String, dynamic> json) => _$AccountContactFromJson(json);

  Map<String, dynamic> toJson() => _$AccountContactToJson(this);

  final String number;
  final String extensionId;
  final String? extensionName;
  @JsonKey(name: 'firstname')
  final String? firstName;
  @JsonKey(name: 'lastname')
  final String? lastName;
  final String? email;
  final String? mobile;
  final String? companyName;
  final int sipStatus;
}
