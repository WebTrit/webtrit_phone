// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_status.freezed.dart';

part 'app_status.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AppStatus with _$AppStatus {
  const AppStatus({required this.register});

  @override
  final bool register;

  factory AppStatus.fromJson(Map<String, dynamic> json) =>
      _$AppStatusFromJson(json);

  Map<String, dynamic> toJson() => _$AppStatusToJson(this);
}
