import 'package:freezed_annotation/freezed_annotation.dart';

part 'numbers.freezed.dart';

part 'numbers.g.dart';

@freezed
class Numbers with _$Numbers {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Numbers({
    required String main,
    List<String>? additional,
    String? ext,
  }) = _Numbers;

  factory Numbers.fromJson(Map<String, Object?> json) => _$NumbersFromJson(json);
}
