// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_smart_contact.freezed.dart';

part 'app_smart_contact.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AppSmartContact with _$AppSmartContact {
  const AppSmartContact({required this.identifier, required this.phones});

  @override
  final String identifier;

  @override
  final List<String> phones;

  factory AppSmartContact.fromJson(Map<String, dynamic> json) => _$AppSmartContactFromJson(json);

  Map<String, dynamic> toJson() => _$AppSmartContactToJson(this);
}
