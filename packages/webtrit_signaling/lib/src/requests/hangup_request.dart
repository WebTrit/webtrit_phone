import 'line_request.dart';

class HangupRequest extends LineRequest {
  const HangupRequest({
    required int line,
  }) : super(line: line);
}
