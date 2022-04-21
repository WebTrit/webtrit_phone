import 'line_request.dart';

class UpdateRequest extends LineRequest {
  const UpdateRequest({
    required int line,
    required this.jsep,
  }) : super(line: line);

  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        jsep,
      ];
}
