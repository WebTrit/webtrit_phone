import 'line_request.dart';

class TrickleRequest extends LineRequest {
  const TrickleRequest({
    required int line,
    this.candidate,
  }) : super(line: line);

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [
        ...super.props,
        candidate,
      ];
}
