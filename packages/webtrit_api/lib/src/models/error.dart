import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable(createToJson: false)
class ErrorResponse {
  const ErrorResponse({
    required this.code,
    this.refining,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  final String code;
  final List<ErrorRefining>? refining;
}

@JsonSerializable(createToJson: false)
class ErrorRefining {
  const ErrorRefining({
    required this.path,
    required this.reason,
  });

  factory ErrorRefining.fromJson(Map<String, dynamic> json) => _$ErrorRefiningFromJson(json);

  final String path;
  final String reason;
}
