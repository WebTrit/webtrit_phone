import 'request.dart';

abstract class LineRequest extends Request {
  const LineRequest({
    required this.line,
  }) : super();

  final int line;

  @override
  List<Object?> get props => [
        line,
      ];

  Map<String, dynamic> toJson();
}
