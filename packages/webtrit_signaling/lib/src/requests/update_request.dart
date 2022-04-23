import 'call_request.dart';

class UpdateRequest extends CallRequest {
  const UpdateRequest({
    required String callId,
    required this.jsep,
  }) : super(callId: callId);

  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        jsep,
      ];

  static const request = 'update';

  factory UpdateRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return UpdateRequest(
      callId: json['call_id'],
      jsep: json['jsep'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'call_id': callId,
      'jsep': jsep,
    };
  }
}
