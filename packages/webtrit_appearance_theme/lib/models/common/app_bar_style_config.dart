import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_bar_style_config.freezed.dart';

part 'app_bar_style_config.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class AppBarStyleConfig with _$AppBarStyleConfig {
  const AppBarStyleConfig({
    /// Background color for the AppBar (hex, e.g. "#FFFFFF")
    this.backgroundColor,

    /// Foreground color for icons & text (hex)
    this.foregroundColor,

    /// Whether the AppBar is considered primary
    this.primary = true,

    /// Optional flag for showing back button
    this.showBackButton = true,
  });

  @override
  final String? backgroundColor;

  @override
  final String? foregroundColor;

  @override
  final bool primary;

  @override
  final bool showBackButton;

  factory AppBarStyleConfig.fromJson(Map<String, dynamic> json) =>
      _$AppBarStyleConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AppBarStyleConfigToJson(this);
}
