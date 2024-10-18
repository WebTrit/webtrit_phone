import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';

import 'l10n.dart';

String defaultErrorL10n(BuildContext context, Object error) {
  return switch (error) {
    FormatException() => context.l10n.default_FormatExceptionError,
    TlsException() => context.l10n.default_TlsExceptionError,
    SocketException() => context.l10n.default_SocketExceptionError,
    ClientException() => context.l10n.default_ClientExceptionError,
    TypeError() => context.l10n.default_TypeErrorError,
    RequestFailure() => _defaultRequestFailureL10n(context, error),
    MessagingSocketException() => _defaultMessagingSocketExceptionL10n(context, error),
    _ => error.toString(),
  };
}

String _defaultRequestFailureL10n(BuildContext context, RequestFailure error) {
  if (error.statusCode == HttpStatus.unauthorized) {
    return context.l10n.default_UnauthorizedRequestFailureError;
  } else {
    return context.l10n.default_RequestFailureError;
  }
}

String _defaultMessagingSocketExceptionL10n(BuildContext context, MessagingSocketException error) {
  final l10n = context.l10n;
  final code = error.code;

  switch (code) {
    case 'unauthorized':
      return l10n.default_UnauthorizedMessagingSocketException;
    case 'forbidden':
      return l10n.default_ForbiddenMessagingSocketException;
    case 'internal_error':
      return l10n.default_InternalErrorMessagingSocketException;
    case 'chat_not_found':
      return l10n.default_ChatNotFoundMessagingSocketException;
    case 'invalid_chat_type':
      return l10n.default_InvalidChatTypeMessagingSocketException;
    case 'user_already_in_chat':
      return l10n.default_UserAlreadyInChatMessagingSocketException;
    case 'chat_member_not_found':
      return l10n.default_ChatMemberNotFoundMessagingSocketException;
    case 'self_removal_forbidden':
      return l10n.default_SelfRemovalForbiddenMessagingSocketException;
    case 'self_authority_assignment_forbidden':
      return l10n.default_SelfAuthorityAssignmentForbiddenMessagingSocketException;
    case 'sms_conversation_not_found':
      return l10n.default_SmsConversationNotFoundMessagingSocketException;
    default:
      return l10n.default_MessagingSocketException;
  }
}
