import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_color.freezed.dart';
part 'custom_color.g.dart';

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class CustomColor with _$CustomColor {
  const factory CustomColor({
    required String color,
    @Default(true) bool blend,
  }) = _CustomColor;

  factory CustomColor.fromJson(Map<String, dynamic> json) =>
      _$CustomColorFromJson(json);
}
