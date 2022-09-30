import 'request.dart';

abstract class SessionRequest extends Request {
  const SessionRequest({
    required this.transaction,
  }) : super();

  final String transaction;

  @override
  List<Object?> get props => [
        transaction,
      ];
}
