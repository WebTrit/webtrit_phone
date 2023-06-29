import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_collection_dto.freezed.dart';

part 'image_collection_dto.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ImageCollectionDTO with _$ImageCollectionDTO {
  const factory ImageCollectionDTO({
    String? onboarding,
    String? applicationLogo,
    String? notificationLogo,
    String? adaptiveIconBackground,
    String? adaptiveIconForeground,
    String? androidLauncherIcon,
    String? iosLauncherIcon,
    String? webLauncherIcon,
  }) = _ImageCollectionDTO;

  factory ImageCollectionDTO.fromJson(Map<String, Object?> json) => _$ImageCollectionDTOFromJson(json);
}
