import 'package:freezed_annotation/freezed_annotation.dart';

part 'separator_style_config.freezed.dart';

part 'separator_style_config.g.dart';

/// Declarative configuration for a list separator (divider line between items).
///
/// `null` for the whole config means "use the default" (separator shown with the
/// theme's default color); it does NOT mean hidden — set [enabled] to `false` for that.
@freezed
abstract class SeparatorStyleConfig with _$SeparatorStyleConfig {
  const factory SeparatorStyleConfig({
    /// Whether to render the separator. `null` → shown (default).
    bool? enabled,

    /// Separator color (hex string, e.g. `#CAC7D1`). `null` → theme default.
    String? color,
  }) = _SeparatorStyleConfig;

  factory SeparatorStyleConfig.fromJson(Map<String, dynamic> json) => _$SeparatorStyleConfigFromJson(json);
}
