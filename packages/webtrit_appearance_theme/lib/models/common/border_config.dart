import 'package:freezed_annotation/freezed_annotation.dart';

import 'style_types.dart';

part 'border_config.freezed.dart';

part 'border_config.g.dart';

/// Declarative configuration for input borders.
///
/// Mirrors Flutter's [InputBorder] types such as [UnderlineInputBorder]
/// and [OutlineInputBorder].
@freezed
abstract class BorderConfig with _$BorderConfig {
  const factory BorderConfig({
    /// Border type:
    /// - [`BorderTypeConfig.underline`]
    /// - [`BorderTypeConfig.outline`]
    /// - [`BorderTypeConfig.none`]
    @Default(BorderTypeConfig.underline) BorderTypeConfig type,

    /// Corner radius for outline borders.
    double? borderRadius,

    /// Border color (hex string, e.g. `#000000`).
    String? borderColor,

    /// Stroke width of the border.
    double? borderWidth,
  }) = _BorderConfig;

  factory BorderConfig.fromJson(Map<String, dynamic> json) => _$BorderConfigFromJson(json);
}
