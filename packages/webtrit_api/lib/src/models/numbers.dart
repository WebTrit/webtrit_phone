import 'package:freezed_annotation/freezed_annotation.dart';

part 'numbers.freezed.dart';

part 'numbers.g.dart';

@freezed
class Numbers with _$Numbers {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Numbers({
    List<String>? additional,
    String? ext,
    String? main,
  }) = _Numbers;

  factory Numbers.fromJson(Map<String, Object?> json) => _$NumbersFromJson(json);
}

