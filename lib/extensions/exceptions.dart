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
        return context.l10n.socketError_serverUnreachable;
      case 8: // EHOSTUNREACH
        return context.l10n.socketError_networkUnreachable;
      case 11: // ETIMEDOUT
        return context.l10n.socketError_connectionTimedOut;
      case 111: // ECONNREFUSED
        return context.l10n.socketError_connectionRefused;
      case 101: // ENETUNREACH
        return context.l10n.socketError_networkUnreachable;
      case 104: // ECONNRESET
        return context.l10n.socketError_connectionReset;
      default:
        return context.l10n.socketError_default;
    }
  }

  String descriptionL10n(BuildContext context) {
    switch (osError?.errorCode) {
      case 7: // EHOSTDOWN
        return context.l10n.socketError_serverUnreachableDescription;
      case 8: // EHOSTUNREACH
        return context.l10n.socketError_networkUnreachableDescription;
      case 11: // ETIMEDOUT
        return context.l10n.socketError_connectionTimedOutDescription;
      case 111: // ECONNREFUSED
        return context.l10n.socketError_connectionRefusedDescription;
      case 101: // ENETUNREACH
        return context.l10n.socketError_networkUnreachableDescription;
      case 104: // ECONNRESET
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
