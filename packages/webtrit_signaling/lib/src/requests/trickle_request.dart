import 'call_request.dart';

class TrickleRequest extends CallRequest {
  const TrickleRequest({
    required String callId,
    this.candidate,
  }) : super(callId: callId);

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [
        ...super.props,
        candidate,
      ];

  static const request = 'trickle';

  factory TrickleRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return TrickleRequest(
      callId: json['call_id'],
      candidate: json['candidate'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'call_id': callId,
      'candidate': candidate,
    };
  }
}
