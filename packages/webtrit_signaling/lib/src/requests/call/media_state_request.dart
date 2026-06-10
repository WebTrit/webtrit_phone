import '../abstract_requests.dart';

class MediaStateRequest extends CallRequest {
  const MediaStateRequest({
    required super.transaction,
    required super.line,
    required super.callId,
    required this.media,
  });

  final Map<String, dynamic> media;

  @override
  List<Object?> get props => [...super.props, media];

  static const typeValue = 'media_state';

  factory MediaStateRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Not equal $typeValue');
    }

    return MediaStateRequest(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      media: json['media'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {Request.typeKey: typeValue, 'transaction': transaction, 'line': line, 'call_id': callId, 'media': media};
  }
}
