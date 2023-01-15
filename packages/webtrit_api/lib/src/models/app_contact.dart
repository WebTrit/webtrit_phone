// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_contact.freezed.dart';

part 'app_contact.g.dart';

@freezed
class AppContact with _$AppContact {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AppContact({
    required String identifier,
    required List<String> phones,
  }) = _AppContact;

  factory AppContact.fromJson(Map<String, dynamic> json) => _$AppContactFromJson(json);
}
