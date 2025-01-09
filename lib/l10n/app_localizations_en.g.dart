import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get account_selfCarePasswordExpired_message => 'Your self-care password has expired. Please update it using your self-care.\nUntil the password is changed, access to the service will be limited.';

  @override
  String get alertDialogActions_no => 'No';

  @override
  String get alertDialogActions_ok => 'Ok';

  @override
  String get alertDialogActions_yes => 'Yes';

  @override
  String get autoprovision_errorSnackBar_invalidToken => 'The autoconfiguration credentials were rejected by the server. Please request a new configuration link';

  @override
  String get autoprovision_ReloginDialog_confirm => 'Confirm';

  @override
  String get autoprovision_ReloginDialog_decline => 'Decline';

  @override
  String get autoprovision_ReloginDialog_text => 'Do you want to use the new authentication credentials provided in the link? You will be logged out from the current session.';

  @override
  String get autoprovision_ReloginDialog_title => 'Relogin Confirmation';

  @override
  String get autoprovision_successSnackBar_used => 'Successfully retrieved your settings, your app is ready to use';

  @override
  String get call_CallActionsTooltip_accept => 'Accept';

  @override
  String get call_CallActionsTooltip_accept_inviteToAttendedTransfer => 'Accept transfer';

  @override
  String get call_CallActionsTooltip_attended_transfer => 'Attended transfer';

  @override
  String get call_CallActionsTooltip_decline_inviteToAttendedTransfer => 'Decline transfer';

  @override
  String get call_CallActionsTooltip_disableCamera => 'Disable camera';

  @override
  String get call_CallActionsTooltip_disableSpeaker => 'Disable speakerphone';

  @override
  String get call_CallActionsTooltip_enableCamera => 'Enable camera';

  @override
  String get call_CallActionsTooltip_enableSpeaker => 'Enable speakerphone';

  @override
  String get call_CallActionsTooltip_hangup => 'Hangup';

  @override
  String get call_CallActionsTooltip_hangupAndAccept => 'Hangup & Accept';

  @override
  String get call_CallActionsTooltip_hideKeypad => 'Hide keypad';

  @override
  String get call_CallActionsTooltip_hold => 'Hold call';

  @override
  String get call_CallActionsTooltip_holdAndAccept => 'Hold & Accept';

  @override
  String get call_CallActionsTooltip_mute => 'Mute microphone';

  @override
  String get call_CallActionsTooltip_showKeypad => 'Show keypad';

  @override
  String get call_CallActionsTooltip_swap => 'Swap calls';

  @override
  String get call_CallActionsTooltip_transfer => 'Transfer';

  @override
  String get call_CallActionsTooltip_transfer_choose => 'Choose number';

  @override
  String get call_CallActionsTooltip_unattended_transfer => 'Unattended transfer';

  @override
  String get call_CallActionsTooltip_unhold => 'Unhold call';

  @override
  String get call_CallActionsTooltip_unmute => 'Unmute microphone';

  @override
  String get call_description_held => 'On hold';

  @override
  String get call_description_incoming => 'Incoming call';

  @override
  String get call_description_inviteToAttendedTransfer => 'You\'ve been invited to join an attended transfer call';

  @override
  String get call_description_outgoing => 'Outgoing call';

  @override
  String get call_description_requestToAttendedTransfer => 'Transfer request';

  @override
  String get call_description_transferProcessing => 'Transfer processing';

  @override
  String get call_FailureAcknowledgeDialog_title => 'Failure';

  @override
  String get callProcessingStatus_answering => 'Answering the call, please hold on…';

  @override
  String get callProcessingStatus_disconnecting => 'Disconnecting the call, please hold on…';

  @override
  String get callStatus_appUnregistered => 'Unregistered';

  @override
  String get callStatus_connectError => 'Connection error';

  @override
  String get callStatus_connectIssue => 'Connection issue';

  @override
  String get callStatus_connectivityNone => 'No internet connection';

  @override
  String get callStatus_inProgress => 'Connection in progress';

  @override
  String get callStatus_ready => 'Connection established';

  @override
  String get call_ThumbnailAvatar_currentlyNoActiveCall => 'Currently, there is no active call';

  @override
  String get common_noInternetConnection_message => 'It seems you are not connected to the internet. Please check your connection and try again.';

  @override
  String get common_noInternetConnection_retryButton => 'Try Again';

  @override
  String get common_noInternetConnection_title => 'No Internet Connection';

  @override
  String get common_problemWithLoadingPage => 'There was an issue loading the page.';

  @override
  String get contacts_ExternalTabButton_refresh => 'Refresh';

  @override
  String get contacts_ExternalTabText_empty => 'No contacts';

  @override
  String get contacts_ExternalTabText_emptyOnSearching => 'No contacts found';

  @override
  String get contacts_ExternalTabText_failure => 'Failed to get cloud PBX contacts';

  @override
  String get contacts_LocalTabButton_openAppSettings => 'Grant access to your phone contacts';

  @override
  String get contacts_LocalTabButton_refresh => 'Refresh';

  @override
  String get contacts_LocalTabText_empty => 'No contacts';

  @override
  String get contacts_LocalTabText_emptyOnSearching => 'No contacts found';

  @override
  String get contacts_LocalTabText_failure => 'Failed to get your phone contacts';

  @override
  String get contacts_LocalTabText_permissionFailure => 'There are no permissions to get your phone contacts';

  @override
  String get contactsSourceExternal => 'Cloud PBX';

  @override
  String get contactsSourceLocal => 'Your phone';

  @override
  String get contacts_Text_blingTransferInitiated => 'Performing blind transfer';

  @override
  String get copyToClipboard_floatingSnackBar => 'Text copied';

  @override
  String get copyToClipboard_popupMenuItem => 'Copy to clipboard';

  @override
  String get default_CannotRemoveOwnerMessagingSocketException => 'Cannot remove owner';

  @override
  String get default_ChatMemberNotFoundMessagingSocketException => 'Chat member not found';

  @override
  String get default_ChatNotFoundMessagingSocketException => 'Chat not found';

  @override
  String get default_ClientExceptionError => 'A HTTP client issue occurred';

  @override
  String get default_ErrorDetails => 'Details';

  @override
  String get default_ErrorMessage => 'Error message';

  @override
  String get default_ErrorPath => 'Error path';

  @override
  String get default_ErrorTransactionId => 'Transaction ID';

  @override
  String get default_ForbiddenMessagingSocketException => 'Forbidden request';

  @override
  String get default_FormatExceptionError => 'A response format issue occurred';

  @override
  String get default_InternalErrorMessagingSocketException => 'Internal server error';

  @override
  String get default_InvalidChatTypeMessagingSocketException => 'Invalid chat type';

  @override
  String get default_MessagingSocketException => 'An error occurred while processing the request';

  @override
  String get default_JoinCrashedMessagingSocketException => 'Error occurred while joining the conversation';

  @override
  String get default_RequestFailureError => 'A server failure occurred';

  @override
  String get default_SelfAuthorityAssignmentForbiddenMessagingSocketException => 'Self authority assignment is forbidden';

  @override
  String get default_SelfRemovalForbiddenMessagingSocketException => 'Self removal is forbidden';

  @override
  String get default_SmsConversationNotFoundMessagingSocketException => 'SMS conversation not found';

  @override
  String get default_SocketExceptionError => 'A network issue occurred';

  @override
  String get default_TimeoutExceptionError => 'A server timeout occurred';

  @override
  String get default_TimeoutMessagingSocketException => 'The request has timed out';

  @override
  String get default_TlsExceptionError => 'A secure network protocol (TLS/SSL) issue occurred';

  @override
  String get default_TypeErrorError => 'A response issue occurred';

  @override
  String get default_UnauthorizedMessagingSocketException => 'Unauthorized request';

  @override
  String get default_UnauthorizedRequestFailureError => 'An unauthorized request failure occurred';

  @override
  String get default_UserAlreadyInChatMessagingSocketException => 'User is already in chat';

  @override
  String get diagnostic_AppBar_title => 'Diagnostic';

  @override
  String get diagnostic_battery_groupTitle => 'Battery';

  @override
  String get diagnostic_batteryMode_optimized_description => 'The app\'s background activity is managed by the system to save the battery. It may not work correctly with incoming calls triggered by push notifications.';

  @override
  String get diagnostic_batteryMode_optimized_title => 'Optimized';

  @override
  String get diagnostic_batteryMode_restricted_description => 'The app\'s background activity is heavily restricted to conserve the battery. Incoming calls may be missed.';

  @override
  String get diagnostic_batteryMode_restricted_title => 'Restricted';

  @override
  String get diagnostic_batteryMode_unknown_description => 'The battery mode status is unknown. The app might have unpredictable behavior.';

  @override
  String get diagnostic_batteryMode_unknown_title => 'Unknown';

  @override
  String get diagnostic_batteryMode_unrestricted_description => 'The app has full access to run in the background without restrictions.';

  @override
  String get diagnostic_batteryMode_unrestricted_title => 'Unrestricted';

  @override
  String get diagnostic_battery_navigate_section => 'Navigate to the Battery section';

  @override
  String get diagnostic_battery_tile_title => 'Battery mode';

  @override
  String get diagnostic_permission_camera_description => 'This app requires permission to access the camera to make video calls.';

  @override
  String get diagnostic_permission_camera_title => 'Camera';

  @override
  String get diagnostic_permission_contacts_description => 'This app requires permission to access contacts to make calls within your address book.';

  @override
  String get diagnostic_permission_contacts_title => 'Contacts';

  @override
  String get diagnosticPermissionDetails_button_managePermission => 'Manage Permission';

  @override
  String get diagnosticPermissionDetails_button_requestPermission => 'Request Permission';

  @override
  String get diagnosticPermissionDetails_title_statusPermission => 'Status permission';

  @override
  String get diagnostic_permission_microphone_description => 'This app requires permission to access the microphone to make audio calls.';

  @override
  String get diagnostic_permission_microphone_title => 'Microphone';

  @override
  String get diagnostic_permission_notification_description => 'Enables the app to trigger incoming call.';

  @override
  String get diagnostic_permission_notification_title => 'Notification';

  @override
  String get diagnostic_permissionStatus_denied => 'Access Denied';

  @override
  String get diagnostic_permissionStatus_granted => 'Access Granted';

  @override
  String get diagnostic_permissionStatus_limited => 'Limited Access';

  @override
  String get diagnostic_permissionStatus_permanentlyDenied => 'Access Permanently Denied';

  @override
  String get diagnostic_permissionStatus_provisional => 'Provisional Access';

  @override
  String get diagnostic_permissionStatus_restricted => 'Restricted Access';

  @override
  String get diagnosticPushDetails_configuration_title => 'Push Notification service configuration';

  @override
  String get diagnosticPushDetails_errorMessage_intro => 'Some steps to try:\n';

  @override
  String get diagnosticPushDetails_errorMessage_step1 => '1. Ensure your phone is connected to the internet.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step2 => '2. If connected, check that your phone can access Google services by visiting a website.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step3 => '3. Wait a few minutes and try again – Firebase messaging servers may be temporarily down.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step4 => '4. Restart Google Play services to ensure they are functioning correctly.\n';

  @override
  String get diagnosticPushDetails_errorMessage_step5 => '5. Verify that Google Play services are installed on your device.\n';

  @override
  String get diagnosticPushDetails_successMessage => 'The notification service is successfully configured and ready for use to receive messages and handle incoming calls.';

  @override
  String get diagnostic_pushTokenStatusType_progress => 'In progress';

  @override
  String get diagnostic_pushTokenStatusType_success => 'Service successfully configured';

  @override
  String get diagnosticScreen_permissionsGroup_title => 'Permissions';

  @override
  String get diagnosticScreen_pushNotificationService_title => 'Push notification service';

  @override
  String get favorites_BodyCenter_empty => 'Currently, you have no favorite numbers.\nAdd favorites from Contacts using the star icon';

  @override
  String get favorites_DeleteConfirmDialog_content => 'Are you sure you want to delete the current favorite number?';

  @override
  String get favorites_DeleteConfirmDialog_title => 'Confirm deleting';

  @override
  String favorites_SnackBar_deleted(String name) {
    return '$name deleted';
  }

  @override
  String get favorites_Text_blingTransferInitiated => 'Performing blind transfer';

  @override
  String get locale_default => 'Default';

  @override
  String get locale_en => 'English';

  @override
  String get locale_it => 'Italian';

  @override
  String get locale_uk => 'Ukrainian';

  @override
  String get login_Button_coreUrlAssignProceed => 'Proceed';

  @override
  String get login_Button_otpSigninRequestProceed => 'Proceed';

  @override
  String get login_Button_otpSigninVerifyProceed => 'Verify';

  @override
  String get login_Button_otpSigninVerifyRepeat => 'Resend the code';

  @override
  String login_Button_otpSigninVerifyRepeatInterval(int seconds) {
    return 'Resend the code ($seconds s)';
  }

  @override
  String get login_Button_passwordSigninProceed => 'Proceed';

  @override
  String get login_Button_signIn => 'Sign in';

  @override
  String get login_Button_signupRequestProceed => 'Proceed';

  @override
  String get login_Button_signUpToDemoInstance => 'Sign up';

  @override
  String get login_Button_signupVerifyProceed => 'Verify';

  @override
  String get login_Button_signupVerifyRepeat => 'Resend the code';

  @override
  String login_Button_signupVerifyRepeatInterval(int seconds) {
    return 'Resend the code ($seconds s)';
  }

  @override
  String get login_ButtonTooltip_signInToYourInstance => 'Sign in to your WebTrit Cloud Backend';

  @override
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'An incompatible instance version provided, please contact the administrator of your system (actual: $actual, supported: $supportedConstraint)';
  }

  @override
  String get login_RequestFailureEmptyEmailError => 'Cannot send the verification code';

  @override
  String get login_RequestFailureIdentifierIsNotValid => 'The identifier is invalid or does not exist';

  @override
  String get login_RequestFailureIncorrectOtpCodeError => 'Incorrect verification code';

  @override
  String get login_RequestFailureOtpAlreadyVerifiedError => 'Verification already verified';

  @override
  String get login_RequestFailureOtpExpiredError => 'Verification expired';

  @override
  String get login_RequestFailureOtpNotFoundError => 'Verification not found';

  @override
  String get login_RequestFailureOtpVerificationAttemptsExceededError => 'Verification attempts exceeded';

  @override
  String get login_RequestFailureParametersApplyIssueError => 'Provided data can\'t be processed';

  @override
  String get login_RequestFailurePhoneNotFoundError => 'Phone number not found';

  @override
  String get login_RequestFailureUnconfiguredBundleIdError => 'The app is not supported by your WebTrit Cloud Backend';

  @override
  String get login_SupportedLoginTypeMissedExceptionError => 'The current WebTrit Cloud Backend does not support any login types compatible with this app';

  @override
  String login_Text_coreUrlAssignPostDescription(Object email) {
    return 'If you do not yet have your own WebTrit Cloud Backend - contact sales team $email.';
  }

  @override
  String get login_Text_coreUrlAssignPreDescription => 'In order to make calls via your own VoIP system please enter the URL of WebTrit Cloud Backend (as it was provided to you by your account manager) below.';

  @override
  String get login_TextFieldLabelText_coreUrlAssign => 'Enter your WebTrit Cloud Backend URL';

  @override
  String get login_TextFieldLabelText_otpSigninCode => 'Enter the verification code';

  @override
  String get login_TextFieldLabelText_otpSigninUserRef => 'Enter your phone number or email';

  @override
  String get login_TextFieldLabelText_passwordSigninPassword => 'Enter your password';

  @override
  String get login_TextFieldLabelText_passwordSigninUserRef => 'Enter your phone number or email';

  @override
  String get login_TextFieldLabelText_signupCode => 'Enter the verification code';

  @override
  String get login_TextFieldLabelText_signupEmail => 'Enter your email';

  @override
  String get login_Text_otpSigninRequestPostDescription => '';

  @override
  String get login_Text_otpSigninRequestPreDescription => '';

  @override
  String login_Text_otpSigninVerifyPostDescriptionFromEmail(String email) {
    return 'If you do not see an email with the verification code from $email in your inbox, please check your spam folder.';
  }

  @override
  String get login_Text_otpSigninVerifyPostDescriptionGeneral => 'If you do not see an email with the verification code in your inbox, please check your spam folder.';

  @override
  String login_Text_otpSigninVerifyPreDescriptionUserRef(String userRef) {
    return 'A one-time verification code was sent to the email assigned to provided phone number or email.';
  }

  @override
  String get login_Text_passwordSigninPostDescription => '';

  @override
  String get login_Text_passwordSigninPreDescription => '';

  @override
  String get login_Text_signupRequestPostDescription => '';

  @override
  String get login_Text_signupRequestPostDescriptionDemo => 'If you do not have an account yet, it will be automatically created for you';

  @override
  String get login_Text_signupRequestPreDescription => '';

  @override
  String get login_Text_signupRequestPreDescriptionDemo => '';

  @override
  String login_Text_signupVerifyPostDescriptionFromEmail(String email) {
    return 'If you do not see an email with the verification code from $email in your inbox, please check your spam folder.';
  }

  @override
  String get login_Text_signupVerifyPostDescriptionGeneral => 'If you do not see an email with the verification code in your inbox, please check your spam folder.';

  @override
  String login_Text_signupVerifyPreDescriptionEmail(String email) {
    return 'A one-time verification code was sent to $email.';
  }

  @override
  String get loginType_otpSignin => 'OTP sign in';

  @override
  String get loginType_passwordSignin => 'Password sign in';

  @override
  String get loginType_signup => 'Sign up';

  @override
  String get login_validationCoreUrlError => 'Please enter a valid URL';

  @override
  String get login_validationEmailError => 'Please enter a valid email';

  @override
  String get login_validationPhoneError => 'Please enter a valid phone number';

  @override
  String get login_validationUserRefError => 'Please enter a valid phone number or email';

  @override
  String get logRecordsConsole_AppBarTitle => 'Log Console';

  @override
  String get logRecordsConsole_Button_failureRefresh => 'Refresh';

  @override
  String get logRecordsConsole_Text_failure => 'An unexpected error occurred';

  @override
  String get main_BottomNavigationBarItemLabel_chats => 'Chats';

  @override
  String get main_BottomNavigationBarItemLabel_contacts => 'Contacts';

  @override
  String get main_BottomNavigationBarItemLabel_favorites => 'Favorites';

  @override
  String get main_BottomNavigationBarItemLabel_keypad => 'Keypad';

  @override
  String get main_BottomNavigationBarItemLabel_recents => 'Recents';

  @override
  String get main_CompatibilityIssueDialogActions_logout => 'Logout';

  @override
  String get main_CompatibilityIssueDialogActions_update => 'Update';

  @override
  String main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Incompatible WebTrit Cloud Backend version, please contact the administrator of your system.\n\nInstance version:\n$actual\n\nSupported version:\n$supportedConstraint';
  }

  @override
  String get main_CompatibilityIssueDialog_title => 'Compatibility issue';

  @override
  String get messaging_ActionBtn_retry => 'Retry';

  @override
  String get messaging_ChooseContact_cancel => 'Cancel';

  @override
  String get messaging_ChooseContact_empty => 'No contacts found';

  @override
  String get messaging_ChooseContact_title => 'Choose contact:';

  @override
  String get messaging_ConfirmDialog_ask => 'Are you sure?';

  @override
  String get messaging_ConfirmDialog_cancel => 'No';

  @override
  String get messaging_ConfirmDialog_confirm => 'Yes';

  @override
  String get messaging_ConversationBuilders_addUserBtnText => 'Add user';

  @override
  String get messaging_ConversationBuilders_back => 'Back';

  @override
  String get messaging_ConversationBuilders_back_action => 'Back';

  @override
  String get messaging_ConversationBuilders_cancel => 'Cancel';

  @override
  String get messaging_ConversationBuilders_connectionError => 'Connection error, please try later';

  @override
  String get messaging_ConversationBuilders_contactOrNumberSearch_hint => 'Enter name or phone number';

  @override
  String get messaging_ConversationBuilders_contactSearch_hint => 'Search contacts';

  @override
  String get messaging_ConversationBuilders_create => 'Create';

  @override
  String get messaging_ConversationBuilders_createGroup => 'Create group';

  @override
  String get messaging_ConversationBuilders_externalContacts_heading => 'Cloud PBX contacts';

  @override
  String get messaging_ConversationBuilders_groupNameHeadline => 'Group name';

  @override
  String get messaging_ConversationBuilders_invalidNumber_message1 => 'The contact has an invalid phone number. It should be in the format ';

  @override
  String get messaging_ConversationBuilders_invalidNumber_message2 => '. Please fix it in your phone book.';

  @override
  String get messaging_ConversationBuilders_invalidNumber_ok => 'Close';

  @override
  String get messaging_ConversationBuilders_invalidNumber_title => 'Invalid phone number';

  @override
  String get messaging_ConversationBuilders_invite_heading => 'Invite users:';

  @override
  String get messaging_ConversationBuilders_localContacts_heading => 'Local contacts';

  @override
  String get messaging_ConversationBuilders_membersHeadline => 'Members';

  @override
  String get messaging_ConversationBuilders_nameFieldEmpty => 'Please enter a group name';

  @override
  String get messaging_ConversationBuilders_nameFieldLabel => 'Group Name';

  @override
  String get messaging_ConversationBuilders_nameFieldShort => 'Group name must be at least 3 characters';

  @override
  String get messaging_ConversationBuilders_next_action => 'Next';

  @override
  String get messaging_ConversationBuilders_noContacts => 'There are no contacts matching the search result';

  @override
  String get messaging_ConversationBuilders_numberFormatExample => '+ [country code] [area/operator code] [subscriber number]';

  @override
  String get messaging_ConversationBuilders_numberSearch_errorError => 'The entered phone number is invalid. It should be entered in the format: ';

  @override
  String get messaging_ConversationBuilders_numberSearch_errorHint => 'Phone number format: ';

  @override
  String get messaging_ConversationBuilders_submitBtnText => 'Submit';

  @override
  String get messaging_ConversationBuilders_submitError => 'Error happened while creating group, please try again';

  @override
  String get messaging_ConversationBuilders_title_group => 'Create group';

  @override
  String get messaging_ConversationBuilders_title_new => 'New chat';

  @override
  String get messaging_Conversation_failure => 'Conversation load error';

  @override
  String get messaging_ConversationScreen_titlePrefix => 'Dialog:';

  @override
  String get messaging_ConversationsScreen_chatsSearch_hint => 'Enter chat or user name';

  @override
  String get messaging_ConversationsScreen_empty => 'No conversations started yet';

  @override
  String get messaging_ConversationsScreen_messages_title => 'Messages';

  @override
  String get messaging_ConversationsScreen_noNumberAlert_text => 'You need to have a phone number linked to you account to send SMS messages';

  @override
  String get messaging_ConversationsScreen_noNumberAlert_title => 'No phone number';

  @override
  String get messaging_ConversationsScreen_selectNumberSheet_title => 'Select a number';

  @override
  String get messaging_ConversationsScreen_smses_title => 'SMS';

  @override
  String get messaging_ConversationsScreen_smssSearch_hint => 'Enter phone number';

  @override
  String get messaging_ConversationsScreen_startDialog => 'Start dialog';

  @override
  String get messaging_ConversationsScreen_unsupported => 'Messaging is not supported by remote system, please contact your administrator to enable it';

  @override
  String get messaging_Conversations_tile_empty => 'No messages yet';

  @override
  String get messaging_Conversations_tile_you => 'You';

  @override
  String get messaging_DialogInfo_deleteAsk => 'Are you sure you want to delete this dialog?';

  @override
  String get messaging_DialogInfo_deleteBtn => 'Delete dialog';

  @override
  String get messaging_DialogInfo_title => 'Contact info';

  @override
  String get messaging_GroupAuthorities_moderator => 'moderator';

  @override
  String get messaging_GroupAuthorities_noauthorities => 'member';

  @override
  String get messaging_GroupAuthorities_owner => 'owner';

  @override
  String get messaging_GroupInfo_addUserBtnText => 'Add user';

  @override
  String get messaging_GroupInfo_deleteLeaveBtnText => 'Delete and leave';

  @override
  String get messaging_GroupInfo_groupMembersHeadline => 'Group members';

  @override
  String get messaging_GroupInfo_leaveAndDeleteAsk => 'Are you sure you want leave and delete this group?';

  @override
  String get messaging_GroupInfo_leaveAsk => 'Are you sure you want to leave this group?';

  @override
  String get messaging_GroupInfo_leaveBtnText => 'Leave group';

  @override
  String get messaging_GroupInfo_makeModeratorAsk => 'Are you sure you want to make this user a moderator?';

  @override
  String get messaging_GroupInfo_makeModeratorBtnText => 'Make moderator';

  @override
  String get messaging_GroupInfo_removeModeratorAsk => 'Are you sure you want to remove this user from moderators?';

  @override
  String get messaging_GroupInfo_removeUserAsk => 'Are you sure you want to remove this user from the group?';

  @override
  String get messaging_GroupInfo_removeUserBtnText => 'Remove';

  @override
  String get messaging_GroupInfo_title => 'Group info';

  @override
  String get messaging_GroupInfo_titlePrefix => 'Group:';

  @override
  String get messaging_GroupInfo_unmakeModeratorBtnText => 'Unmake moderator';

  @override
  String get messaging_GroupNameDialog_cancelBtnText => 'Cancel';

  @override
  String get messaging_GroupNameDialog_fieldHint => 'Enter group name';

  @override
  String get messaging_GroupNameDialog_fieldLabel => 'Group name';

  @override
  String get messaging_GroupNameDialog_fieldValidation_empty => 'Please enter group name';

  @override
  String get messaging_GroupNameDialog_fieldValidation_short => 'Group name is too short';

  @override
  String get messaging_GroupNameDialog_saveBtnText => 'Save';

  @override
  String get messaging_GroupNameDialog_title => 'Group name';

  @override
  String get messaging_GroupScreen_titlePrefix => 'Group:';

  @override
  String get messaging_MessageField_hint => 'Type a message';

  @override
  String get messaging_MessageListView_typingTrail => 'is typing...';

  @override
  String get messaging_MessageView_delete => 'Delete';

  @override
  String get messaging_MessageView_deleted => '[deleted]';

  @override
  String get messaging_MessageView_edit => 'Edit';

  @override
  String get messaging_MessageView_edited => '[edited]';

  @override
  String get messaging_MessageView_forward => 'Forward';

  @override
  String get messaging_MessageView_forwarded => '[forwarded]';

  @override
  String get messaging_MessageView_reply => 'Reply';

  @override
  String get messaging_MessageView_textcopy => 'Copy to clipboard';

  @override
  String get messaging_NewConversation_createGroup => '';

  @override
  String get messaging_NewConversation_title => '';

  @override
  String get messaging_ParticipantName_you => 'You';

  @override
  String get messaging_SmsSendingStatus_delivered => 'delivered';

  @override
  String get messaging_SmsSendingStatus_failed => 'failed';

  @override
  String get messaging_SmsSendingStatus_sent => 'sent';

  @override
  String get messaging_SmsSendingStatus_waiting => 'waiting';

  @override
  String get messaging_StateBar_connecting => 'CONNECTING';

  @override
  String get messaging_StateBar_error => 'DISCONNECTED';

  @override
  String get messaging_StateBar_initializing => 'INITIALIZING';

  @override
  String get notifications_errorSnackBarAction_callUserMedia => 'Check';

  @override
  String get notifications_errorSnackBar_activeLineBlindTransferWarning => 'You are already on the line with the recipient you are trying to blind transfer to';

  @override
  String get notifications_errorSnackBar_appOffline => 'Your application is currently offline';

  @override
  String get notifications_errorSnackBar_appOnline => 'Your application is online';

  @override
  String get notifications_errorSnackBar_appUnregistered => 'Sorry, your application is currently disconnected from the WebTrit core servers and hence can\'t call right now. Please go to the settings page, and slide the online status toggle switch off and on again to reestablish the connection';

  @override
  String get notifications_errorSnackBar_callConnect => 'Connecting to the core failed, trying to reconnect';

  @override
  String get notifications_errorSnackBar_callSignalingClientNotConnect => 'Cannot initiate the call, please check the connection status';

  @override
  String get notifications_errorSnackBar_callSignalingClientSessionMissed => 'Authentication error, please re-login';

  @override
  String get notifications_errorSnackBar_callUndefinedLine => 'No idle lines to initiate the call';

  @override
  String get notifications_errorSnackBar_callUserMedia => 'No access to media input, please check app permissions';

  @override
  String get notifications_errorSnackBar_sipServiceUnavailable => 'Authentication error with the remote VoIP system';

  @override
  String get permission_Button_request => 'Continue';

  @override
  String get permission_manageFullScreenNotificationInstructions_step1 => 'Go to your phone\'s Settings.';

  @override
  String get permission_manageFullScreenNotificationInstructions_step2 => 'Navigate to \'Special App Access\' under the \'Apps & notifications\' section.';

  @override
  String get permission_manageFullScreenNotificationInstructions_step3 => 'Find and tap on \'Manage full screen intents\'.';

  @override
  String get permission_manageFullScreenNotificationInstructions_step4 => 'Select the app for which you want to manage full-screen notifications.';

  @override
  String get permission_manageFullScreenNotificationInstructions_step5 => 'Toggle the permission to enable or disable full-screen notifications for that app.';

  @override
  String get permission_manageFullScreenNotificationPermissions => 'Manage Full-Screen Notification Permissions';

  @override
  String get permission_manufacturer_Button_gotIt => 'Got it';

  @override
  String get permission_manufacturer_Button_toSettings => 'Open app Settings';

  @override
  String get permission_manufacturer_Text_heading => 'To ensure the best user experience, the app needs to be granted the following permissions manually:';

  @override
  String get permission_manufacturer_Text_trailing => 'Permissions could be changed at any time in the future.';

  @override
  String get permission_manufacturer_Text_xiaomi_tip1 => 'Go to \"App settings\" → \"Notifications\".';

  @override
  String get permission_manufacturer_Text_xiaomi_tip2 => 'Find and turn on \"Lockscreen notifications\".';

  @override
  String get permission_Text_description => 'To ensure the best user experience, the app needs to be granted the following permissions: microphone for audio calls, camera for video calls, and contacts to simplify reaching them from the app.\n\nPermissions could be changed at any time in the future.';

  @override
  String recents_BodyCenter_empty(Object filter) {
    return 'Currently you have no ${filter}recent calls.';
  }

  @override
  String get recents_DeleteConfirmDialog_content => 'Are you sure you want to delete the current call log?';

  @override
  String get recents_DeleteConfirmDialog_title => 'Confirm deleting';

  @override
  String get recents_HistoryTile_missedCallText => 'Missed';

  @override
  String recents_snackBar_deleted(String name) {
    return '$name deleted';
  }

  @override
  String get recents_Text_blingTransferInitiated => 'Performing blind transfer';

  @override
  String get recentsVisibilityFilter_all => 'All';

  @override
  String get recentsVisibilityFilter_all_preposit => 'all';

  @override
  String get recentsVisibilityFilter_incoming => 'Incoming';

  @override
  String get recentsVisibilityFilter_incoming_preposit => 'incoming';

  @override
  String get recentsVisibilityFilter_missed => 'Missed';

  @override
  String get recentsVisibilityFilter_missed_preposit => 'missed';

  @override
  String get recentsVisibilityFilter_outgoing => 'Outgoing';

  @override
  String get recentsVisibilityFilter_outgoing_preposit => 'outgoing';

  @override
  String recentTimeAfterMidnight(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat.yMd(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String recentTimeBeforeMidnight(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String get request_Id => 'Request id';

  @override
  String get request_StatusCode => 'Status code';

  @override
  String get sessionStatus_pushNotificationServiceProblem => 'Problem with configuration push notification service';

  @override
  String get settings_AboutText_AppSessionIdentifier => 'Application session identifier';

  @override
  String get settings_AboutText_AppVersion => 'App Version';

  @override
  String get settings_AboutText_CoreVersionUndefined => '?.?.?';

  @override
  String get settings_AboutText_FCMPushNotificationToken => 'FCM Push Notification Token';

  @override
  String get settings_AboutText_StoreVersion => 'Build version in the Store';

  @override
  String get settings_AccountDeleteConfirmDialog_content => 'Are you sure you want to delete account?';

  @override
  String get settings_AccountDeleteConfirmDialog_title => 'Confirm delete account';

  @override
  String get settings_AppBarTitle_myAccount => 'My account';

  @override
  String get settings_call_codecs_preferred_audio_default => 'Auto';

  @override
  String get settings_call_codecs_preferred_audio_tip => 'The preferred audio codec is used for audio calls. If the codec is not supported by the device, the call will be established using the next available codec.';

  @override
  String get settings_call_codecs_preferred_audio_title => 'Preferred audio codec';

  @override
  String get settings_call_codecs_preferred_video_default => 'Auto';

  @override
  String get settings_call_codecs_preferred_video_tip => 'The preferred video codec is used for video calls. If the codec is not supported by the device, the call will be established using the next available codec.';

  @override
  String get settings_call_codecs_preferred_video_title => 'Preferred video codec';

  @override
  String get settings_ListViewTileTitle_about => 'About';

  @override
  String get settings_ListViewTileTitle_accountDelete => 'Delete account';

  @override
  String get settings_ListViewTileTitle_call_codecs => 'Call codecs';

  @override
  String get settings_ListViewTileTitle_self_config => 'Self-config page';

  @override
  String get settings_ListViewTileTitle_help => 'Help';

  @override
  String get settings_ListViewTileTitle_language => 'Language';

  @override
  String get settings_ListViewTileTitle_logout => 'Logout';

  @override
  String get settings_ListViewTileTitle_logRecordsConsole => 'Log records console';

  @override
  String get settings_ListViewTileTitle_network => 'Network settings';

  @override
  String get settings_ListViewTileTitle_registered => 'Online';

  @override
  String get settings_ListViewTileTitle_settings => 'SETTINGS';

  @override
  String get settings_ListViewTileTitle_termsConditions => 'Terms and conditions';

  @override
  String get settings_ListViewTileTitle_themeMode => 'Theme mode';

  @override
  String get settings_ListViewTileTitle_toolbox => 'TOOLBOX';

  @override
  String get settings_LogoutConfirmDialog_content => 'Are you sure you want to logout?';

  @override
  String get settings_LogoutConfirmDialog_title => 'Confirm logout';

  @override
  String get settings_network_incomingCallType_pushNotification_description => 'When the app is not in use, it stops running and consumes minimal resources, which helps conserve battery life. During an incoming call, the server sends a push notification to the phone, prompting the mobile operating system to launch the app to handle the call. However, this method does not guarantee that all calls will be received. If the phone has been inactive for an extended period, some versions of Android may limit push notifications, potentially causing you to miss an incoming call.';

  @override
  String get settings_network_incomingCallType_pushNotification_title => 'Push Notification';

  @override
  String get settings_network_incomingCallType_socket_description => 'The app continues running in the background and always maintains an active connection to the server. This increases the chances of receiving an incoming call but may drain the battery more quickly.';

  @override
  String get settings_network_incomingCallType_socket_title => 'Persistent Connection to the Server';

  @override
  String get settings_network_incomingCallType_title => 'Incoming Call Type';

  @override
  String get signalingResponseCode_errorAttachingPlugin => 'We had trouble connecting a feature. Please try again later.';

  @override
  String get signalingResponseCode_errorDetachingPlugin => 'We had trouble disconnecting a feature. Please try again later.';

  @override
  String get signalingResponseCode_errorSendingMessage => 'We couldn\'t send your message. Check your network and try again.';

  @override
  String get signalingResponseCode_handleNotFound => 'We couldn\'t find what you were looking for. Please try again.';

  @override
  String get signalingResponseCode_invalidElementType => 'Something isn\'t quite right. Please try again.';

  @override
  String get signalingResponseCode_invalidJson => 'There was an error processing your data. Please try again.';

  @override
  String get signalingResponseCode_invalidJsonObject => 'Some of the information provided was not valid. Please double-check and try again.';

  @override
  String get signalingResponseCode_invalidPath => 'The requested action isn\'t available. Please try a different option.';

  @override
  String get signalingResponseCode_invalidSdp => 'We encountered a technical error. Please try again later.';

  @override
  String get signalingResponseCode_invalidStream => 'The requested stream isn\'t available. Please try again.';

  @override
  String get signalingResponseCode_missingMandatoryElement => 'Required information is missing. Please fill in all required fields.';

  @override
  String get signalingResponseCode_missingRequest => 'Something went wrong with your request. Please try again.';

  @override
  String get signalingResponseCode_notAcceptingNewSessions => 'We\'re not able to start new sessions at the moment. Please try later.';

  @override
  String get signalingResponseCode_notFoundRoutesInReplyFromBE => 'We couldn\'t find a route to complete your request. Please try again later.';

  @override
  String get signalingResponseCode_pluginNotFound => 'A required component is missing. Please try restarting the app.';

  @override
  String get signalingResponseCode_sessionIdInUse => 'This session is already active. Try using a different session.';

  @override
  String get signalingResponseCode_sessionNotFound => 'Your session could not be found. Please sign in and try again.';

  @override
  String get signalingResponseCode_tokenNotFound => 'Your access token is missing or invalid. Please sign in again.';

  @override
  String get signalingResponseCode_transportSpecificError => 'A connection issue occurred. Please check your network and try again.';

  @override
  String get signalingResponseCode_normalUnspecified => 'An error occurred. Please try again later.';

  @override
  String get signalingResponseCode_callNotExist => 'The call you\'re trying to reach doesn\'t exist.';

  @override
  String get signalingResponseCode_loopDetected => 'We detected a loop in the call. Please try again.';

  @override
  String get signalingResponseCode_exchangeRoutingError => 'We couldn\'t find a route to complete your request. Please try again later.';

  @override
  String get signalingResponseCode_invalidNumberFormat => 'The number you entered is invalid.';

  @override
  String get signalingResponseCode_ambiguousRequest => 'We couldn\'t understand your request.';

  @override
  String get signalingResponseCode_userBusy => 'The user you\'re trying to reach is busy. Please try again later.';

  @override
  String get signalingResponseCode_requestTerminated => 'Your request was terminated. Please try again.';

  @override
  String get signalingResponseCode_incompatibleDestination => 'The destination you\'re trying to reach is incompatible.';

  @override
  String get signalingResponseCode_busyEverywhere => 'The user you\'re trying to reach is busy. Please try again later.';

  @override
  String get signalingResponseCode_declineCall => 'The call was declined';

  @override
  String get signalingResponseCode_userNotExist => 'The user you\'re trying to reach doesn\'t exist.';

  @override
  String get signalingResponseCode_notAcceptable => 'The call is not acceptable.';

  @override
  String get signalingResponseCode_unwanted => 'The call is unwanted.';

  @override
  String get signalingResponseCode_rejected => 'The call was rejected.';

  @override
  String get signalingResponseCodeType_plugin => 'A required feature isn\'t working properly. Try restarting the app.';

  @override
  String get signalingResponseCodeType_request => 'There\'s an issue with your request. Please try again.';

  @override
  String get signalingResponseCodeType_session => 'There\'s an issue with your session. Please sign in again or restart the app.';

  @override
  String get signalingResponseCodeType_token => 'Your access token isn\'t valid. Please sign in again.';

  @override
  String get signalingResponseCodeType_transport => 'We\'re having trouble communicating with the server. Please check your connection and try again.';

  @override
  String get signalingResponseCodeType_unauthorized => 'You do not have the proper authorization. Please sign in or contact support.';

  @override
  String get signalingResponseCodeType_unknown => 'An unexpected issue occurred. Please try again later.';

  @override
  String get signalingResponseCodeType_webrtc => 'There\'s an issue with the call connection. Please hang up and try again.';

  @override
  String get signalingResponseCodeType_callHangup => 'The call was ended.';

  @override
  String get signalingResponseCode_unauthorizedAccess => 'You do not have permission to access this feature. Please contact support if you believe this is an error.';

  @override
  String get signalingResponseCode_unauthorizedRequest => 'Your request could not be authorized. Please try signing in again.';

  @override
  String get signalingResponseCode_unexpectedAnswer => 'We got an unexpected response. Please try again.';

  @override
  String get signalingResponseCode_unknownError => 'An unexpected error occurred. Please try again later.';

  @override
  String get signalingResponseCode_unknownRequest => 'We didn\'t recognize that request. Please try again or contact support.';

  @override
  String get signalingResponseCode_unsupportedJsepType => 'This action isn\'t supported by your current setup.';

  @override
  String get signalingResponseCode_wrongWebrtcState => 'A call-related error occurred. Please hang up and try again.';

  @override
  String get themeMode_dark => 'Dark';

  @override
  String get themeMode_light => 'Light';

  @override
  String get themeMode_system => 'System';

  @override
  String get user_agreement_agrement_link => 'The terms and conditions of the agreement';

  @override
  String get user_agreement_button_text => 'Continue';

  @override
  String user_agreement_checkbox_text(Object url) {
    return 'I have read the $url and consent to its terms.';
  }

  @override
  String user_agreement_description(Object appName) {
    return 'Welcome to $appName';
  }

  @override
  String get validationBlankError => 'Please enter a value';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_retry => 'Retry';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_skip => 'Skip';

  @override
  String get webRegistration_ErrorAcknowledgeDialog_title => 'Web resource error';

  @override
  String get socketError_serverUnreachable => 'The server is unreachable due to network issues';

  @override
  String get socketError_networkUnreachable => 'Network Unreachable';

  @override
  String get socketError_connectionTimedOut => 'Connection Timed Out';

  @override
  String get socketError_connectionRefused => 'Connection Refused';

  @override
  String get socketError_connectionReset => 'Connection Reset';

  @override
  String get socketError_default => 'Network Error';

  @override
  String get socketError_serverUnreachableDescription => 'The server is unreachable. This could be due to no internet connection or server maintenance. Please check your internet connection and try again.';

  @override
  String get socketError_networkUnreachableDescription => 'The network is unreachable. This could be due to a weak internet connection, network restrictions such as firewalls, or incorrect DNS settings. If you\'re on a work or restricted network, please contact your network administrator or try using a different network.';

  @override
  String get socketError_connectionTimedOutDescription => 'The connection has timed out. This might happen due to a slow or unstable internet connection. Please check your connection and try again.';

  @override
  String get socketError_connectionRefusedDescription => 'The server refused the connection. The server may be down or rejecting requests. Please try again later.';

  @override
  String get socketError_connectionResetDescription => 'The connection was reset by the server. Please try again.';

  @override
  String socketError_defaultDescription(int? errorCode) {
    return 'An unexpected network error occurred (Error code: $errorCode). This might be caused by network issues or server problems. Please try again later.';
  }
}
