import 'request.dart';

abstract class CallRequest extends Request {
  const CallRequest({
    required this.callId,
  }) : super();

  final String callId;

  @override
  List<Object?> get props => [
        callId,
      ];
}
