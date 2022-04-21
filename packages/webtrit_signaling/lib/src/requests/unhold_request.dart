import 'line_request.dart';

class UnholdRequest extends LineRequest {
  const UnholdRequest({
    required int line,
  }) : super(line: line);
}
