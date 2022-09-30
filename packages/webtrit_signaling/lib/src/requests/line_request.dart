import 'requests.dart';

abstract class LineRequest extends SessionRequest {
  const LineRequest({
    required String transaction,
    required this.line,
  }) : super(transaction: transaction);

  final int line;

  @override
  List<Object?> get props => [
        ...super.props,
        line,
      ];

  factory LineRequest.fromJson(Map<String, dynamic> json) {
    final lineRequest = tryFromJson(json);
    if (lineRequest == null) {
      final requestTypeValue = json[Request.typeKey];
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Unknown line request type');
    } else {
      return lineRequest;
    }
  }

  static LineRequest? tryFromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    return _lineRequestFromJsonDecoders[requestTypeValue]?.call(json) ?? CallRequest.tryFromJson(json);
  }

  static final Map<String, LineRequest Function(Map<String, dynamic>)> _lineRequestFromJsonDecoders = {
    IceTrickleRequest.typeValue: IceTrickleRequest.fromJson,
  };
}
