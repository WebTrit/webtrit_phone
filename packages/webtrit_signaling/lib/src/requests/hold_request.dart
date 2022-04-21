import 'line_request.dart';

enum HoldDirection {
  sendonly,
  recvonly,
  inactive,
}

class HoldRequest extends LineRequest {
  const HoldRequest({
    required int line,
    this.direction,
  }) : super(line: line);

  final HoldDirection? direction;

  @override
  List<Object?> get props => [
        ...super.props,
        direction,
      ];
}
