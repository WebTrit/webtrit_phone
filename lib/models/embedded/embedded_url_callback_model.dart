import 'package:freezed_annotation/freezed_annotation.dart';

part 'embedded_url_callback_model.freezed.dart';

part 'embedded_url_callback_model.g.dart';

@freezed
class EmbeddedUrlCallbackModel with _$EmbeddedUrlCallbackModel {
  const factory EmbeddedUrlCallbackModel({
    required String method,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  }) = _EmbeddedUrlCallbackModel;

  factory EmbeddedUrlCallbackModel.fromJson(Map<String, dynamic> json) => _$EmbeddedUrlCallbackModelFromJson(json);
}
