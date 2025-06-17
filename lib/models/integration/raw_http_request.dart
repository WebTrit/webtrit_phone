import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_http_request.freezed.dart';

part 'raw_http_request.g.dart';

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
