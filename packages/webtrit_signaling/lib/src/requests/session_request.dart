import 'abstract_requests.dart';

abstract class SessionRequest extends Request {
  const SessionRequest({required this.transaction}) : super();

  final String transaction;

  @override
  List<Object?> get props => [transaction];

  factory SessionRequest.fromJson(Map<String, dynamic> json) {
    final sessionRequest = tryFromJson(json);
    if (sessionRequest == null) {
      final requestTypeValue = json[Request.typeKey];
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Unknown session request type');
    } else {
      return sessionRequest;
    }
  }

  static SessionRequest? tryFromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    return _sessionRequestFromJsonDecoders[requestTypeValue]?.call(json) ?? LineRequest.tryFromJson(json);
  }

  static final Map<String, SessionRequest Function(Map<String, dynamic>)> _sessionRequestFromJsonDecoders = {};
}
