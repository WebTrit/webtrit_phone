import 'session_request.dart';

abstract class LineRequest extends SessionRequest {
  const LineRequest({
    required String transaction,
    required this.line,
  }) : super(transaction: transaction);

  final int line;

  @override
  List<Object?> get props => [
        ...super.props,
        line,
      ];
}
