import 'package:json_annotation/json_annotation.dart';

part 'app_contacts_smart.g.dart';

class AppSmartContactsResponse {
  const AppSmartContactsResponse({
    required this.data,
  });

  factory AppSmartContactsResponse.fromJson(List<dynamic> json) {
    return AppSmartContactsResponse(
      data: json.map((e) => AppSmartContact.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  final List<AppSmartContact> data;
}

@JsonSerializable()
class AppSmartContact {
  const AppSmartContact({
    required this.identifier,
    required this.phones,
  });

  factory AppSmartContact.fromJson(Map<String, dynamic> json) => _$AppSmartContactFromJson(json);

  Map<String, dynamic> toJson() => _$AppSmartContactToJson(this);

  final String identifier;
  final List<String> phones;
}
