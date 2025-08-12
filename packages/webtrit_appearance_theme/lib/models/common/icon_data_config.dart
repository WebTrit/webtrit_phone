import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_appearance_theme/converters/converters.dart';

part 'icon_data_config.freezed.dart';

part 'icon_data_config.g.dart';

@freezed
class IconDataConfig with _$IconDataConfig {
  /// Exact IconData representation.
  const factory IconDataConfig({
    /// e.g. 0xe491 (58513)
    @HexCodePointConverter() required int codePoint,

    /// e.g. "MaterialIcons"
    @Default('MaterialIcons') String fontFamily,

    /// Mirrors IconData.matchTextDirection
    @Default(false) bool matchTextDirection,
  }) = _IconDataConfig;

  factory IconDataConfig.fromJson(Map<String, dynamic> json) => _$IconDataConfigFromJson(json);
}
