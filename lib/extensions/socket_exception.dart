import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

// The meaning of each code can be found at:
// https://www.gnu.org/software/libc/manual/html_node/Error-Codes.html
const int _errorHostDown = 7; // EHOSTDOWN
const int _errorHostUnreachable = 8; // EHOSTUNREACH
const int _errorTimeout = 11; // ETIMEDOUT
const int _errorConnectionRefused = 111; // ECONNREFUSED
const int _errorNetworkUnreachable = 101; // ENETUNREACH
const int _errorConnectionReset = 104; // ECONNRESET

extension SocketExceptionL10n on SocketException {
  String titleL10n(BuildContext context) {
    switch (osError?.errorCode) {
      case _errorHostDown:
        return context.l10n.socketError_serverUnreachable;
      case _errorHostUnreachable:
        return context.l10n.socketError_networkUnreachable;
      case _errorTimeout:
        return context.l10n.socketError_connectionTimedOut;
      case _errorConnectionRefused:
        return context.l10n.socketError_connectionRefused;
      case _errorNetworkUnreachable:
        return context.l10n.socketError_networkUnreachable;
      case _errorConnectionReset:
        return context.l10n.socketError_connectionReset;
      default:
        return context.l10n.socketError_default;
    }
  }

  String descriptionL10n(BuildContext context) {
    switch (osError?.errorCode) {
      case _errorHostDown:
        return context.l10n.socketError_serverUnreachableDescription;
      case _errorHostUnreachable:
        return context.l10n.socketError_networkUnreachableDescription;
      case _errorTimeout:
        return context.l10n.socketError_connectionTimedOutDescription;
      case _errorConnectionRefused:
        return context.l10n.socketError_connectionRefusedDescription;
      case _errorNetworkUnreachable:
        return context.l10n.socketError_networkUnreachableDescription;
      case _errorConnectionReset:
        return context.l10n.socketError_connectionResetDescription;
      default:
        return context.l10n.socketError_defaultDescription(osError?.errorCode);
    }
  }

  List<ErrorFieldModel> errorFields(BuildContext context) {
    return [
      ErrorFieldModel(context.l10n.default_ErrorMessage, titleL10n(context)),
      ErrorFieldModel(context.l10n.default_ErrorDetails, descriptionL10n(context)),
    ];
  }
}
