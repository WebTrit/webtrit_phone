// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppIntlLocalizations {
  AppIntlLocalizations();

  static AppIntlLocalizations? _current;

  static AppIntlLocalizations get current {
    assert(_current != null,
        'No instance of AppIntlLocalizations was loaded. Try to initialize the AppIntlLocalizations delegate before accessing AppIntlLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppIntlLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppIntlLocalizations();
      AppIntlLocalizations._current = instance;

      return instance;
    });
  }

  static AppIntlLocalizations of(BuildContext context) {
    final instance = AppIntlLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppIntlLocalizations present in the widget tree. Did you add AppIntlLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppIntlLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppIntlLocalizations>(
        context, AppIntlLocalizations);
  }

  /// `No`
  String get alertDialogActions_no {
    return Intl.message(
      'No',
      name: 'alertDialogActions_no',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get alertDialogActions_ok {
    return Intl.message(
      'Ok',
      name: 'alertDialogActions_ok',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get alertDialogActions_yes {
    return Intl.message(
      'Yes',
      name: 'alertDialogActions_yes',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get call_CallActionsTooltip_accept {
    return Intl.message(
      'Accept',
      name: 'call_CallActionsTooltip_accept',
      desc: '',
      args: [],
    );
  }

  /// `Disable camera`
  String get call_CallActionsTooltip_disableCamera {
    return Intl.message(
      'Disable camera',
      name: 'call_CallActionsTooltip_disableCamera',
      desc: '',
      args: [],
    );
  }

  /// `Disable speakerphone`
  String get call_CallActionsTooltip_disableSpeaker {
    return Intl.message(
      'Disable speakerphone',
      name: 'call_CallActionsTooltip_disableSpeaker',
      desc: '',
      args: [],
    );
  }

  /// `Enable camera`
  String get call_CallActionsTooltip_enableCamera {
    return Intl.message(
      'Enable camera',
      name: 'call_CallActionsTooltip_enableCamera',
      desc: '',
      args: [],
    );
  }

  /// `Enable speakerphone`
  String get call_CallActionsTooltip_enableSpeaker {
    return Intl.message(
      'Enable speakerphone',
      name: 'call_CallActionsTooltip_enableSpeaker',
      desc: '',
      args: [],
    );
  }

  /// `Hangup`
  String get call_CallActionsTooltip_hangup {
    return Intl.message(
      'Hangup',
      name: 'call_CallActionsTooltip_hangup',
      desc: '',
      args: [],
    );
  }

  /// `Hide keypad`
  String get call_CallActionsTooltip_hideKeypad {
    return Intl.message(
      'Hide keypad',
      name: 'call_CallActionsTooltip_hideKeypad',
      desc: '',
      args: [],
    );
  }

  /// `Hold call`
  String get call_CallActionsTooltip_hold {
    return Intl.message(
      'Hold call',
      name: 'call_CallActionsTooltip_hold',
      desc: '',
      args: [],
    );
  }

  /// `Mute microphone`
  String get call_CallActionsTooltip_mute {
    return Intl.message(
      'Mute microphone',
      name: 'call_CallActionsTooltip_mute',
      desc: '',
      args: [],
    );
  }

  /// `Show keypad`
  String get call_CallActionsTooltip_showKeypad {
    return Intl.message(
      'Show keypad',
      name: 'call_CallActionsTooltip_showKeypad',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get call_CallActionsTooltip_transfer {
    return Intl.message(
      'Transfer',
      name: 'call_CallActionsTooltip_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Unhold call`
  String get call_CallActionsTooltip_unhold {
    return Intl.message(
      'Unhold call',
      name: 'call_CallActionsTooltip_unhold',
      desc: '',
      args: [],
    );
  }

  /// `Unmute microphone`
  String get call_CallActionsTooltip_unmute {
    return Intl.message(
      'Unmute microphone',
      name: 'call_CallActionsTooltip_unmute',
      desc: '',
      args: [],
    );
  }

  /// `Incoming call from`
  String get call_description_incoming {
    return Intl.message(
      'Incoming call from',
      name: 'call_description_incoming',
      desc: '',
      args: [],
    );
  }

  /// `Outgoing call to`
  String get call_description_outgoing {
    return Intl.message(
      'Outgoing call to',
      name: 'call_description_outgoing',
      desc: '',
      args: [],
    );
  }

  /// `Failure`
  String get call_FailureAcknowledgeDialog_title {
    return Intl.message(
      'Failure',
      name: 'call_FailureAcknowledgeDialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Unregistered`
  String get callStatus_appUnregistered {
    return Intl.message(
      'Unregistered',
      name: 'callStatus_appUnregistered',
      desc: '',
      args: [],
    );
  }

  /// `Connection error`
  String get callStatus_connectError {
    return Intl.message(
      'Connection error',
      name: 'callStatus_connectError',
      desc: '',
      args: [],
    );
  }

  /// `Connection issue`
  String get callStatus_connectIssue {
    return Intl.message(
      'Connection issue',
      name: 'callStatus_connectIssue',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get callStatus_connectivityNone {
    return Intl.message(
      'No internet connection',
      name: 'callStatus_connectivityNone',
      desc: '',
      args: [],
    );
  }

  /// `Connection in progress`
  String get callStatus_inProgress {
    return Intl.message(
      'Connection in progress',
      name: 'callStatus_inProgress',
      desc: '',
      args: [],
    );
  }

  /// `Connection established`
  String get callStatus_ready {
    return Intl.message(
      'Connection established',
      name: 'callStatus_ready',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get contacts_ExternalTabButton_refresh {
    return Intl.message(
      'Refresh',
      name: 'contacts_ExternalTabButton_refresh',
      desc: '',
      args: [],
    );
  }

  /// `No contacts`
  String get contacts_ExternalTabText_empty {
    return Intl.message(
      'No contacts',
      name: 'contacts_ExternalTabText_empty',
      desc: '',
      args: [],
    );
  }

  /// `No contacts found`
  String get contacts_ExternalTabText_emptyOnSearching {
    return Intl.message(
      'No contacts found',
      name: 'contacts_ExternalTabText_emptyOnSearching',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get cloud PBX contacts`
  String get contacts_ExternalTabText_failure {
    return Intl.message(
      'Failed to get cloud PBX contacts',
      name: 'contacts_ExternalTabText_failure',
      desc: '',
      args: [],
    );
  }

  /// `Grant access to your phone contacts`
  String get contacts_LocalTabButton_openAppSettings {
    return Intl.message(
      'Grant access to your phone contacts',
      name: 'contacts_LocalTabButton_openAppSettings',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get contacts_LocalTabButton_refresh {
    return Intl.message(
      'Refresh',
      name: 'contacts_LocalTabButton_refresh',
      desc: '',
      args: [],
    );
  }

  /// `No contacts`
  String get contacts_LocalTabText_empty {
    return Intl.message(
      'No contacts',
      name: 'contacts_LocalTabText_empty',
      desc: '',
      args: [],
    );
  }

  /// `No contacts found`
  String get contacts_LocalTabText_emptyOnSearching {
    return Intl.message(
      'No contacts found',
      name: 'contacts_LocalTabText_emptyOnSearching',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get your phone contacts`
  String get contacts_LocalTabText_failure {
    return Intl.message(
      'Failed to get your phone contacts',
      name: 'contacts_LocalTabText_failure',
      desc: '',
      args: [],
    );
  }

  /// `There are no permissions to get your phone contacts`
  String get contacts_LocalTabText_permissionFailure {
    return Intl.message(
      'There are no permissions to get your phone contacts',
      name: 'contacts_LocalTabText_permissionFailure',
      desc: '',
      args: [],
    );
  }

  /// `Cloud PBX`
  String get contactsSourceExternal {
    return Intl.message(
      'Cloud PBX',
      name: 'contactsSourceExternal',
      desc: '',
      args: [],
    );
  }

  /// `Your phone`
  String get contactsSourceLocal {
    return Intl.message(
      'Your phone',
      name: 'contactsSourceLocal',
      desc: '',
      args: [],
    );
  }

  /// `Text copied`
  String get copyToClipboard_floatingSnackBar {
    return Intl.message(
      'Text copied',
      name: 'copyToClipboard_floatingSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `Copy to clipboard`
  String get copyToClipboard_popupMenuItem {
    return Intl.message(
      'Copy to clipboard',
      name: 'copyToClipboard_popupMenuItem',
      desc: '',
      args: [],
    );
  }

  /// `A HTTP client issue occurred`
  String get default_ClientExceptionError {
    return Intl.message(
      'A HTTP client issue occurred',
      name: 'default_ClientExceptionError',
      desc: '',
      args: [],
    );
  }

  /// `A response issue occurred`
  String get default_FormatExceptionError {
    return Intl.message(
      'A response issue occurred',
      name: 'default_FormatExceptionError',
      desc: '',
      args: [],
    );
  }

  /// `A server failure occurred`
  String get default_RequestFailureError {
    return Intl.message(
      'A server failure occurred',
      name: 'default_RequestFailureError',
      desc: '',
      args: [],
    );
  }

  /// `A network issue occurred`
  String get default_SocketExceptionError {
    return Intl.message(
      'A network issue occurred',
      name: 'default_SocketExceptionError',
      desc: '',
      args: [],
    );
  }

  /// `A secure networking issue occurred`
  String get default_TlsExceptionError {
    return Intl.message(
      'A secure networking issue occurred',
      name: 'default_TlsExceptionError',
      desc: '',
      args: [],
    );
  }

  /// `A response issue occurred`
  String get default_TypeErrorError {
    return Intl.message(
      'A response issue occurred',
      name: 'default_TypeErrorError',
      desc: '',
      args: [],
    );
  }

  /// `An unauthorised request failure occurred`
  String get default_UnauthorizedRequestFailureError {
    return Intl.message(
      'An unauthorised request failure occurred',
      name: 'default_UnauthorizedRequestFailureError',
      desc: '',
      args: [],
    );
  }

  /// `There are no favorite numbers`
  String get favorites_BodyCenter_empty {
    return Intl.message(
      'There are no favorite numbers',
      name: 'favorites_BodyCenter_empty',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the current favorite?`
  String get favorites_DeleteConfirmDialog_content {
    return Intl.message(
      'Are you sure you want to delete the current favorite?',
      name: 'favorites_DeleteConfirmDialog_content',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deleting`
  String get favorites_DeleteConfirmDialog_title {
    return Intl.message(
      'Confirm deleting',
      name: 'favorites_DeleteConfirmDialog_title',
      desc: '',
      args: [],
    );
  }

  /// `{name} deleted`
  String favorites_SnackBar_deleted(String name) {
    return Intl.message(
      '$name deleted',
      name: 'favorites_SnackBar_deleted',
      desc: '',
      args: [name],
    );
  }

  /// `Default`
  String get locale_default {
    return Intl.message(
      'Default',
      name: 'locale_default',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get locale_en {
    return Intl.message(
      'English',
      name: 'locale_en',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get login_AppBarTitle_coreUrlAssign {
    return Intl.message(
      '',
      name: 'login_AppBarTitle_coreUrlAssign',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get login_AppBarTitle_otpRequest {
    return Intl.message(
      '',
      name: 'login_AppBarTitle_otpRequest',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get login_AppBarTitle_otpVerify {
    return Intl.message(
      '',
      name: 'login_AppBarTitle_otpVerify',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get login_Button_coreUrlAssignProceed {
    return Intl.message(
      'Proceed',
      name: 'login_Button_coreUrlAssignProceed',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get login_Button_otpRequestProceed {
    return Intl.message(
      'Proceed',
      name: 'login_Button_otpRequestProceed',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get login_Button_otpVerifyProceed {
    return Intl.message(
      'Verify',
      name: 'login_Button_otpVerifyProceed',
      desc: '',
      args: [],
    );
  }

  /// `Resend the code`
  String get login_Button_otpVerifyRepeat {
    return Intl.message(
      'Resend the code',
      name: 'login_Button_otpVerifyRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Resend the code ({seconds} s)`
  String login_Button_otpVerifyRepeatInterval(int seconds) {
    return Intl.message(
      'Resend the code ($seconds s)',
      name: 'login_Button_otpVerifyRepeatInterval',
      desc: '',
      args: [seconds],
    );
  }

  /// `Sign in`
  String get login_Button_signIn {
    return Intl.message(
      'Sign in',
      name: 'login_Button_signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get login_Button_signUpToDemoInstance {
    return Intl.message(
      'Sign up',
      name: 'login_Button_signUpToDemoInstance',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to your PortaPhone instance`
  String get login_ButtonTooltip_signInToYourInstance {
    return Intl.message(
      'Sign in to your PortaPhone instance',
      name: 'login_ButtonTooltip_signInToYourInstance',
      desc: '',
      args: [],
    );
  }

  /// `An incompatible instance version provided, please contact the administrator of your system (actual: {actual}, supported: {supportedConstraint})`
  String login_CoreVersionUnsupportedExceptionError(
      String actual, String supportedConstraint) {
    return Intl.message(
      'An incompatible instance version provided, please contact the administrator of your system (actual: $actual, supported: $supportedConstraint)',
      name: 'login_CoreVersionUnsupportedExceptionError',
      desc: '',
      args: [actual, supportedConstraint],
    );
  }

  /// `A response issue occurred`
  String get login_FormatExceptionError {
    return Intl.message(
      'A response issue occurred',
      name: 'login_FormatExceptionError',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect verification code`
  String get login_RequestFailureCodeIncorrectError {
    return Intl.message(
      'Incorrect verification code',
      name: 'login_RequestFailureCodeIncorrectError',
      desc: '',
      args: [],
    );
  }

  /// `Cannot send the verification code`
  String get login_RequestFailureEmptyEmailError {
    return Intl.message(
      'Cannot send the verification code',
      name: 'login_RequestFailureEmptyEmailError',
      desc: '',
      args: [],
    );
  }

  /// `A server failure occurred`
  String get login_RequestFailureError {
    return Intl.message(
      'A server failure occurred',
      name: 'login_RequestFailureError',
      desc: '',
      args: [],
    );
  }

  /// `Verification already verified`
  String get login_RequestFailureOtpAlreadyVerifiedError {
    return Intl.message(
      'Verification already verified',
      name: 'login_RequestFailureOtpAlreadyVerifiedError',
      desc: '',
      args: [],
    );
  }

  /// `Verification expired`
  String get login_RequestFailureOtpExpiredError {
    return Intl.message(
      'Verification expired',
      name: 'login_RequestFailureOtpExpiredError',
      desc: '',
      args: [],
    );
  }

  /// `Verification attempts exceeded`
  String get login_RequestFailureOtpIdVerifyAttemptsExceededError {
    return Intl.message(
      'Verification attempts exceeded',
      name: 'login_RequestFailureOtpIdVerifyAttemptsExceededError',
      desc: '',
      args: [],
    );
  }

  /// `Verification not found`
  String get login_RequestFailureOtpNotFoundError {
    return Intl.message(
      'Verification not found',
      name: 'login_RequestFailureOtpNotFoundError',
      desc: '',
      args: [],
    );
  }

  /// `Phone number not found`
  String get login_RequestFailurePhoneNotFoundError {
    return Intl.message(
      'Phone number not found',
      name: 'login_RequestFailurePhoneNotFoundError',
      desc: '',
      args: [],
    );
  }

  /// `App back-end configuration error - please notify your service provider.`
  String get login_RequestFailureUnconfiguredBundleIdError {
    return Intl.message(
      'App back-end configuration error - please notify your service provider.',
      name: 'login_RequestFailureUnconfiguredBundleIdError',
      desc: '',
      args: [],
    );
  }

  /// `A network issue occurred`
  String get login_SocketExceptionError {
    return Intl.message(
      'A network issue occurred',
      name: 'login_SocketExceptionError',
      desc: '',
      args: [],
    );
  }

  /// `If you do not yet have your own WebTrit Cloud Backend - contact sales team {email}.`
  String login_Text_coreUrlAssignPostDescription(Object email) {
    return Intl.message(
      'If you do not yet have your own WebTrit Cloud Backend - contact sales team $email.',
      name: 'login_Text_coreUrlAssignPostDescription',
      desc: '',
      args: [email],
    );
  }

  /// `In order to make calls via your own PortaPhone instance and your own PortaSwitch please enter the server's URL (as it was provided to you by your account manager) below.`
  String get login_Text_coreUrlAssignPreDescription {
    return Intl.message(
      'In order to make calls via your own PortaPhone instance and your own PortaSwitch please enter the server\'s URL (as it was provided to you by your account manager) below.',
      name: 'login_Text_coreUrlAssignPreDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enter your PortaPhone instance URL`
  String get login_TextFieldLabelText_coreUrlAssign {
    return Intl.message(
      'Enter your PortaPhone instance URL',
      name: 'login_TextFieldLabelText_coreUrlAssign',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get login_TextFieldLabelText_otpRequestEmail {
    return Intl.message(
      'Enter your email',
      name: 'login_TextFieldLabelText_otpRequestEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get login_TextFieldLabelText_otpRequestPhone {
    return Intl.message(
      'Enter your phone number',
      name: 'login_TextFieldLabelText_otpRequestPhone',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code`
  String get login_TextFieldLabelText_otpVerifyCode {
    return Intl.message(
      'Enter the verification code',
      name: 'login_TextFieldLabelText_otpVerifyCode',
      desc: '',
      args: [],
    );
  }

  /// `If you do not have an account yet, it will be automatically created for you.`
  String get login_Text_otpRequestDemoDescription {
    return Intl.message(
      'If you do not have an account yet, it will be automatically created for you.',
      name: 'login_Text_otpRequestDemoDescription',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get login_Text_otpRequestDescription {
    return Intl.message(
      '',
      name: 'login_Text_otpRequestDescription',
      desc: '',
      args: [],
    );
  }

  /// `If you do not see an email with the verification code from {email} in your inbox, please check your spam folder.`
  String login_Text_otpVerifyCheckSpamFrom(String email) {
    return Intl.message(
      'If you do not see an email with the verification code from $email in your inbox, please check your spam folder.',
      name: 'login_Text_otpVerifyCheckSpamFrom',
      desc: '',
      args: [email],
    );
  }

  /// `If you do not see an email with the verification code in your inbox, please check your spam folder.`
  String get login_Text_otpVerifyCheckSpamGeneral {
    return Intl.message(
      'If you do not see an email with the verification code in your inbox, please check your spam folder.',
      name: 'login_Text_otpVerifyCheckSpamGeneral',
      desc: '',
      args: [],
    );
  }

  /// `A one-time verification code was sent to {email}.`
  String login_Text_otpVerifySentToEmail(String email) {
    return Intl.message(
      'A one-time verification code was sent to $email.',
      name: 'login_Text_otpVerifySentToEmail',
      desc: '',
      args: [email],
    );
  }

  /// `A one-time verification code was sent to the email assigned to the tel:{phone} phone number.`
  String login_Text_otpVerifySentToEmailAssignedWithPhone(String phone) {
    return Intl.message(
      'A one-time verification code was sent to the email assigned to the tel:$phone phone number.',
      name: 'login_Text_otpVerifySentToEmailAssignedWithPhone',
      desc: '',
      args: [phone],
    );
  }

  /// `A secure networking issue occurred`
  String get login_TlsExceptionError {
    return Intl.message(
      'A secure networking issue occurred',
      name: 'login_TlsExceptionError',
      desc: '',
      args: [],
    );
  }

  /// `A response issue occurred`
  String get login_TypeErrorError {
    return Intl.message(
      'A response issue occurred',
      name: 'login_TypeErrorError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid URL`
  String get login_validationCoreUrlError {
    return Intl.message(
      'Please enter a valid URL',
      name: 'login_validationCoreUrlError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get login_validationEmailError {
    return Intl.message(
      'Please enter a valid email',
      name: 'login_validationEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get login_validationPhoneError {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'login_validationPhoneError',
      desc: '',
      args: [],
    );
  }

  /// `Log Console`
  String get logRecordsConsole_AppBarTitle {
    return Intl.message(
      'Log Console',
      name: 'logRecordsConsole_AppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get logRecordsConsole_Button_failureRefresh {
    return Intl.message(
      'Refresh',
      name: 'logRecordsConsole_Button_failureRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Oops... an error occurred ☹️`
  String get logRecordsConsole_Text_failure {
    return Intl.message(
      'Oops... an error occurred ☹️',
      name: 'logRecordsConsole_Text_failure',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get main_BottomNavigationBarItemLabel_contacts {
    return Intl.message(
      'Contacts',
      name: 'main_BottomNavigationBarItemLabel_contacts',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get main_BottomNavigationBarItemLabel_favorites {
    return Intl.message(
      'Favorites',
      name: 'main_BottomNavigationBarItemLabel_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Keypad`
  String get main_BottomNavigationBarItemLabel_keypad {
    return Intl.message(
      'Keypad',
      name: 'main_BottomNavigationBarItemLabel_keypad',
      desc: '',
      args: [],
    );
  }

  /// `Recents`
  String get main_BottomNavigationBarItemLabel_recents {
    return Intl.message(
      'Recents',
      name: 'main_BottomNavigationBarItemLabel_recents',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get main_CompatibilityIssueDialogActions_logout {
    return Intl.message(
      'Logout',
      name: 'main_CompatibilityIssueDialogActions_logout',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get main_CompatibilityIssueDialogActions_update {
    return Intl.message(
      'Update',
      name: 'main_CompatibilityIssueDialogActions_update',
      desc: '',
      args: [],
    );
  }

  /// `Check again`
  String get main_CompatibilityIssueDialogActions_verify {
    return Intl.message(
      'Check again',
      name: 'main_CompatibilityIssueDialogActions_verify',
      desc: '',
      args: [],
    );
  }

  /// `Incompatible PortaPhone instance version, please contact the administrator of your system (actual: {actual}, supported: {supportedConstraint})`
  String
      main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(
          String actual, String supportedConstraint) {
    return Intl.message(
      'Incompatible PortaPhone instance version, please contact the administrator of your system (actual: $actual, supported: $supportedConstraint)',
      name:
          'main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError',
      desc: '',
      args: [actual, supportedConstraint],
    );
  }

  /// `Compatibility issue`
  String get main_CompatibilityIssueDialog_title {
    return Intl.message(
      'Compatibility issue',
      name: 'main_CompatibilityIssueDialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get notifications_errorSnackBarAction_callUserMedia {
    return Intl.message(
      'Check',
      name: 'notifications_errorSnackBarAction_callUserMedia',
      desc: '',
      args: [],
    );
  }

  /// `Connecting to the core failed, trying to reconnect`
  String get notifications_errorSnackBar_callConnect {
    return Intl.message(
      'Connecting to the core failed, trying to reconnect',
      name: 'notifications_errorSnackBar_callConnect',
      desc: '',
      args: [],
    );
  }

  /// `Cannot initiate the call, please check the connection status`
  String get notifications_errorSnackBar_callSignalingClientNotConnect {
    return Intl.message(
      'Cannot initiate the call, please check the connection status',
      name: 'notifications_errorSnackBar_callSignalingClientNotConnect',
      desc: '',
      args: [],
    );
  }

  /// `The current connection session is invalid, please sign in again`
  String get notifications_errorSnackBar_callSignalingClientSessionMissed {
    return Intl.message(
      'The current connection session is invalid, please sign in again',
      name: 'notifications_errorSnackBar_callSignalingClientSessionMissed',
      desc: '',
      args: [],
    );
  }

  /// `No idle lines to initiate the call`
  String get notifications_errorSnackBar_callUndefinedLine {
    return Intl.message(
      'No idle lines to initiate the call',
      name: 'notifications_errorSnackBar_callUndefinedLine',
      desc: '',
      args: [],
    );
  }

  /// `No access to media input, please check app permissions`
  String get notifications_errorSnackBar_callUserMedia {
    return Intl.message(
      'No access to media input, please check app permissions',
      name: 'notifications_errorSnackBar_callUserMedia',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, not implemented yet`
  String get notImplemented {
    return Intl.message(
      'Sorry, not implemented yet',
      name: 'notImplemented',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get permission_Button_request {
    return Intl.message(
      'Continue',
      name: 'permission_Button_request',
      desc: '',
      args: [],
    );
  }

  /// `To ensure the best user experience, the app needs to be granted the following permissions: microphone for audio calls, camera for video calls, and contacts to simplify reaching them from the app.\n\nPermissions could be changed at any time in the future.`
  String get permission_Text_description {
    return Intl.message(
      'To ensure the best user experience, the app needs to be granted the following permissions: microphone for audio calls, camera for video calls, and contacts to simplify reaching them from the app.\n\nPermissions could be changed at any time in the future.',
      name: 'permission_Text_description',
      desc: '',
      args: [],
    );
  }

  /// `Currently you have no {filter} recent calls.`
  String recents_BodyCenter_empty(Object filter) {
    return Intl.message(
      'Currently you have no $filter recent calls.',
      name: 'recents_BodyCenter_empty',
      desc: '',
      args: [filter],
    );
  }

  /// `Are you sure you want to delete the current call log?`
  String get recents_DeleteConfirmDialog_content {
    return Intl.message(
      'Are you sure you want to delete the current call log?',
      name: 'recents_DeleteConfirmDialog_content',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete`
  String get recents_DeleteConfirmDialog_title {
    return Intl.message(
      'Confirm delete',
      name: 'recents_DeleteConfirmDialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Oops... an error happened ☹️`
  String get recents_errorSnackBar_loadFailure {
    return Intl.message(
      'Oops... an error happened ☹️',
      name: 'recents_errorSnackBar_loadFailure',
      desc: '',
      args: [],
    );
  }

  /// `{name} deleted`
  String recents_snackBar_deleted(String name) {
    return Intl.message(
      '$name deleted',
      name: 'recents_snackBar_deleted',
      desc: '',
      args: [name],
    );
  }

  /// `All`
  String get recentsVisibilityFilter_all {
    return Intl.message(
      'All',
      name: 'recentsVisibilityFilter_all',
      desc: '',
      args: [],
    );
  }

  /// `Incoming`
  String get recentsVisibilityFilter_incoming {
    return Intl.message(
      'Incoming',
      name: 'recentsVisibilityFilter_incoming',
      desc: '',
      args: [],
    );
  }

  /// `Missed`
  String get recentsVisibilityFilter_missed {
    return Intl.message(
      'Missed',
      name: 'recentsVisibilityFilter_missed',
      desc: '',
      args: [],
    );
  }

  /// `Outgoing`
  String get recentsVisibilityFilter_outgoing {
    return Intl.message(
      'Outgoing',
      name: 'recentsVisibilityFilter_outgoing',
      desc: '',
      args: [],
    );
  }

  /// `{time}`
  String recentTimeAfterMidnight(DateTime time) {
    final DateFormat timeDateFormat = DateFormat.yMd(Intl.getCurrentLocale());
    final String timeString = timeDateFormat.format(time);

    return Intl.message(
      '$timeString',
      name: 'recentTimeAfterMidnight',
      desc: '',
      args: [timeString],
    );
  }

  /// `{time}`
  String recentTimeBeforeMidnight(DateTime time) {
    final DateFormat timeDateFormat = DateFormat.Hm(Intl.getCurrentLocale());
    final String timeString = timeDateFormat.format(time);

    return Intl.message(
      '$timeString',
      name: 'recentTimeBeforeMidnight',
      desc: '',
      args: [timeString],
    );
  }

  /// `?.?.?`
  String get settings_AboutText_CoreVersionUndefined {
    return Intl.message(
      '?.?.?',
      name: 'settings_AboutText_CoreVersionUndefined',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete account?`
  String get settings_AccountDeleteConfirmDialog_content {
    return Intl.message(
      'Are you sure you want to delete account?',
      name: 'settings_AccountDeleteConfirmDialog_content',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete account`
  String get settings_AccountDeleteConfirmDialog_title {
    return Intl.message(
      'Confirm delete account',
      name: 'settings_AccountDeleteConfirmDialog_title',
      desc: '',
      args: [],
    );
  }

  /// `My account`
  String get settings_AppBarTitle_myAccount {
    return Intl.message(
      'My account',
      name: 'settings_AppBarTitle_myAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to force logout?`
  String get settings_ForceLogoutConfirmDialog_content {
    return Intl.message(
      'Are you sure you want to force logout?',
      name: 'settings_ForceLogoutConfirmDialog_content',
      desc: '',
      args: [],
    );
  }

  /// `Confirm force logout`
  String get settings_ForceLogoutConfirmDialog_title {
    return Intl.message(
      'Confirm force logout',
      name: 'settings_ForceLogoutConfirmDialog_title',
      desc: '',
      args: [],
    );
  }

  /// `A response issue occurred`
  String get settings_FormatExceptionError {
    return Intl.message(
      'A response issue occurred',
      name: 'settings_FormatExceptionError',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get settings_ListViewTileTitle_about {
    return Intl.message(
      'About',
      name: 'settings_ListViewTileTitle_about',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get settings_ListViewTileTitle_accountDelete {
    return Intl.message(
      'Delete account',
      name: 'settings_ListViewTileTitle_accountDelete',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get settings_ListViewTileTitle_help {
    return Intl.message(
      'Help',
      name: 'settings_ListViewTileTitle_help',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_ListViewTileTitle_language {
    return Intl.message(
      'Language',
      name: 'settings_ListViewTileTitle_language',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get settings_ListViewTileTitle_logout {
    return Intl.message(
      'Logout',
      name: 'settings_ListViewTileTitle_logout',
      desc: '',
      args: [],
    );
  }

  /// `Log records console`
  String get settings_ListViewTileTitle_logRecordsConsole {
    return Intl.message(
      'Log records console',
      name: 'settings_ListViewTileTitle_logRecordsConsole',
      desc: '',
      args: [],
    );
  }

  /// `Network settings`
  String get settings_ListViewTileTitle_network {
    return Intl.message(
      'Network settings',
      name: 'settings_ListViewTileTitle_network',
      desc: '',
      args: [],
    );
  }

  /// `Registered`
  String get settings_ListViewTileTitle_registered {
    return Intl.message(
      'Registered',
      name: 'settings_ListViewTileTitle_registered',
      desc: '',
      args: [],
    );
  }

  /// `SETTINGS`
  String get settings_ListViewTileTitle_settings {
    return Intl.message(
      'SETTINGS',
      name: 'settings_ListViewTileTitle_settings',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get settings_ListViewTileTitle_termsConditions {
    return Intl.message(
      'Terms and conditions',
      name: 'settings_ListViewTileTitle_termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Theme mode`
  String get settings_ListViewTileTitle_themeMode {
    return Intl.message(
      'Theme mode',
      name: 'settings_ListViewTileTitle_themeMode',
      desc: '',
      args: [],
    );
  }

  /// `TOOLBOX`
  String get settings_ListViewTileTitle_toolbox {
    return Intl.message(
      'TOOLBOX',
      name: 'settings_ListViewTileTitle_toolbox',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get settings_LogoutConfirmDialog_content {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'settings_LogoutConfirmDialog_content',
      desc: '',
      args: [],
    );
  }

  /// `Confirm logout`
  String get settings_LogoutConfirmDialog_title {
    return Intl.message(
      'Confirm logout',
      name: 'settings_LogoutConfirmDialog_title',
      desc: '',
      args: [],
    );
  }

  /// `A server failure occurred`
  String get settings_RequestFailureError {
    return Intl.message(
      'A server failure occurred',
      name: 'settings_RequestFailureError',
      desc: '',
      args: [],
    );
  }

  /// `A network issue occurred`
  String get settings_SocketExceptionError {
    return Intl.message(
      'A network issue occurred',
      name: 'settings_SocketExceptionError',
      desc: '',
      args: [],
    );
  }

  /// `A secure networking issue occurred`
  String get settings_TlsExceptionError {
    return Intl.message(
      'A secure networking issue occurred',
      name: 'settings_TlsExceptionError',
      desc: '',
      args: [],
    );
  }

  /// `A response issue occurred`
  String get settings_TypeErrorError {
    return Intl.message(
      'A response issue occurred',
      name: 'settings_TypeErrorError',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get themeMode_dark {
    return Intl.message(
      'Dark',
      name: 'themeMode_dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get themeMode_light {
    return Intl.message(
      'Light',
      name: 'themeMode_light',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get themeMode_system {
    return Intl.message(
      'System',
      name: 'themeMode_system',
      desc: '',
      args: [],
    );
  }

  /// `This page is under development.`
  String get underDevelopment {
    return Intl.message(
      'This page is under development.',
      name: 'underDevelopment',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a value`
  String get validationBlankError {
    return Intl.message(
      'Please enter a value',
      name: 'validationBlankError',
      desc: '',
      args: [],
    );
  }

  /// `Demo`
  String get webRegistration_ErrorAcknowledgeDialogActions_demo {
    return Intl.message(
      'Demo',
      name: 'webRegistration_ErrorAcknowledgeDialogActions_demo',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get webRegistration_ErrorAcknowledgeDialogActions_retry {
    return Intl.message(
      'Retry',
      name: 'webRegistration_ErrorAcknowledgeDialogActions_retry',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get webRegistration_ErrorAcknowledgeDialogActions_skip {
    return Intl.message(
      'Skip',
      name: 'webRegistration_ErrorAcknowledgeDialogActions_skip',
      desc: '',
      args: [],
    );
  }

  /// `Web resource error`
  String get webRegistration_ErrorAcknowledgeDialog_title {
    return Intl.message(
      'Web resource error',
      name: 'webRegistration_ErrorAcknowledgeDialog_title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<AppIntlLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'he'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppIntlLocalizations> load(Locale locale) =>
      AppIntlLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
