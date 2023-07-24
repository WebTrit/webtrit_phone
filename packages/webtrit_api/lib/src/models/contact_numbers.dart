import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_numbers.freezed.dart';

part 'contact_numbers.g.dart';

@freezed
class ContactNumbers with _$ContactNumbers {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ContactNumbers({
    List<String>? additional,
    String? ext,
    String? main,
  }) = _ContactNumbers;

  factory ContactNumbers.fromJson(Map<String, Object?> json) => _$ContactNumbersFromJson(json);
}

