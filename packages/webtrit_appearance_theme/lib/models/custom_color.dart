import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_color.freezed.dart';

part 'custom_color.g.dart';

@freezed
@JsonSerializable()
class CustomColor with _$CustomColor {
  /// Creates a [CustomColor].
  const CustomColor({required this.color, this.blend = true});

  /// The base color in hex format (e.g., `#FF0000`).
  @override
  final String color;

  /// Whether this color should blend with the theme seed.
  @override
  final bool blend;

  factory CustomColor.fromJson(Map<String, Object?> json) =>
      _$CustomColorFromJson(json);

  Map<String, Object?> toJson() => _$CustomColorToJson(this);
}
