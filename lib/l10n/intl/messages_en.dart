// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "${name} deleted";

  static String m1(seconds) => "Resend the code (${seconds} s)";

  static String m2(actual, supportedConstraint) =>
      "An incompatible instance version provided, please contact the administrator of your system (actual: ${actual}, supported: ${supportedConstraint})";

  static String m3(email) =>
      "If you do not yet have your own WebTrit Cloud Backend - contact sales team ${email}.";

  static String m4(email) =>
      "If you do not see an email with the verification code from ${email} in your inbox, please check your spam folder.";

  static String m5(email) =>
      "A one-time verification code was sent to ${email}.";

  static String m6(phone) =>
      "A one-time verification code was sent to the email assigned to the tel:${phone} phone number.";

  static String m7(actual, supportedConstraint) =>
      "Incompatible PortaPhone instance version, please contact the administrator of your system (actual: ${actual}, supported: ${supportedConstraint})";

  static String m8(time) => "${time}";

  static String m9(time) => "${time}";

  static String m10(filter) => "Currently you have no ${filter} recent calls.";

  static String m11(name) => "${name} deleted";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertDialogActions_no": MessageLookupByLibrary.simpleMessage("No"),
        "alertDialogActions_ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "alertDialogActions_yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "callStatus_appUnregistered":
            MessageLookupByLibrary.simpleMessage("Unregistered"),
        "callStatus_connectError":
            MessageLookupByLibrary.simpleMessage("Connection error"),
        "callStatus_connectIssue":
            MessageLookupByLibrary.simpleMessage("Connection issue"),
        "callStatus_connectivityNone":
            MessageLookupByLibrary.simpleMessage("No internet connection"),
        "callStatus_inProgress":
            MessageLookupByLibrary.simpleMessage("Connection in progress"),
        "callStatus_ready":
            MessageLookupByLibrary.simpleMessage("Connection established"),
        "call_CallActionsTooltip_accept":
            MessageLookupByLibrary.simpleMessage("Accept"),
        "call_CallActionsTooltip_disableCamera":
            MessageLookupByLibrary.simpleMessage("Disable camera"),
        "call_CallActionsTooltip_disableSpeaker":
            MessageLookupByLibrary.simpleMessage("Disable speakerphone"),
        "call_CallActionsTooltip_enableCamera":
            MessageLookupByLibrary.simpleMessage("Enable camera"),
        "call_CallActionsTooltip_enableSpeaker":
            MessageLookupByLibrary.simpleMessage("Enable speakerphone"),
        "call_CallActionsTooltip_hangup":
            MessageLookupByLibrary.simpleMessage("Hangup"),
        "call_CallActionsTooltip_hideKeypad":
            MessageLookupByLibrary.simpleMessage("Hide keypad"),
        "call_CallActionsTooltip_hold":
            MessageLookupByLibrary.simpleMessage("Hold call"),
        "call_CallActionsTooltip_mute":
            MessageLookupByLibrary.simpleMessage("Mute microphone"),
        "call_CallActionsTooltip_showKeypad":
            MessageLookupByLibrary.simpleMessage("Show keypad"),
        "call_CallActionsTooltip_transfer":
            MessageLookupByLibrary.simpleMessage("Transfer"),
        "call_CallActionsTooltip_unhold":
            MessageLookupByLibrary.simpleMessage("Unhold call"),
        "call_CallActionsTooltip_unmute":
            MessageLookupByLibrary.simpleMessage("Unmute microphone"),
        "call_FailureAcknowledgeDialog_title":
            MessageLookupByLibrary.simpleMessage("Failure"),
        "call_description_incoming":
            MessageLookupByLibrary.simpleMessage("Incoming call from"),
        "call_description_outgoing":
            MessageLookupByLibrary.simpleMessage("Outgoing call to"),
        "contactsSourceExternal":
            MessageLookupByLibrary.simpleMessage("Cloud PBX"),
        "contactsSourceLocal":
            MessageLookupByLibrary.simpleMessage("Your phone"),
        "contacts_ExternalTabButton_refresh":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "contacts_ExternalTabText_empty":
            MessageLookupByLibrary.simpleMessage("No contacts"),
        "contacts_ExternalTabText_emptyOnSearching":
            MessageLookupByLibrary.simpleMessage("No contacts found"),
        "contacts_ExternalTabText_failure":
            MessageLookupByLibrary.simpleMessage(
                "Failed to get cloud PBX contacts"),
        "contacts_LocalTabButton_openAppSettings":
            MessageLookupByLibrary.simpleMessage(
                "Grant access to your phone contacts"),
        "contacts_LocalTabButton_refresh":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "contacts_LocalTabText_empty":
            MessageLookupByLibrary.simpleMessage("No contacts"),
        "contacts_LocalTabText_emptyOnSearching":
            MessageLookupByLibrary.simpleMessage("No contacts found"),
        "contacts_LocalTabText_failure": MessageLookupByLibrary.simpleMessage(
            "Failed to get your phone contacts"),
        "contacts_LocalTabText_permissionFailure":
            MessageLookupByLibrary.simpleMessage(
                "There are no permissions to get your phone contacts"),
        "copyToClipboard_floatingSnackBar":
            MessageLookupByLibrary.simpleMessage("Text copied"),
        "copyToClipboard_popupMenuItem":
            MessageLookupByLibrary.simpleMessage("Copy to clipboard"),
        "default_ClientExceptionError": MessageLookupByLibrary.simpleMessage(
            "A HTTP client issue occurred"),
        "default_FormatExceptionError":
            MessageLookupByLibrary.simpleMessage("A response issue occurred"),
        "default_RequestFailureError":
            MessageLookupByLibrary.simpleMessage("A server failure occurred"),
        "default_SocketExceptionError":
            MessageLookupByLibrary.simpleMessage("A network issue occurred"),
        "default_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "A secure networking issue occurred"),
        "default_TypeErrorError":
            MessageLookupByLibrary.simpleMessage("A response issue occurred"),
        "default_UnauthorizedRequestFailureError":
            MessageLookupByLibrary.simpleMessage(
                "An unauthorised request failure occurred"),
        "favorites_BodyCenter_empty": MessageLookupByLibrary.simpleMessage(
            "There are no favorite numbers"),
        "favorites_DeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to delete the current favorite?"),
        "favorites_DeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Confirm deleting"),
        "favorites_SnackBar_deleted": m0,
        "locale_default": MessageLookupByLibrary.simpleMessage("Default"),
        "locale_en": MessageLookupByLibrary.simpleMessage("English"),
        "logRecordsConsole_AppBarTitle":
            MessageLookupByLibrary.simpleMessage("Log Console"),
        "logRecordsConsole_Button_failureRefresh":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "logRecordsConsole_Text_failure": MessageLookupByLibrary.simpleMessage(
            "Oops... an error occurred ☹️"),
        "login_AppBarTitle_coreUrlAssign":
            MessageLookupByLibrary.simpleMessage(""),
        "login_AppBarTitle_otpRequest":
            MessageLookupByLibrary.simpleMessage(""),
        "login_AppBarTitle_otpVerify": MessageLookupByLibrary.simpleMessage(""),
        "login_ButtonTooltip_signInToYourInstance":
            MessageLookupByLibrary.simpleMessage(
                "Sign in to your PortaPhone instance"),
        "login_Button_coreUrlAssignProceed":
            MessageLookupByLibrary.simpleMessage("Proceed"),
        "login_Button_otpRequestProceed":
            MessageLookupByLibrary.simpleMessage("Proceed"),
        "login_Button_otpVerifyProceed":
            MessageLookupByLibrary.simpleMessage("Verify"),
        "login_Button_otpVerifyRepeat":
            MessageLookupByLibrary.simpleMessage("Resend the code"),
        "login_Button_otpVerifyRepeatInterval": m1,
        "login_Button_signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "login_Button_signUpToDemoInstance":
            MessageLookupByLibrary.simpleMessage("Sign up"),
        "login_CoreVersionUnsupportedExceptionError": m2,
        "login_FormatExceptionError":
            MessageLookupByLibrary.simpleMessage("A response issue occurred"),
        "login_RequestFailureCodeIncorrectError":
            MessageLookupByLibrary.simpleMessage("Incorrect verification code"),
        "login_RequestFailureEmptyEmailError":
            MessageLookupByLibrary.simpleMessage(
                "Cannot send the verification code"),
        "login_RequestFailureError":
            MessageLookupByLibrary.simpleMessage("A server failure occurred"),
        "login_RequestFailureOtpAlreadyVerifiedError":
            MessageLookupByLibrary.simpleMessage(
                "Verification already verified"),
        "login_RequestFailureOtpExpiredError":
            MessageLookupByLibrary.simpleMessage("Verification expired"),
        "login_RequestFailureOtpIdVerifyAttemptsExceededError":
            MessageLookupByLibrary.simpleMessage(
                "Verification attempts exceeded"),
        "login_RequestFailureOtpNotFoundError":
            MessageLookupByLibrary.simpleMessage("Verification not found"),
        "login_RequestFailurePhoneNotFoundError":
            MessageLookupByLibrary.simpleMessage("Phone number not found"),
        "login_RequestFailureUnconfiguredBundleIdError":
            MessageLookupByLibrary.simpleMessage(
                "App back-end configuration error - please notify your service provider."),
        "login_SocketExceptionError":
            MessageLookupByLibrary.simpleMessage("A network issue occurred"),
        "login_TextFieldLabelText_coreUrlAssign":
            MessageLookupByLibrary.simpleMessage(
                "Enter your PortaPhone instance URL"),
        "login_TextFieldLabelText_otpRequestEmail":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "login_TextFieldLabelText_otpRequestPhone":
            MessageLookupByLibrary.simpleMessage("Enter your phone number"),
        "login_TextFieldLabelText_otpVerifyCode":
            MessageLookupByLibrary.simpleMessage("Enter the verification code"),
        "login_Text_coreUrlAssignPostDescription": m3,
        "login_Text_coreUrlAssignPreDescription":
            MessageLookupByLibrary.simpleMessage(
                "In order to make calls via your own PortaPhone instance and your own PortaSwitch please enter the server\'s URL (as it was provided to you by your account manager) below."),
        "login_Text_otpRequestDemoDescription":
            MessageLookupByLibrary.simpleMessage(
                "If you do not have an account yet, it will be automatically created for you."),
        "login_Text_otpRequestDescription":
            MessageLookupByLibrary.simpleMessage(""),
        "login_Text_otpVerifyCheckSpamFrom": m4,
        "login_Text_otpVerifyCheckSpamGeneral":
            MessageLookupByLibrary.simpleMessage(
                "If you do not see an email with the verification code in your inbox, please check your spam folder."),
        "login_Text_otpVerifySentToEmail": m5,
        "login_Text_otpVerifySentToEmailAssignedWithPhone": m6,
        "login_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "A secure networking issue occurred"),
        "login_TypeErrorError":
            MessageLookupByLibrary.simpleMessage("A response issue occurred"),
        "login_validationCoreUrlError":
            MessageLookupByLibrary.simpleMessage("Please enter a valid URL"),
        "login_validationEmailError":
            MessageLookupByLibrary.simpleMessage("Please enter a valid email"),
        "login_validationPhoneError": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid phone number"),
        "main_BottomNavigationBarItemLabel_contacts":
            MessageLookupByLibrary.simpleMessage("Contacts"),
        "main_BottomNavigationBarItemLabel_favorites":
            MessageLookupByLibrary.simpleMessage("Favorites"),
        "main_BottomNavigationBarItemLabel_keypad":
            MessageLookupByLibrary.simpleMessage("Keypad"),
        "main_BottomNavigationBarItemLabel_recents":
            MessageLookupByLibrary.simpleMessage("Recents"),
        "main_CompatibilityIssueDialogActions_logout":
            MessageLookupByLibrary.simpleMessage("Logout"),
        "main_CompatibilityIssueDialogActions_update":
            MessageLookupByLibrary.simpleMessage("Update"),
        "main_CompatibilityIssueDialogActions_verify":
            MessageLookupByLibrary.simpleMessage("Check again"),
        "main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError":
            m7,
        "main_CompatibilityIssueDialog_title":
            MessageLookupByLibrary.simpleMessage("Compatibility issue"),
        "notImplemented":
            MessageLookupByLibrary.simpleMessage("Sorry, not implemented yet"),
        "notifications_errorSnackBarAction_callUserMedia":
            MessageLookupByLibrary.simpleMessage("Check"),
        "notifications_errorSnackBar_callConnect":
            MessageLookupByLibrary.simpleMessage(
                "Connecting to the core failed, trying to reconnect"),
        "notifications_errorSnackBar_callSignalingClientNotConnect":
            MessageLookupByLibrary.simpleMessage(
                "Cannot initiate the call, please check the connection status"),
        "notifications_errorSnackBar_callSignalingClientSessionMissed":
            MessageLookupByLibrary.simpleMessage(
                "The current connection session is invalid, please sign in again"),
        "notifications_errorSnackBar_callUndefinedLine":
            MessageLookupByLibrary.simpleMessage(
                "No idle lines to initiate the call"),
        "notifications_errorSnackBar_callUserMedia":
            MessageLookupByLibrary.simpleMessage(
                "No access to media input, please check app permissions"),
        "permission_Button_request":
            MessageLookupByLibrary.simpleMessage("Continue"),
        "permission_Text_description": MessageLookupByLibrary.simpleMessage(
            "To ensure the best user experience, the app needs to be granted the following permissions: microphone for audio calls, camera for video calls, and contacts to simplify reaching them from the app.\n\nPermissions could be changed at any time in the future."),
        "recentTimeAfterMidnight": m8,
        "recentTimeBeforeMidnight": m9,
        "recentsVisibilityFilter_all":
            MessageLookupByLibrary.simpleMessage("All"),
        "recentsVisibilityFilter_incoming":
            MessageLookupByLibrary.simpleMessage("Incoming"),
        "recentsVisibilityFilter_missed":
            MessageLookupByLibrary.simpleMessage("Missed"),
        "recentsVisibilityFilter_outgoing":
            MessageLookupByLibrary.simpleMessage("Outgoing"),
        "recents_BodyCenter_empty": m10,
        "recents_DeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to delete the current call log?"),
        "recents_DeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Confirm delete"),
        "recents_errorSnackBar_loadFailure":
            MessageLookupByLibrary.simpleMessage(
                "Oops... an error happened ☹️"),
        "recents_snackBar_deleted": m11,
        "settings_AboutText_CoreVersionUndefined":
            MessageLookupByLibrary.simpleMessage("?.?.?"),
        "settings_AccountDeleteConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to delete account?"),
        "settings_AccountDeleteConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Confirm delete account"),
        "settings_AppBarTitle_myAccount":
            MessageLookupByLibrary.simpleMessage("My account"),
        "settings_ForceLogoutConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to force logout?"),
        "settings_ForceLogoutConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Confirm force logout"),
        "settings_FormatExceptionError":
            MessageLookupByLibrary.simpleMessage("A response issue occurred"),
        "settings_ListViewTileTitle_about":
            MessageLookupByLibrary.simpleMessage("About"),
        "settings_ListViewTileTitle_accountDelete":
            MessageLookupByLibrary.simpleMessage("Delete account"),
        "settings_ListViewTileTitle_help":
            MessageLookupByLibrary.simpleMessage("Help"),
        "settings_ListViewTileTitle_language":
            MessageLookupByLibrary.simpleMessage("Language"),
        "settings_ListViewTileTitle_logRecordsConsole":
            MessageLookupByLibrary.simpleMessage("Log records console"),
        "settings_ListViewTileTitle_logout":
            MessageLookupByLibrary.simpleMessage("Logout"),
        "settings_ListViewTileTitle_network":
            MessageLookupByLibrary.simpleMessage("Network settings"),
        "settings_ListViewTileTitle_registered":
            MessageLookupByLibrary.simpleMessage("Registered"),
        "settings_ListViewTileTitle_settings":
            MessageLookupByLibrary.simpleMessage("SETTINGS"),
        "settings_ListViewTileTitle_termsConditions":
            MessageLookupByLibrary.simpleMessage("Terms and conditions"),
        "settings_ListViewTileTitle_themeMode":
            MessageLookupByLibrary.simpleMessage("Theme mode"),
        "settings_ListViewTileTitle_toolbox":
            MessageLookupByLibrary.simpleMessage("TOOLBOX"),
        "settings_LogoutConfirmDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to logout?"),
        "settings_LogoutConfirmDialog_title":
            MessageLookupByLibrary.simpleMessage("Confirm logout"),
        "settings_RequestFailureError":
            MessageLookupByLibrary.simpleMessage("A server failure occurred"),
        "settings_SocketExceptionError":
            MessageLookupByLibrary.simpleMessage("A network issue occurred"),
        "settings_TlsExceptionError": MessageLookupByLibrary.simpleMessage(
            "A secure networking issue occurred"),
        "settings_TypeErrorError":
            MessageLookupByLibrary.simpleMessage("A response issue occurred"),
        "themeMode_dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "themeMode_light": MessageLookupByLibrary.simpleMessage("Light"),
        "themeMode_system": MessageLookupByLibrary.simpleMessage("System"),
        "underDevelopment": MessageLookupByLibrary.simpleMessage(
            "This page is under development."),
        "validationBlankError":
            MessageLookupByLibrary.simpleMessage("Please enter a value"),
        "webRegistration_ErrorAcknowledgeDialogActions_demo":
            MessageLookupByLibrary.simpleMessage("Demo"),
        "webRegistration_ErrorAcknowledgeDialogActions_retry":
            MessageLookupByLibrary.simpleMessage("Retry"),
        "webRegistration_ErrorAcknowledgeDialogActions_skip":
            MessageLookupByLibrary.simpleMessage("Skip"),
        "webRegistration_ErrorAcknowledgeDialog_title":
            MessageLookupByLibrary.simpleMessage("Web resource error")
      };
}
