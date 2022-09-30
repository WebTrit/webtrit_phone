import 'line_request.dart';

abstract class CallRequest extends LineRequest {
  const CallRequest({
    required String transaction,
    required int line,
    required this.callId,
  }) : super(transaction: transaction, line: line);

  final String callId;

  @override
  List<Object?> get props => [
        ...super.props,
        callId,
      ];
}
