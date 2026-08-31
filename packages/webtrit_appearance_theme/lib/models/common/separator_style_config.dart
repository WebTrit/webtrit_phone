import 'package:freezed_annotation/freezed_annotation.dart';

part 'separator_style_config.freezed.dart';

part 'separator_style_config.g.dart';

/// Declarative configuration for a list separator (divider line between items).
///
/// `null` for the whole config means "use the default" (separator shown with the
/// theme's default color); it does NOT mean hidden — set [enabled] to `false` for that.
@freezed
@JsonSerializable(explicitToJson: true)
class SeparatorStyleConfig with _$SeparatorStyleConfig {
  const SeparatorStyleConfig({this.enabled, this.color});

  /// Whether to render the separator. `null` → shown (default).
  @override
  final bool? enabled;

  /// Separator color (hex string, e.g. `#CAC7D1`). `null` → theme default.
  @override
  final String? color;

  factory SeparatorStyleConfig.fromJson(Map<String, Object?> json) => _$SeparatorStyleConfigFromJson(json);

  Map<String, Object?> toJson() => _$SeparatorStyleConfigToJson(this);
}
