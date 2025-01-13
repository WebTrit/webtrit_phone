import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/models.dart';

import 'l10n.dart';

String defaultErrorL10n(BuildContext context, Object error) {
  return switch (error) {
    FormatException() => context.l10n.default_FormatExceptionError,
    TlsException() => context.l10n.default_TlsExceptionError,
    SocketException() => _defaultSocketExceptionL10n(context, error),
    TimeoutException() => context.l10n.default_TimeoutExceptionError,
    ClientException() => context.l10n.default_ClientExceptionError,
    TypeError() => context.l10n.default_TypeErrorError,
    SignalingHangupFailure() => _defaultSignalingHangupFailureL10n(context, error),
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

String _defaultSignalingHangupFailureL10n(BuildContext context, SignalingHangupFailure failure) {
  return failure.code.l10n(context);
}

String _defaultSocketExceptionL10n(BuildContext context, SocketException exception) {
  return exception.titleL10n(context);
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
    case 'user_not_in_chat':
      return l10n.default_ChatMemberNotFoundMessagingSocketException;
    case 'self_removal_forbidden':
      return l10n.default_SelfRemovalForbiddenMessagingSocketException;
    case 'cannot_remove_owner':
      return l10n.default_CannotRemoveOwnerMessagingSocketException;
    case 'self_authority_assignment_forbidden':
      return l10n.default_SelfAuthorityAssignmentForbiddenMessagingSocketException;
    case 'sms_conversation_not_found':
      return l10n.default_SmsConversationNotFoundMessagingSocketException;
    case 'timeout':
      return l10n.default_TimeoutMessagingSocketException;
    case 'join crashed':
      return l10n.default_JoinCrashedMessagingSocketException;
    default:
      return l10n.default_MessagingSocketException;
  }
}
