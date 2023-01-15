// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_status.freezed.dart';

part 'app_status.g.dart';

@freezed
class AppStatus with _$AppStatus {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AppStatus({
    required bool register,
  }) = _AppStatus;

  factory AppStatus.fromJson(Map<String, dynamic> json) => _$AppStatusFromJson(json);
}
