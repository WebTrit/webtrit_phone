import 'package:freezed_annotation/freezed_annotation.dart';

part 'separator_style_config.freezed.dart';

part 'separator_style_config.g.dart';

/// Declarative configuration for a list separator (divider line between items).
///
/// `null` for the whole config means "use the default" (separator shown with the
/// theme's default color); it does NOT mean hidden - set [enabled] to `false`
/// for that.
///
/// A config that exists always answers whether the separator shows. It used to
/// be able to exist and say nothing, which is how a coloured separator turned a
/// hidden one back on: the store writes this style as soon as either of its
/// fields is filled, so colouring one produced a style with no visibility in
/// it, and a null read as shown.
@freezed
@JsonSerializable(explicitToJson: true)
class SeparatorStyleConfig with _$SeparatorStyleConfig {
  const SeparatorStyleConfig({this.enabled = true, this.color});

  /// Whether to render the separator.
  @override
  final bool enabled;

  /// Separator color (hex string, e.g. `#CAC7D1`). `null` → theme default.
  @override
  final String? color;

  factory SeparatorStyleConfig.fromJson(Map<String, Object?> json) => _$SeparatorStyleConfigFromJson(json);

  Map<String, Object?> toJson() => _$SeparatorStyleConfigToJson(this);
}
