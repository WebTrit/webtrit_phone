import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get alertDialogActions_no => 'No';

  @override
  String get alertDialogActions_ok => 'Ok';

  @override
  String get alertDialogActions_yes => 'Yes';

  @override
  String get call_CallActionsTooltip_accept => 'Accept';

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
  String get call_CallActionsTooltip_unhold => 'Unhold call';

  @override
  String get call_CallActionsTooltip_unmute => 'Unmute microphone';

  @override
  String get call_description_held => 'On hold';

  @override
  String get call_description_incoming => 'Incoming call';

  @override
  String get call_description_outgoing => 'Outgoing call';

  @override
  String get call_description_transferProcessing => 'Transfer processing';

  @override
  String get call_FailureAcknowledgeDialog_title => 'Failure';

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
  String get contacts_Text_blingTransferInitiated => 'Blind transferring';

  @override
  String get copyToClipboard_floatingSnackBar => 'Text copied';

  @override
  String get copyToClipboard_popupMenuItem => 'Copy to clipboard';

  @override
  String get default_ClientExceptionError => 'A HTTP client issue occurred';

  @override
  String get default_FormatExceptionError => 'A response format issue occurred';

  @override
  String get default_RequestFailureError => 'A server failure occurred';

  @override
  String get default_SocketExceptionError => 'A network issue occurred';

  @override
  String get default_TlsExceptionError => 'A secure network protocol (TLS/SSL) issue occurred';

  @override
  String get default_TypeErrorError => 'A response issue occurred';

  @override
  String get default_ErrorMessage => 'Error message';

  @override
  String get default_ErrorDetails => 'Details';

  @override
  String get default_ErrorPath => 'Error path';

  @override
  String get request_StatusCode => 'Status code';

  @override
  String get request_Id => 'Request id';

  @override
  String get default_UnauthorizedRequestFailureError => 'An unauthorized request failure occurred';

  @override
  String get favorites_BodyCenter_empty => 'Currently, you have no favorite numbers.\nAdd favorites from Contacts using the star icon.';

  @override
  String get favorites_DeleteConfirmDialog_content => 'Are you sure you want to delete the current favorite number?';

  @override
  String get favorites_DeleteConfirmDialog_title => 'Confirm deleting';

  @override
  String favorites_SnackBar_deleted(String name) {
    return '$name deleted';
  }

  @override
  String get favorites_Text_blingTransferInitiated => 'Blind transferring';

  @override
  String get locale_default => 'Default';

  @override
  String get locale_en => 'English';

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
  String get login_RequestFailureIdentifierIsNotValid => 'The identifier appears invalid due to a non-existent';

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
  String login_Text_otpVerifySentToEmailAssignedWithPhone(String phone) {
    return 'A one-time verification code was sent to the email assigned to the tel:$phone phone number.';
  }

  @override
  String get login_Text_passwordSigninPostDescription => '';

  @override
  String get login_Text_passwordSigninPreDescription => '';

  @override
  String get login_Text_signupRequestPostDescription => '';

  @override
  String get login_Text_signupRequestPostDescriptionDemo => 'If you do not have an account yet, it will be automatically created for you.';

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
  String get main_CompatibilityIssueDialogActions_verify => 'Check again';

  @override
  String main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'Incompatible WebTrit Cloud Backend version, please contact the administrator of your system.\n\nInstance version:\n$actual\n\nSupported version:\n$supportedConstraint';
  }

  @override
  String get main_CompatibilityIssueDialog_title => 'Compatibility issue';

  @override
  String get notifications_errorSnackBarAction_callUserMedia => 'Check';

  @override
  String get notifications_errorSnackBar_callConnect => 'Connecting to the core failed, trying to reconnect';

  @override
  String get notifications_errorSnackBar_callSignalingClientNotConnect => 'Cannot initiate the call, please check the connection status';

  @override
  String get notifications_errorSnackBar_callSignalingClientSessionMissed => 'The current connection session is invalid, please sign in again';

  @override
  String get notifications_errorSnackBar_callUndefinedLine => 'No idle lines to initiate the call';

  @override
  String get notifications_errorSnackBar_callUserMedia => 'No access to media input, please check app permissions';

  @override
  String get notifications_errorSnackBar_appUnregistered => 'Sorry, your application is currently disconnected from the WebTrit core servers and hence can\'t call right now. Please go to the settings page, and slide the online status toggle switch off and on again to reestablish the connection';

  @override
  String get notifications_errorSnackBar_appOffline => 'Your application is currently offline';

  @override
  String get notImplemented => 'Sorry, not implemented yet';

  @override
  String get permission_Button_request => 'Continue';

  @override
  String get permission_Text_description => 'To ensure the best user experience, the app needs to be granted the following permissions: microphone for audio calls, camera for video calls, and contacts to simplify reaching them from the app.\n\nPermissions could be changed at any time in the future.';

  @override
  String get permission_miui_Text_heading => 'To ensure the best user experience, the app needs to be granted the following permissions manually:';

  @override
  String get permission_miui_Text_description => '1. Go to \"App settings\" >> \"Notifications\".\n2. Find and turn on \"Lockscreen notifications\".';

  @override
  String get permission_miui_Text_trailing => 'Permissions could be changed at any time in the future.';

  @override
  String get permission_miui_Button_toSettings => 'Open app Settings';

  @override
  String get permission_miui_Button_gotIt => 'Got it';

  @override
  String user_agreement_checkbox_text(String url) {
    return 'I have read the $url and consent to its terms.';
  }

  @override
  String user_agreement_description(String appName) {
    return 'Welcome to $appName';
  }

  @override
  String get user_agreement_button_text => 'Continue';

  @override
  String get user_agreement_agrement_link => 'terms and condition of agreement';

  @override
  String recents_BodyCenter_empty(Object filter) {
    return 'Currently you have no ${filter}recent calls.';
  }

  @override
  String get recents_DeleteConfirmDialog_content => 'Are you sure you want to delete the current call log?';

  @override
  String get recents_DeleteConfirmDialog_title => 'Confirm deleting';

  @override
  String get recents_errorSnackBar_loadFailure => 'Oops... an error happened ☹️';

  @override
  String get notifications_errorSnackBar_appOnline => 'Your application is online';

  @override
  String recents_snackBar_deleted(String name) {
    return '$name deleted';
  }

  @override
  String get recents_Text_blingTransferInitiated => 'Blind transferring';

  @override
  String get recentsVisibilityFilter_all => 'All';

  @override
  String get recentsVisibilityFilter_incoming => 'Incoming';

  @override
  String get recentsVisibilityFilter_missed => 'Missed';

  @override
  String get recentsVisibilityFilter_outgoing => 'Outgoing';

  @override
  String get recentsVisibilityFilter_all_preposit => 'all';

  @override
  String get recentsVisibilityFilter_incoming_preposit => 'incoming';

  @override
  String get recentsVisibilityFilter_missed_preposit => 'missed';

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
  String get settings_AboutText_AppVersion => 'App Version';

  @override
  String get settings_AboutText_StoreVersion => 'Build version in the Store';

  @override
  String get settings_AboutText_CoreVersionUndefined => '?.?.?';

  @override
  String get settings_AccountDeleteConfirmDialog_content => 'Are you sure you want to delete account?';

  @override
  String get settings_AccountDeleteConfirmDialog_title => 'Confirm delete account';

  @override
  String get settings_AppBarTitle_myAccount => 'My account';

  @override
  String get settings_ForceLogoutConfirmDialog_content => 'Are you sure you want to force logout?';

  @override
  String get settings_ForceLogoutConfirmDialog_title => 'Confirm force logout';

  @override
  String get settings_ListViewTileTitle_about => 'About';

  @override
  String get settings_ListViewTileTitle_accountDelete => 'Delete account';

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
  String get themeMode_dark => 'Dark';

  @override
  String get themeMode_light => 'Light';

  @override
  String get themeMode_system => 'System';

  @override
  String get underDevelopment => 'This page is under development.';

  @override
  String get validationBlankError => 'Please enter a value';

  @override
  String get autoprovision_ReloginDialog_title => 'Relogin Confirmation';

  @override
  String get autoprovision_ReloginDialog_text => 'Do you want to use the new authentication credentials, provided in the link? You will be logged out from the current session.';

  @override
  String get autoprovision_ReloginDialog_confirm => 'Confirm';

  @override
  String get autoprovision_ReloginDialog_decline => 'Decline';

  @override
  String get autoprovision_errorSnackBar_invalidToken => 'The auto configuration credentials were rejected by the server. Please request a new configuration link';

  @override
  String get autoprovision_successSnackBar_used => 'Successfully retrieved your settings, your app is ready to use';

  @override
  String get undefine_DeeplinkConfigurationInvalid_text => 'The auto configuration credentials are invalid, please log in';
}
