// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// L10nMapperGenerator
// **************************************************************************

import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:flutter/widgets.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get _localizations => AppLocalizations.of(this)!;
  AppLocalizations get l10n => _localizations;
  Locale get locale => Localizations.localeOf(this);
  String? parseL10n(String translationKey, {List<Object>? arguments}) {
    final localizations = AppLocalizations.of(this)!;
    return localizations.parseL10n(translationKey, arguments: arguments);
  }
}

extension AppLocalizationsExtension on AppLocalizations {
  Object? lookupKey(String key, [List<Object>? args]) {
    return switch (key) {
      'localeName' => localeName,
      'account_selfCarePasswordExpired_message' =>
        account_selfCarePasswordExpired_message,
      'alertDialogActions_no' => alertDialogActions_no,
      'alertDialogActions_ok' => alertDialogActions_ok,
      'alertDialogActions_yes' => alertDialogActions_yes,
      'autoprovision_errorSnackBar_invalidToken' =>
        autoprovision_errorSnackBar_invalidToken,
      'autoprovision_ReloginDialog_confirm' =>
        autoprovision_ReloginDialog_confirm,
      'autoprovision_ReloginDialog_decline' =>
        autoprovision_ReloginDialog_decline,
      'autoprovision_ReloginDialog_text' => autoprovision_ReloginDialog_text,
      'autoprovision_ReloginDialog_title' => autoprovision_ReloginDialog_title,
      'autoprovision_successSnackBar_used' =>
        autoprovision_successSnackBar_used,
      'call_CallActionsTooltip_accept' => call_CallActionsTooltip_accept,
      'call_CallActionsTooltip_accept_inviteToAttendedTransfer' =>
        call_CallActionsTooltip_accept_inviteToAttendedTransfer,
      'call_CallActionsTooltip_attended_transfer' =>
        call_CallActionsTooltip_attended_transfer,
      'call_CallActionsTooltip_changeAudioDevice' =>
        call_CallActionsTooltip_changeAudioDevice,
      'call_CallActionsTooltip_decline_inviteToAttendedTransfer' =>
        call_CallActionsTooltip_decline_inviteToAttendedTransfer,
      'call_CallActionsTooltip_device_bluetooth' =>
        call_CallActionsTooltip_device_bluetooth,
      'call_CallActionsTooltip_device_earpiece' =>
        call_CallActionsTooltip_device_earpiece,
      'call_CallActionsTooltip_device_speaker' =>
        call_CallActionsTooltip_device_speaker,
      'call_CallActionsTooltip_device_streaming' =>
        call_CallActionsTooltip_device_streaming,
      'call_CallActionsTooltip_device_unknown' =>
        call_CallActionsTooltip_device_unknown,
      'call_CallActionsTooltip_device_wiredHeadset' =>
        call_CallActionsTooltip_device_wiredHeadset,
      'call_CallActionsTooltip_disableCamera' =>
        call_CallActionsTooltip_disableCamera,
      'call_CallActionsTooltip_disableSpeaker' =>
        call_CallActionsTooltip_disableSpeaker,
      'call_CallActionsTooltip_enableCamera' =>
        call_CallActionsTooltip_enableCamera,
      'call_CallActionsTooltip_enableSpeaker' =>
        call_CallActionsTooltip_enableSpeaker,
      'call_CallActionsTooltip_hangup' => call_CallActionsTooltip_hangup,
      'call_CallActionsTooltip_hangupAndAccept' =>
        call_CallActionsTooltip_hangupAndAccept,
      'call_CallActionsTooltip_hideKeypad' =>
        call_CallActionsTooltip_hideKeypad,
      'call_CallActionsTooltip_hold' => call_CallActionsTooltip_hold,
      'call_CallActionsTooltip_holdAndAccept' =>
        call_CallActionsTooltip_holdAndAccept,
      'call_CallActionsTooltip_mute' => call_CallActionsTooltip_mute,
      'call_CallActionsTooltip_showKeypad' =>
        call_CallActionsTooltip_showKeypad,
      'call_CallActionsTooltip_swap' => call_CallActionsTooltip_swap,
      'call_CallActionsTooltip_transfer' => call_CallActionsTooltip_transfer,
      'call_CallActionsTooltip_transfer_choose' =>
        call_CallActionsTooltip_transfer_choose,
      'call_CallActionsTooltip_unattended_transfer' =>
        call_CallActionsTooltip_unattended_transfer,
      'call_CallActionsTooltip_unhold' => call_CallActionsTooltip_unhold,
      'call_CallActionsTooltip_unmute' => call_CallActionsTooltip_unmute,
      'call_description_held' => call_description_held,
      'call_description_incoming' => call_description_incoming,
      'call_description_inviteToAttendedTransfer' =>
        call_description_inviteToAttendedTransfer,
      'call_description_outgoing' => call_description_outgoing,
      'call_description_requestToAttendedTransfer' =>
        call_description_requestToAttendedTransfer,
      'call_description_transferProcessing' =>
        call_description_transferProcessing,
      'call_errorRegisteringSelfManagedPhoneAccount' =>
        call_errorRegisteringSelfManagedPhoneAccount,
      'call_FailureAcknowledgeDialog_title' =>
        call_FailureAcknowledgeDialog_title,
      'callProcessingStatus_answering' => callProcessingStatus_answering,
      'callProcessingStatus_disconnecting' =>
        callProcessingStatus_disconnecting,
      'callProcessingStatus_init_media' => callProcessingStatus_init_media,
      'callProcessingStatus_invite' => callProcessingStatus_invite,
      'callProcessingStatus_preparing' => callProcessingStatus_preparing,
      'callProcessingStatus_ringing' => callProcessingStatus_ringing,
      'callProcessingStatus_routing' => callProcessingStatus_routing,
      'callProcessingStatus_signaling_connecting' =>
        callProcessingStatus_signaling_connecting,
      'iceConnectionIssue_iceFail' => iceConnectionIssue_iceFail,
      'iceConnectionIssue_iceFailNoIcePath' =>
        iceConnectionIssue_iceFailNoIcePath,
      'iceConnectionIssue_iceFailNoIcePathViaVpn' =>
        iceConnectionIssue_iceFailNoIcePathViaVpn,
      'callNetworkQuality_yourAudioWeak' => callNetworkQuality_yourAudioWeak,
      'callNetworkQuality_yourVideoWeak' => callNetworkQuality_yourVideoWeak,
      'callNetworkQuality_theirAudioWeak' => callNetworkQuality_theirAudioWeak,
      'callNetworkQuality_theirVideoWeak' => callNetworkQuality_theirVideoWeak,
      'callPullBadge_dialogTitle' => callPullBadge_dialogTitle,
      'callPullBadge_pickupButtonTitle' => callPullBadge_pickupButtonTitle,
      'call_settings_additional_options' => call_settings_additional_options,
      'callStatus_appUnregistered' => callStatus_appUnregistered,
      'callStatus_connectError' => callStatus_connectError,
      'callStatus_connectIssue' => callStatus_connectIssue,
      'callStatus_connectivityNone' => callStatus_connectivityNone,
      'callStatus_inProgress' => callStatus_inProgress,
      'callStatus_ready' => callStatus_ready,
      'call_SystemErrorDialog_description' =>
        call_SystemErrorDialog_description,
      'call_SystemErrorDialog_title' => call_SystemErrorDialog_title,
      'call_ThumbnailAvatar_currentlyNoActiveCall' =>
        call_ThumbnailAvatar_currentlyNoActiveCall,
      'call_videoBackground_actionLabel_disableBlur' =>
        call_videoBackground_actionLabel_disableBlur,
      'call_videoBackground_actionLabel_enableBlur' =>
        call_videoBackground_actionLabel_enableBlur,
      'call_videoView_actionLabel_cover' => call_videoView_actionLabel_cover,
      'call_videoView_actionLabel_fit' => call_videoView_actionLabel_fit,
      'cdrs_noMissedCalls_message' => cdrs_noMissedCalls_message,
      'cdrs_noRecentCalls_message' => cdrs_noRecentCalls_message,
      'common_noInternetConnection_message' =>
        common_noInternetConnection_message,
      'common_noInternetConnection_retryButton' =>
        common_noInternetConnection_retryButton,
      'common_noInternetConnection_title' => common_noInternetConnection_title,
      'common_problemWithLoadingPage' => common_problemWithLoadingPage,
      'contacts_agreement_button_text' => contacts_agreement_button_text,
      'contacts_agreement_checkbox_text' => contacts_agreement_checkbox_text,
      'contacts_agreement_description' => contacts_agreement_description,
      'contacts_agreement_title' => contacts_agreement_title,
      'contacts_ExternalTabButton_refresh' =>
        contacts_ExternalTabButton_refresh,
      'contacts_ExternalTabText_empty' => contacts_ExternalTabText_empty,
      'contacts_ExternalTabText_emptyOnSearching' =>
        contacts_ExternalTabText_emptyOnSearching,
      'contacts_ExternalTabText_failure' => contacts_ExternalTabText_failure,
      'contacts_LocalTabButton_contactsAgreement' =>
        contacts_LocalTabButton_contactsAgreement,
      'contacts_LocalTabButton_openAppSettings' =>
        contacts_LocalTabButton_openAppSettings,
      'contacts_LocalTabButton_refresh' => contacts_LocalTabButton_refresh,
      'contacts_LocalTabText_contactsAgreementFailure' =>
        contacts_LocalTabText_contactsAgreementFailure,
      'contacts_LocalTabText_empty' => contacts_LocalTabText_empty,
      'contacts_LocalTabText_emptyOnSearching' =>
        contacts_LocalTabText_emptyOnSearching,
      'contacts_LocalTabText_failure' => contacts_LocalTabText_failure,
      'contacts_LocalTabText_permissionFailure' =>
        contacts_LocalTabText_permissionFailure,
      'contactsSourceExternal' => contactsSourceExternal,
      'contactsSourceLocal' => contactsSourceLocal,
      'contacts_Text_blingTransferInitiated' =>
        contacts_Text_blingTransferInitiated,
      'contacts_DialogsInfoView_title' => contacts_DialogsInfoView_title,
      'contacts_ContactScreen_options' => contacts_ContactScreen_options,
      'contacts_ContactScreen_presenceViaSip' =>
        contacts_ContactScreen_presenceViaSip,
      'contacts_ContactScreen_presenceViaSip_tooltip' =>
        contacts_ContactScreen_presenceViaSip_tooltip,
      'contacts_ContactScreen_dialogsViaSipBlf' =>
        contacts_ContactScreen_dialogsViaSipBlf,
      'contacts_ContactScreen_dialogsViaSipBlf_tooltip' =>
        contacts_ContactScreen_dialogsViaSipBlf_tooltip,
      'copyToClipboard_floatingSnackBar' => copyToClipboard_floatingSnackBar,
      'copyToClipboard_popupMenuItem' => copyToClipboard_popupMenuItem,
      'default_CannotRemoveOwnerMessagingSocketException' =>
        default_CannotRemoveOwnerMessagingSocketException,
      'default_ChatMemberNotFoundMessagingSocketException' =>
        default_ChatMemberNotFoundMessagingSocketException,
      'default_ChatNotFoundMessagingSocketException' =>
        default_ChatNotFoundMessagingSocketException,
      'default_ClientExceptionError' => default_ClientExceptionError,
      'default_ErrorDetails' => default_ErrorDetails,
      'default_ErrorMessage' => default_ErrorMessage,
      'default_ErrorPath' => default_ErrorPath,
      'default_ErrorTransactionId' => default_ErrorTransactionId,
      'default_ForbiddenMessagingSocketException' =>
        default_ForbiddenMessagingSocketException,
      'default_FormatExceptionError' => default_FormatExceptionError,
      'default_InternalErrorMessagingSocketException' =>
        default_InternalErrorMessagingSocketException,
      'default_InvalidChatTypeMessagingSocketException' =>
        default_InvalidChatTypeMessagingSocketException,
      'default_JoinCrashedMessagingSocketException' =>
        default_JoinCrashedMessagingSocketException,
      'default_MessagingSocketException' => default_MessagingSocketException,
      'default_RequestFailureError' => default_RequestFailureError,
      'default_SelfAuthorityAssignmentForbiddenMessagingSocketException' =>
        default_SelfAuthorityAssignmentForbiddenMessagingSocketException,
      'default_SelfRemovalForbiddenMessagingSocketException' =>
        default_SelfRemovalForbiddenMessagingSocketException,
      'default_SmsConversationNotFoundMessagingSocketException' =>
        default_SmsConversationNotFoundMessagingSocketException,
      'default_TimeoutExceptionError' => default_TimeoutExceptionError,
      'default_TimeoutMessagingSocketException' =>
        default_TimeoutMessagingSocketException,
      'default_TlsExceptionError' => default_TlsExceptionError,
      'default_TypeErrorError' => default_TypeErrorError,
      'default_UnauthorizedMessagingSocketException' =>
        default_UnauthorizedMessagingSocketException,
      'default_UnauthorizedRequestFailureError' =>
        default_UnauthorizedRequestFailureError,
      'default_UserAlreadyInChatMessagingSocketException' =>
        default_UserAlreadyInChatMessagingSocketException,
      'diagnostic_AppBar_title' => diagnostic_AppBar_title,
      'diagnostic_battery_groupTitle' => diagnostic_battery_groupTitle,
      'diagnostic_batteryMode_optimized_description' =>
        diagnostic_batteryMode_optimized_description,
      'diagnostic_batteryMode_optimized_title' =>
        diagnostic_batteryMode_optimized_title,
      'diagnostic_batteryMode_restricted_description' =>
        diagnostic_batteryMode_restricted_description,
      'diagnostic_batteryMode_restricted_title' =>
        diagnostic_batteryMode_restricted_title,
      'diagnostic_batteryMode_unknown_description' =>
        diagnostic_batteryMode_unknown_description,
      'diagnostic_batteryMode_unknown_title' =>
        diagnostic_batteryMode_unknown_title,
      'diagnostic_batteryMode_unrestricted_description' =>
        diagnostic_batteryMode_unrestricted_description,
      'diagnostic_batteryMode_unrestricted_title' =>
        diagnostic_batteryMode_unrestricted_title,
      'diagnostic_battery_navigate_section' =>
        diagnostic_battery_navigate_section,
      'diagnostic_battery_tile_title' => diagnostic_battery_tile_title,
      'diagnostic_callingMode_groupTitle' => diagnostic_callingMode_groupTitle,
      'diagnostic_callingMode_tile_title' => diagnostic_callingMode_tile_title,
      'diagnostic_callingMode_standalone_title' =>
        diagnostic_callingMode_standalone_title,
      'diagnostic_callingMode_standalone_caption' =>
        diagnostic_callingMode_standalone_caption,
      'diagnostic_callingMode_standalone_description' =>
        diagnostic_callingMode_standalone_description,
      'diagnostic_permission_camera_description' =>
        diagnostic_permission_camera_description,
      'diagnostic_permission_camera_title' =>
        diagnostic_permission_camera_title,
      'diagnostic_permission_contacts_description' =>
        diagnostic_permission_contacts_description,
      'diagnostic_permission_contacts_title' =>
        diagnostic_permission_contacts_title,
      'diagnosticPermissionDetails_button_managePermission' =>
        diagnosticPermissionDetails_button_managePermission,
      'diagnosticPermissionDetails_button_requestPermission' =>
        diagnosticPermissionDetails_button_requestPermission,
      'diagnosticPermissionDetails_title_statusPermission' =>
        diagnosticPermissionDetails_title_statusPermission,
      'diagnostic_permission_microphone_description' =>
        diagnostic_permission_microphone_description,
      'diagnostic_permission_microphone_title' =>
        diagnostic_permission_microphone_title,
      'diagnostic_permission_notification_description' =>
        diagnostic_permission_notification_description,
      'diagnostic_permission_notification_title' =>
        diagnostic_permission_notification_title,
      'diagnostic_permissionStatus_denied' =>
        diagnostic_permissionStatus_denied,
      'diagnostic_permissionStatus_granted' =>
        diagnostic_permissionStatus_granted,
      'diagnostic_permissionStatus_limited' =>
        diagnostic_permissionStatus_limited,
      'diagnostic_permissionStatus_permanentlyDenied' =>
        diagnostic_permissionStatus_permanentlyDenied,
      'diagnostic_permissionStatus_provisional' =>
        diagnostic_permissionStatus_provisional,
      'diagnostic_permissionStatus_restricted' =>
        diagnostic_permissionStatus_restricted,
      'diagnosticPushDetails_configuration_title' =>
        diagnosticPushDetails_configuration_title,
      'diagnosticPushDetails_errorMessage_intro' =>
        diagnosticPushDetails_errorMessage_intro,
      'diagnosticPushDetails_errorMessage_step1' =>
        diagnosticPushDetails_errorMessage_step1,
      'diagnosticPushDetails_errorMessage_step2' =>
        diagnosticPushDetails_errorMessage_step2,
      'diagnosticPushDetails_errorMessage_step3' =>
        diagnosticPushDetails_errorMessage_step3,
      'diagnosticPushDetails_errorMessage_step4' =>
        diagnosticPushDetails_errorMessage_step4,
      'diagnosticPushDetails_errorMessage_step5' =>
        diagnosticPushDetails_errorMessage_step5,
      'diagnosticPushDetails_successMessage' =>
        diagnosticPushDetails_successMessage,
      'diagnostic_pushTokenStatusType_progress' =>
        diagnostic_pushTokenStatusType_progress,
      'diagnostic_pushTokenStatusType_success' =>
        diagnostic_pushTokenStatusType_success,
      'diagnosticReportDialogAddNoteExpansionTileTitle' =>
        diagnosticReportDialogAddNoteExpansionTileTitle,
      'diagnosticReportDialogCancelButtonLabel' =>
        diagnosticReportDialogCancelButtonLabel,
      'diagnosticReportDialogCommentTextFieldHintText' =>
        diagnosticReportDialogCommentTextFieldHintText,
      'diagnosticReportDialogContent' => diagnosticReportDialogContent,
      'diagnosticReportDialogIncludeSystemLogsSwitchTileSubtitle' =>
        diagnosticReportDialogIncludeSystemLogsSwitchTileSubtitle,
      'diagnosticReportDialogIncludeSystemLogsSwitchTileTitle' =>
        diagnosticReportDialogIncludeSystemLogsSwitchTileTitle,
      'diagnosticReportDialogSendReportButtonLabel' =>
        diagnosticReportDialogSendReportButtonLabel,
      'diagnosticReportDialogTitle' => diagnosticReportDialogTitle,
      'diagnosticScreen_contacts_agreement_description' =>
        diagnosticScreen_contacts_agreement_description,
      'diagnosticScreen_contacts_agreement_group_title' =>
        diagnosticScreen_contacts_agreement_group_title,
      'diagnosticScreen_contacts_agreement_title' =>
        diagnosticScreen_contacts_agreement_title,
      'diagnosticScreen_permissionsGroup_title' =>
        diagnosticScreen_permissionsGroup_title,
      'diagnosticScreen_pushNotificationService_title' =>
        diagnosticScreen_pushNotificationService_title,
      'diagnostic_network_groupTitle' => diagnostic_network_groupTitle,
      'diagnosticNetworkTest_status_offline' =>
        diagnosticNetworkTest_status_offline,
      'diagnosticNetworkTest_status_reachable' =>
        diagnosticNetworkTest_status_reachable,
      'diagnosticNetworkTest_status_restricted' =>
        diagnosticNetworkTest_status_restricted,
      'diagnosticNetworkTest_status_checking' =>
        diagnosticNetworkTest_status_checking,
      'diagnosticNetworkTest_status_unreachable' =>
        diagnosticNetworkTest_status_unreachable,
      'diagnosticNetworkTestItem_subtitle_noNetwork' =>
        diagnosticNetworkTestItem_subtitle_noNetwork,
      'diagnosticNetworkTestItem_subtitle_stunBlocked' =>
        diagnosticNetworkTestItem_subtitle_stunBlocked,
      'diagnosticNetworkTestItem_subtitle_stunUnreachable' =>
        diagnosticNetworkTestItem_subtitle_stunUnreachable,
      'diagnosticNetworkTestItem_subtitle_noCandidates' =>
        diagnosticNetworkTestItem_subtitle_noCandidates,
      'diagnosticNetworkTestItem_network_wifi' =>
        diagnosticNetworkTestItem_network_wifi,
      'diagnosticNetworkTestItem_network_mobile' =>
        diagnosticNetworkTestItem_network_mobile,
      'diagnosticNetworkTestItem_network_ethernet' =>
        diagnosticNetworkTestItem_network_ethernet,
      'diagnosticNetworkTestItem_network_vpn' =>
        diagnosticNetworkTestItem_network_vpn,
      'diagnosticNetworkTestDetails_title' =>
        diagnosticNetworkTestDetails_title,
      'diagnosticNetworkTestDetails_description' =>
        diagnosticNetworkTestDetails_description,
      'diagnosticNetworkTestDetails_status' =>
        diagnosticNetworkTestDetails_status,
      'diagnosticNetworkTestDetails_candidates' =>
        diagnosticNetworkTestDetails_candidates,
      'diagnosticNetworkTestDetails_noNetwork' =>
        diagnosticNetworkTestDetails_noNetwork,
      'diagnosticNetworkTestDetails_noCandidates' =>
        diagnosticNetworkTestDetails_noCandidates,
      'favorites_BodyCenter_empty' => favorites_BodyCenter_empty,
      'favorites_DeleteConfirmDialog_content' =>
        favorites_DeleteConfirmDialog_content,
      'favorites_DeleteConfirmDialog_title' =>
        favorites_DeleteConfirmDialog_title,
      'favorites_Text_blingTransferInitiated' =>
        favorites_Text_blingTransferInitiated,
      'locale_default' => locale_default,
      'locale_en' => locale_en,
      'locale_it' => locale_it,
      'locale_uk' => locale_uk,
      'login_Button_coreUrlAssignProceed' => login_Button_coreUrlAssignProceed,
      'login_Button_otpSigninRequestProceed' =>
        login_Button_otpSigninRequestProceed,
      'login_Button_otpSigninVerifyProceed' =>
        login_Button_otpSigninVerifyProceed,
      'login_Button_otpSigninVerifyRepeat' =>
        login_Button_otpSigninVerifyRepeat,
      'login_Button_passwordSigninProceed' =>
        login_Button_passwordSigninProceed,
      'login_Button_signIn' => login_Button_signIn,
      'login_Button_signupRequestProceed' => login_Button_signupRequestProceed,
      'login_Button_signUpToDemoInstance' => login_Button_signUpToDemoInstance,
      'login_Button_signupVerifyProceed' => login_Button_signupVerifyProceed,
      'login_Button_signupVerifyRepeat' => login_Button_signupVerifyRepeat,
      'login_ButtonTooltip_signInToYourInstance' =>
        login_ButtonTooltip_signInToYourInstance,
      'login_RequestFailureEmptyEmailError' =>
        login_RequestFailureEmptyEmailError,
      'login_RequestFailureIdentifierIsNotValid' =>
        login_RequestFailureIdentifierIsNotValid,
      'login_RequestFailureIncorrectOtpCodeError' =>
        login_RequestFailureIncorrectOtpCodeError,
      'login_RequestFailureOtpAlreadyVerifiedError' =>
        login_RequestFailureOtpAlreadyVerifiedError,
      'login_RequestFailureOtpExpiredError' =>
        login_RequestFailureOtpExpiredError,
      'login_RequestFailureOtpNotFoundError' =>
        login_RequestFailureOtpNotFoundError,
      'login_RequestFailureOtpVerificationAttemptsExceededError' =>
        login_RequestFailureOtpVerificationAttemptsExceededError,
      'login_RequestFailureParametersApplyIssueError' =>
        login_RequestFailureParametersApplyIssueError,
      'login_RequestFailurePhoneNotFoundError' =>
        login_RequestFailurePhoneNotFoundError,
      'login_RequestFailureIncorrectCredentialsError' =>
        login_RequestFailureIncorrectCredentialsError,
      'login_RequestFailureUserNotFoundError' =>
        login_RequestFailureUserNotFoundError,
      'login_RequestFailureUnconfiguredBundleIdError' =>
        login_RequestFailureUnconfiguredBundleIdError,
      'login_SupportedLoginTypeMissedExceptionError' =>
        login_SupportedLoginTypeMissedExceptionError,
      'login_Text_coreUrlAssignPreDescription' =>
        login_Text_coreUrlAssignPreDescription,
      'login_TextFieldLabelText_coreUrlAssign' =>
        login_TextFieldLabelText_coreUrlAssign,
      'login_TextFieldLabelText_otpSigninCode' =>
        login_TextFieldLabelText_otpSigninCode,
      'login_TextFieldLabelText_otpSigninUserRef' =>
        login_TextFieldLabelText_otpSigninUserRef,
      'login_TextFieldLabelText_otpSigninUserRefPhone' =>
        login_TextFieldLabelText_otpSigninUserRefPhone,
      'login_TextFieldLabelText_otpSigninUserRefEmail' =>
        login_TextFieldLabelText_otpSigninUserRefEmail,
      'login_TextFieldLabelText_passwordSigninPassword' =>
        login_TextFieldLabelText_passwordSigninPassword,
      'login_TextFieldLabelText_passwordSigninUserRef' =>
        login_TextFieldLabelText_passwordSigninUserRef,
      'login_TextFieldLabelText_signupCode' =>
        login_TextFieldLabelText_signupCode,
      'login_TextFieldLabelText_signupEmail' =>
        login_TextFieldLabelText_signupEmail,
      'login_Text_otpSigninRequestPostDescription' =>
        login_Text_otpSigninRequestPostDescription,
      'login_Text_otpSigninRequestPreDescription' =>
        login_Text_otpSigninRequestPreDescription,
      'login_Text_otpSigninVerifyPostDescriptionGeneral' =>
        login_Text_otpSigninVerifyPostDescriptionGeneral,
      'login_Text_passwordSigninPostDescription' =>
        login_Text_passwordSigninPostDescription,
      'login_Text_passwordSigninPreDescription' =>
        login_Text_passwordSigninPreDescription,
      'login_Text_signupRequestPostDescription' =>
        login_Text_signupRequestPostDescription,
      'login_Text_signupRequestPostDescriptionDemo' =>
        login_Text_signupRequestPostDescriptionDemo,
      'login_Text_signupRequestPreDescription' =>
        login_Text_signupRequestPreDescription,
      'login_Text_signupRequestPreDescriptionDemo' =>
        login_Text_signupRequestPreDescriptionDemo,
      'login_Text_signupVerifyPostDescriptionGeneral' =>
        login_Text_signupVerifyPostDescriptionGeneral,
      'loginType_otpSignin' => loginType_otpSignin,
      'loginType_passwordSignin' => loginType_passwordSignin,
      'loginType_signup' => loginType_signup,
      'login_validationCoreUrlError' => login_validationCoreUrlError,
      'login_validationEmailError' => login_validationEmailError,
      'login_validationPhoneError' => login_validationPhoneError,
      'login_validationUserRefError' => login_validationUserRefError,
      'logRecordsConsole_AppBarTitle' => logRecordsConsole_AppBarTitle,
      'logRecordsConsole_Button_failureRefresh' =>
        logRecordsConsole_Button_failureRefresh,
      'logRecordsConsole_Text_failure' => logRecordsConsole_Text_failure,
      'logRecordsConsole_Button_infoClose' =>
        logRecordsConsole_Button_infoClose,
      'logRecordsConsole_PopupMenuItem_info' =>
        logRecordsConsole_PopupMenuItem_info,
      'logRecordsConsole_PopupMenuItem_clear' =>
        logRecordsConsole_PopupMenuItem_clear,
      'main_BottomNavigationBarItemLabel_chats' =>
        main_BottomNavigationBarItemLabel_chats,
      'main_BottomNavigationBarItemLabel_contacts' =>
        main_BottomNavigationBarItemLabel_contacts,
      'main_BottomNavigationBarItemLabel_favorites' =>
        main_BottomNavigationBarItemLabel_favorites,
      'main_BottomNavigationBarItemLabel_keypad' =>
        main_BottomNavigationBarItemLabel_keypad,
      'main_BottomNavigationBarItemLabel_recents' =>
        main_BottomNavigationBarItemLabel_recents,
      'main_CompatibilityIssueDialogActions_logout' =>
        main_CompatibilityIssueDialogActions_logout,
      'main_CompatibilityIssueDialogActions_update' =>
        main_CompatibilityIssueDialogActions_update,
      'main_CompatibilityIssueDialog_title' =>
        main_CompatibilityIssueDialog_title,
      'messaging_ActionBtn_retry' => messaging_ActionBtn_retry,
      'messaging_ChooseContact_cancel' => messaging_ChooseContact_cancel,
      'messaging_ChooseContact_empty' => messaging_ChooseContact_empty,
      'messaging_ChooseContact_title' => messaging_ChooseContact_title,
      'messaging_ConfirmDialog_ask' => messaging_ConfirmDialog_ask,
      'messaging_ConfirmDialog_cancel' => messaging_ConfirmDialog_cancel,
      'messaging_ConfirmDialog_confirm' => messaging_ConfirmDialog_confirm,
      'messaging_ConversationBuilders_back' =>
        messaging_ConversationBuilders_back,
      'messaging_ConversationBuilders_cancel' =>
        messaging_ConversationBuilders_cancel,
      'messaging_ConversationBuilders_contactOrNumberSearch_hint' =>
        messaging_ConversationBuilders_contactOrNumberSearch_hint,
      'messaging_ConversationBuilders_contactSearch_hint' =>
        messaging_ConversationBuilders_contactSearch_hint,
      'messaging_ConversationBuilders_create' =>
        messaging_ConversationBuilders_create,
      'messaging_ConversationBuilders_createGroup' =>
        messaging_ConversationBuilders_createGroup,
      'messaging_ConversationBuilders_externalContacts_heading' =>
        messaging_ConversationBuilders_externalContacts_heading,
      'messaging_ConversationBuilders_invalidNumber_message1' =>
        messaging_ConversationBuilders_invalidNumber_message1,
      'messaging_ConversationBuilders_invalidNumber_message2' =>
        messaging_ConversationBuilders_invalidNumber_message2,
      'messaging_ConversationBuilders_invalidNumber_ok' =>
        messaging_ConversationBuilders_invalidNumber_ok,
      'messaging_ConversationBuilders_invalidNumber_title' =>
        messaging_ConversationBuilders_invalidNumber_title,
      'messaging_ConversationBuilders_invite_heading' =>
        messaging_ConversationBuilders_invite_heading,
      'messaging_ConversationBuilders_localContacts_heading' =>
        messaging_ConversationBuilders_localContacts_heading,
      'messaging_ConversationBuilders_membersHeadline' =>
        messaging_ConversationBuilders_membersHeadline,
      'messaging_ConversationBuilders_nameFieldEmpty' =>
        messaging_ConversationBuilders_nameFieldEmpty,
      'messaging_ConversationBuilders_nameFieldLabel' =>
        messaging_ConversationBuilders_nameFieldLabel,
      'messaging_ConversationBuilders_nameFieldShort' =>
        messaging_ConversationBuilders_nameFieldShort,
      'messaging_ConversationBuilders_next_action' =>
        messaging_ConversationBuilders_next_action,
      'messaging_ConversationBuilders_noContacts' =>
        messaging_ConversationBuilders_noContacts,
      'messaging_ConversationBuilders_numberFormatExample' =>
        messaging_ConversationBuilders_numberFormatExample,
      'messaging_ConversationBuilders_numberSearch_errorError' =>
        messaging_ConversationBuilders_numberSearch_errorError,
      'messaging_ConversationBuilders_numberSearch_errorHint' =>
        messaging_ConversationBuilders_numberSearch_errorHint,
      'messaging_ConversationBuilders_title_group' =>
        messaging_ConversationBuilders_title_group,
      'messaging_ConversationBuilders_title_new' =>
        messaging_ConversationBuilders_title_new,
      'messaging_Conversation_failure' => messaging_Conversation_failure,
      'messaging_ConversationScreen_titleAvailable' =>
        messaging_ConversationScreen_titleAvailable,
      'messaging_ConversationScreen_titlePrefix' =>
        messaging_ConversationScreen_titlePrefix,
      'messaging_ConversationsScreen_chatsSearch_hint' =>
        messaging_ConversationsScreen_chatsSearch_hint,
      'messaging_ConversationsScreen_empty' =>
        messaging_ConversationsScreen_empty,
      'messaging_ConversationsScreen_messages_title' =>
        messaging_ConversationsScreen_messages_title,
      'messaging_ConversationsScreen_noNumberAlert_text' =>
        messaging_ConversationsScreen_noNumberAlert_text,
      'messaging_ConversationsScreen_noNumberAlert_title' =>
        messaging_ConversationsScreen_noNumberAlert_title,
      'messaging_ConversationsScreen_selectNumberSheet_title' =>
        messaging_ConversationsScreen_selectNumberSheet_title,
      'messaging_ConversationsScreen_smses_title' =>
        messaging_ConversationsScreen_smses_title,
      'messaging_ConversationsScreen_smssSearch_hint' =>
        messaging_ConversationsScreen_smssSearch_hint,
      'messaging_ConversationsScreen_unsupported' =>
        messaging_ConversationsScreen_unsupported,
      'messaging_Conversations_tile_empty' =>
        messaging_Conversations_tile_empty,
      'messaging_Conversations_tile_you' => messaging_Conversations_tile_you,
      'messaging_DialogInfo_deleteAsk' => messaging_DialogInfo_deleteAsk,
      'messaging_DialogInfo_deleteBtn' => messaging_DialogInfo_deleteBtn,
      'messaging_DialogInfo_title' => messaging_DialogInfo_title,
      'messaging_GroupAuthorities_moderator' =>
        messaging_GroupAuthorities_moderator,
      'messaging_GroupAuthorities_noauthorities' =>
        messaging_GroupAuthorities_noauthorities,
      'messaging_GroupAuthorities_owner' => messaging_GroupAuthorities_owner,
      'messaging_GroupInfo_addUserBtnText' =>
        messaging_GroupInfo_addUserBtnText,
      'messaging_GroupInfo_deleteLeaveBtnText' =>
        messaging_GroupInfo_deleteLeaveBtnText,
      'messaging_GroupInfo_groupMembersHeadline' =>
        messaging_GroupInfo_groupMembersHeadline,
      'messaging_GroupInfo_leaveAndDeleteAsk' =>
        messaging_GroupInfo_leaveAndDeleteAsk,
      'messaging_GroupInfo_leaveAsk' => messaging_GroupInfo_leaveAsk,
      'messaging_GroupInfo_leaveBtnText' => messaging_GroupInfo_leaveBtnText,
      'messaging_GroupInfo_makeModeratorAsk' =>
        messaging_GroupInfo_makeModeratorAsk,
      'messaging_GroupInfo_makeModeratorBtnText' =>
        messaging_GroupInfo_makeModeratorBtnText,
      'messaging_GroupInfo_removeModeratorAsk' =>
        messaging_GroupInfo_removeModeratorAsk,
      'messaging_GroupInfo_removeUserAsk' => messaging_GroupInfo_removeUserAsk,
      'messaging_GroupInfo_removeUserBtnText' =>
        messaging_GroupInfo_removeUserBtnText,
      'messaging_GroupInfo_title' => messaging_GroupInfo_title,
      'messaging_GroupInfo_titlePrefix' => messaging_GroupInfo_titlePrefix,
      'messaging_GroupInfo_unmakeModeratorBtnText' =>
        messaging_GroupInfo_unmakeModeratorBtnText,
      'messaging_MessageField_hint' => messaging_MessageField_hint,
      'messaging_MessageListView_typingTrail' =>
        messaging_MessageListView_typingTrail,
      'messaging_MessageView_delete' => messaging_MessageView_delete,
      'messaging_MessageView_deleted' => messaging_MessageView_deleted,
      'messaging_MessageView_edit' => messaging_MessageView_edit,
      'messaging_MessageView_edited' => messaging_MessageView_edited,
      'messaging_MessageView_forward' => messaging_MessageView_forward,
      'messaging_MessageView_reply' => messaging_MessageView_reply,
      'messaging_MessageView_textcopy' => messaging_MessageView_textcopy,
      'messaging_MessageView_today' => messaging_MessageView_today,
      'messaging_MessageView_yesterday' => messaging_MessageView_yesterday,
      'messaging_ParticipantName_unknown' => messaging_ParticipantName_unknown,
      'messaging_ParticipantName_you' => messaging_ParticipantName_you,
      'messaging_SmsSendingStatus_delivered' =>
        messaging_SmsSendingStatus_delivered,
      'messaging_SmsSendingStatus_failed' => messaging_SmsSendingStatus_failed,
      'messaging_SmsSendingStatus_sent' => messaging_SmsSendingStatus_sent,
      'messaging_SmsSendingStatus_waiting' =>
        messaging_SmsSendingStatus_waiting,
      'messaging_StateBar_connecting' => messaging_StateBar_connecting,
      'messaging_StateBar_error' => messaging_StateBar_error,
      'messaging_StateBar_initializing' => messaging_StateBar_initializing,
      'notifications_errorSnackBarAction_callSdpConfiguration' =>
        notifications_errorSnackBarAction_callSdpConfiguration,
      'notifications_errorSnackBarAction_callUserMedia' =>
        notifications_errorSnackBarAction_callUserMedia,
      'notifications_errorSnackBar_activeLineBlindTransferWarning' =>
        notifications_errorSnackBar_activeLineBlindTransferWarning,
      'notifications_errorSnackBar_blindTransferFailed' =>
        notifications_errorSnackBar_blindTransferFailed,
      'notifications_errorSnackBar_appOffline' =>
        notifications_errorSnackBar_appOffline,
      'notifications_errorSnackBar_appOnline' =>
        notifications_errorSnackBar_appOnline,
      'notifications_errorSnackBar_appUnregistered' =>
        notifications_errorSnackBar_appUnregistered,
      'notifications_errorSnackBar_callConnect' =>
        notifications_errorSnackBar_callConnect,
      'notifications_errorSnackBar_callNegotiationTimeout' =>
        notifications_errorSnackBar_callNegotiationTimeout,
      'notifications_errorSnackBar_generalUnableToCall' =>
        notifications_errorSnackBar_generalUnableToCall,
      'notifications_errorSnackBar_callServiceBusyLine' =>
        notifications_errorSnackBar_callServiceBusyLine,
      'notifications_errorSnackBar_callSignalingClientNotConnect' =>
        notifications_errorSnackBar_callSignalingClientNotConnect,
      'notifications_errorSnackBar_callSignalingClientSessionMissed' =>
        notifications_errorSnackBar_callSignalingClientSessionMissed,
      'notifications_errorSnackBar_callUndefinedLine' =>
        notifications_errorSnackBar_callUndefinedLine,
      'notifications_errorSnackBar_callMediaTrackSetup' =>
        notifications_errorSnackBar_callMediaTrackSetup,
      'notifications_errorSnackBar_callUserMedia' =>
        notifications_errorSnackBar_callUserMedia,
      'notifications_errorSnackBar_callWhileOffline' =>
        notifications_errorSnackBar_callWhileOffline,
      'notifications_errorSnackBar_callWhileUnregistered' =>
        notifications_errorSnackBar_callWhileUnregistered,
      'notifications_errorSnackBar_sessionExpired' =>
        notifications_errorSnackBar_sessionExpired,
      'notifications_errorSnackBar_accountNotFound' =>
        notifications_errorSnackBar_accountNotFound,
      'notifications_errorSnackBar_SignalingConnectFailed' =>
        notifications_errorSnackBar_SignalingConnectFailed,
      'notifications_errorSnackBarAction_emergencyNumber' =>
        notifications_errorSnackBarAction_emergencyNumber,
      'notifications_errorSnackBar_SignalingSessionMissed' =>
        notifications_errorSnackBar_SignalingSessionMissed,
      'notifications_errorSnackBar_sipRegistrationFailed_Unavailable' =>
        notifications_errorSnackBar_sipRegistrationFailed_Unavailable,
      'notifications_errorSnackBar_sipRegistrationFailed_Unexpected' =>
        notifications_errorSnackBar_sipRegistrationFailed_Unexpected,
      'notifications_errorSnackBar_sipServiceUnavailable' =>
        notifications_errorSnackBar_sipServiceUnavailable,
      'notifications_messageSnackBar_appOffline' =>
        notifications_messageSnackBar_appOffline,
      'notifications_successSnackBar_appOnline' =>
        notifications_successSnackBar_appOnline,
      'numberActions_audioCall' => numberActions_audioCall,
      'numberActions_callLog' => numberActions_callLog,
      'numberActions_chat' => numberActions_chat,
      'numberActions_copyCallId' => numberActions_copyCallId,
      'numberActions_copyNumber' => numberActions_copyNumber,
      'numberActions_delete' => numberActions_delete,
      'numberActions_sendSms' => numberActions_sendSms,
      'numberActions_transfer' => numberActions_transfer,
      'numberActions_videoCall' => numberActions_videoCall,
      'numberActions_viewContact' => numberActions_viewContact,
      'permission_Button_request' => permission_Button_request,
      'permission_manageFullScreenNotificationInstructions_step1' =>
        permission_manageFullScreenNotificationInstructions_step1,
      'permission_manageFullScreenNotificationInstructions_step2' =>
        permission_manageFullScreenNotificationInstructions_step2,
      'permission_manageFullScreenNotificationInstructions_step3' =>
        permission_manageFullScreenNotificationInstructions_step3,
      'permission_manageFullScreenNotificationInstructions_step4' =>
        permission_manageFullScreenNotificationInstructions_step4,
      'permission_manageFullScreenNotificationInstructions_step5' =>
        permission_manageFullScreenNotificationInstructions_step5,
      'permission_manageFullScreenNotificationPermissions' =>
        permission_manageFullScreenNotificationPermissions,
      'permission_manufacturer_Button_gotIt' =>
        permission_manufacturer_Button_gotIt,
      'permission_manufacturer_Button_toSettings' =>
        permission_manufacturer_Button_toSettings,
      'permission_manufacturer_Text_heading' =>
        permission_manufacturer_Text_heading,
      'permission_manufacturer_Text_trailing' =>
        permission_manufacturer_Text_trailing,
      'permission_manufacturer_Text_xiaomi_tip1' =>
        permission_manufacturer_Text_xiaomi_tip1,
      'permission_manufacturer_Text_xiaomi_tip2' =>
        permission_manufacturer_Text_xiaomi_tip2,
      'permission_Text_description' => permission_Text_description,
      'persistentConnectionReminderContent' =>
        persistentConnectionReminderContent,
      'persistentConnectionReminderTitle' => persistentConnectionReminderTitle,
      'batteryOptimizationWarningTitle' => batteryOptimizationWarningTitle,
      'batteryOptimizationWarningContent' => batteryOptimizationWarningContent,
      'batteryOptimizationWarningOpenSettings' =>
        batteryOptimizationWarningOpenSettings,
      'presence_activity_appointment_name' =>
        presence_activity_appointment_name,
      'presence_activity_away_name' => presence_activity_away_name,
      'presence_activity_busy_name' => presence_activity_busy_name,
      'presence_activity_doNotDisturb_name' =>
        presence_activity_doNotDisturb_name,
      'presence_activity_inTransit_name' => presence_activity_inTransit_name,
      'presence_activity_meal_name' => presence_activity_meal_name,
      'presence_activity_meeting_name' => presence_activity_meeting_name,
      'presence_activity_none_name' => presence_activity_none_name,
      'presence_activity_onThePhone_name' => presence_activity_onThePhone_name,
      'presence_activity_permanentAbsence_name' =>
        presence_activity_permanentAbsence_name,
      'presence_activity_sleeping_name' => presence_activity_sleeping_name,
      'presence_activity_travel_name' => presence_activity_travel_name,
      'presence_activity_vacation_name' => presence_activity_vacation_name,
      'presence_infoView_activity' => presence_infoView_activity,
      'presence_infoView_available' => presence_infoView_available,
      'presence_infoView_available_false' => presence_infoView_available_false,
      'presence_infoView_available_true' => presence_infoView_available_true,
      'presence_infoView_client' => presence_infoView_client,
      'presence_infoView_device' => presence_infoView_device,
      'presence_infoView_localTime' => presence_infoView_localTime,
      'presence_infoView_note' => presence_infoView_note,
      'presence_infoView_statusIcon' => presence_infoView_statusIcon,
      'presence_infoView_timeZone' => presence_infoView_timeZone,
      'presence_infoView_title' => presence_infoView_title,
      'presence_infoView_updated' => presence_infoView_updated,
      'presence_infoView_source_direct' => presence_infoView_source_direct,
      'presence_infoView_source_sip' => presence_infoView_source_sip,
      'presence_infoView_source_sipAndDirect' =>
        presence_infoView_source_sipAndDirect,
      'presence_preset_absent_name' => presence_preset_absent_name,
      'presence_preset_absent_note' => presence_preset_absent_note,
      'presence_preset_appointment_name' => presence_preset_appointment_name,
      'presence_preset_appointment_note' => presence_preset_appointment_note,
      'presence_preset_available_name' => presence_preset_available_name,
      'presence_preset_away_name' => presence_preset_away_name,
      'presence_preset_away_note' => presence_preset_away_note,
      'presence_preset_dnd_name' => presence_preset_dnd_name,
      'presence_preset_dnd_note' => presence_preset_dnd_note,
      'presence_preset_inTransit_name' => presence_preset_inTransit_name,
      'presence_preset_inTransit_note' => presence_preset_inTransit_note,
      'presence_preset_meal_name' => presence_preset_meal_name,
      'presence_preset_meal_note' => presence_preset_meal_note,
      'presence_preset_meeting_name' => presence_preset_meeting_name,
      'presence_preset_meeting_note' => presence_preset_meeting_note,
      'presence_preset_sleeping_name' => presence_preset_sleeping_name,
      'presence_preset_sleeping_note' => presence_preset_sleeping_note,
      'presence_preset_travel_name' => presence_preset_travel_name,
      'presence_preset_travel_note' => presence_preset_travel_note,
      'presence_preset_unavailable_name' => presence_preset_unavailable_name,
      'presence_preset_vacation_name' => presence_preset_vacation_name,
      'presence_preset_vacation_note' => presence_preset_vacation_note,
      'presence_settings_activity_label' => presence_settings_activity_label,
      'presence_settings_activity_tooltip' =>
        presence_settings_activity_tooltip,
      'presence_settings_availability_title' =>
        presence_settings_availability_title,
      'presence_settings_availability_tooltip' =>
        presence_settings_availability_tooltip,
      'presence_settings_config_title' => presence_settings_config_title,
      'presence_settings_dnd_title' => presence_settings_dnd_title,
      'presence_settings_dnd_tooltip' => presence_settings_dnd_tooltip,
      'presence_settings_note_label' => presence_settings_note_label,
      'presence_settings_note_tooltip' => presence_settings_note_tooltip,
      'presence_settings_presets_label' => presence_settings_presets_label,
      'presence_settings_presets_label_custom' =>
        presence_settings_presets_label_custom,
      'presence_settings_presets_title' => presence_settings_presets_title,
      'presence_settings_statusIcon_none' => presence_settings_statusIcon_none,
      'presence_settings_statusIcon_title' =>
        presence_settings_statusIcon_title,
      'recents_DeleteConfirmDialog_content' =>
        recents_DeleteConfirmDialog_content,
      'recents_DeleteConfirmDialog_title' => recents_DeleteConfirmDialog_title,
      'recents_HistoryTile_missedCallText' =>
        recents_HistoryTile_missedCallText,
      'recents_Text_blingTransferInitiated' =>
        recents_Text_blingTransferInitiated,
      'recentsVisibilityFilter_all' => recentsVisibilityFilter_all,
      'recentsVisibilityFilter_all_preposit' =>
        recentsVisibilityFilter_all_preposit,
      'recentsVisibilityFilter_incoming' => recentsVisibilityFilter_incoming,
      'recentsVisibilityFilter_incoming_preposit' =>
        recentsVisibilityFilter_incoming_preposit,
      'recentsVisibilityFilter_missed' => recentsVisibilityFilter_missed,
      'recentsVisibilityFilter_missed_preposit' =>
        recentsVisibilityFilter_missed_preposit,
      'recentsVisibilityFilter_outgoing' => recentsVisibilityFilter_outgoing,
      'recentsVisibilityFilter_outgoing_preposit' =>
        recentsVisibilityFilter_outgoing_preposit,
      'request_Id' => request_Id,
      'request_StatusCode' => request_StatusCode,
      'request_StatusName' => request_StatusName,
      'sessionStatus_AppBar_waitingForNetwork' =>
        sessionStatus_AppBar_waitingForNetwork,
      'sessionStatus_AppBar_waitingForConnection' =>
        sessionStatus_AppBar_waitingForConnection,
      'sessionStatus_AppBar_disconnected' => sessionStatus_AppBar_disconnected,
      'sessionStatus_AppBar_connecting' => sessionStatus_AppBar_connecting,
      'sessionStatus_pushNotificationServiceProblem' =>
        sessionStatus_pushNotificationServiceProblem,
      'sessionStatus_issue_limitedStandaloneCallMode_title' =>
        sessionStatus_issue_limitedStandaloneCallMode_title,
      'sessionStatus_issue_limitedStandaloneCallMode_caption' =>
        sessionStatus_issue_limitedStandaloneCallMode_caption,
      'session_Teardown_progressText' => session_Teardown_progressText,
      'settings_AboutText_ApplicationEmbeddedLinks' =>
        settings_AboutText_ApplicationEmbeddedLinks,
      'settings_AboutText_AppSessionIdentifier' =>
        settings_AboutText_AppSessionIdentifier,
      'settings_AboutText_AppVersion' => settings_AboutText_AppVersion,
      'settings_AboutText_CallkeepVersion' =>
        settings_AboutText_CallkeepVersion,
      'settings_AboutText_CoreVersion' => settings_AboutText_CoreVersion,
      'settings_AboutText_CoreVersionUndefined' =>
        settings_AboutText_CoreVersionUndefined,
      'settings_AboutText_FCMPushNotificationToken' =>
        settings_AboutText_FCMPushNotificationToken,
      'settings_AboutText_StoreVersion' => settings_AboutText_StoreVersion,
      'settings_AccountDeleteConfirmDialog_content' =>
        settings_AccountDeleteConfirmDialog_content,
      'settings_AccountDeleteConfirmDialog_title' =>
        settings_AccountDeleteConfirmDialog_title,
      'settings_AccountDeleteNotSupported_message' =>
        settings_AccountDeleteNotSupported_message,
      'settings_AppBarTitle_myAccount' => settings_AppBarTitle_myAccount,
      'settings_audioProcessing_Section_AGC_title' =>
        settings_audioProcessing_Section_AGC_title,
      'settings_audioProcessing_Section_AM_title' =>
        settings_audioProcessing_Section_AM_title,
      'settings_audioProcessing_Section_EC_title' =>
        settings_audioProcessing_Section_EC_title,
      'settings_audioProcessing_Section_HPF_title' =>
        settings_audioProcessing_Section_HPF_title,
      'settings_audioProcessing_Section_NS_title' =>
        settings_audioProcessing_Section_NS_title,
      'settings_audioProcessing_Section_title' =>
        settings_audioProcessing_Section_title,
      'settings_audioProcessing_Section_tooltip' =>
        settings_audioProcessing_Section_tooltip,
      'settings_audioProcessing_Section_VP_title' =>
        settings_audioProcessing_Section_VP_title,
      'settings_call_codecs_preferred_audio_default' =>
        settings_call_codecs_preferred_audio_default,
      'settings_call_codecs_preferred_audio_tip' =>
        settings_call_codecs_preferred_audio_tip,
      'settings_call_codecs_preferred_audio_title' =>
        settings_call_codecs_preferred_audio_title,
      'settings_call_codecs_preferred_video_default' =>
        settings_call_codecs_preferred_video_default,
      'settings_call_codecs_preferred_video_tip' =>
        settings_call_codecs_preferred_video_tip,
      'settings_call_codecs_preferred_video_title' =>
        settings_call_codecs_preferred_video_title,
      'settings_callerId_cancel_button' => settings_callerId_cancel_button,
      'settings_callerId_defaultTitle' => settings_callerId_defaultTitle,
      'settings_callerId_dialcode' => settings_callerId_dialcode,
      'settings_callerId_dialCodeMatching_title' =>
        settings_callerId_dialCodeMatching_title,
      'settings_callerId_duplicate_dialcode_error' =>
        settings_callerId_duplicate_dialcode_error,
      'settings_callerId_number' => settings_callerId_number,
      'settings_callerId_number_hint' => settings_callerId_number_hint,
      'settings_callerId_save_button' => settings_callerId_save_button,
      'settings_connectionSection_title' => settings_connectionSection_title,
      'settings_connectionSection_tooltip' =>
        settings_connectionSection_tooltip,
      'settings_encoding_AppBar_reset_tooltip' =>
        settings_encoding_AppBar_reset_tooltip,
      'settings_encoding_Section_audio_ptime' =>
        settings_encoding_Section_audio_ptime,
      'settings_encoding_Section_audio_ptime_limit' =>
        settings_encoding_Section_audio_ptime_limit,
      'settings_encoding_Section_bandwidth_prefix' =>
        settings_encoding_Section_bandwidth_prefix,
      'settings_encoding_Section_bitrate_prefix' =>
        settings_encoding_Section_bitrate_prefix,
      'settings_encoding_Section_bitrate_title' =>
        settings_encoding_Section_bitrate_title,
      'settings_encoding_Section_bitrate_tooltip' =>
        settings_encoding_Section_bitrate_tooltip,
      'settings_encoding_Section_extra_sdp_mod_removeREMBFeedback' =>
        settings_encoding_Section_extra_sdp_mod_removeREMBFeedback,
      'settings_encoding_Section_extra_sdp_mod_removeREMBFeedback_tooltip' =>
        settings_encoding_Section_extra_sdp_mod_removeREMBFeedback_tooltip,
      'settings_encoding_Section_extra_sdp_mod_removeTWCCFeedback' =>
        settings_encoding_Section_extra_sdp_mod_removeTWCCFeedback,
      'settings_encoding_Section_extra_sdp_mod_removeTWCCFeedback_tooltip' =>
        settings_encoding_Section_extra_sdp_mod_removeTWCCFeedback_tooltip,
      'settings_encoding_Section_rtp_extensions_title' =>
        settings_encoding_Section_rtp_extensions_title,
      'settings_encoding_Section_rtp_extensions_tooltip' =>
        settings_encoding_Section_rtp_extensions_tooltip,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_twcc' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_twcc,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_absSendTime' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_absSendTime,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_playoutDelay' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_playoutDelay,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_videoContentType' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_videoContentType,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_videoTiming' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_videoTiming,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_colorSpace' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_colorSpace,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_audioLevel' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_audioLevel,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_tOffset' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_tOffset,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_videoOrientation' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_videoOrientation,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_rtpStreamId' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_rtpStreamId,
      'settings_encoding_Section_extra_sdp_mod_removeExtmap_repairedRtpStreamId' =>
        settings_encoding_Section_extra_sdp_mod_removeExtmap_repairedRtpStreamId,
      'settings_encoding_Section_extra_sdp_mod_remapTE8' =>
        settings_encoding_Section_extra_sdp_mod_remapTE8,
      'settings_encoding_Section_extra_sdp_mod_remapTE8_tooltip' =>
        settings_encoding_Section_extra_sdp_mod_remapTE8_tooltip,
      'settings_encoding_Section_extra_sdp_mod_removeStaticRtpmaps' =>
        settings_encoding_Section_extra_sdp_mod_removeStaticRtpmaps,
      'settings_encoding_Section_extra_sdp_mod_removeStaticRtpmaps_tooltip' =>
        settings_encoding_Section_extra_sdp_mod_removeStaticRtpmaps_tooltip,
      'settings_encoding_Section_extra_sdp_mod_title' =>
        settings_encoding_Section_extra_sdp_mod_title,
      'settings_encoding_Section_measure_hz' =>
        settings_encoding_Section_measure_hz,
      'settings_encoding_Section_measure_kbps' =>
        settings_encoding_Section_measure_kbps,
      'settings_encoding_Section_measure_ms' =>
        settings_encoding_Section_measure_ms,
      'settings_encoding_Section_opus_bandwidth' =>
        settings_encoding_Section_opus_bandwidth,
      'settings_encoding_Section_opus_bitrate' =>
        settings_encoding_Section_opus_bitrate,
      'settings_encoding_Section_opus_channels' =>
        settings_encoding_Section_opus_channels,
      'settings_encoding_Section_opus_dtx' =>
        settings_encoding_Section_opus_dtx,
      'settings_encoding_Section_opus_samplingRate' =>
        settings_encoding_Section_opus_samplingRate,
      'settings_encoding_Section_opus_title' =>
        settings_encoding_Section_opus_title,
      'settings_encoding_Section_opus_tooltip' =>
        settings_encoding_Section_opus_tooltip,
      'settings_encoding_Section_packetization_title' =>
        settings_encoding_Section_packetization_title,
      'settings_encoding_Section_packetization_tooltip' =>
        settings_encoding_Section_packetization_tooltip,
      'settings_encoding_Section_packetization_warning_title' =>
        settings_encoding_Section_packetization_warning_title,
      'settings_encoding_Section_packetization_warning_message' =>
        settings_encoding_Section_packetization_warning_message,
      'settings_encoding_Section_preset' => settings_encoding_Section_preset,
      'settings_encoding_Section_preset_balance' =>
        settings_encoding_Section_preset_balance,
      'settings_encoding_Section_preset_balance_tooltip' =>
        settings_encoding_Section_preset_balance_tooltip,
      'settings_encoding_Section_preset_eco' =>
        settings_encoding_Section_preset_eco,
      'settings_encoding_Section_preset_eco_tooltip' =>
        settings_encoding_Section_preset_eco_tooltip,
      'settings_encoding_Section_preset_custom' =>
        settings_encoding_Section_preset_custom,
      'settings_encoding_Section_preset_custom_tooltip' =>
        settings_encoding_Section_preset_custom_tooltip,
      'settings_encoding_Section_preset_default' =>
        settings_encoding_Section_preset_default,
      'settings_encoding_Section_preset_default_tooltip' =>
        settings_encoding_Section_preset_default_tooltip,
      'settings_encoding_Section_preset_bypass' =>
        settings_encoding_Section_preset_bypass,
      'settings_encoding_Section_preset_bypass_tooltip' =>
        settings_encoding_Section_preset_bypass_tooltip,
      'settings_encoding_Section_preset_full_flex' =>
        settings_encoding_Section_preset_full_flex,
      'settings_encoding_Section_preset_quality' =>
        settings_encoding_Section_preset_quality,
      'settings_encoding_Section_preset_quality_tooltip' =>
        settings_encoding_Section_preset_quality_tooltip,
      'settings_encoding_Section_preset_title' =>
        settings_encoding_Section_preset_title,
      'settings_encoding_Section_preset_tooltip' =>
        settings_encoding_Section_preset_tooltip,
      'settings_encoding_Section_ptime_prefix' =>
        settings_encoding_Section_ptime_prefix,
      'settings_encoding_Section_rtp_override_audio' =>
        settings_encoding_Section_rtp_override_audio,
      'settings_encoding_Section_rtp_override_title' =>
        settings_encoding_Section_rtp_override_title,
      'settings_encoding_Section_rtp_override_tooltip' =>
        settings_encoding_Section_rtp_override_tooltip,
      'settings_encoding_Section_rtp_override_video' =>
        settings_encoding_Section_rtp_override_video,
      'settings_encoding_Section_rtp_override_warning_message' =>
        settings_encoding_Section_rtp_override_warning_message,
      'settings_encoding_Section_rtp_override_warning_title' =>
        settings_encoding_Section_rtp_override_warning_title,
      'settings_encoding_Section_target_audio_bitrate' =>
        settings_encoding_Section_target_audio_bitrate,
      'settings_encoding_Section_target_video_bitrate' =>
        settings_encoding_Section_target_video_bitrate,
      'settings_encoding_Section_value_auto' =>
        settings_encoding_Section_value_auto,
      'settings_encoding_Section_value_disable' =>
        settings_encoding_Section_value_disable,
      'settings_encoding_Section_value_enable' =>
        settings_encoding_Section_value_enable,
      'settings_encoding_Section_value_mono' =>
        settings_encoding_Section_value_mono,
      'settings_encoding_Section_value_off' =>
        settings_encoding_Section_value_off,
      'settings_encoding_Section_value_on' =>
        settings_encoding_Section_value_on,
      'settings_encoding_Section_value_stereo' =>
        settings_encoding_Section_value_stereo,
      'settings_iceSettings_Section_netfilter_skipv4' =>
        settings_iceSettings_Section_netfilter_skipv4,
      'settings_iceSettings_Section_netfilter_skipv6' =>
        settings_iceSettings_Section_netfilter_skipv6,
      'settings_iceSettings_Section_netfilter_title' =>
        settings_iceSettings_Section_netfilter_title,
      'settings_iceSettings_Section_noskip' =>
        settings_iceSettings_Section_noskip,
      'settings_iceSettings_Section_title' =>
        settings_iceSettings_Section_title,
      'settings_iceSettings_Section_tooltip' =>
        settings_iceSettings_Section_tooltip,
      'settings_iceSettings_Section_trfilter_skipTcp' =>
        settings_iceSettings_Section_trfilter_skipTcp,
      'settings_iceSettings_Section_trfilter_skipUdp' =>
        settings_iceSettings_Section_trfilter_skipUdp,
      'settings_iceSettings_Section_trfilter_title' =>
        settings_iceSettings_Section_trfilter_title,
      'settings_ListViewTileTitle_about' => settings_ListViewTileTitle_about,
      'settings_ListViewTileTitle_accountDelete' =>
        settings_ListViewTileTitle_accountDelete,
      'settings_ListViewTileTitle_call_codecs' =>
        settings_ListViewTileTitle_call_codecs,
      'settings_ListViewTileTitle_callerId' =>
        settings_ListViewTileTitle_callerId,
      'settings_ListViewTileTitle_encoding' =>
        settings_ListViewTileTitle_encoding,
      'settings_ListViewTileTitle_features' =>
        settings_ListViewTileTitle_features,
      'settings_ListViewTileTitle_help' => settings_ListViewTileTitle_help,
      'settings_ListViewTileTitle_language' =>
        settings_ListViewTileTitle_language,
      'settings_ListViewTileTitle_logout' => settings_ListViewTileTitle_logout,
      'settings_ListViewTileTitle_logRecordsConsole' =>
        settings_ListViewTileTitle_logRecordsConsole,
      'settings_ListViewTileTitle_mediaSettings' =>
        settings_ListViewTileTitle_mediaSettings,
      'settings_ListViewTileTitle_network' =>
        settings_ListViewTileTitle_network,
      'settings_ListViewTileTitle_presence' =>
        settings_ListViewTileTitle_presence,
      'settings_ListViewTileTitle_registered' =>
        settings_ListViewTileTitle_registered,
      'settings_ListViewTileTitle_self_config' =>
        settings_ListViewTileTitle_self_config,
      'settings_ListViewTileTitle_settings' =>
        settings_ListViewTileTitle_settings,
      'settings_ListViewTileTitle_termsConditions' =>
        settings_ListViewTileTitle_termsConditions,
      'settings_ListViewTileTitle_themeMode' =>
        settings_ListViewTileTitle_themeMode,
      'settings_ListViewTileTitle_toolbox' =>
        settings_ListViewTileTitle_toolbox,
      'settings_ListViewTileTitle_voicemail' =>
        settings_ListViewTileTitle_voicemail,
      'settings_LogoutConfirmDialog_content' =>
        settings_LogoutConfirmDialog_content,
      'settings_LogoutConfirmDialog_title' =>
        settings_LogoutConfirmDialog_title,
      'settings_missingMicrophoneIndicator_title' =>
        settings_missingMicrophoneIndicator_title,
      'settings_network_fallbackCalls_description' =>
        settings_network_fallbackCalls_description,
      'settings_network_fallbackCalls_title' =>
        settings_network_fallbackCalls_title,
      'settings_network_incomingCallType_pushNotification_description' =>
        settings_network_incomingCallType_pushNotification_description,
      'settings_network_incomingCallType_pushNotification_title' =>
        settings_network_incomingCallType_pushNotification_title,
      'settings_network_incomingCallType_socket_description' =>
        settings_network_incomingCallType_socket_description,
      'settings_network_incomingCallType_socket_title' =>
        settings_network_incomingCallType_socket_title,
      'settings_network_incomingCallType_title' =>
        settings_network_incomingCallType_title,
      'settings_network_smsFallback_toggle' =>
        settings_network_smsFallback_toggle,
      'settings_videoCapturing_Section_framerate_prefix' =>
        settings_videoCapturing_Section_framerate_prefix,
      'settings_videoCapturing_Section_framerate_title' =>
        settings_videoCapturing_Section_framerate_title,
      'settings_videoCapturing_Section_resolution_prefix' =>
        settings_videoCapturing_Section_resolution_prefix,
      'settings_videoCapturing_Section_resolution_title' =>
        settings_videoCapturing_Section_resolution_title,
      'settings_videoCapturing_Section_title' =>
        settings_videoCapturing_Section_title,
      'settings_videoCapturing_Section_tooltip' =>
        settings_videoCapturing_Section_tooltip,
      'settings_videoOffer_option_ignore' => settings_videoOffer_option_ignore,
      'settings_videoOffer_option_includeInactive' =>
        settings_videoOffer_option_includeInactive,
      'settings_videoOffer_title' => settings_videoOffer_title,
      'signalingResponseCode_ambiguousRequest' =>
        signalingResponseCode_ambiguousRequest,
      'signalingResponseCode_busyEverywhere' =>
        signalingResponseCode_busyEverywhere,
      'signalingResponseCode_callNotExist' =>
        signalingResponseCode_callNotExist,
      'signalingResponseCode_declineCall' => signalingResponseCode_declineCall,
      'signalingResponseCode_errorAttachingPlugin' =>
        signalingResponseCode_errorAttachingPlugin,
      'signalingResponseCode_errorDetachingPlugin' =>
        signalingResponseCode_errorDetachingPlugin,
      'signalingResponseCode_errorSendingMessage' =>
        signalingResponseCode_errorSendingMessage,
      'signalingResponseCode_exchangeRoutingError' =>
        signalingResponseCode_exchangeRoutingError,
      'signalingResponseCode_handleNotFound' =>
        signalingResponseCode_handleNotFound,
      'signalingResponseCode_incompatibleDestination' =>
        signalingResponseCode_incompatibleDestination,
      'signalingResponseCode_invalidElementType' =>
        signalingResponseCode_invalidElementType,
      'signalingResponseCode_invalidJson' => signalingResponseCode_invalidJson,
      'signalingResponseCode_invalidJsonObject' =>
        signalingResponseCode_invalidJsonObject,
      'signalingResponseCode_invalidNumberFormat' =>
        signalingResponseCode_invalidNumberFormat,
      'signalingResponseCode_invalidPath' => signalingResponseCode_invalidPath,
      'signalingResponseCode_invalidSdp' => signalingResponseCode_invalidSdp,
      'signalingResponseCode_invalidStream' =>
        signalingResponseCode_invalidStream,
      'signalingResponseCode_loopDetected' =>
        signalingResponseCode_loopDetected,
      'signalingResponseCode_missingMandatoryElement' =>
        signalingResponseCode_missingMandatoryElement,
      'signalingResponseCode_missingRequest' =>
        signalingResponseCode_missingRequest,
      'signalingResponseCode_normalUnspecified' =>
        signalingResponseCode_normalUnspecified,
      'signalingResponseCode_notAcceptable' =>
        signalingResponseCode_notAcceptable,
      'signalingResponseCode_notAcceptingNewSessions' =>
        signalingResponseCode_notAcceptingNewSessions,
      'signalingResponseCode_notFoundRoutesInReplyFromBE' =>
        signalingResponseCode_notFoundRoutesInReplyFromBE,
      'signalingResponseCode_pluginNotFound' =>
        signalingResponseCode_pluginNotFound,
      'signalingResponseCode_rejected' => signalingResponseCode_rejected,
      'signalingResponseCode_requestTerminated' =>
        signalingResponseCode_requestTerminated,
      'signalingResponseCode_sessionIdInUse' =>
        signalingResponseCode_sessionIdInUse,
      'signalingResponseCode_sessionNotFound' =>
        signalingResponseCode_sessionNotFound,
      'signalingResponseCode_tokenNotFound' =>
        signalingResponseCode_tokenNotFound,
      'signalingResponseCode_transportSpecificError' =>
        signalingResponseCode_transportSpecificError,
      'signalingResponseCodeType_callHangup' =>
        signalingResponseCodeType_callHangup,
      'signalingResponseCodeType_plugin' => signalingResponseCodeType_plugin,
      'signalingResponseCodeType_request' => signalingResponseCodeType_request,
      'signalingResponseCodeType_session' => signalingResponseCodeType_session,
      'signalingResponseCodeType_token' => signalingResponseCodeType_token,
      'signalingResponseCodeType_transport' =>
        signalingResponseCodeType_transport,
      'signalingResponseCodeType_unauthorized' =>
        signalingResponseCodeType_unauthorized,
      'signalingResponseCodeType_unknown' => signalingResponseCodeType_unknown,
      'signalingResponseCodeType_webrtc' => signalingResponseCodeType_webrtc,
      'signalingResponseCode_unauthorizedAccess' =>
        signalingResponseCode_unauthorizedAccess,
      'signalingResponseCode_unauthorizedRequest' =>
        signalingResponseCode_unauthorizedRequest,
      'signalingResponseCode_unexpectedAnswer' =>
        signalingResponseCode_unexpectedAnswer,
      'signalingResponseCode_unknownError' =>
        signalingResponseCode_unknownError,
      'signalingResponseCode_unknownRequest' =>
        signalingResponseCode_unknownRequest,
      'signalingResponseCode_unsupportedJsepType' =>
        signalingResponseCode_unsupportedJsepType,
      'signalingResponseCode_unwanted' => signalingResponseCode_unwanted,
      'signalingResponseCode_userBusy' => signalingResponseCode_userBusy,
      'signalingResponseCode_userNotExist' =>
        signalingResponseCode_userNotExist,
      'signalingResponseCode_wrongWebrtcState' =>
        signalingResponseCode_wrongWebrtcState,
      'socketError_connectionRefused' => socketError_connectionRefused,
      'socketError_connectionRefusedDescription' =>
        socketError_connectionRefusedDescription,
      'socketError_connectionReset' => socketError_connectionReset,
      'socketError_connectionResetDescription' =>
        socketError_connectionResetDescription,
      'socketError_connectionTimedOut' => socketError_connectionTimedOut,
      'socketError_connectionTimedOutDescription' =>
        socketError_connectionTimedOutDescription,
      'socketError_default' => socketError_default,
      'socketError_networkUnreachable' => socketError_networkUnreachable,
      'socketError_networkUnreachableDescription' =>
        socketError_networkUnreachableDescription,
      'socketError_serverUnreachable' => socketError_serverUnreachable,
      'socketError_serverUnreachableDescription' =>
        socketError_serverUnreachableDescription,
      'system_notifications_screen_list_empty' =>
        system_notifications_screen_list_empty,
      'system_notifications_screen_title' => system_notifications_screen_title,
      'themeMode_dark' => themeMode_dark,
      'themeMode_light' => themeMode_light,
      'themeMode_system' => themeMode_system,
      'undefined_autoprovision_invalidToken' =>
        undefined_autoprovision_invalidToken,
      'undefined_autoprovision_invalidToken_title' =>
        undefined_autoprovision_invalidToken_title,
      'undefined_stackScreenNotSupported' => undefined_stackScreenNotSupported,
      'undefined_stackScreenNotSupported_title' =>
        undefined_stackScreenNotSupported_title,
      'user_agreement_agrement_link' => user_agreement_agrement_link,
      'user_agreement_button_text' => user_agreement_button_text,
      'validationBlankError' => validationBlankError,
      'voicemail_Description_notSupported' =>
        voicemail_Description_notSupported,
      'voicemail_Dialog_deleteSelectedContent' =>
        voicemail_Dialog_deleteSelectedContent,
      'voicemail_Dialog_deleteSelectedTitle' =>
        voicemail_Dialog_deleteSelectedTitle,
      'voicemail_Dialog_deleteSingleContent' =>
        voicemail_Dialog_deleteSingleContent,
      'voicemail_Dialog_deleteSingleTitle' =>
        voicemail_Dialog_deleteSingleTitle,
      'voicemail_Label_call' => voicemail_Label_call,
      'voicemail_Label_delete' => voicemail_Label_delete,
      'voicemail_Label_deleteAll' => voicemail_Label_deleteAll,
      'voicemail_Label_deleteAllDescription' =>
        voicemail_Label_deleteAllDescription,
      'voicemail_Label_empty' => voicemail_Label_empty,
      'voicemail_Label_markAsHeard' => voicemail_Label_markAsHeard,
      'voicemail_Label_markAsNew' => voicemail_Label_markAsNew,
      'voicemail_Label_playbackError' => voicemail_Label_playbackError,
      'voicemail_Label_retry' => voicemail_Label_retry,
      'voicemail_Snackbar_notConfigured' => voicemail_Snackbar_notConfigured,
      'voicemail_Title_notSupported' => voicemail_Title_notSupported,
      'voicemail_Widget_screenTitle' => voicemail_Widget_screenTitle,
      'webRegistration_ErrorAcknowledgeDialogActions_retry' =>
        webRegistration_ErrorAcknowledgeDialogActions_retry,
      'webRegistration_ErrorAcknowledgeDialogActions_skip' =>
        webRegistration_ErrorAcknowledgeDialogActions_skip,
      'webRegistration_ErrorAcknowledgeDialog_title' =>
        webRegistration_ErrorAcknowledgeDialog_title,
      'webview_defaultError_reload' => webview_defaultError_reload,
      'webview_defaultError_title' => webview_defaultError_title,
      'webview_sslError_details' => webview_sslError_details,
      'webview_sslError_details_type' => webview_sslError_details_type,
      'webview_sslError_details_url' => webview_sslError_details_url,
      'webview_sslError_message' => webview_sslError_message,
      'webview_sslError_title' => webview_sslError_title,
      'webview_sslError_tryAgain' => webview_sslError_tryAgain,
      'cdr_disconnectReason_unknown' => cdr_disconnectReason_unknown,
      'cdr_disconnectReason_validCauseCodeNotYetReceived' =>
        cdr_disconnectReason_validCauseCodeNotYetReceived,
      'cdr_disconnectReason_unallocatedNumber' =>
        cdr_disconnectReason_unallocatedNumber,
      'cdr_disconnectReason_noRouteToSpecifiedTransitNetworkWan' =>
        cdr_disconnectReason_noRouteToSpecifiedTransitNetworkWan,
      'cdr_disconnectReason_noRouteToDestination' =>
        cdr_disconnectReason_noRouteToDestination,
      'cdr_disconnectReason_sendSpecialInformationTone' =>
        cdr_disconnectReason_sendSpecialInformationTone,
      'cdr_disconnectReason_misdialledTrunkPrefix' =>
        cdr_disconnectReason_misdialledTrunkPrefix,
      'cdr_disconnectReason_channelUnacceptable' =>
        cdr_disconnectReason_channelUnacceptable,
      'cdr_disconnectReason_callAwardedAndBeingDeliveredInAnEstablishedChannel' =>
        cdr_disconnectReason_callAwardedAndBeingDeliveredInAnEstablishedChannel,
      'cdr_disconnectReason_prefix0DialedButNotAllowedPreemption' =>
        cdr_disconnectReason_prefix0DialedButNotAllowedPreemption,
      'cdr_disconnectReason_prefix1DialedButNotAllowedPreemptionReserved' =>
        cdr_disconnectReason_prefix1DialedButNotAllowedPreemptionReserved,
      'cdr_disconnectReason_prefix1DialedButNotRequired' =>
        cdr_disconnectReason_prefix1DialedButNotRequired,
      'cdr_disconnectReason_moreDigitsReceivedThanAllowedCallIsProceeding' =>
        cdr_disconnectReason_moreDigitsReceivedThanAllowedCallIsProceeding,
      'cdr_disconnectReason_normalCallClearing' =>
        cdr_disconnectReason_normalCallClearing,
      'cdr_disconnectReason_userBusy' => cdr_disconnectReason_userBusy,
      'cdr_disconnectReason_noUserResponding' =>
        cdr_disconnectReason_noUserResponding,
      'cdr_disconnectReason_noAnswerFromUser' =>
        cdr_disconnectReason_noAnswerFromUser,
      'cdr_disconnectReason_subscriberIsAbsent' =>
        cdr_disconnectReason_subscriberIsAbsent,
      'cdr_disconnectReason_callRejected' => cdr_disconnectReason_callRejected,
      'cdr_disconnectReason_numberChanged' =>
        cdr_disconnectReason_numberChanged,
      'cdr_disconnectReason_reverseChargingRejected' =>
        cdr_disconnectReason_reverseChargingRejected,
      'cdr_disconnectReason_callSuspended' =>
        cdr_disconnectReason_callSuspended,
      'cdr_disconnectReason_callResumed' => cdr_disconnectReason_callResumed,
      'cdr_disconnectReason_nonSelectedUserClearing' =>
        cdr_disconnectReason_nonSelectedUserClearing,
      'cdr_disconnectReason_destinationOutOfOrder' =>
        cdr_disconnectReason_destinationOutOfOrder,
      'cdr_disconnectReason_invalidNumberFormatIncompleteNumber' =>
        cdr_disconnectReason_invalidNumberFormatIncompleteNumber,
      'cdr_disconnectReason_facilityRejected' =>
        cdr_disconnectReason_facilityRejected,
      'cdr_disconnectReason_responseToStatusEnquiry' =>
        cdr_disconnectReason_responseToStatusEnquiry,
      'cdr_disconnectReason_normalUnspecified' =>
        cdr_disconnectReason_normalUnspecified,
      'cdr_disconnectReason_circuitOutOfOrder' =>
        cdr_disconnectReason_circuitOutOfOrder,
      'cdr_disconnectReason_noCircuitChannelAvailable' =>
        cdr_disconnectReason_noCircuitChannelAvailable,
      'cdr_disconnectReason_destinationUnattainableRequireVpciVciIsNotAvailable' =>
        cdr_disconnectReason_destinationUnattainableRequireVpciVciIsNotAvailable,
      'cdr_disconnectReason_vpciVciAssignmentFailure' =>
        cdr_disconnectReason_vpciVciAssignmentFailure,
      'cdr_disconnectReason_degradedServiceCallRateIsnNotValid' =>
        cdr_disconnectReason_degradedServiceCallRateIsnNotValid,
      'cdr_disconnectReason_networkWanOutOfOrder' =>
        cdr_disconnectReason_networkWanOutOfOrder,
      'cdr_disconnectReason_transitDelayRangeCannotBeAchievedPermanentFrameModeIsOutOfService' =>
        cdr_disconnectReason_transitDelayRangeCannotBeAchievedPermanentFrameModeIsOutOfService,
      'cdr_disconnectReason_throughputRangeCannotBeAchievedPermanentFrameModeIsOperational' =>
        cdr_disconnectReason_throughputRangeCannotBeAchievedPermanentFrameModeIsOperational,
      'cdr_disconnectReason_temporaryFailure' =>
        cdr_disconnectReason_temporaryFailure,
      'cdr_disconnectReason_switchingEquipmentCongestion' =>
        cdr_disconnectReason_switchingEquipmentCongestion,
      'cdr_disconnectReason_accessInformationDiscarded' =>
        cdr_disconnectReason_accessInformationDiscarded,
      'cdr_disconnectReason_requestedCircuitChannelNotAvailable' =>
        cdr_disconnectReason_requestedCircuitChannelNotAvailable,
      'cdr_disconnectReason_preEmptedNoVpciVciIsAvailable' =>
        cdr_disconnectReason_preEmptedNoVpciVciIsAvailable,
      'cdr_disconnectReason_precedenceCallBlocked' =>
        cdr_disconnectReason_precedenceCallBlocked,
      'cdr_disconnectReason_resourceUnavailableUnspecified' =>
        cdr_disconnectReason_resourceUnavailableUnspecified,
      'cdr_disconnectReason_dspError' => cdr_disconnectReason_dspError,
      'cdr_disconnectReason_qualityOfServiceUnavailable' =>
        cdr_disconnectReason_qualityOfServiceUnavailable,
      'cdr_disconnectReason_requestedFacilityNotSubscribed' =>
        cdr_disconnectReason_requestedFacilityNotSubscribed,
      'cdr_disconnectReason_reverseChargingNotAllowed' =>
        cdr_disconnectReason_reverseChargingNotAllowed,
      'cdr_disconnectReason_outgoingCallsBarred' =>
        cdr_disconnectReason_outgoingCallsBarred,
      'cdr_disconnectReason_outgoingCallsBarredWithinCug' =>
        cdr_disconnectReason_outgoingCallsBarredWithinCug,
      'cdr_disconnectReason_incomingCallsBarred' =>
        cdr_disconnectReason_incomingCallsBarred,
      'cdr_disconnectReason_incomingCallsBarredWithinCug' =>
        cdr_disconnectReason_incomingCallsBarredWithinCug,
      'cdr_disconnectReason_callWaitingNotSubscribed' =>
        cdr_disconnectReason_callWaitingNotSubscribed,
      'cdr_disconnectReason_bearerCapabilityNotAuthorized' =>
        cdr_disconnectReason_bearerCapabilityNotAuthorized,
      'cdr_disconnectReason_bearerCapabilityNotPresentlyAvailable' =>
        cdr_disconnectReason_bearerCapabilityNotPresentlyAvailable,
      'cdr_disconnectReason_inconsistancyInTheInformationAndClass' =>
        cdr_disconnectReason_inconsistancyInTheInformationAndClass,
      'cdr_disconnectReason_serviceOrOptionNotAvailableUnspecified' =>
        cdr_disconnectReason_serviceOrOptionNotAvailableUnspecified,
      'cdr_disconnectReason_bearerServiceNotImplemented' =>
        cdr_disconnectReason_bearerServiceNotImplemented,
      'cdr_disconnectReason_channelTypeNotImplemented' =>
        cdr_disconnectReason_channelTypeNotImplemented,
      'cdr_disconnectReason_transitNetworkSelectionNotImplemented' =>
        cdr_disconnectReason_transitNetworkSelectionNotImplemented,
      'cdr_disconnectReason_messageNotImplemented' =>
        cdr_disconnectReason_messageNotImplemented,
      'cdr_disconnectReason_requestedFacilityNotImplemented' =>
        cdr_disconnectReason_requestedFacilityNotImplemented,
      'cdr_disconnectReason_onlyRestrictedDigitalInformationBearerCapabilityIsAvailable' =>
        cdr_disconnectReason_onlyRestrictedDigitalInformationBearerCapabilityIsAvailable,
      'cdr_disconnectReason_serviceOrOptionNotImplementedUnspecified' =>
        cdr_disconnectReason_serviceOrOptionNotImplementedUnspecified,
      'cdr_disconnectReason_invalidCallReferenceValue' =>
        cdr_disconnectReason_invalidCallReferenceValue,
      'cdr_disconnectReason_identifiedChannelDoesNotExist' =>
        cdr_disconnectReason_identifiedChannelDoesNotExist,
      'cdr_disconnectReason_aSuspendedCallExistsButThisCallIdentityDoesNot' =>
        cdr_disconnectReason_aSuspendedCallExistsButThisCallIdentityDoesNot,
      'cdr_disconnectReason_callIdentityInUse' =>
        cdr_disconnectReason_callIdentityInUse,
      'cdr_disconnectReason_noCallSuspended' =>
        cdr_disconnectReason_noCallSuspended,
      'cdr_disconnectReason_callHavingTheRequestedCallIdentityHasBeenCleared' =>
        cdr_disconnectReason_callHavingTheRequestedCallIdentityHasBeenCleared,
      'cdr_disconnectReason_calledUserNotMemberOfCug' =>
        cdr_disconnectReason_calledUserNotMemberOfCug,
      'cdr_disconnectReason_incompatibleDestination' =>
        cdr_disconnectReason_incompatibleDestination,
      'cdr_disconnectReason_nonExistentAbbreviatedAddressEntry' =>
        cdr_disconnectReason_nonExistentAbbreviatedAddressEntry,
      'cdr_disconnectReason_destinationAddressMissingAndDirectCallNotSubscribed' =>
        cdr_disconnectReason_destinationAddressMissingAndDirectCallNotSubscribed,
      'cdr_disconnectReason_invalidTransitNetworkSelectionNationalUse' =>
        cdr_disconnectReason_invalidTransitNetworkSelectionNationalUse,
      'cdr_disconnectReason_invalidFacilityParameter' =>
        cdr_disconnectReason_invalidFacilityParameter,
      'cdr_disconnectReason_mandatoryInformationElementIsMissingAalParameterIsNotSupported' =>
        cdr_disconnectReason_mandatoryInformationElementIsMissingAalParameterIsNotSupported,
      'cdr_disconnectReason_invalidMessageUnspecified' =>
        cdr_disconnectReason_invalidMessageUnspecified,
      'cdr_disconnectReason_mandatoryInformationElementIsMissing' =>
        cdr_disconnectReason_mandatoryInformationElementIsMissing,
      'cdr_disconnectReason_messageTypeNonExistentOrNotImplemented' =>
        cdr_disconnectReason_messageTypeNonExistentOrNotImplemented,
      'cdr_disconnectReason_messageNotCompatibleWithCallStateOrMessageTypeNonExistentOrNotImplemented' =>
        cdr_disconnectReason_messageNotCompatibleWithCallStateOrMessageTypeNonExistentOrNotImplemented,
      'cdr_disconnectReason_informationElementNonexistantOrNotImplemented' =>
        cdr_disconnectReason_informationElementNonexistantOrNotImplemented,
      'cdr_disconnectReason_invalidInformationElementContents' =>
        cdr_disconnectReason_invalidInformationElementContents,
      'cdr_disconnectReason_messageNotCompatibleWithCallState' =>
        cdr_disconnectReason_messageNotCompatibleWithCallState,
      'cdr_disconnectReason_recoveryOnTimerExpiry' =>
        cdr_disconnectReason_recoveryOnTimerExpiry,
      'cdr_disconnectReason_parameterNonExistentOrNotImplementedPassedOn' =>
        cdr_disconnectReason_parameterNonExistentOrNotImplementedPassedOn,
      'cdr_disconnectReason_urecognizedParameterMessageDiscarded' =>
        cdr_disconnectReason_urecognizedParameterMessageDiscarded,
      'cdr_disconnectReason_protocolErrorUnspecified' =>
        cdr_disconnectReason_protocolErrorUnspecified,
      'cdr_disconnectReason_internetworkingUnspecified' =>
        cdr_disconnectReason_internetworkingUnspecified,
      'cdr_disconnectReason_nextNodeIsUnreachable' =>
        cdr_disconnectReason_nextNodeIsUnreachable,
      'cdr_disconnectReason_holstTelephonyServiceProviderModuleHtspmIsOutOfService' =>
        cdr_disconnectReason_holstTelephonyServiceProviderModuleHtspmIsOutOfService,
      'cdr_disconnectReason_dtlTransitIsNotMyNodeId' =>
        cdr_disconnectReason_dtlTransitIsNotMyNodeId,
      'devTools_AppBarTitle' => devTools_AppBarTitle,
      'devTools_signalingService_groupTitle' =>
        devTools_signalingService_groupTitle,
      'devTools_signalingService_simulateKill_title' =>
        devTools_signalingService_simulateKill_title,
      'devTools_signalingService_simulateKill_subtitle' =>
        devTools_signalingService_simulateKill_subtitle,
      'devTools_signalingService_simulateKill_confirmMessage' =>
        devTools_signalingService_simulateKill_confirmMessage,
      'devTools_signalingService_simulateKill_confirm' =>
        devTools_signalingService_simulateKill_confirm,
      'devTools_signalingService_simulateKill_cancel' =>
        devTools_signalingService_simulateKill_cancel,
      'agoTicker_daysAgo' => switch (args) {
        [final int days] => agoTicker_daysAgo(days),
        _ => throw ArgumentError('agoTicker_daysAgo requires 1 arguments'),
      },
      'agoTicker_hoursAgo' => switch (args) {
        [final int hours] => agoTicker_hoursAgo(hours),
        _ => throw ArgumentError('agoTicker_hoursAgo requires 1 arguments'),
      },
      'agoTicker_minutesAgo' => switch (args) {
        [final int minutes] => agoTicker_minutesAgo(minutes),
        _ => throw ArgumentError('agoTicker_minutesAgo requires 1 arguments'),
      },
      'agoTicker_secondsAgo' => switch (args) {
        [final num seconds] => agoTicker_secondsAgo(seconds),
        _ => throw ArgumentError('agoTicker_secondsAgo requires 1 arguments'),
      },
      'contacts_ContactTile_inCall' => switch (args) {
        [final Object destination] => contacts_ContactTile_inCall(destination),
        _ => throw ArgumentError(
          'contacts_ContactTile_inCall requires 1 arguments',
        ),
      },
      'default_UnknownExceptionError' => switch (args) {
        [final String error] => default_UnknownExceptionError(error),
        _ => throw ArgumentError(
          'default_UnknownExceptionError requires 1 arguments',
        ),
      },
      'diagnosticNetworkTestItem_subtitle_publicIps' => switch (args) {
        [final String ips] => diagnosticNetworkTestItem_subtitle_publicIps(ips),
        _ => throw ArgumentError(
          'diagnosticNetworkTestItem_subtitle_publicIps requires 1 arguments',
        ),
      },
      'favorites_SnackBar_deleted' => switch (args) {
        [final String name] => favorites_SnackBar_deleted(name),
        _ => throw ArgumentError(
          'favorites_SnackBar_deleted requires 1 arguments',
        ),
      },
      'formatPhone' => switch (args) {
        [final String style, final String main, final String ext] =>
          formatPhone(style, main, ext),
        _ => throw ArgumentError('formatPhone requires 3 arguments'),
      },
      'login_Button_otpSigninVerifyRepeatInterval' => switch (args) {
        [final int seconds] => login_Button_otpSigninVerifyRepeatInterval(
          seconds,
        ),
        _ => throw ArgumentError(
          'login_Button_otpSigninVerifyRepeatInterval requires 1 arguments',
        ),
      },
      'login_Button_signupVerifyRepeatInterval' => switch (args) {
        [final int seconds] => login_Button_signupVerifyRepeatInterval(seconds),
        _ => throw ArgumentError(
          'login_Button_signupVerifyRepeatInterval requires 1 arguments',
        ),
      },
      'login_CoreVersionUnsupportedExceptionError' => switch (args) {
        [final String actual, final String supportedConstraint] =>
          login_CoreVersionUnsupportedExceptionError(
            actual,
            supportedConstraint,
          ),
        _ => throw ArgumentError(
          'login_CoreVersionUnsupportedExceptionError requires 2 arguments',
        ),
      },
      'login_Text_coreUrlAssignPostDescription' => switch (args) {
        [final Object email] => login_Text_coreUrlAssignPostDescription(email),
        _ => throw ArgumentError(
          'login_Text_coreUrlAssignPostDescription requires 1 arguments',
        ),
      },
      'login_Text_otpSigninVerifyPostDescriptionFromEmail' => switch (args) {
        [final String email] =>
          login_Text_otpSigninVerifyPostDescriptionFromEmail(email),
        _ => throw ArgumentError(
          'login_Text_otpSigninVerifyPostDescriptionFromEmail requires 1 arguments',
        ),
      },
      'login_Text_otpSigninVerifyPreDescriptionUserRef' => switch (args) {
        [final String userRef] =>
          login_Text_otpSigninVerifyPreDescriptionUserRef(userRef),
        _ => throw ArgumentError(
          'login_Text_otpSigninVerifyPreDescriptionUserRef requires 1 arguments',
        ),
      },
      'login_Text_signupVerifyPostDescriptionFromEmail' => switch (args) {
        [final String email] => login_Text_signupVerifyPostDescriptionFromEmail(
          email,
        ),
        _ => throw ArgumentError(
          'login_Text_signupVerifyPostDescriptionFromEmail requires 1 arguments',
        ),
      },
      'login_Text_signupVerifyPreDescriptionEmail' => switch (args) {
        [final String email] => login_Text_signupVerifyPreDescriptionEmail(
          email,
        ),
        _ => throw ArgumentError(
          'login_Text_signupVerifyPreDescriptionEmail requires 1 arguments',
        ),
      },
      'logRecordsConsole_Text_recordsCountHint' => switch (args) {
        [final int count] => logRecordsConsole_Text_recordsCountHint(count),
        _ => throw ArgumentError(
          'logRecordsConsole_Text_recordsCountHint requires 1 arguments',
        ),
      },
      'main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError' =>
        switch (args) {
          [final String actual, final String supportedConstraint] =>
            main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(
              actual,
              supportedConstraint,
            ),
          _ => throw ArgumentError(
            'main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError requires 2 arguments',
          ),
        },
      'messaging_ConversationBuilders_contactExtension' => switch (args) {
        [final String extension] =>
          messaging_ConversationBuilders_contactExtension(extension),
        _ => throw ArgumentError(
          'messaging_ConversationBuilders_contactExtension requires 1 arguments',
        ),
      },
      'notifications_errorSnackBar_signalingDisconnectWithCodeName' =>
        switch (args) {
          [final String codeName] =>
            notifications_errorSnackBar_signalingDisconnectWithCodeName(
              codeName,
            ),
          _ => throw ArgumentError(
            'notifications_errorSnackBar_signalingDisconnectWithCodeName requires 1 arguments',
          ),
        },
      'notifications_errorSnackBar_signalingDisconnectWithSystemReason' =>
        switch (args) {
          [final String reason] =>
            notifications_errorSnackBar_signalingDisconnectWithSystemReason(
              reason,
            ),
          _ => throw ArgumentError(
            'notifications_errorSnackBar_signalingDisconnectWithSystemReason requires 1 arguments',
          ),
        },
      'notifications_errorSnackBar_emergencyNumber' => switch (args) {
        [final String number] => notifications_errorSnackBar_emergencyNumber(
          number,
        ),
        _ => throw ArgumentError(
          'notifications_errorSnackBar_emergencyNumber requires 1 arguments',
        ),
      },
      'notifications_errorSnackBar_sipRegistrationFailed_WithSystemReason' =>
        switch (args) {
          [final String reason] =>
            notifications_errorSnackBar_sipRegistrationFailed_WithSystemReason(
              reason,
            ),
          _ => throw ArgumentError(
            'notifications_errorSnackBar_sipRegistrationFailed_WithSystemReason requires 1 arguments',
          ),
        },
      'numberActions_callFrom' => switch (args) {
        [final String number] => numberActions_callFrom(number),
        _ => throw ArgumentError('numberActions_callFrom requires 1 arguments'),
      },
      'presence_infoView_source' => switch (args) {
        [final Object source] => presence_infoView_source(source),
        _ => throw ArgumentError(
          'presence_infoView_source requires 1 arguments',
        ),
      },
      'recents_BodyCenter_empty' => switch (args) {
        [final Object filter] => recents_BodyCenter_empty(filter),
        _ => throw ArgumentError(
          'recents_BodyCenter_empty requires 1 arguments',
        ),
      },
      'recents_snackBar_deleted' => switch (args) {
        [final String name] => recents_snackBar_deleted(name),
        _ => throw ArgumentError(
          'recents_snackBar_deleted requires 1 arguments',
        ),
      },
      'recentTimeAfterMidnight' => switch (args) {
        [final DateTime time] => recentTimeAfterMidnight(time),
        _ => throw ArgumentError(
          'recentTimeAfterMidnight requires 1 arguments',
        ),
      },
      'recentTimeBeforeMidnight' => switch (args) {
        [final DateTime time] => recentTimeBeforeMidnight(time),
        _ => throw ArgumentError(
          'recentTimeBeforeMidnight requires 1 arguments',
        ),
      },
      'socketError_defaultDescription' => switch (args) {
        [final int? errorCode] => socketError_defaultDescription(errorCode),
        _ => throw ArgumentError(
          'socketError_defaultDescription requires 1 arguments',
        ),
      },
      'user_agreement_checkbox_text' => switch (args) {
        [final Object url] => user_agreement_checkbox_text(url),
        _ => throw ArgumentError(
          'user_agreement_checkbox_text requires 1 arguments',
        ),
      },
      'user_agreement_description' => switch (args) {
        [final Object appName] => user_agreement_description(appName),
        _ => throw ArgumentError(
          'user_agreement_description requires 1 arguments',
        ),
      },
      'webview_defaultError_details' => switch (args) {
        [final String description, final int code] =>
          webview_defaultError_details(description, code),
        _ => throw ArgumentError(
          'webview_defaultError_details requires 2 arguments',
        ),
      },
      _ => null,
    };
  }

  String? parseL10n(String translationKey, {List<Object>? arguments}) {
    final result = lookupKey(translationKey, arguments);
    if (result == null) {
      return null;
    }
    return result as String;
  }
}
