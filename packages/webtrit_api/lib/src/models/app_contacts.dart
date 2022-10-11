import 'package:json_annotation/json_annotation.dart';

part 'app_contacts.g.dart';

class AppCreateContactsRequest {
  const AppCreateContactsRequest({
    required this.data,
  });

  List<dynamic> toJson() => data.map((e) => e.toJson()).toList();

  final List<AppContact> data;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class AppContact {
  const AppContact({
    required this.identifier,
    required this.phones,
  });

  factory AppContact.fromJson(Map<String, dynamic> json) => _$AppContactFromJson(json);

  Map<String, dynamic> toJson() => _$AppContactToJson(this);

  final String identifier;
  final List<String> phones;
}
