import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_http_request.freezed.dart';

part 'raw_http_request.g.dart';

/// A fully self-contained HTTP request model that can be constructed from any source,
/// such as embedded pages, environment variables, or external configurations.
///
/// This model is intended for use cases where the request must be defined
/// independently of internal API clients or repositories.
@freezed
class RawHttpRequest with _$RawHttpRequest {
  const factory RawHttpRequest({
    required String method,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  }) = _RawHttpRequest;

  factory RawHttpRequest.fromJson(Map<String, dynamic> json) => _$RawHttpRequestFromJson(json);
}
