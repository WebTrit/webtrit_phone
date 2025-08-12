import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_bar_style_config.freezed.dart';

part 'app_bar_style_config.g.dart';

@freezed
class AppBarStyleConfig with _$AppBarStyleConfig {
  @JsonSerializable(explicitToJson: true)
  const factory AppBarStyleConfig({
    /// Background color for the AppBar (hex, e.g. "#FFFFFF")
    String? backgroundColor,

    /// Foreground color for icons & text (hex)
    String? foregroundColor,

    /// Whether the AppBar is considered primary
    @Default(true) bool primary,

    /// Optional flag for showing back button
    @Default(true) bool showBackButton,
  }) = _AppBarStyleConfig;

  factory AppBarStyleConfig.fromJson(Map<String, dynamic> json) => _$AppBarStyleConfigFromJson(json);
}
