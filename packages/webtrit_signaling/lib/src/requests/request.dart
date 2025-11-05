import 'package:equatable/equatable.dart';

import 'abstract_requests.dart';

abstract class Request extends Equatable {
  const Request();

  Map<String, dynamic> toJson();

  static const typeKey = 'request';

  factory Request.fromJson(Map<String, dynamic> json) {
    final request = tryFromJson(json);
    if (request == null) {
      final requestTypeValue = json[Request.typeKey];
      throw ArgumentError.value(
          requestTypeValue, Request.typeKey, 'Unknown request type');
    } else {
      return request;
    }
  }

  static Request? tryFromJson(Map<String, dynamic> json) {
    return SessionRequest.tryFromJson(json);
  }
}
