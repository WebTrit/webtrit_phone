import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

// The meaning of each code can be found at:
// https://www.gnu.org/software/libc/manual/html_node/Error-Codes.html
extension SocketExceptionL10n on SocketException {
  String titleL10n(BuildContext context) {
    switch (osError?.errorCode) {
      case 7:
        return 'The server is unreachable due to network issues';
      case 8: // EHOSTUNREACH
        return 'Network Unreachable';
      case 11: // ETIMEDOUT
        return 'Connection Timed Out';
      case 111: // ECONNREFUSED
        return 'Connection Refused';
      case 101: // ENETUNREACH
        return 'The server is unreachable due to network issues';
      case 104: // ECONNRESET
        return 'Connection Reset';
      default:
        return 'Network Error';
    }
  }

  String descriptionL10n(BuildContext context) {
    switch (osError?.errorCode) {
      case 7: // EHOSTDOWN
        return 'The server is unreachable. This could be due to no internet connection or server maintenance. Please check your internet connection and try again.';
      case 8: // EHOSTUNREACH
        return 'The network is unreachable. This could be due to a weak internet connection, network restrictions such as firewalls, or incorrect DNS settings. If you\'re on a work or restricted network, please contact your network administrator or try using a different network.';
      case 11: // ETIMEDOUT
        return 'The connection has timed out. This might happen due to a slow or unstable internet connection. Please check your connection and try again.';
      case 111: // ECONNREFUSED
        return 'The server refused the connection. The server may be down or rejecting requests. Please try again later.';
      case 101: // ENETUNREACH
        return 'The network is unreachable. Please ensure your device is connected to the internet or switch to a more reliable network.';
      case 104: // ECONNRESET
        return 'The connection was reset by the server. Please try again.';
      default:
        return 'An unexpected network error occurred (Error code: ${osError?.errorCode}). This might be caused by network issues or server problems. Please try again later.';
    }
  }

  List<ErrorFieldModel> errorFields(BuildContext context) {
    return [
      ErrorFieldModel(context.l10n.default_ErrorMessage, titleL10n(context)),
      ErrorFieldModel(context.l10n.default_ErrorDetails, descriptionL10n(context)),
    ];
  }
}
