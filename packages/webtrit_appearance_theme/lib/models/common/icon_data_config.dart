import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_appearance_theme/converters/converters.dart';

part 'icon_data_config.freezed.dart';

part 'icon_data_config.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class IconDataConfig with _$IconDataConfig {
  /// Exact IconData representation.
  const IconDataConfig({
    /// e.g. 0xe491 (58513)
    required this.codePoint,

    /// e.g. "MaterialIcons"
    this.fontFamily = 'MaterialIcons',

    /// Mirrors IconData.matchTextDirection
    this.matchTextDirection = false,
  });

  @override
  @HexCodePointConverter()
  final int codePoint;

  @override
  final String fontFamily;

  @override
  final bool matchTextDirection;

  factory IconDataConfig.fromJson(Map<String, dynamic> json) =>
      _$IconDataConfigFromJson(json);

  Map<String, dynamic> toJson() => _$IconDataConfigToJson(this);
}
