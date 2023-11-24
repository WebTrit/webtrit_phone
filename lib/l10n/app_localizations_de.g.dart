import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get alertDialogActions_no => '';

  @override
  String get alertDialogActions_ok => '';

  @override
  String get alertDialogActions_yes => '';

  @override
  String get call_CallActionsTooltip_accept => '';

  @override
  String get call_CallActionsTooltip_disableCamera => '';

  @override
  String get call_CallActionsTooltip_disableSpeaker => '';

  @override
  String get call_CallActionsTooltip_enableCamera => '';

  @override
  String get call_CallActionsTooltip_enableSpeaker => '';

  @override
  String get call_CallActionsTooltip_hangup => '';

  @override
  String get call_CallActionsTooltip_hideKeypad => '';

  @override
  String get call_CallActionsTooltip_hold => '';

  @override
  String get call_CallActionsTooltip_mute => '';

  @override
  String get call_CallActionsTooltip_showKeypad => '';

  @override
  String get call_CallActionsTooltip_transfer => '';

  @override
  String get call_CallActionsTooltip_unhold => '';

  @override
  String get call_CallActionsTooltip_unmute => '';

  @override
  String get call_description_incoming => '';

  @override
  String get call_description_outgoing => '';

  @override
  String get call_FailureAcknowledgeDialog_title => '';

  @override
  String get callStatus_appUnregistered => '';

  @override
  String get callStatus_connectError => '';

  @override
  String get callStatus_connectIssue => '';

  @override
  String get callStatus_connectivityNone => '';

  @override
  String get callStatus_inProgress => '';

  @override
  String get callStatus_ready => '';

  @override
  String get contacts_ExternalTabButton_refresh => '';

  @override
  String get contacts_ExternalTabText_empty => '';

  @override
  String get contacts_ExternalTabText_emptyOnSearching => '';

  @override
  String get contacts_ExternalTabText_failure => '';

  @override
  String get contacts_LocalTabButton_openAppSettings => '';

  @override
  String get contacts_LocalTabButton_refresh => '';

  @override
  String get contacts_LocalTabText_empty => '';

  @override
  String get contacts_LocalTabText_emptyOnSearching => '';

  @override
  String get contacts_LocalTabText_failure => '';

  @override
  String get contacts_LocalTabText_permissionFailure => '';

  @override
  String get contactsSourceExternal => '';

  @override
  String get contactsSourceLocal => '';

  @override
  String get copyToClipboard_floatingSnackBar => 'Text kopiert';

  @override
  String get copyToClipboard_popupMenuItem => 'In die Zwischenablage kopieren';

  @override
  String get default_ClientExceptionError => 'Ein HTTP-Client-Problem ist aufgetreten';

  @override
  String get default_FormatExceptionError => 'Es ist ein Antwortproblem aufgetreten';

  @override
  String get default_RequestFailureError => 'Ein Serverfehler ist aufgetreten';

  @override
  String get default_SocketExceptionError => 'Ein Netzwerkproblem ist aufgetreten';

  @override
  String get default_TlsExceptionError => 'Ein sicheres Netzwerkproblem ist aufgetreten';

  @override
  String get default_TypeErrorError => 'Es ist ein Antwortproblem aufgetreten';

  @override
  String get default_UnauthorizedRequestFailureError => 'Ein Fehler bei der nicht autorisierten Anfrage ist aufgetreten';

  @override
  String get favorites_BodyCenter_empty => '';

  @override
  String get favorites_DeleteConfirmDialog_content => '';

  @override
  String get favorites_DeleteConfirmDialog_title => '';

  @override
  String favorites_SnackBar_deleted(String name) {
    return '';
  }

  @override
  String get locale_default => 'Standard';

  @override
  String get locale_en => '';

  @override
  String get login_AppBarTitle_coreUrlAssign => '';

  @override
  String get login_AppBarTitle_otpRequest => '';

  @override
  String get login_AppBarTitle_otpVerify => '';

  @override
  String get login_Button_coreUrlAssignProceed => '';

  @override
  String get login_Button_otpRequestProceed => '';

  @override
  String get login_Button_otpVerifyProceed => '';

  @override
  String get login_Button_otpVerifyRepeat => '';

  @override
  String login_Button_otpVerifyRepeatInterval(int seconds) {
    return '';
  }

  @override
  String get login_Button_signIn => '';

  @override
  String get login_Button_signUpToDemoInstance => '';

  @override
  String get login_ButtonTooltip_signInToYourInstance => '';

  @override
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return '';
  }

  @override
  String get login_FormatExceptionError => '';

  @override
  String get login_RequestFailureCodeIncorrectError => '';

  @override
  String get login_RequestFailureEmptyEmailError => '';

  @override
  String get login_RequestFailureError => '';

  @override
  String get login_RequestFailureOtpAlreadyVerifiedError => 'Überprüfung bereits durchgeführt';

  @override
  String get login_RequestFailureOtpExpiredError => 'Verifizierung abgelaufen';

  @override
  String get login_RequestFailureOtpIdVerifyAttemptsExceededError => '';

  @override
  String get login_RequestFailureOtpNotFoundError => 'Verifizierung nicht gefunden';

  @override
  String get login_RequestFailurePhoneNotFoundError => '';

  @override
  String get login_RequestFailureUnconfiguredBundleIdError => 'App-Backend-Konfigurationsfehler - Benachrichtigen Sie bitte Ihren Dienstleister';

  @override
  String get login_SocketExceptionError => '';

  @override
  String login_Text_coreUrlAssignPostDescription(Object email) {
    return 'Wenn Sie noch kein eigenes WebTrit Cloud Backend haben, kontaktieren Sie das Verkaufsteam unter $email';
  }

  @override
  String get login_Text_coreUrlAssignPreDescription => '';

  @override
  String get login_TextFieldLabelText_coreUrlAssign => '';

  @override
  String get login_TextFieldLabelText_otpRequestEmail => '';

  @override
  String get login_TextFieldLabelText_otpRequestPhone => '';

  @override
  String get login_TextFieldLabelText_otpVerifyCode => '';

  @override
  String get login_Text_otpRequestDemoDescription => '';

  @override
  String get login_Text_otpRequestDescription => '';

  @override
  String login_Text_otpVerifyCheckSpamFrom(String email) {
    return '';
  }

  @override
  String get login_Text_otpVerifyCheckSpamGeneral => '';

  @override
  String login_Text_otpVerifySentToEmail(String email) {
    return '';
  }

  @override
  String login_Text_otpVerifySentToEmailAssignedWithPhone(String phone) {
    return '';
  }

  @override
  String get login_TlsExceptionError => '';

  @override
  String get login_TypeErrorError => '';

  @override
  String get login_validationCoreUrlError => '';

  @override
  String get login_validationEmailError => '';

  @override
  String get login_validationPhoneError => '';

  @override
  String get logRecordsConsole_AppBarTitle => '';

  @override
  String get logRecordsConsole_Button_failureRefresh => 'Aktualisieren';

  @override
  String get logRecordsConsole_Text_failure => 'Ein Fehler is aufgetreten';

  @override
  String get main_BottomNavigationBarItemLabel_contacts => '';

  @override
  String get main_BottomNavigationBarItemLabel_favorites => '';

  @override
  String get main_BottomNavigationBarItemLabel_keypad => '';

  @override
  String get main_BottomNavigationBarItemLabel_recents => '';

  @override
  String get main_CompatibilityIssueDialogActions_logout => '';

  @override
  String get main_CompatibilityIssueDialogActions_update => 'Aktualisierung';

  @override
  String get main_CompatibilityIssueDialogActions_verify => '';

  @override
  String main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(String actual, String supportedConstraint) {
    return '';
  }

  @override
  String get main_CompatibilityIssueDialog_title => '';

  @override
  String get notifications_errorSnackBarAction_callUserMedia => '';

  @override
  String get notifications_errorSnackBar_callConnect => '';

  @override
  String get notifications_errorSnackBar_callSignalingClientNotConnect => '';

  @override
  String get notifications_errorSnackBar_callSignalingClientSessionMissed => '';

  @override
  String get notifications_errorSnackBar_callUndefinedLine => '';

  @override
  String get notifications_errorSnackBar_callUserMedia => '';

  @override
  String get notImplemented => '';

  @override
  String get permission_Button_request => '';

  @override
  String get permission_Text_description => '';

  @override
  String recents_BodyCenter_empty(Object filter) {
    return ' Derzeit gibt es keine $filter aktuellen Anrufe.';
  }

  @override
  String get recents_DeleteConfirmDialog_content => '';

  @override
  String get recents_DeleteConfirmDialog_title => '';

  @override
  String get recents_errorSnackBar_loadFailure => '';

  @override
  String recents_snackBar_deleted(String name) {
    return '';
  }

  @override
  String get recentsVisibilityFilter_all => '';

  @override
  String get recentsVisibilityFilter_incoming => '';

  @override
  String get recentsVisibilityFilter_missed => '';

  @override
  String get recentsVisibilityFilter_outgoing => '';

  @override
  String recentTimeAfterMidnight(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat.yMd(localeName);
    final String timeString = timeDateFormat.format(time);

    return '';
  }

  @override
  String recentTimeBeforeMidnight(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    return '';
  }

  @override
  String get settings_AboutText_CoreVersionUndefined => '?.?.?';

  @override
  String get settings_AccountDeleteConfirmDialog_content => 'Sind Sie sicher, dass Sie das Konto löschen möchten?';

  @override
  String get settings_AccountDeleteConfirmDialog_title => 'Löschen des Kontos bestätigen';

  @override
  String get settings_AppBarTitle_myAccount => '';

  @override
  String get settings_ForceLogoutConfirmDialog_content => 'Sind Sie sicher, dass Sie das Ausloggen erzwingen möchten?';

  @override
  String get settings_ForceLogoutConfirmDialog_title => 'Bestätigen Sie das erzwungene Ausloggen';

  @override
  String get settings_FormatExceptionError => '';

  @override
  String get settings_ListViewTileTitle_about => '';

  @override
  String get settings_ListViewTileTitle_accountDelete => 'Konto löschen';

  @override
  String get settings_ListViewTileTitle_help => '';

  @override
  String get settings_ListViewTileTitle_language => '';

  @override
  String get settings_ListViewTileTitle_logout => '';

  @override
  String get settings_ListViewTileTitle_logRecordsConsole => '';

  @override
  String get settings_ListViewTileTitle_network => '';

  @override
  String get settings_ListViewTileTitle_registered => '';

  @override
  String get settings_ListViewTileTitle_settings => '';

  @override
  String get settings_ListViewTileTitle_termsConditions => '';

  @override
  String get settings_ListViewTileTitle_themeMode => '';

  @override
  String get settings_ListViewTileTitle_toolbox => '';

  @override
  String get settings_LogoutConfirmDialog_content => '';

  @override
  String get settings_LogoutConfirmDialog_title => '';

  @override
  String get settings_RequestFailureError => '';

  @override
  String get settings_SocketExceptionError => '';

  @override
  String get settings_TlsExceptionError => '';

  @override
  String get settings_TypeErrorError => '';

  @override
  String get themeMode_dark => '';

  @override
  String get themeMode_light => '';

  @override
  String get themeMode_system => '';

  @override
  String get underDevelopment => 'diese Seite wird noch nicht entwickelt';

  @override
  String get validationBlankError => '';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_demo => '';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_retry => '';

  @override
  String get webRegistration_ErrorAcknowledgeDialogActions_skip => '';

  @override
  String get webRegistration_ErrorAcknowledgeDialog_title => '';
}
