import 'package:freezed_annotation/freezed_annotation.dart';

part 'overlay_style_model.freezed.dart';

part 'overlay_style_model.g.dart';

@freezed
@JsonSerializable()
class OverlayStyleModel with _$OverlayStyleModel {
  /// Creates an [OverlayStyleModel].
  const OverlayStyleModel({
    /// System navigation bar background color.
    this.systemNavigationBarColor,

    /// System navigation bar icon brightness (e.g., "dark" or "light").
    this.systemNavigationBarIconBrightness,

    /// Status bar icon brightness (e.g., "dark" or "light").
    this.statusBarIconBrightness,

    /// Status bar brightness (e.g., "dark" or "light").
    this.statusBarBrightness,
  });

  /// System navigation bar background color.
  @override
  final String? systemNavigationBarColor;

  /// System navigation bar icon brightness (e.g., "dark" or "light").
  @override
  final String? systemNavigationBarIconBrightness;

  /// Status bar icon brightness (e.g., "dark" or "light").
  @override
  final String? statusBarIconBrightness;

  /// Status bar brightness (e.g., "dark" or "light").
  @override
  final String? statusBarBrightness;

  factory OverlayStyleModel.fromJson(Map<String, Object?> json) => _$OverlayStyleModelFromJson(json);

  Map<String, Object?> toJson() => _$OverlayStyleModelToJson(this);
}
