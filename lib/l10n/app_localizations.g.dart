import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.g.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.g.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @locale_default.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get locale_default;

  /// No description provided for @locale_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get locale_en;

  /// No description provided for @themeMode_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeMode_system;

  /// No description provided for @themeMode_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeMode_light;

  /// No description provided for @themeMode_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeMode_dark;

  /// No description provided for @alertDialogActions_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get alertDialogActions_no;

  /// No description provided for @alertDialogActions_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get alertDialogActions_yes;

  /// No description provided for @alertDialogActions_ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get alertDialogActions_ok;

  /// No description provided for @callStatus_connectivityNone.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get callStatus_connectivityNone;

  /// No description provided for @callStatus_connectError.
  ///
  /// In en, this message translates to:
  /// **'Connection error'**
  String get callStatus_connectError;

  /// No description provided for @callStatus_appUnregistered.
  ///
  /// In en, this message translates to:
  /// **'Unregistered'**
  String get callStatus_appUnregistered;

  /// No description provided for @callStatus_connectIssue.
  ///
  /// In en, this message translates to:
  /// **'Connection issue'**
  String get callStatus_connectIssue;

  /// No description provided for @callStatus_inProgress.
  ///
  /// In en, this message translates to:
  /// **'Connection in progress'**
  String get callStatus_inProgress;

  /// No description provided for @callStatus_ready.
  ///
  /// In en, this message translates to:
  /// **'Connection established'**
  String get callStatus_ready;

  /// No description provided for @notifications_errorSnackBar_callUndefinedLine.
  ///
  /// In en, this message translates to:
  /// **'No idle lines to initiate the call'**
  String get notifications_errorSnackBar_callUndefinedLine;

  /// No description provided for @notifications_errorSnackBar_callSignalingClientNotConnect.
  ///
  /// In en, this message translates to:
  /// **'Cannot initiate the call, please check the connection status'**
  String get notifications_errorSnackBar_callSignalingClientNotConnect;

  /// No description provided for @notifications_errorSnackBar_callSignalingClientSessionMissed.
  ///
  /// In en, this message translates to:
  /// **'The current connection session is invalid, please sign in again'**
  String get notifications_errorSnackBar_callSignalingClientSessionMissed;

  /// No description provided for @notifications_errorSnackBar_callConnect.
  ///
  /// In en, this message translates to:
  /// **'Connecting to the core failed, trying to reconnect'**
  String get notifications_errorSnackBar_callConnect;

  /// No description provided for @notifications_errorSnackBar_callUserMedia.
  ///
  /// In en, this message translates to:
  /// **'No access to media input, please check app permissions'**
  String get notifications_errorSnackBar_callUserMedia;

  /// No description provided for @notifications_errorSnackBarAction_callUserMedia.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get notifications_errorSnackBarAction_callUserMedia;

  /// No description provided for @main_BottomNavigationBarItemLabel_favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get main_BottomNavigationBarItemLabel_favorites;

  /// No description provided for @main_BottomNavigationBarItemLabel_recents.
  ///
  /// In en, this message translates to:
  /// **'Recents'**
  String get main_BottomNavigationBarItemLabel_recents;

  /// No description provided for @main_BottomNavigationBarItemLabel_contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get main_BottomNavigationBarItemLabel_contacts;

  /// No description provided for @main_BottomNavigationBarItemLabel_keypad.
  ///
  /// In en, this message translates to:
  /// **'Keypad'**
  String get main_BottomNavigationBarItemLabel_keypad;

  /// No description provided for @call_FailureAcknowledgeDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get call_FailureAcknowledgeDialog_title;

  /// No description provided for @call_description_incoming.
  ///
  /// In en, this message translates to:
  /// **'Incoming call from'**
  String get call_description_incoming;

  /// No description provided for @call_description_outgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing call to'**
  String get call_description_outgoing;

  /// No description provided for @call_CallActionsTooltip_mute.
  ///
  /// In en, this message translates to:
  /// **'Mute microphone'**
  String get call_CallActionsTooltip_mute;

  /// No description provided for @call_CallActionsTooltip_unmute.
  ///
  /// In en, this message translates to:
  /// **'Unmute microphone'**
  String get call_CallActionsTooltip_unmute;

  /// No description provided for @call_CallActionsTooltip_disableCamera.
  ///
  /// In en, this message translates to:
  /// **'Disable camera'**
  String get call_CallActionsTooltip_disableCamera;

  /// No description provided for @call_CallActionsTooltip_enableCamera.
  ///
  /// In en, this message translates to:
  /// **'Enable camera'**
  String get call_CallActionsTooltip_enableCamera;

  /// No description provided for @call_CallActionsTooltip_disableSpeaker.
  ///
  /// In en, this message translates to:
  /// **'Disable speakerphone'**
  String get call_CallActionsTooltip_disableSpeaker;

  /// No description provided for @call_CallActionsTooltip_enableSpeaker.
  ///
  /// In en, this message translates to:
  /// **'Enable speakerphone'**
  String get call_CallActionsTooltip_enableSpeaker;

  /// No description provided for @call_CallActionsTooltip_transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get call_CallActionsTooltip_transfer;

  /// No description provided for @call_CallActionsTooltip_hold.
  ///
  /// In en, this message translates to:
  /// **'Hold call'**
  String get call_CallActionsTooltip_hold;

  /// No description provided for @call_CallActionsTooltip_unhold.
  ///
  /// In en, this message translates to:
  /// **'Unhold call'**
  String get call_CallActionsTooltip_unhold;

  /// No description provided for @call_CallActionsTooltip_showKeypad.
  ///
  /// In en, this message translates to:
  /// **'Show keypad'**
  String get call_CallActionsTooltip_showKeypad;

  /// No description provided for @call_CallActionsTooltip_hideKeypad.
  ///
  /// In en, this message translates to:
  /// **'Hide keypad'**
  String get call_CallActionsTooltip_hideKeypad;

  /// No description provided for @call_CallActionsTooltip_hangup.
  ///
  /// In en, this message translates to:
  /// **'Hangup'**
  String get call_CallActionsTooltip_hangup;

  /// No description provided for @call_CallActionsTooltip_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get call_CallActionsTooltip_accept;

  /// No description provided for @favorites_BodyCenter_empty.
  ///
  /// In en, this message translates to:
  /// **'There are no favorite numbers'**
  String get favorites_BodyCenter_empty;

  /// No description provided for @favorites_SnackBar_deleted.
  ///
  /// In en, this message translates to:
  /// **'{name} deleted'**
  String favorites_SnackBar_deleted(String name);

  /// No description provided for @favorites_DeleteConfirmDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm deleting'**
  String get favorites_DeleteConfirmDialog_title;

  /// No description provided for @favorites_DeleteConfirmDialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the current favorite?'**
  String get favorites_DeleteConfirmDialog_content;

  /// No description provided for @login_ButtonTooltip_signInToYourInstance.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your PortaPhone instance'**
  String get login_ButtonTooltip_signInToYourInstance;

  /// No description provided for @login_Button_signUpToDemoInstance.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get login_Button_signUpToDemoInstance;

  /// No description provided for @login_Button_signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login_Button_signIn;

  /// No description provided for @login_AppBarTitle_coreUrlAssign.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_AppBarTitle_coreUrlAssign;

  /// No description provided for @login_TextFieldLabelText_coreUrlAssign.
  ///
  /// In en, this message translates to:
  /// **'Enter your PortaPhone instance URL'**
  String get login_TextFieldLabelText_coreUrlAssign;

  /// No description provided for @login_Text_coreUrlAssignPreDescription.
  ///
  /// In en, this message translates to:
  /// **'In order to make calls via your own PortaPhone instance and your own PortaSwitch please enter the server\'s URL (as it was provided to you by your account manager) below.'**
  String get login_Text_coreUrlAssignPreDescription;

  /// No description provided for @login_Text_coreUrlAssignPostDescription.
  ///
  /// In en, this message translates to:
  /// **'If you do not yet have your own PortaPhone instance - contact sales team sales@portaone.com.'**
  String get login_Text_coreUrlAssignPostDescription;

  /// No description provided for @login_Button_coreUrlAssignProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get login_Button_coreUrlAssignProceed;

  /// No description provided for @login_AppBarTitle_otpRequest.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_AppBarTitle_otpRequest;

  /// No description provided for @login_TextFieldLabelText_otpRequestEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get login_TextFieldLabelText_otpRequestEmail;

  /// No description provided for @login_TextFieldLabelText_otpRequestPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get login_TextFieldLabelText_otpRequestPhone;

  /// No description provided for @login_Text_otpRequestDemoDescription.
  ///
  /// In en, this message translates to:
  /// **'If you do not have an account yet, it will be automatically created for you.'**
  String get login_Text_otpRequestDemoDescription;

  /// No description provided for @login_Text_otpRequestDescription.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_Text_otpRequestDescription;

  /// No description provided for @login_Button_otpRequestProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get login_Button_otpRequestProceed;

  /// No description provided for @login_AppBarTitle_otpVerify.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_AppBarTitle_otpVerify;

  /// No description provided for @login_Text_otpVerifySentToEmail.
  ///
  /// In en, this message translates to:
  /// **'A one-time verification code was sent to {email}.'**
  String login_Text_otpVerifySentToEmail(String email);

  /// No description provided for @login_Text_otpVerifySentToEmailAssignedWithPhone.
  ///
  /// In en, this message translates to:
  /// **'A one-time verification code was sent to the email assigned to the tel:{phone} phone number.'**
  String login_Text_otpVerifySentToEmailAssignedWithPhone(String phone);

  /// No description provided for @login_TextFieldLabelText_otpVerifyCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code'**
  String get login_TextFieldLabelText_otpVerifyCode;

  /// No description provided for @login_Text_otpVerifyCheckSpamGeneral.
  ///
  /// In en, this message translates to:
  /// **'If you do not see an email with the verification code in your inbox, please check your spam folder.'**
  String get login_Text_otpVerifyCheckSpamGeneral;

  /// No description provided for @login_Text_otpVerifyCheckSpamFrom.
  ///
  /// In en, this message translates to:
  /// **'If you do not see an email with the verification code from {email} in your inbox, please check your spam folder.'**
  String login_Text_otpVerifyCheckSpamFrom(String email);

  /// No description provided for @login_Button_otpVerifyRepeatInterval.
  ///
  /// In en, this message translates to:
  /// **'Resend the code ({seconds} s)'**
  String login_Button_otpVerifyRepeatInterval(int seconds);

  /// No description provided for @login_Button_otpVerifyRepeat.
  ///
  /// In en, this message translates to:
  /// **'Resend the code'**
  String get login_Button_otpVerifyRepeat;

  /// No description provided for @login_Button_otpVerifyProceed.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get login_Button_otpVerifyProceed;

  /// No description provided for @login_validationEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get login_validationEmailError;

  /// No description provided for @login_validationPhoneError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get login_validationPhoneError;

  /// No description provided for @login_validationCoreUrlError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get login_validationCoreUrlError;

  /// No description provided for @login_LoginIncompatibleCoreVersionExceptionError.
  ///
  /// In en, this message translates to:
  /// **'An incompatible instance version provided, please contact the administrator of your system (actual: {actual}, expected: {expected})'**
  String login_LoginIncompatibleCoreVersionExceptionError(String actual, String expected);

  /// No description provided for @login_FormatExceptionError.
  ///
  /// In en, this message translates to:
  /// **'A response issue occurred'**
  String get login_FormatExceptionError;

  /// No description provided for @login_TlsExceptionError.
  ///
  /// In en, this message translates to:
  /// **'A secure networking issue occurred'**
  String get login_TlsExceptionError;

  /// No description provided for @login_SocketExceptionError.
  ///
  /// In en, this message translates to:
  /// **'A network issue occurred'**
  String get login_SocketExceptionError;

  /// No description provided for @login_TypeErrorError.
  ///
  /// In en, this message translates to:
  /// **'A response issue occurred'**
  String get login_TypeErrorError;

  /// No description provided for @login_RequestFailureError.
  ///
  /// In en, this message translates to:
  /// **'A server failure occurred'**
  String get login_RequestFailureError;

  /// No description provided for @login_RequestFailureEmptyEmailError.
  ///
  /// In en, this message translates to:
  /// **'Cannot send the verification code'**
  String get login_RequestFailureEmptyEmailError;

  /// No description provided for @login_RequestFailurePhoneNotFoundError.
  ///
  /// In en, this message translates to:
  /// **'Phone number not found'**
  String get login_RequestFailurePhoneNotFoundError;

  /// No description provided for @login_RequestFailureCodeIncorrectError.
  ///
  /// In en, this message translates to:
  /// **'Incorrect verification code'**
  String get login_RequestFailureCodeIncorrectError;

  /// No description provided for @login_RequestFailureOtpIdVerifyAttemptsExceededError.
  ///
  /// In en, this message translates to:
  /// **'Verification attempts exceeded'**
  String get login_RequestFailureOtpIdVerifyAttemptsExceededError;

  /// No description provided for @permission_Text_description.
  ///
  /// In en, this message translates to:
  /// **'To ensure the best user experience, the app needs to be granted the following permissions: microphone for audio calls, camera for video calls, and contacts to simplify reaching them from the app.\n\nPermissions could be changed at any time in the future.'**
  String get permission_Text_description;

  /// No description provided for @permission_Button_request.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get permission_Button_request;

  /// No description provided for @validationBlankError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a value'**
  String get validationBlankError;

  /// No description provided for @recentTimeBeforeMidnight.
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String recentTimeBeforeMidnight(DateTime time);

  /// No description provided for @recentTimeAfterMidnight.
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String recentTimeAfterMidnight(DateTime time);

  /// No description provided for @recentsVisibilityFilter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get recentsVisibilityFilter_all;

  /// No description provided for @recentsVisibilityFilter_missed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get recentsVisibilityFilter_missed;

  /// No description provided for @recentsVisibilityFilter_incoming.
  ///
  /// In en, this message translates to:
  /// **'Incoming'**
  String get recentsVisibilityFilter_incoming;

  /// No description provided for @recentsVisibilityFilter_outgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get recentsVisibilityFilter_outgoing;

  /// No description provided for @recents_errorSnackBar_loadFailure.
  ///
  /// In en, this message translates to:
  /// **'Oops... an error happened ☹️'**
  String get recents_errorSnackBar_loadFailure;

  /// No description provided for @recents_snackBar_deleted.
  ///
  /// In en, this message translates to:
  /// **'{name} deleted'**
  String recents_snackBar_deleted(String name);

  /// No description provided for @recents_DeleteConfirmDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm deleting'**
  String get recents_DeleteConfirmDialog_title;

  /// No description provided for @recents_DeleteConfirmDialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the current call log?'**
  String get recents_DeleteConfirmDialog_content;

  /// No description provided for @contactsSourceLocal.
  ///
  /// In en, this message translates to:
  /// **'Your phone'**
  String get contactsSourceLocal;

  /// No description provided for @contactsSourceExternal.
  ///
  /// In en, this message translates to:
  /// **'Cloud PBX'**
  String get contactsSourceExternal;

  /// No description provided for @contacts_LocalTabText_permissionFailure.
  ///
  /// In en, this message translates to:
  /// **'There are no permissions to get your phone contacts'**
  String get contacts_LocalTabText_permissionFailure;

  /// No description provided for @contacts_LocalTabButton_openAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Grant access to your phone contacts'**
  String get contacts_LocalTabButton_openAppSettings;

  /// No description provided for @contacts_LocalTabText_failure.
  ///
  /// In en, this message translates to:
  /// **'Failed to get your phone contacts'**
  String get contacts_LocalTabText_failure;

  /// No description provided for @contacts_LocalTabText_emptyOnSearching.
  ///
  /// In en, this message translates to:
  /// **'No contacts found'**
  String get contacts_LocalTabText_emptyOnSearching;

  /// No description provided for @contacts_LocalTabText_empty.
  ///
  /// In en, this message translates to:
  /// **'No contacts'**
  String get contacts_LocalTabText_empty;

  /// No description provided for @contacts_LocalTabButton_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get contacts_LocalTabButton_refresh;

  /// No description provided for @contacts_ExternalTabText_failure.
  ///
  /// In en, this message translates to:
  /// **'Failed to get cloud PBX contacts'**
  String get contacts_ExternalTabText_failure;

  /// No description provided for @contacts_ExternalTabText_emptyOnSearching.
  ///
  /// In en, this message translates to:
  /// **'No contacts found'**
  String get contacts_ExternalTabText_emptyOnSearching;

  /// No description provided for @contacts_ExternalTabText_empty.
  ///
  /// In en, this message translates to:
  /// **'No contacts'**
  String get contacts_ExternalTabText_empty;

  /// No description provided for @contacts_ExternalTabButton_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get contacts_ExternalTabButton_refresh;

  /// No description provided for @settings_AppBarTitle_myAccount.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get settings_AppBarTitle_myAccount;

  /// No description provided for @settings_ListViewTileTitle_registered.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get settings_ListViewTileTitle_registered;

  /// No description provided for @settings_ListViewTileTitle_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settings_ListViewTileTitle_logout;

  /// No description provided for @settings_ListViewTileTitle_settings.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settings_ListViewTileTitle_settings;

  /// No description provided for @settings_ListViewTileTitle_network.
  ///
  /// In en, this message translates to:
  /// **'Network settings'**
  String get settings_ListViewTileTitle_network;

  /// No description provided for @settings_ListViewTileTitle_help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get settings_ListViewTileTitle_help;

  /// No description provided for @settings_ListViewTileTitle_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_ListViewTileTitle_language;

  /// No description provided for @settings_ListViewTileTitle_termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get settings_ListViewTileTitle_termsConditions;

  /// No description provided for @settings_ListViewTileTitle_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_ListViewTileTitle_about;

  /// No description provided for @settings_ListViewTileTitle_themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get settings_ListViewTileTitle_themeMode;

  /// No description provided for @settings_ListViewTileTitle_toolbox.
  ///
  /// In en, this message translates to:
  /// **'TOOLBOX'**
  String get settings_ListViewTileTitle_toolbox;

  /// No description provided for @settings_ListViewTileTitle_logRecordsConsole.
  ///
  /// In en, this message translates to:
  /// **'Log records console'**
  String get settings_ListViewTileTitle_logRecordsConsole;

  /// No description provided for @settings_LogoutConfirmDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm logout'**
  String get settings_LogoutConfirmDialog_title;

  /// No description provided for @settings_LogoutConfirmDialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get settings_LogoutConfirmDialog_content;

  /// No description provided for @settings_FormatExceptionError.
  ///
  /// In en, this message translates to:
  /// **'A response issue occurred'**
  String get settings_FormatExceptionError;

  /// No description provided for @settings_SocketExceptionError.
  ///
  /// In en, this message translates to:
  /// **'A network issue occurred'**
  String get settings_SocketExceptionError;

  /// No description provided for @settings_TypeErrorError.
  ///
  /// In en, this message translates to:
  /// **'A response issue occurred'**
  String get settings_TypeErrorError;

  /// No description provided for @settings_RequestFailureError.
  ///
  /// In en, this message translates to:
  /// **'A server failure occurred'**
  String get settings_RequestFailureError;

  /// No description provided for @webRegistration_ErrorAcknowledgeDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Web resource error'**
  String get webRegistration_ErrorAcknowledgeDialog_title;

  /// No description provided for @webRegistration_ErrorAcknowledgeDialogActions_demo.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get webRegistration_ErrorAcknowledgeDialogActions_demo;

  /// No description provided for @webRegistration_ErrorAcknowledgeDialogActions_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get webRegistration_ErrorAcknowledgeDialogActions_skip;

  /// No description provided for @webRegistration_ErrorAcknowledgeDialogActions_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get webRegistration_ErrorAcknowledgeDialogActions_retry;

  /// No description provided for @logRecordsConsole_AppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Console'**
  String get logRecordsConsole_AppBarTitle;

  /// No description provided for @logRecordsConsole_Text_failure.
  ///
  /// In en, this message translates to:
  /// **'Ups error happened ☹️'**
  String get logRecordsConsole_Text_failure;

  /// No description provided for @logRecordsConsole_Button_failureRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get logRecordsConsole_Button_failureRefresh;

  /// No description provided for @underDevelopment.
  ///
  /// In en, this message translates to:
  /// **'This page is under development.'**
  String get underDevelopment;

  /// No description provided for @notImplemented.
  ///
  /// In en, this message translates to:
  /// **'Sorry, not implemented yet'**
  String get notImplemented;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
