import 'package:json_annotation/json_annotation.dart';

part 'account_contacts.g.dart';

@JsonSerializable(createToJson: false)
class AccountContactsResponse {
  const AccountContactsResponse({
    required this.data,
  });

  factory AccountContactsResponse.fromJson(Map<String, dynamic> json) => _$AccountContactsResponseFromJson(json);

  final List<AccountContact> data;
}

@JsonSerializable()
class AccountContact {
  const AccountContact({
    required this.number,
    required this.extensionId,
    this.extensionName,
    this.firstname,
    this.lastname,
    this.email,
    this.mobile,
    this.companyName,
    required this.sipStatus,
  });

  factory AccountContact.fromJson(Map<String, dynamic> json) => _$AccountContactFromJson(json);

  Map<String, dynamic> toJson() => _$AccountContactToJson(this);

  final String number;
  @JsonKey(name: 'extension_id')
  final String extensionId;
  @JsonKey(name: 'extension_name')
  final String? extensionName;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? mobile;
  @JsonKey(name: 'company_name')
  final String? companyName;
  @JsonKey(name: 'sip_status')
  final int sipStatus;
}
