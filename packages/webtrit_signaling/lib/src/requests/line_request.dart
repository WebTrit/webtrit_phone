import 'session_request.dart';

abstract class LineRequest extends SessionRequest {
  const LineRequest({
    required this.line,
  }) : super();

  final int line;

  @override
  List<Object?> get props => [
        line,
      ];
}
