import 'package:json_annotation/json_annotation.dart';

part 'account_info.g.dart';

@JsonSerializable(createToJson: false)
class AccountInfoResponse {
  const AccountInfoResponse({
    required this.data,
  });

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) => _$AccountInfoResponseFromJson(json);

  final AccountInfo data;
}

@JsonSerializable()
class AccountInfo {
  const AccountInfo({
    required this.balance,
    required this.currency,
    required this.extensionName,
    required this.firstname,
    required this.lastname,
    this.email,
    this.mobile,
    this.companyName,
    required this.ext,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) => _$AccountInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoToJson(this);

  final double balance;
  final String currency;
  @JsonKey(name: 'extension_name')
  final String? extensionName;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? mobile;
  @JsonKey(name: 'company_name')
  final String? companyName;
  final String ext;
}
