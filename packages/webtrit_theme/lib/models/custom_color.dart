import 'package:json_annotation/json_annotation.dart';

part 'custom_color.g.dart';

@JsonSerializable()
class CustomColor {
  const CustomColor({
    required this.color,
    this.blend = true,
  });

  final String color;
  final bool blend;

  factory CustomColor.fromJson(Map<String, dynamic> json) => _$CustomColorFromJson(json);

  Map<String, dynamic> toJson() => _$CustomColorToJson(this);
}
