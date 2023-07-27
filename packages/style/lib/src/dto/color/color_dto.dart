import 'package:freezed_annotation/freezed_annotation.dart';

part 'color_dto.freezed.dart';

part 'color_dto.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ColorDTO with _$ColorDTO {
  const factory ColorDTO({
    String? primary,
    String? onPrimary,
    String? secondary,
    String? secondaryContainer,
    String? onSecondaryContainer,
    String? tertiary,
    String? error,
    String? outline,
    String? background,
    String? onBackground,
    String? surface,
    String? onSurface,
    List<String>? gradientTabColor,
    LaunchDTO? launch,
  }) = _ColorDTO;

  factory ColorDTO.fromJson(Map<String, Object?> json) => _$ColorDTOFromJson(json);
}

@freezed
class LaunchDTO with _$LaunchDTO {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory LaunchDTO({
    String? adaptiveIconBackground,
    String? splashBackground,
  }) = _LaunchDTO;

  factory LaunchDTO.fromJson(Map<String, dynamic> json) => _$LaunchDTOFromJson(json);
}
