// ignore_for_file: invalid_annotation_target

import 'package:webtrit_api/src/models/session_authorized_response.dart';
import 'package:webtrit_api/src/models/session_otp_response.dart';
import 'package:webtrit_api/src/models/session_undefine_response.dart';

class BaseSessionResponse {
  static BaseSessionResponse fromJson(Map<String, dynamic> json) {
    if (json.containsKey('otp_id')) {
      return SessionOtpResponse.fromJson(json);
    } else if (json.containsKey('token')) {
      return SessionAuthorizedResponse.fromJson(json);
    } else {
      return SessionUndefineResponse.fromJson(json);
    }
  }
}
