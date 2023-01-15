// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_smart_contact.freezed.dart';

part 'app_smart_contact.g.dart';

@freezed
class AppSmartContact with _$AppSmartContact {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AppSmartContact({
    required String identifier,
    required List<String> phones,
  }) = _AppSmartContact;

  factory AppSmartContact.fromJson(Map<String, dynamic> json) => _$AppSmartContactFromJson(json);
}
