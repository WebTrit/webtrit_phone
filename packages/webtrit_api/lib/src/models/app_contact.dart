// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_contact.freezed.dart';

part 'app_contact.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AppContact with _$AppContact {
  const AppContact({required this.identifier, required this.phones});

  @override
  final String identifier;

  @override
  final List<String> phones;

  factory AppContact.fromJson(Map<String, dynamic> json) =>
      _$AppContactFromJson(json);

  Map<String, dynamic> toJson() => _$AppContactToJson(this);
}
