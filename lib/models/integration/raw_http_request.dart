import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_http_request.freezed.dart';

part 'raw_http_request.g.dart';

/// A fully self-contained HTTP request model that can be constructed from any source,
/// such as embedded pages, environment variables, or external configurations.
///
/// This model is intended for use cases where the request must be defined
/// independently of internal API clients or repositories.
@freezed
@JsonSerializable()
class RawHttpRequest with _$RawHttpRequest {
  const RawHttpRequest({
    required this.method,
    required this.url,
    this.headers,
    this.data,
  });

  @override
  final String method;
  @override
  final String url;
  @override
  final Map<String, String>? headers;
  @override
  final Map<String, dynamic>? data;

  factory RawHttpRequest.fromJson(Map<String, dynamic> json) => _$RawHttpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RawHttpRequestToJson(this);
}
