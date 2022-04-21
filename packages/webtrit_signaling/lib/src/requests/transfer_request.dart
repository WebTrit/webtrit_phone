import 'line_request.dart';

class TransferRequest extends LineRequest {
  const TransferRequest({
    required int line,
    required this.number,
    this.replaceCallId,
  }) : super(line: line);

  final String number;
  final String? replaceCallId;

  @override
  List<Object?> get props => [
        ...super.props,
        number,
        replaceCallId,
      ];
}
