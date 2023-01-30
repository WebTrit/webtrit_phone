import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get locale_default => 'Default';

  @override
  String get locale_en => 'English';

  @override
  String get themeMode_system => 'System';

  @override
  String get themeMode_light => 'Light';

  @override
  String get themeMode_dark => 'Dark';

  @override
  String get alertDialogActions_no => 'No';

  @override
  String get alertDialogActions_yes => 'Yes';

  @override
  String get alertDialogActions_ok => 'Ok';

  @override
  String get callStatus_connectivityNone => 'No internet connection';

  @override
  String get callStatus_connectError => 'Connection error';

  @override
  String get callStatus_appUnregistered => 'Unregistered';

  @override
  String get callStatus_connectIssue => 'Connection issue';

  @override
  String get callStatus_inProgress => 'Connection in progress';

  @override
  String get callStatus_ready => 'Connection established';

  @override
  String get notifications_errorSnackBar_callUndefinedLine => 'No idle lines to initiate the call';

  @override
  String get notifications_errorSnackBar_callSignalingClientNotConnect => 'Cannot initiate the call, please check the connection status';

  @override
  String get notifications_errorSnackBar_callSignalingClientSessionMissed => 'The current connection session is invalid, please sign in again';

  @override
  String get notifications_errorSnackBar_callConnect => 'Connecting to the core failed, trying to reconnect';

  @override
  String get notifications_errorSnackBar_callUserMedia => 'No access to media input, please check app permissions';

  @override
  String get notifications_errorSnackBarAction_callUserMedia => 'Check';

  @override
  String get main_BottomNavigationBarItemLabel_favorites => 'Favorites';

  @override
  String get main_BottomNavigationBarItemLabel_recents => 'Recents';

  @override
  String get main_BottomNavigationBarItemLabel_contacts => 'Contacts';

  @override
  String get main_BottomNavigationBarItemLabel_keypad => 'Keypad';

  @override
  String get call_FailureAcknowledgeDialog_title => 'Failure';

  @override
  String get call_description_incoming => 'Incoming call from';

  @override
  String get call_description_outgoing => 'Outgoing call to';

  @override
  String get call_CallActionsTooltip_mute => 'Mute microphone';

  @override
  String get call_CallActionsTooltip_unmute => 'Unmute microphone';

  @override
  String get call_CallActionsTooltip_disableCamera => 'Disable camera';

  @override
  String get call_CallActionsTooltip_enableCamera => 'Enable camera';

  @override
  String get call_CallActionsTooltip_disableSpeaker => 'Disable speakerphone';

  @override
  String get call_CallActionsTooltip_enableSpeaker => 'Enable speakerphone';

  @override
  String get call_CallActionsTooltip_transfer => 'Transfer';

  @override
  String get call_CallActionsTooltip_hold => 'Hold call';

  @override
  String get call_CallActionsTooltip_unhold => 'Unhold call';

  @override
  String get call_CallActionsTooltip_showKeypad => 'Show keypad';

  @override
  String get call_CallActionsTooltip_hideKeypad => 'Hide keypad';

  @override
  String get call_CallActionsTooltip_hangup => 'Hangup';

  @override
  String get call_CallActionsTooltip_accept => 'Accept';

  @override
  String get favorites_BodyCenter_empty => 'There are no favorite numbers';

  @override
  String favorites_SnackBar_deleted(String name) {
    return '$name deleted';
  }

  @override
  String get favorites_DeleteConfirmDialog_title => 'Confirm deleting';

  @override
  String get favorites_DeleteConfirmDialog_content => 'Are you sure you want to delete the current favorite?';

  @override
  String get login_ButtonTooltip_signInToYourInstance => 'Sign in to your PortaPhone instance';

  @override
  String get login_Button_signUpToDemoInstance => 'Sign up';

  @override
  String get login_Button_signIn => 'Sign in';

  @override
  String get login_AppBarTitle_coreUrlAssign => '';

  @override
  String get login_TextFieldLabelText_coreUrlAssign => 'Enter your PortaPhone instance URL';

  @override
  String get login_Text_coreUrlAssignPreDescription => 'In order to make calls via your own PortaPhone instance and your own PortaSwitch please enter the server\'s URL (as it was provided to you by your account manager) below.';

  @override
  String get login_Text_coreUrlAssignPostDescription => 'If you do not yet have your own PortaPhone instance - contact sales team sales@portaone.com.';

  @override
  String get login_Button_coreUrlAssignProceed => 'Proceed';

  @override
  String get login_AppBarTitle_otpRequest => '';

  @override
  String get login_TextFieldLabelText_otpRequestEmail => 'Enter your email';

  @override
  String get login_TextFieldLabelText_otpRequestPhone => 'Enter your phone number';

  @override
  String get login_Text_otpRequestDemoDescription => 'If you do not have an account yet, it will be automatically created for you.';

  @override
  String get login_Text_otpRequestDescription => '';

  @override
  String get login_Button_otpRequestProceed => 'Proceed';

  @override
  String get login_AppBarTitle_otpVerify => '';

  @override
  String login_Text_otpVerifySentToEmail(String email) {
    return 'A one-time verification code was sent to $email.';
  }

  @override
  String login_Text_otpVerifySentToEmailAssignedWithPhone(String phone) {
    return 'A one-time verification code was sent to the email assigned to the tel:$phone phone number.';
  }

  @override
  String get login_TextFieldLabelText_otpVerifyCode => 'Enter the verification code';

  @override
  String get login_Text_otpVerifyCheckSpamGeneral => 'If you do not see an email with the verification code in your inbox, please check your spam folder.';

  @override
  String login_Text_otpVerifyCheckSpamFrom(String email) {
    return 'If you do not see an email with the verification code from $email in your inbox, please check your spam folder.';
  }

  @override
  String login_Button_otpVerifyRepeatInterval(int seconds) {
    return 'Resend the code ($seconds s)';
  }

  @override
  String get login_Button_otpVerifyRepeat => 'Resend the code';

  @override
  String get login_Button_otpVerifyProceed => 'Verify';

  @override
  String get login_validationEmailError => 'Please enter a valid email';

  @override
  String get login_validationPhoneError => 'Please enter a valid phone number';

  @override
  String get login_validationCoreUrlError => 'Please enter a valid URL';

  @override
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return 'An incompatible instance version provided, please contact the administrator of your system (actual: $actual, supported: $supportedConstraint)';
  }

  @override
  String get login_FormatExceptionError => 'A response issue occurred';

  @override
  String get login_TlsExceptionError => 'A secure networking issue occurred';

  @override
  String get login_SocketExceptionError => 'A network issue occurred';

  @override
  String get login_TypeErrorError => 'A response issue occurred';

  @override
  String get login_RequestFailureError => 'A server failure occurred';

  @override
  String get login_RequestFailureEmptyEmailError => 'Cannot send the verification code';

  @override
  String get login_RequestFailurePhoneNotFoundError => 'Phone number not found';

  @override
  String get login_RequestFailureCodeIncorrectError => 'Incorrect verification code';

  @override
  String get login_RequestFailureOtpIdVerifyAttemptsExceededError => 'Verification attempts exceeded';

  @override
  String get permission_Text_description => 'To ensure the best user experience, the app needs to be granted the following permissions: microphone for audio calls, camera for video calls, and contacts to simplify reaching them from the app.\n\nPermissions could be changed at any time in the future.';

  @override
  String get permission_Button_request => 'Continue';

  @override
  String get validationBlankError => 'Please enter a value';

  @override
  String recentTimeBeforeMidnight(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String recentTimeAfterMidnight(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat.yMd(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String get recentsVisibilityFilter_all => 'All';

  @override
  String get recentsVisibilityFilter_missed => 'Missed';

  @override
  String get recentsVisibilityFilter_incoming => 'Incoming';

  @override
  String get recentsVisibilityFilter_outgoing => 'Outgoing';

  @override
  String get recents_errorSnackBar_loadFailure => 'Oops... an error happened ☹️';

  @override
  String recents_snackBar_deleted(String name) {
    return '$name deleted';
  }

  @override
  String get recents_DeleteConfirmDialog_title => 'Confirm deleting';

  @override
  String get recents_DeleteConfirmDialog_content => 'Are you sure you want to delete the current call log?';

  @override
  String get contactsSourceLocal => 'Your phone';

  @override
  String get contactsSourceExternal => 'Cloud PBX';

  @override
  String get contacts_LocalTabText_permissionFailure => 'There are no permissions to get your phone contacts';

  @override
  String get contacts_LocalTabButton_openAppSettings => 'Grant access to your phone contacts';

  @override
  String get contacts_LocalTabText_failure => 'Failed to get your phone contacts';

  @override
  String get contacts_LocalTabText_emptyOnSearching => 'No contacts found';

  @override
  String get contacts_LocalTabText_empty => 'No contacts';

  @override
  String get contacts_LocalTabButton_refresh => 'Refresh';

  @override
  String get contacts_ExternalTabText_failure => 'Failed to get cloud PBX contacts';

  @override
  String get contacts_ExternalTabText_emptyOnSearching => 'No contacts found';

  @override
  String get contacts_ExternalTabText_empty => 'No contacts';

  @override
  String get contacts_ExternalTabButton_refresh => 'Refresh';

  @override
  String get settings_AppBarTitle_myAccount => 'My account';

  @override
  String get settings_ListViewTileTitle_registered => 'Registered';

  @override
  String get settings_ListViewTileTitle_logout => 'Logout';

  @override
  String get settings_ListViewTileTitle_settings => 'SETTINGS';

  @override
  String get settings_ListViewTileTitle_network => 'Network settings';

  @override
  String get settings_ListViewTileTitle_help => 'Help';

  @override
  String get settings_ListViewTileTitle_language => 'Language';

  @override
  String get settings_ListViewTileTitle_termsConditions => 'Terms and conditions';

  @override
  String get settings_ListViewTileTitle_about => 'About';

  @override
  String get settings_ListViewTileTitle_themeMode => 'Theme mode';

  @override
  String get settings_ListViewTileTitle_toolbox => 'TOOLBOX';

  @override
  String get settings_ListViewTileTitle_logRecordsConsole => 'Log records console';

  @override
  String get settings_LogoutConfirmDialog_title => 'Confirm logout';

  @override
  String get settings_LogoutConfirmDialog_content => 'Are you sure you want to logout?';

  @override
  String get settings_FormatExceptionError => 'A response issue occurred';

  @override
  String get settings_TlsExceptionError => 'A secure networking issue occurred';

  @override
  String get settings_SocketExceptionError => 'A network issue occurred';

  @override
  String get settings_TypeErrorError => 'A response issue occurred';

  @override
  String get settings_RequestFailureError => 'A server failure occurred';

  @override
  String get webRegistration_ErrorAcknowledgeDialog_title => 'Web resource error';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_demo => 'Demo';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_skip => 'Skip';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_retry => 'Retry';

  @override
  String get logRecordsConsole_AppBarTitle => 'Log Console';

  @override
  String get logRecordsConsole_Text_failure => 'Ups error happened ☹️';

  @override
  String get logRecordsConsole_Button_failureRefresh => 'Refresh';

  @override
  String get underDevelopment => 'This page is under development.';

  @override
  String get notImplemented => 'Sorry, not implemented yet';
}
