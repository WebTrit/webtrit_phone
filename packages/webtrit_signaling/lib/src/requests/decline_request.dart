import 'line_request.dart';

class DeclineRequest extends LineRequest {
  const DeclineRequest({
    required int line,
  }) : super(line: line);
}
