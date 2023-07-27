import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_dto.freezed.dart';

part 'application_dto.g.dart';

@freezed
class ApplicationDTO with _$ApplicationDTO {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory ApplicationDTO({
    String? id,
    String? name,
    String? platformIdentifier,
    String? theme,
    int? version,
    GoogleServices? googleServices,
  }) = _ApplicationDTO;

  factory ApplicationDTO.fromJson(Map<String, dynamic> json) => _$ApplicationDTOFromJson(json);
}

@freezed
class GoogleServices with _$GoogleServices {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory GoogleServices({
    String? androidUrl,
    String? androidPath,
    String? iosUrl,
    String? iosPath,
    String? projectId,
  }) = _GoogleServicesDTO;

  factory GoogleServices.fromJson(Map<String, dynamic> json) => _$GoogleServicesFromJson(json);
}
