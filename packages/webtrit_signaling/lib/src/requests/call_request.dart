import 'abstract_requests.dart';
import 'call/call_requests.dart';

abstract class CallRequest extends LineRequest {
  const CallRequest({
    required super.transaction,
    required super.line,
    required this.callId,
  });

  final String callId;

  @override
  List<Object?> get props => [
        ...super.props,
        callId,
      ];

  factory CallRequest.fromJson(Map<String, dynamic> json) {
    final callRequest = tryFromJson(json);
    if (callRequest == null) {
      final requestTypeValue = json[Request.typeKey];
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Unknown call request type');
    } else {
      return callRequest;
    }
  }

  static CallRequest? tryFromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    return _callRequestFromJsonDecoders[requestTypeValue]?.call(json);
  }

  static final Map<String, CallRequest Function(Map<String, dynamic>)> _callRequestFromJsonDecoders = {
    AcceptRequest.typeValue: AcceptRequest.fromJson,
    DeclineRequest.typeValue: DeclineRequest.fromJson,
    HangupRequest.typeValue: HangupRequest.fromJson,
    HoldRequest.typeValue: HoldRequest.fromJson,
    OutgoingCallRequest.typeValue: OutgoingCallRequest.fromJson,
    TransferRequest.typeValue: TransferRequest.fromJson,
    UnholdRequest.typeValue: UnholdRequest.fromJson,
    UpdateRequest.typeValue: UpdateRequest.fromJson,
  };
}
