// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

import 'converters/converters.dart';

part 'info.freezed.dart';

part 'info.g.dart';

@freezed
class Info with _$Info {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Info({
    required CoreInfo core,
  }) = _Info;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}

@freezed
class CoreInfo with _$CoreInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CoreInfo({
    @VersionConverter() required Version version,
  }) = _CoreInfo;

  factory CoreInfo.fromJson(Map<String, dynamic> json) => _$CoreInfoFromJson(json);
}
