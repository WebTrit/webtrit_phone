import 'package:json_annotation/json_annotation.dart';

part 'app_status.g.dart';

class AppStatusResponse {
  const AppStatusResponse({
    required this.data,
  });

  factory AppStatusResponse.fromJson(Map<String, dynamic> json) => AppStatusResponse(
        data: AppStatus.fromJson(json),
      );

  final AppStatus data;
}

class AppStatusUpdateRequest {
  const AppStatusUpdateRequest({
    required this.data,
  });

  Map<String, dynamic> toJson() => data.toJson();

  final AppStatus data;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class AppStatus {
  const AppStatus({
    required this.register,
  });

  factory AppStatus.fromJson(Map<String, dynamic> json) => _$AppStatusFromJson(json);

  Map<String, dynamic> toJson() => _$AppStatusToJson(this);

  final bool register;
}
