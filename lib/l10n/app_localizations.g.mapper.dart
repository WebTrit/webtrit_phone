// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// L10nMapperGenerator
// **************************************************************************

import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:flutter/widgets.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get _localizations => AppLocalizations.of(this)!;
  AppLocalizations get l10n => _localizations;
  Locale get locale => Localizations.localeOf(this);
  String? parseL10n(String translationKey, {List<Object>? arguments}) {
    const mapper = AppLocalizationsMapper();
    final object = mapper.toLocalizationMap(this)[translationKey];
    if (object is String || object == null) return object;
    assert(arguments != null, 'Arguments should not be null!');
    assert(arguments!.isNotEmpty, 'Arguments should not be empty!');
    return Function.apply(object, arguments);
  }
}

class AppLocalizationsMapper {
  const AppLocalizationsMapper();
  Map<String, dynamic> toLocalizationMap(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return {
      'localeName': localizations.localeName,
      'alertDialogActions_no': localizations.alertDialogActions_no,
      'alertDialogActions_ok': localizations.alertDialogActions_ok,
      'alertDialogActions_yes': localizations.alertDialogActions_yes,
      'autoprovision_errorSnackBar_invalidToken':
          localizations.autoprovision_errorSnackBar_invalidToken,
      'autoprovision_ReloginDialog_confirm':
          localizations.autoprovision_ReloginDialog_confirm,
      'autoprovision_ReloginDialog_decline':
          localizations.autoprovision_ReloginDialog_decline,
      'autoprovision_ReloginDialog_text':
          localizations.autoprovision_ReloginDialog_text,
      'autoprovision_ReloginDialog_title':
          localizations.autoprovision_ReloginDialog_title,
      'autoprovision_successSnackBar_used':
          localizations.autoprovision_successSnackBar_used,
      'call_CallActionsTooltip_accept':
          localizations.call_CallActionsTooltip_accept,
      'call_CallActionsTooltip_accept_inviteToAttendedTransfer':
          localizations.call_CallActionsTooltip_accept_inviteToAttendedTransfer,
      'call_CallActionsTooltip_attended_transfer':
          localizations.call_CallActionsTooltip_attended_transfer,
      'call_CallActionsTooltip_decline_inviteToAttendedTransfer': localizations
          .call_CallActionsTooltip_decline_inviteToAttendedTransfer,
      'call_CallActionsTooltip_disableCamera':
          localizations.call_CallActionsTooltip_disableCamera,
      'call_CallActionsTooltip_disableSpeaker':
          localizations.call_CallActionsTooltip_disableSpeaker,
      'call_CallActionsTooltip_enableCamera':
          localizations.call_CallActionsTooltip_enableCamera,
      'call_CallActionsTooltip_enableSpeaker':
          localizations.call_CallActionsTooltip_enableSpeaker,
      'call_CallActionsTooltip_hangup':
          localizations.call_CallActionsTooltip_hangup,
      'call_CallActionsTooltip_hangupAndAccept':
          localizations.call_CallActionsTooltip_hangupAndAccept,
      'call_CallActionsTooltip_hideKeypad':
          localizations.call_CallActionsTooltip_hideKeypad,
      'call_CallActionsTooltip_hold':
          localizations.call_CallActionsTooltip_hold,
      'call_CallActionsTooltip_holdAndAccept':
          localizations.call_CallActionsTooltip_holdAndAccept,
      'call_CallActionsTooltip_mute':
          localizations.call_CallActionsTooltip_mute,
      'call_CallActionsTooltip_showKeypad':
          localizations.call_CallActionsTooltip_showKeypad,
      'call_CallActionsTooltip_swap':
          localizations.call_CallActionsTooltip_swap,
      'call_CallActionsTooltip_transfer':
          localizations.call_CallActionsTooltip_transfer,
      'call_CallActionsTooltip_transfer_choose':
          localizations.call_CallActionsTooltip_transfer_choose,
      'call_CallActionsTooltip_unattended_transfer':
          localizations.call_CallActionsTooltip_unattended_transfer,
      'call_CallActionsTooltip_unhold':
          localizations.call_CallActionsTooltip_unhold,
      'call_CallActionsTooltip_unmute':
          localizations.call_CallActionsTooltip_unmute,
      'call_description_held': localizations.call_description_held,
      'call_description_incoming': localizations.call_description_incoming,
      'call_description_inviteToAttendedTransfer':
          localizations.call_description_inviteToAttendedTransfer,
      'call_description_outgoing': localizations.call_description_outgoing,
      'call_description_requestToAttendedTransfer':
          localizations.call_description_requestToAttendedTransfer,
      'call_description_transferProcessing':
          localizations.call_description_transferProcessing,
      'call_description_transfer_requested':
          localizations.call_description_transfer_requested,
      'call_FailureAcknowledgeDialog_title':
          localizations.call_FailureAcknowledgeDialog_title,
      'callStatus_appUnregistered': localizations.callStatus_appUnregistered,
      'callStatus_connectError': localizations.callStatus_connectError,
      'callStatus_connectIssue': localizations.callStatus_connectIssue,
      'callStatus_connectivityNone': localizations.callStatus_connectivityNone,
      'callStatus_inProgress': localizations.callStatus_inProgress,
      'callStatus_ready': localizations.callStatus_ready,
      'callProcessingStatus_disconnecting':
          localizations.callProcessingStatus_disconnecting,
      'call_ThumbnailAvatar_currentlyNoActiveCall':
          localizations.call_ThumbnailAvatar_currentlyNoActiveCall,
      'connectToYourOwnVoIPSystem_Button_Action':
          localizations.connectToYourOwnVoIPSystem_Button_Action,
      'contacts_ExternalTabButton_refresh':
          localizations.contacts_ExternalTabButton_refresh,
      'contacts_ExternalTabText_empty':
          localizations.contacts_ExternalTabText_empty,
      'contacts_ExternalTabText_emptyOnSearching':
          localizations.contacts_ExternalTabText_emptyOnSearching,
      'contacts_ExternalTabText_failure':
          localizations.contacts_ExternalTabText_failure,
      'contacts_LocalTabButton_openAppSettings':
          localizations.contacts_LocalTabButton_openAppSettings,
      'contacts_LocalTabButton_refresh':
          localizations.contacts_LocalTabButton_refresh,
      'contacts_LocalTabText_empty': localizations.contacts_LocalTabText_empty,
      'contacts_LocalTabText_emptyOnSearching':
          localizations.contacts_LocalTabText_emptyOnSearching,
      'contacts_LocalTabText_failure':
          localizations.contacts_LocalTabText_failure,
      'contacts_LocalTabText_permissionFailure':
          localizations.contacts_LocalTabText_permissionFailure,
      'contactsSourceExternal': localizations.contactsSourceExternal,
      'contactsSourceLocal': localizations.contactsSourceLocal,
      'contacts_Text_blingTransferInitiated':
          localizations.contacts_Text_blingTransferInitiated,
      'copyToClipboard_floatingSnackBar':
          localizations.copyToClipboard_floatingSnackBar,
      'copyToClipboard_popupMenuItem':
          localizations.copyToClipboard_popupMenuItem,
      'default_ClientExceptionError':
          localizations.default_ClientExceptionError,
      'default_ErrorDetails': localizations.default_ErrorDetails,
      'default_ErrorMessage': localizations.default_ErrorMessage,
      'default_ErrorPath': localizations.default_ErrorPath,
      'default_ErrorTransactionId': localizations.default_ErrorTransactionId,
      'default_FormatExceptionError':
          localizations.default_FormatExceptionError,
      'default_RequestFailureError': localizations.default_RequestFailureError,
      'default_SocketExceptionError':
          localizations.default_SocketExceptionError,
      'default_TimeoutExceptionError':
          localizations.default_TimeoutExceptionError,
      'default_TlsExceptionError': localizations.default_TlsExceptionError,
      'default_TypeErrorError': localizations.default_TypeErrorError,
      'default_UnauthorizedRequestFailureError':
          localizations.default_UnauthorizedRequestFailureError,
      'favorites_BodyCenter_empty': localizations.favorites_BodyCenter_empty,
      'favorites_DeleteConfirmDialog_content':
          localizations.favorites_DeleteConfirmDialog_content,
      'favorites_DeleteConfirmDialog_title':
          localizations.favorites_DeleteConfirmDialog_title,
      'favorites_Text_blingTransferInitiated':
          localizations.favorites_Text_blingTransferInitiated,
      'inviteFriends_Dialog_close': localizations.inviteFriends_Dialog_close,
      'inviteFriends_Dialog_invite': localizations.inviteFriends_Dialog_invite,
      'inviteFriends_Dialog_title': localizations.inviteFriends_Dialog_title,
      'locale_default': localizations.locale_default,
      'locale_en': localizations.locale_en,
      'locale_it': localizations.locale_it,
      'locale_uk': localizations.locale_uk,
      'login_Button_coreUrlAssignProceed':
          localizations.login_Button_coreUrlAssignProceed,
      'login_Button_otpSigninRequestProceed':
          localizations.login_Button_otpSigninRequestProceed,
      'login_Button_otpSigninVerifyProceed':
          localizations.login_Button_otpSigninVerifyProceed,
      'login_Button_otpSigninVerifyRepeat':
          localizations.login_Button_otpSigninVerifyRepeat,
      'login_Button_passwordSigninProceed':
          localizations.login_Button_passwordSigninProceed,
      'login_Button_signIn': localizations.login_Button_signIn,
      'login_Button_signupRequestProceed':
          localizations.login_Button_signupRequestProceed,
      'login_Button_signUpToDemoInstance':
          localizations.login_Button_signUpToDemoInstance,
      'login_Button_signupVerifyProceed':
          localizations.login_Button_signupVerifyProceed,
      'login_Button_signupVerifyRepeat':
          localizations.login_Button_signupVerifyRepeat,
      'login_ButtonTooltip_signInToYourInstance':
          localizations.login_ButtonTooltip_signInToYourInstance,
      'login_requestCredentials_button':
          localizations.login_requestCredentials_button,
      'login_requestCredentials_DialogContent':
          localizations.login_requestCredentials_DialogContent,
      'login_requestCredentials_DialogTitle':
          localizations.login_requestCredentials_DialogTitle,
      'login_requestCredentials_title':
          localizations.login_requestCredentials_title,
      'login_RequestFailureEmptyEmailError':
          localizations.login_RequestFailureEmptyEmailError,
      'login_RequestFailureIdentifierIsNotValid':
          localizations.login_RequestFailureIdentifierIsNotValid,
      'login_RequestFailureIncorrectOtpCodeError':
          localizations.login_RequestFailureIncorrectOtpCodeError,
      'login_RequestFailureOtpAlreadyVerifiedError':
          localizations.login_RequestFailureOtpAlreadyVerifiedError,
      'login_RequestFailureOtpExpiredError':
          localizations.login_RequestFailureOtpExpiredError,
      'login_RequestFailureOtpNotFoundError':
          localizations.login_RequestFailureOtpNotFoundError,
      'login_RequestFailureOtpVerificationAttemptsExceededError': localizations
          .login_RequestFailureOtpVerificationAttemptsExceededError,
      'login_RequestFailureParametersApplyIssueError':
          localizations.login_RequestFailureParametersApplyIssueError,
      'login_RequestFailurePhoneNotFoundError':
          localizations.login_RequestFailurePhoneNotFoundError,
      'login_RequestFailureUnconfiguredBundleIdError':
          localizations.login_RequestFailureUnconfiguredBundleIdError,
      'login_SupportedLoginTypeMissedExceptionError':
          localizations.login_SupportedLoginTypeMissedExceptionError,
      'login_Text_coreUrlAssignPreDescription':
          localizations.login_Text_coreUrlAssignPreDescription,
      'login_TextFieldLabelText_coreUrlAssign':
          localizations.login_TextFieldLabelText_coreUrlAssign,
      'login_TextFieldLabelText_otpSigninCode':
          localizations.login_TextFieldLabelText_otpSigninCode,
      'login_TextFieldLabelText_otpSigninUserRef':
          localizations.login_TextFieldLabelText_otpSigninUserRef,
      'login_TextFieldLabelText_passwordSigninPassword':
          localizations.login_TextFieldLabelText_passwordSigninPassword,
      'login_TextFieldLabelText_passwordSigninUserRef':
          localizations.login_TextFieldLabelText_passwordSigninUserRef,
      'login_TextFieldLabelText_signupCode':
          localizations.login_TextFieldLabelText_signupCode,
      'login_TextFieldLabelText_signupEmail':
          localizations.login_TextFieldLabelText_signupEmail,
      'login_Text_otpSigninRequestPostDescription':
          localizations.login_Text_otpSigninRequestPostDescription,
      'login_Text_otpSigninRequestPreDescription':
          localizations.login_Text_otpSigninRequestPreDescription,
      'login_Text_otpSigninVerifyPostDescriptionGeneral':
          localizations.login_Text_otpSigninVerifyPostDescriptionGeneral,
      'login_Text_passwordSigninPostDescription':
          localizations.login_Text_passwordSigninPostDescription,
      'login_Text_passwordSigninPreDescription':
          localizations.login_Text_passwordSigninPreDescription,
      'login_Text_signupRequestPostDescription':
          localizations.login_Text_signupRequestPostDescription,
      'login_Text_signupRequestPostDescriptionDemo':
          localizations.login_Text_signupRequestPostDescriptionDemo,
      'login_Text_signupRequestPreDescription':
          localizations.login_Text_signupRequestPreDescription,
      'login_Text_signupRequestPreDescriptionDemo':
          localizations.login_Text_signupRequestPreDescriptionDemo,
      'login_Text_signupVerifyPostDescriptionGeneral':
          localizations.login_Text_signupVerifyPostDescriptionGeneral,
      'loginType_otpSignin': localizations.loginType_otpSignin,
      'loginType_passwordSignin': localizations.loginType_passwordSignin,
      'loginType_signup': localizations.loginType_signup,
      'login_validationCoreUrlError':
          localizations.login_validationCoreUrlError,
      'login_validationEmailError': localizations.login_validationEmailError,
      'login_validationPhoneError': localizations.login_validationPhoneError,
      'login_validationUserRefError':
          localizations.login_validationUserRefError,
      'logRecordsConsole_AppBarTitle':
          localizations.logRecordsConsole_AppBarTitle,
      'logRecordsConsole_Button_failureRefresh':
          localizations.logRecordsConsole_Button_failureRefresh,
      'logRecordsConsole_Text_failure':
          localizations.logRecordsConsole_Text_failure,
      'main_BottomNavigationBarItemLabel_contacts':
          localizations.main_BottomNavigationBarItemLabel_contacts,
      'main_BottomNavigationBarItemLabel_favorites':
          localizations.main_BottomNavigationBarItemLabel_favorites,
      'main_BottomNavigationBarItemLabel_keypad':
          localizations.main_BottomNavigationBarItemLabel_keypad,
      'main_BottomNavigationBarItemLabel_chats':
          localizations.main_BottomNavigationBarItemLabel_chats,
      'main_BottomNavigationBarItemLabel_recents':
          localizations.main_BottomNavigationBarItemLabel_recents,
      'main_CompatibilityIssueDialogActions_logout':
          localizations.main_CompatibilityIssueDialogActions_logout,
      'main_CompatibilityIssueDialogActions_update':
          localizations.main_CompatibilityIssueDialogActions_update,
      'main_CompatibilityIssueDialogActions_verify':
          localizations.main_CompatibilityIssueDialogActions_verify,
      'main_CompatibilityIssueDialog_title':
          localizations.main_CompatibilityIssueDialog_title,
      'notifications_errorSnackBarAction_callUserMedia':
          localizations.notifications_errorSnackBarAction_callUserMedia,
      'notifications_errorSnackBar_appOffline':
          localizations.notifications_errorSnackBar_appOffline,
      'notifications_errorSnackBar_appOnline':
          localizations.notifications_errorSnackBar_appOnline,
      'notifications_errorSnackBar_appUnregistered':
          localizations.notifications_errorSnackBar_appUnregistered,
      'notifications_errorSnackBar_sipServiceUnavailable':
          localizations.notifications_errorSnackBar_sipServiceUnavailable,
      'notifications_errorSnackBar_callConnect':
          localizations.notifications_errorSnackBar_callConnect,
      'notifications_errorSnackBar_callSignalingClientNotConnect': localizations
          .notifications_errorSnackBar_callSignalingClientNotConnect,
      'notifications_errorSnackBar_callSignalingClientSessionMissed':
          localizations
              .notifications_errorSnackBar_callSignalingClientSessionMissed,
      'notifications_errorSnackBar_callUndefinedLine':
          localizations.notifications_errorSnackBar_callUndefinedLine,
      'notifications_errorSnackBar_callUserMedia':
          localizations.notifications_errorSnackBar_callUserMedia,
      'notifications_errorSnackBar_activeLineBlindTransferWarning':
          localizations
              .notifications_errorSnackBar_activeLineBlindTransferWarning,
      'notImplemented': localizations.notImplemented,
      'permission_Button_request': localizations.permission_Button_request,
      'permission_manufacturer_Button_gotIt':
          localizations.permission_manufacturer_Button_gotIt,
      'permission_manufacturer_Button_toSettings':
          localizations.permission_manufacturer_Button_toSettings,
      'permission_manufacturer_Text_heading':
          localizations.permission_manufacturer_Text_heading,
      'permission_manufacturer_Text_trailing':
          localizations.permission_manufacturer_Text_trailing,
      'permission_manufacturer_Text_xiaomi_tip1':
          localizations.permission_manufacturer_Text_xiaomi_tip1,
      'permission_manufacturer_Text_xiaomi_tip2':
          localizations.permission_manufacturer_Text_xiaomi_tip2,
      'permission_Text_description': localizations.permission_Text_description,
      'recents_DeleteConfirmDialog_content':
          localizations.recents_DeleteConfirmDialog_content,
      'recents_DeleteConfirmDialog_title':
          localizations.recents_DeleteConfirmDialog_title,
      'recents_errorSnackBar_loadFailure':
          localizations.recents_errorSnackBar_loadFailure,
      'recents_Text_blingTransferInitiated':
          localizations.recents_Text_blingTransferInitiated,
      'recentsVisibilityFilter_all': localizations.recentsVisibilityFilter_all,
      'recentsVisibilityFilter_all_preposit':
          localizations.recentsVisibilityFilter_all_preposit,
      'recentsVisibilityFilter_incoming':
          localizations.recentsVisibilityFilter_incoming,
      'recentsVisibilityFilter_incoming_preposit':
          localizations.recentsVisibilityFilter_incoming_preposit,
      'recentsVisibilityFilter_missed':
          localizations.recentsVisibilityFilter_missed,
      'recentsVisibilityFilter_missed_preposit':
          localizations.recentsVisibilityFilter_missed_preposit,
      'recentsVisibilityFilter_outgoing':
          localizations.recentsVisibilityFilter_outgoing,
      'recentsVisibilityFilter_outgoing_preposit':
          localizations.recentsVisibilityFilter_outgoing_preposit,
      'request_Id': localizations.request_Id,
      'request_StatusCode': localizations.request_StatusCode,
      'settings_AboutText_AppVersion':
          localizations.settings_AboutText_AppVersion,
      'settings_AboutText_CoreVersionUndefined':
          localizations.settings_AboutText_CoreVersionUndefined,
      'settings_AboutText_StoreVersion':
          localizations.settings_AboutText_StoreVersion,
      'settings_AccountDeleteConfirmDialog_content':
          localizations.settings_AccountDeleteConfirmDialog_content,
      'settings_AccountDeleteConfirmDialog_title':
          localizations.settings_AccountDeleteConfirmDialog_title,
      'settings_AppBarTitle_myAccount':
          localizations.settings_AppBarTitle_myAccount,
      'settings_ForceLogoutConfirmDialog_content':
          localizations.settings_ForceLogoutConfirmDialog_content,
      'settings_ForceLogoutConfirmDialog_title':
          localizations.settings_ForceLogoutConfirmDialog_title,
      'settings_ListViewTileTitle_about':
          localizations.settings_ListViewTileTitle_about,
      'settings_ListViewTileTitle_accountDelete':
          localizations.settings_ListViewTileTitle_accountDelete,
      'settings_ListViewTileTitle_help':
          localizations.settings_ListViewTileTitle_help,
      'settings_ListViewTileTitle_language':
          localizations.settings_ListViewTileTitle_language,
      'settings_ListViewTileTitle_logout':
          localizations.settings_ListViewTileTitle_logout,
      'settings_ListViewTileTitle_logRecordsConsole':
          localizations.settings_ListViewTileTitle_logRecordsConsole,
      'settings_ListViewTileTitle_network':
          localizations.settings_ListViewTileTitle_network,
      'settings_ListViewTileTitle_registered':
          localizations.settings_ListViewTileTitle_registered,
      'settings_ListViewTileTitle_settings':
          localizations.settings_ListViewTileTitle_settings,
      'settings_ListViewTileTitle_termsConditions':
          localizations.settings_ListViewTileTitle_termsConditions,
      'settings_ListViewTileTitle_themeMode':
          localizations.settings_ListViewTileTitle_themeMode,
      'settings_ListViewTileTitle_toolbox':
          localizations.settings_ListViewTileTitle_toolbox,
      'settings_LogoutConfirmDialog_content':
          localizations.settings_LogoutConfirmDialog_content,
      'settings_LogoutConfirmDialog_title':
          localizations.settings_LogoutConfirmDialog_title,
      'themeMode_dark': localizations.themeMode_dark,
      'themeMode_light': localizations.themeMode_light,
      'themeMode_system': localizations.themeMode_system,
      'undefine_DeeplinkConfigurationInvalid_text':
          localizations.undefine_DeeplinkConfigurationInvalid_text,
      'underDevelopment': localizations.underDevelopment,
      'user_agreement_agrement_link':
          localizations.user_agreement_agrement_link,
      'user_agreement_button_text': localizations.user_agreement_button_text,
      'validationBlankError': localizations.validationBlankError,
      'webRegistration_ErrorAcknowledgeDialogActions_demo':
          localizations.webRegistration_ErrorAcknowledgeDialogActions_demo,
      'webRegistration_ErrorAcknowledgeDialogActions_retry':
          localizations.webRegistration_ErrorAcknowledgeDialogActions_retry,
      'webRegistration_ErrorAcknowledgeDialogActions_skip':
          localizations.webRegistration_ErrorAcknowledgeDialogActions_skip,
      'webRegistration_ErrorAcknowledgeDialog_title':
          localizations.webRegistration_ErrorAcknowledgeDialog_title,
      'messaging_Conversation_failure':
          localizations.messaging_Conversation_failure,
      'messaging_ActionBtn_retry': localizations.messaging_ActionBtn_retry,
      'messaging_MessageView_textcopy':
          localizations.messaging_MessageView_textcopy,
      'messaging_MessageView_reply': localizations.messaging_MessageView_reply,
      'messaging_MessageView_forward':
          localizations.messaging_MessageView_forward,
      'messaging_MessageView_edit': localizations.messaging_MessageView_edit,
      'messaging_MessageView_delete':
          localizations.messaging_MessageView_delete,
      'messaging_MessageView_forwarded':
          localizations.messaging_MessageView_forwarded,
      'messaging_MessageView_edited':
          localizations.messaging_MessageView_edited,
      'messaging_MessageView_deleted':
          localizations.messaging_MessageView_deleted,
      'messaging_SmsSendingStatus_waiting':
          localizations.messaging_SmsSendingStatus_waiting,
      'messaging_SmsSendingStatus_sent':
          localizations.messaging_SmsSendingStatus_sent,
      'messaging_SmsSendingStatus_failed':
          localizations.messaging_SmsSendingStatus_failed,
      'messaging_SmsSendingStatus_delivered':
          localizations.messaging_SmsSendingStatus_delivered,
      'messaging_ParticipantName_you':
          localizations.messaging_ParticipantName_you,
      'messaging_StateBar_initializing':
          localizations.messaging_StateBar_initializing,
      'messaging_StateBar_connecting':
          localizations.messaging_StateBar_connecting,
      'messaging_StateBar_error': localizations.messaging_StateBar_error,
      'messaging_ConversationsScreen_startDialog':
          localizations.messaging_ConversationsScreen_startDialog,
      'messaging_ConversationsScreen_empty':
          localizations.messaging_ConversationsScreen_empty,
      'messaging_ConversationsScreen_chatsSearch_hint':
          localizations.messaging_ConversationsScreen_chatsSearch_hint,
      'messaging_ConversationsScreen_smssSearch_hint':
          localizations.messaging_ConversationsScreen_smssSearch_hint,
      'messaging_ConversationsScreen_messages_title':
          localizations.messaging_ConversationsScreen_messages_title,
      'messaging_ConversationsScreen_smses_title':
          localizations.messaging_ConversationsScreen_smses_title,
      'messaging_ConversationsScreen_selectNumberSheet_title':
          localizations.messaging_ConversationsScreen_selectNumberSheet_title,
      'messaging_ConversationsScreen_noNumberAlert_title':
          localizations.messaging_ConversationsScreen_noNumberAlert_title,
      'messaging_ConversationsScreen_noNumberAlert_text':
          localizations.messaging_ConversationsScreen_noNumberAlert_text,
      'messaging_Conversations_tile_empty':
          localizations.messaging_Conversations_tile_empty,
      'messaging_Conversations_tile_you':
          localizations.messaging_Conversations_tile_you,
      'messaging_MessageField_hint': localizations.messaging_MessageField_hint,
      'messaging_ConversationScreen_titlePrefix':
          localizations.messaging_ConversationScreen_titlePrefix,
      'messaging_DialogInfo_deleteAsk':
          localizations.messaging_DialogInfo_deleteAsk,
      'messaging_DialogInfo_title': localizations.messaging_DialogInfo_title,
      'messaging_DialogInfo_deleteBtn':
          localizations.messaging_DialogInfo_deleteBtn,
      'messaging_ConversationBuilders_createGroup':
          localizations.messaging_ConversationBuilders_createGroup,
      'messaging_ConversationBuilders_title_new':
          localizations.messaging_ConversationBuilders_title_new,
      'messaging_ConversationBuilders_cancel':
          localizations.messaging_ConversationBuilders_cancel,
      'messaging_ConversationBuilders_back':
          localizations.messaging_ConversationBuilders_back,
      'messaging_ConversationBuilders_create':
          localizations.messaging_ConversationBuilders_create,
      'messaging_ConversationBuilders_externalContacts_heading':
          localizations.messaging_ConversationBuilders_externalContacts_heading,
      'messaging_ConversationBuilders_localContacts_heading':
          localizations.messaging_ConversationBuilders_localContacts_heading,
      'messaging_ConversationBuilders_contactSearch_hint':
          localizations.messaging_ConversationBuilders_contactSearch_hint,
      'messaging_ConversationBuilders_contactOrNumberSearch_hint': localizations
          .messaging_ConversationBuilders_contactOrNumberSearch_hint,
      'messaging_ConversationBuilders_numberFormatExample':
          localizations.messaging_ConversationBuilders_numberFormatExample,
      'messaging_ConversationBuilders_numberSearch_errorHint':
          localizations.messaging_ConversationBuilders_numberSearch_errorHint,
      'messaging_ConversationBuilders_numberSearch_errorError':
          localizations.messaging_ConversationBuilders_numberSearch_errorError,
      'messaging_ConversationBuilders_invite_heading':
          localizations.messaging_ConversationBuilders_invite_heading,
      'messaging_ConversationBuilders_next_action':
          localizations.messaging_ConversationBuilders_next_action,
      'messaging_ConversationBuilders_back_action':
          localizations.messaging_ConversationBuilders_back_action,
      'messaging_ConversationBuilders_noContacts':
          localizations.messaging_ConversationBuilders_noContacts,
      'messaging_ConversationBuilders_invalidNumber_title':
          localizations.messaging_ConversationBuilders_invalidNumber_title,
      'messaging_ConversationBuilders_invalidNumber_message1':
          localizations.messaging_ConversationBuilders_invalidNumber_message1,
      'messaging_ConversationBuilders_invalidNumber_message2':
          localizations.messaging_ConversationBuilders_invalidNumber_message2,
      'messaging_ConversationBuilders_invalidNumber_ok':
          localizations.messaging_ConversationBuilders_invalidNumber_ok,
      'messaging_GroupScreen_titlePrefix':
          localizations.messaging_GroupScreen_titlePrefix,
      'messaging_ChooseContact_title':
          localizations.messaging_ChooseContact_title,
      'messaging_ChooseContact_empty':
          localizations.messaging_ChooseContact_empty,
      'messaging_ChooseContact_cancel':
          localizations.messaging_ChooseContact_cancel,
      'messaging_ConfirmDialog_ask': localizations.messaging_ConfirmDialog_ask,
      'messaging_ConfirmDialog_confirm':
          localizations.messaging_ConfirmDialog_confirm,
      'messaging_ConfirmDialog_cancel':
          localizations.messaging_ConfirmDialog_cancel,
      'messaging_GroupAuthorities_noauthorities':
          localizations.messaging_GroupAuthorities_noauthorities,
      'messaging_GroupAuthorities_moderator':
          localizations.messaging_GroupAuthorities_moderator,
      'messaging_GroupAuthorities_owner':
          localizations.messaging_GroupAuthorities_owner,
      'messaging_GroupInfo_title': localizations.messaging_GroupInfo_title,
      'messaging_GroupInfo_leaveAsk':
          localizations.messaging_GroupInfo_leaveAsk,
      'messaging_GroupInfo_leaveAndDeleteAsk':
          localizations.messaging_GroupInfo_leaveAndDeleteAsk,
      'messaging_GroupInfo_removeUserAsk':
          localizations.messaging_GroupInfo_removeUserAsk,
      'messaging_GroupInfo_makeModeratorAsk':
          localizations.messaging_GroupInfo_makeModeratorAsk,
      'messaging_GroupInfo_removeModeratorAsk':
          localizations.messaging_GroupInfo_removeModeratorAsk,
      'messaging_GroupInfo_titlePrefix':
          localizations.messaging_GroupInfo_titlePrefix,
      'messaging_GroupInfo_groupMembersHeadline':
          localizations.messaging_GroupInfo_groupMembersHeadline,
      'messaging_GroupInfo_addUserBtnText':
          localizations.messaging_GroupInfo_addUserBtnText,
      'messaging_GroupInfo_leaveBtnText':
          localizations.messaging_GroupInfo_leaveBtnText,
      'messaging_GroupInfo_deleteLeaveBtnText':
          localizations.messaging_GroupInfo_deleteLeaveBtnText,
      'messaging_GroupInfo_makeModeratorBtnText':
          localizations.messaging_GroupInfo_makeModeratorBtnText,
      'messaging_GroupInfo_unmakeModeratorBtnText':
          localizations.messaging_GroupInfo_unmakeModeratorBtnText,
      'messaging_GroupInfo_removeUserBtnText':
          localizations.messaging_GroupInfo_removeUserBtnText,
      'messaging_GroupNameDialog_title':
          localizations.messaging_GroupNameDialog_title,
      'messaging_GroupNameDialog_fieldLabel':
          localizations.messaging_GroupNameDialog_fieldLabel,
      'messaging_GroupNameDialog_fieldHint':
          localizations.messaging_GroupNameDialog_fieldHint,
      'messaging_GroupNameDialog_fieldValidation_empty':
          localizations.messaging_GroupNameDialog_fieldValidation_empty,
      'messaging_GroupNameDialog_fieldValidation_short':
          localizations.messaging_GroupNameDialog_fieldValidation_short,
      'messaging_GroupNameDialog_saveBtnText':
          localizations.messaging_GroupNameDialog_saveBtnText,
      'messaging_GroupNameDialog_cancelBtnText':
          localizations.messaging_GroupNameDialog_cancelBtnText,
      'messaging_ConversationBuilders_title_group':
          localizations.messaging_ConversationBuilders_title_group,
      'messaging_ConversationBuilders_groupNameHeadline':
          localizations.messaging_ConversationBuilders_groupNameHeadline,
      'messaging_ConversationBuilders_membersHeadline':
          localizations.messaging_ConversationBuilders_membersHeadline,
      'messaging_ConversationBuilders_addUserBtnText':
          localizations.messaging_ConversationBuilders_addUserBtnText,
      'messaging_ConversationBuilders_submitBtnText':
          localizations.messaging_ConversationBuilders_submitBtnText,
      'messaging_ConversationBuilders_nameFieldLabel':
          localizations.messaging_ConversationBuilders_nameFieldLabel,
      'messaging_ConversationBuilders_nameFieldEmpty':
          localizations.messaging_ConversationBuilders_nameFieldEmpty,
      'messaging_ConversationBuilders_nameFieldShort':
          localizations.messaging_ConversationBuilders_nameFieldShort,
      'messaging_ConversationBuilders_connectionError':
          localizations.messaging_ConversationBuilders_connectionError,
      'messaging_ConversationBuilders_submitError':
          localizations.messaging_ConversationBuilders_submitError,
      'messaging_MessageListView_typingTrail':
          localizations.messaging_MessageListView_typingTrail,
      'default_MessagingSocketException':
          localizations.default_MessagingSocketException,
      'default_UnauthorizedMessagingSocketException':
          localizations.default_UnauthorizedMessagingSocketException,
      'default_ForbiddenMessagingSocketException':
          localizations.default_ForbiddenMessagingSocketException,
      'default_InternalErrorMessagingSocketException':
          localizations.default_InternalErrorMessagingSocketException,
      'default_ChatNotFoundMessagingSocketException':
          localizations.default_ChatNotFoundMessagingSocketException,
      'default_InvalidChatTypeMessagingSocketException':
          localizations.default_InvalidChatTypeMessagingSocketException,
      'default_UserAlreadyInChatMessagingSocketException':
          localizations.default_UserAlreadyInChatMessagingSocketException,
      'default_ChatMemberNotFoundMessagingSocketException':
          localizations.default_ChatMemberNotFoundMessagingSocketException,
      'default_SelfRemovalForbiddenMessagingSocketException':
          localizations.default_SelfRemovalForbiddenMessagingSocketException,
      'default_SelfAuthorityAssignmentForbiddenMessagingSocketException':
          localizations
              .default_SelfAuthorityAssignmentForbiddenMessagingSocketException,
      'default_SmsConversationNotFoundMessagingSocketException':
          localizations.default_SmsConversationNotFoundMessagingSocketException,
      'account_selfCarePasswordExpired_message':
          localizations.account_selfCarePasswordExpired_message,
      'common_noInternetConnection_title':
          localizations.common_noInternetConnection_title,
      'common_noInternetConnection_message':
          localizations.common_noInternetConnection_message,
      'common_noInternetConnection_retryButton':
          localizations.common_noInternetConnection_retryButton,
      'common_problemWithLoadingPage':
          localizations.common_problemWithLoadingPage,
      'favorites_SnackBar_deleted': (name) =>
          localizations.favorites_SnackBar_deleted(name),
      'login_Button_otpSigninVerifyRepeatInterval': (seconds) =>
          localizations.login_Button_otpSigninVerifyRepeatInterval(seconds),
      'login_Button_signupVerifyRepeatInterval': (seconds) =>
          localizations.login_Button_signupVerifyRepeatInterval(seconds),
      'login_CoreVersionUnsupportedExceptionError': (actual,
              supportedConstraint) =>
          localizations.login_CoreVersionUnsupportedExceptionError(
              actual, supportedConstraint),
      'login_Text_coreUrlAssignPostDescription': (email) =>
          localizations.login_Text_coreUrlAssignPostDescription(email),
      'login_Text_otpSigninVerifyPostDescriptionFromEmail': (email) =>
          localizations
              .login_Text_otpSigninVerifyPostDescriptionFromEmail(email),
      'login_Text_otpSigninVerifyPreDescriptionUserRef': (userRef) =>
          localizations
              .login_Text_otpSigninVerifyPreDescriptionUserRef(userRef),
      'login_Text_otpVerifySentToEmailAssignedWithPhone': (phone) =>
          localizations.login_Text_otpVerifySentToEmailAssignedWithPhone(phone),
      'login_Text_signupVerifyPostDescriptionFromEmail': (email) =>
          localizations.login_Text_signupVerifyPostDescriptionFromEmail(email),
      'login_Text_signupVerifyPreDescriptionEmail': (email) =>
          localizations.login_Text_signupVerifyPreDescriptionEmail(email),
      'main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError':
          (actual, supportedConstraint) => localizations
              .main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(
                  actual, supportedConstraint),
      'recents_BodyCenter_empty': (filter) =>
          localizations.recents_BodyCenter_empty(filter),
      'recents_snackBar_deleted': (name) =>
          localizations.recents_snackBar_deleted(name),
      'recentTimeAfterMidnight': (time) =>
          localizations.recentTimeAfterMidnight(time),
      'recentTimeBeforeMidnight': (time) =>
          localizations.recentTimeBeforeMidnight(time),
      'user_agreement_checkbox_text': (url) =>
          localizations.user_agreement_checkbox_text(url),
      'user_agreement_description': (appName) =>
          localizations.user_agreement_description(appName),
    };
  }
}
