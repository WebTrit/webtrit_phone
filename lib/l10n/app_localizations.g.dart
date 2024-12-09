import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.g.dart';
import 'app_localizations_it.g.dart';
import 'app_localizations_uk.g.dart';

// ignore_for_file: type=lint

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
    Locale('en'),
    Locale('it'),
    Locale('uk')
  ];

  /// No description provided for @account_selfCarePasswordExpired_message.
  ///
  /// In en, this message translates to:
  /// **'Your self-care password has expired. Please update it using your self-care.\nUntil the password is changed, access to the service will be limited.'**
  String get account_selfCarePasswordExpired_message;

  /// No description provided for @alertDialogActions_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get alertDialogActions_no;

  /// No description provided for @alertDialogActions_ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get alertDialogActions_ok;

  /// No description provided for @alertDialogActions_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get alertDialogActions_yes;

  /// No description provided for @autoprovision_errorSnackBar_invalidToken.
  ///
  /// In en, this message translates to:
  /// **'The autoconfiguration credentials were rejected by the server. Please request a new configuration link'**
  String get autoprovision_errorSnackBar_invalidToken;

  /// No description provided for @autoprovision_ReloginDialog_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get autoprovision_ReloginDialog_confirm;

  /// No description provided for @autoprovision_ReloginDialog_decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get autoprovision_ReloginDialog_decline;

  /// No description provided for @autoprovision_ReloginDialog_text.
  ///
  /// In en, this message translates to:
  /// **'Do you want to use the new authentication credentials provided in the link? You will be logged out from the current session.'**
  String get autoprovision_ReloginDialog_text;

  /// No description provided for @autoprovision_ReloginDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Relogin Confirmation'**
  String get autoprovision_ReloginDialog_title;

  /// No description provided for @autoprovision_successSnackBar_used.
  ///
  /// In en, this message translates to:
  /// **'Successfully retrieved your settings, your app is ready to use'**
  String get autoprovision_successSnackBar_used;

  /// No description provided for @call_CallActionsTooltip_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get call_CallActionsTooltip_accept;

  /// No description provided for @call_CallActionsTooltip_accept_inviteToAttendedTransfer.
  ///
  /// In en, this message translates to:
  /// **'Accept transfer'**
  String get call_CallActionsTooltip_accept_inviteToAttendedTransfer;

  /// No description provided for @call_CallActionsTooltip_attended_transfer.
  ///
  /// In en, this message translates to:
  /// **'Attended transfer'**
  String get call_CallActionsTooltip_attended_transfer;

  /// No description provided for @call_CallActionsTooltip_decline_inviteToAttendedTransfer.
  ///
  /// In en, this message translates to:
  /// **'Decline transfer'**
  String get call_CallActionsTooltip_decline_inviteToAttendedTransfer;

  /// No description provided for @call_CallActionsTooltip_disableCamera.
  ///
  /// In en, this message translates to:
  /// **'Disable camera'**
  String get call_CallActionsTooltip_disableCamera;

  /// No description provided for @call_CallActionsTooltip_disableSpeaker.
  ///
  /// In en, this message translates to:
  /// **'Disable speakerphone'**
  String get call_CallActionsTooltip_disableSpeaker;

  /// No description provided for @call_CallActionsTooltip_enableCamera.
  ///
  /// In en, this message translates to:
  /// **'Enable camera'**
  String get call_CallActionsTooltip_enableCamera;

  /// No description provided for @call_CallActionsTooltip_enableSpeaker.
  ///
  /// In en, this message translates to:
  /// **'Enable speakerphone'**
  String get call_CallActionsTooltip_enableSpeaker;

  /// No description provided for @call_CallActionsTooltip_hangup.
  ///
  /// In en, this message translates to:
  /// **'Hangup'**
  String get call_CallActionsTooltip_hangup;

  /// No description provided for @call_CallActionsTooltip_hangupAndAccept.
  ///
  /// In en, this message translates to:
  /// **'Hangup & Accept'**
  String get call_CallActionsTooltip_hangupAndAccept;

  /// No description provided for @call_CallActionsTooltip_hideKeypad.
  ///
  /// In en, this message translates to:
  /// **'Hide keypad'**
  String get call_CallActionsTooltip_hideKeypad;

  /// No description provided for @call_CallActionsTooltip_hold.
  ///
  /// In en, this message translates to:
  /// **'Hold call'**
  String get call_CallActionsTooltip_hold;

  /// No description provided for @call_CallActionsTooltip_holdAndAccept.
  ///
  /// In en, this message translates to:
  /// **'Hold & Accept'**
  String get call_CallActionsTooltip_holdAndAccept;

  /// No description provided for @call_CallActionsTooltip_mute.
  ///
  /// In en, this message translates to:
  /// **'Mute microphone'**
  String get call_CallActionsTooltip_mute;

  /// No description provided for @call_CallActionsTooltip_showKeypad.
  ///
  /// In en, this message translates to:
  /// **'Show keypad'**
  String get call_CallActionsTooltip_showKeypad;

  /// No description provided for @call_CallActionsTooltip_swap.
  ///
  /// In en, this message translates to:
  /// **'Swap calls'**
  String get call_CallActionsTooltip_swap;

  /// No description provided for @call_CallActionsTooltip_transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get call_CallActionsTooltip_transfer;

  /// No description provided for @call_CallActionsTooltip_transfer_choose.
  ///
  /// In en, this message translates to:
  /// **'Choose number'**
  String get call_CallActionsTooltip_transfer_choose;

  /// No description provided for @call_CallActionsTooltip_unattended_transfer.
  ///
  /// In en, this message translates to:
  /// **'Unattended transfer'**
  String get call_CallActionsTooltip_unattended_transfer;

  /// No description provided for @call_CallActionsTooltip_unhold.
  ///
  /// In en, this message translates to:
  /// **'Unhold call'**
  String get call_CallActionsTooltip_unhold;

  /// No description provided for @call_CallActionsTooltip_unmute.
  ///
  /// In en, this message translates to:
  /// **'Unmute microphone'**
  String get call_CallActionsTooltip_unmute;

  /// No description provided for @call_description_held.
  ///
  /// In en, this message translates to:
  /// **'On hold'**
  String get call_description_held;

  /// No description provided for @call_description_incoming.
  ///
  /// In en, this message translates to:
  /// **'Incoming call'**
  String get call_description_incoming;

  /// No description provided for @call_description_inviteToAttendedTransfer.
  ///
  /// In en, this message translates to:
  /// **'You\'ve been invited to join an attended transfer call'**
  String get call_description_inviteToAttendedTransfer;

  /// No description provided for @call_description_outgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing call'**
  String get call_description_outgoing;

  /// No description provided for @call_description_requestToAttendedTransfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer request'**
  String get call_description_requestToAttendedTransfer;

  /// No description provided for @call_description_transferProcessing.
  ///
  /// In en, this message translates to:
  /// **'Transfer processing'**
  String get call_description_transferProcessing;

  /// No description provided for @call_description_transfer_requested.
  ///
  /// In en, this message translates to:
  /// **'Transfer request'**
  String get call_description_transfer_requested;

  /// No description provided for @call_FailureAcknowledgeDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get call_FailureAcknowledgeDialog_title;

  /// No description provided for @callProcessingStatus_disconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting the call, please hold on…'**
  String get callProcessingStatus_disconnecting;

  /// No description provided for @callProcessingStatus_answering.
  ///
  /// In en, this message translates to:
  /// **'Answering the call, please hold on…'**
  String get callProcessingStatus_answering;

  /// No description provided for @callStatus_appUnregistered.
  ///
  /// In en, this message translates to:
  /// **'Unregistered'**
  String get callStatus_appUnregistered;

  /// No description provided for @callStatus_connectError.
  ///
  /// In en, this message translates to:
  /// **'Connection error'**
  String get callStatus_connectError;

  /// No description provided for @callStatus_connectIssue.
  ///
  /// In en, this message translates to:
  /// **'Connection issue'**
  String get callStatus_connectIssue;

  /// No description provided for @callStatus_connectivityNone.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get callStatus_connectivityNone;

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

  /// No description provided for @call_ThumbnailAvatar_currentlyNoActiveCall.
  ///
  /// In en, this message translates to:
  /// **'Currently, there is no active call'**
  String get call_ThumbnailAvatar_currentlyNoActiveCall;

  /// No description provided for @chats_ActionBtn_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get chats_ActionBtn_retry;

  /// No description provided for @chats_AddContactDialog_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get chats_AddContactDialog_cancel;

  /// No description provided for @chats_AddContactDialog_empty.
  ///
  /// In en, this message translates to:
  /// **'No contacts found'**
  String get chats_AddContactDialog_empty;

  /// No description provided for @chats_AddContactDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Choose contact:'**
  String get chats_AddContactDialog_title;

  /// No description provided for @chats_ChatListItem_empty.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get chats_ChatListItem_empty;

  /// No description provided for @chats_ChatListScreen_createGroup.
  ///
  /// In en, this message translates to:
  /// **'Create group'**
  String get chats_ChatListScreen_createGroup;

  /// No description provided for @chats_ChatListScreen_empty.
  ///
  /// In en, this message translates to:
  /// **'No conversations started yet'**
  String get chats_ChatListScreen_empty;

  /// No description provided for @chats_ChatListScreen_startDialog.
  ///
  /// In en, this message translates to:
  /// **'Start dialog'**
  String get chats_ChatListScreen_startDialog;

  /// No description provided for @chats_ConfirmDialog_ask.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get chats_ConfirmDialog_ask;

  /// No description provided for @chats_ConfirmDialog_cancel.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get chats_ConfirmDialog_cancel;

  /// No description provided for @chats_ConfirmDialog_confirm.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get chats_ConfirmDialog_confirm;

  /// No description provided for @chats_Conversation_failure.
  ///
  /// In en, this message translates to:
  /// **'Conversation load error'**
  String get chats_Conversation_failure;

  /// No description provided for @chats_ConversationScreen_deleteAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this dialog?'**
  String get chats_ConversationScreen_deleteAsk;

  /// No description provided for @chats_ConversationScreen_deleteDialog.
  ///
  /// In en, this message translates to:
  /// **'Delete dialog'**
  String get chats_ConversationScreen_deleteDialog;

  /// No description provided for @chats_ConversationScreen_titlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Dialog:'**
  String get chats_ConversationScreen_titlePrefix;

  /// No description provided for @chats_GroupAuthorities_moderator.
  ///
  /// In en, this message translates to:
  /// **'moderator'**
  String get chats_GroupAuthorities_moderator;

  /// No description provided for @chats_GroupAuthorities_noauthorities.
  ///
  /// In en, this message translates to:
  /// **'member'**
  String get chats_GroupAuthorities_noauthorities;

  /// No description provided for @chats_GroupAuthorities_owner.
  ///
  /// In en, this message translates to:
  /// **'owner'**
  String get chats_GroupAuthorities_owner;

  /// No description provided for @chats_GroupBuilderScreen_addUserBtnText.
  ///
  /// In en, this message translates to:
  /// **'Add user'**
  String get chats_GroupBuilderScreen_addUserBtnText;

  /// No description provided for @chats_GroupBuilderScreen_connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection error, please try later'**
  String get chats_GroupBuilderScreen_connectionError;

  /// No description provided for @chats_GroupBuilderScreen_groupNameHeadline.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get chats_GroupBuilderScreen_groupNameHeadline;

  /// No description provided for @chats_GroupBuilderScreen_membersHeadline.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get chats_GroupBuilderScreen_membersHeadline;

  /// No description provided for @chats_GroupBuilderScreen_nameFieldEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a group name'**
  String get chats_GroupBuilderScreen_nameFieldEmpty;

  /// No description provided for @chats_GroupBuilderScreen_nameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Group Name'**
  String get chats_GroupBuilderScreen_nameFieldLabel;

  /// No description provided for @chats_GroupBuilderScreen_nameFieldShort.
  ///
  /// In en, this message translates to:
  /// **'Group name must be at least 3 characters'**
  String get chats_GroupBuilderScreen_nameFieldShort;

  /// No description provided for @chats_GroupBuilderScreen_screenTitle.
  ///
  /// In en, this message translates to:
  /// **'Create group'**
  String get chats_GroupBuilderScreen_screenTitle;

  /// No description provided for @chats_GroupBuilderScreen_submitBtnText.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get chats_GroupBuilderScreen_submitBtnText;

  /// No description provided for @chats_GroupBuilderScreen_submitError.
  ///
  /// In en, this message translates to:
  /// **'Error happened while creating group, please try again'**
  String get chats_GroupBuilderScreen_submitError;

  /// No description provided for @chats_GroupDrawer_addUserBtnText.
  ///
  /// In en, this message translates to:
  /// **'Add user'**
  String get chats_GroupDrawer_addUserBtnText;

  /// No description provided for @chats_GroupDrawer_deleteLeaveBtnText.
  ///
  /// In en, this message translates to:
  /// **'Delete and leave'**
  String get chats_GroupDrawer_deleteLeaveBtnText;

  /// No description provided for @chats_GroupDrawer_groupMembersHeadline.
  ///
  /// In en, this message translates to:
  /// **'Group members'**
  String get chats_GroupDrawer_groupMembersHeadline;

  /// No description provided for @chats_GroupDrawer_leaveAndDeleteAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want leave and delete this group?'**
  String get chats_GroupDrawer_leaveAndDeleteAsk;

  /// No description provided for @chats_GroupDrawer_leaveAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to leave this group?'**
  String get chats_GroupDrawer_leaveAsk;

  /// No description provided for @chats_GroupDrawer_leaveBtnText.
  ///
  /// In en, this message translates to:
  /// **'Leave group'**
  String get chats_GroupDrawer_leaveBtnText;

  /// No description provided for @chats_GroupDrawer_makeModeratorAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to make this user a moderator?'**
  String get chats_GroupDrawer_makeModeratorAsk;

  /// No description provided for @chats_GroupDrawer_makeModeratorBtnText.
  ///
  /// In en, this message translates to:
  /// **'Make moderator'**
  String get chats_GroupDrawer_makeModeratorBtnText;

  /// No description provided for @chats_GroupDrawer_removeModeratorAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this user from moderators?'**
  String get chats_GroupDrawer_removeModeratorAsk;

  /// No description provided for @chats_GroupDrawer_removeUserAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this user from the group?'**
  String get chats_GroupDrawer_removeUserAsk;

  /// No description provided for @chats_GroupDrawer_removeUserBtnText.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get chats_GroupDrawer_removeUserBtnText;

  /// No description provided for @chats_GroupDrawer_titlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Group:'**
  String get chats_GroupDrawer_titlePrefix;

  /// No description provided for @chats_GroupDrawer_unmakeModeratorBtnText.
  ///
  /// In en, this message translates to:
  /// **'Unmake moderator'**
  String get chats_GroupDrawer_unmakeModeratorBtnText;

  /// No description provided for @chats_GroupNameDialog_cancelBtnText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get chats_GroupNameDialog_cancelBtnText;

  /// No description provided for @chats_GroupNameDialog_fieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter group name'**
  String get chats_GroupNameDialog_fieldHint;

  /// No description provided for @chats_GroupNameDialog_fieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get chats_GroupNameDialog_fieldLabel;

  /// No description provided for @chats_GroupNameDialog_fieldValidation_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter group name'**
  String get chats_GroupNameDialog_fieldValidation_empty;

  /// No description provided for @chats_GroupNameDialog_fieldValidation_short.
  ///
  /// In en, this message translates to:
  /// **'Group name is too short'**
  String get chats_GroupNameDialog_fieldValidation_short;

  /// No description provided for @chats_GroupNameDialog_saveBtnText.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get chats_GroupNameDialog_saveBtnText;

  /// No description provided for @chats_GroupNameDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get chats_GroupNameDialog_title;

  /// No description provided for @chats_GroupScreen_titlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Group:'**
  String get chats_GroupScreen_titlePrefix;

  /// No description provided for @chats_MessageView_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get chats_MessageView_delete;

  /// No description provided for @chats_MessageView_deleted.
  ///
  /// In en, this message translates to:
  /// **'[deleted]'**
  String get chats_MessageView_deleted;

  /// No description provided for @chats_MessageView_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get chats_MessageView_edit;

  /// No description provided for @chats_MessageView_edited.
  ///
  /// In en, this message translates to:
  /// **'[edited]'**
  String get chats_MessageView_edited;

  /// No description provided for @chats_MessageView_forward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get chats_MessageView_forward;

  /// No description provided for @chats_MessageView_forwarded.
  ///
  /// In en, this message translates to:
  /// **'[forwarded]'**
  String get chats_MessageView_forwarded;

  /// No description provided for @chats_MessageView_reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get chats_MessageView_reply;

  /// No description provided for @chats_MessageView_textcopy.
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard'**
  String get chats_MessageView_textcopy;

  /// No description provided for @chats_ParticipantName_you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get chats_ParticipantName_you;

  /// No description provided for @chats_StateBar_connecting.
  ///
  /// In en, this message translates to:
  /// **'CONNECTING'**
  String get chats_StateBar_connecting;

  /// No description provided for @chats_StateBar_error.
  ///
  /// In en, this message translates to:
  /// **'DISCONNECTED'**
  String get chats_StateBar_error;

  /// No description provided for @chats_StateBar_initializing.
  ///
  /// In en, this message translates to:
  /// **'INITIALIZING'**
  String get chats_StateBar_initializing;

  /// No description provided for @common_noInternetConnection_message.
  ///
  /// In en, this message translates to:
  /// **'It seems you are not connected to the internet. Please check your connection and try again.'**
  String get common_noInternetConnection_message;

  /// No description provided for @common_noInternetConnection_retryButton.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get common_noInternetConnection_retryButton;

  /// No description provided for @common_noInternetConnection_title.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get common_noInternetConnection_title;

  /// No description provided for @common_problemWithLoadingPage.
  ///
  /// In en, this message translates to:
  /// **'There was an issue loading the page.'**
  String get common_problemWithLoadingPage;

  /// No description provided for @connectToYourOwnVoIPSystem_Button_Action.
  ///
  /// In en, this message translates to:
  /// **'Connect to your own VoIP system'**
  String get connectToYourOwnVoIPSystem_Button_Action;

  /// No description provided for @contacts_ExternalTabButton_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get contacts_ExternalTabButton_refresh;

  /// No description provided for @contacts_ExternalTabText_empty.
  ///
  /// In en, this message translates to:
  /// **'No contacts'**
  String get contacts_ExternalTabText_empty;

  /// No description provided for @contacts_ExternalTabText_emptyOnSearching.
  ///
  /// In en, this message translates to:
  /// **'No contacts found'**
  String get contacts_ExternalTabText_emptyOnSearching;

  /// No description provided for @contacts_ExternalTabText_failure.
  ///
  /// In en, this message translates to:
  /// **'Failed to get cloud PBX contacts'**
  String get contacts_ExternalTabText_failure;

  /// No description provided for @contacts_LocalTabButton_openAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Grant access to your phone contacts'**
  String get contacts_LocalTabButton_openAppSettings;

  /// No description provided for @contacts_LocalTabButton_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get contacts_LocalTabButton_refresh;

  /// No description provided for @contacts_LocalTabText_empty.
  ///
  /// In en, this message translates to:
  /// **'No contacts'**
  String get contacts_LocalTabText_empty;

  /// No description provided for @contacts_LocalTabText_emptyOnSearching.
  ///
  /// In en, this message translates to:
  /// **'No contacts found'**
  String get contacts_LocalTabText_emptyOnSearching;

  /// No description provided for @contacts_LocalTabText_failure.
  ///
  /// In en, this message translates to:
  /// **'Failed to get your phone contacts'**
  String get contacts_LocalTabText_failure;

  /// No description provided for @contacts_LocalTabText_permissionFailure.
  ///
  /// In en, this message translates to:
  /// **'There are no permissions to get your phone contacts'**
  String get contacts_LocalTabText_permissionFailure;

  /// No description provided for @contactsSourceExternal.
  ///
  /// In en, this message translates to:
  /// **'Cloud PBX'**
  String get contactsSourceExternal;

  /// No description provided for @contactsSourceLocal.
  ///
  /// In en, this message translates to:
  /// **'Your phone'**
  String get contactsSourceLocal;

  /// No description provided for @contacts_Text_blingTransferInitiated.
  ///
  /// In en, this message translates to:
  /// **'Performing blind transfer'**
  String get contacts_Text_blingTransferInitiated;

  /// No description provided for @copyToClipboard_floatingSnackBar.
  ///
  /// In en, this message translates to:
  /// **'Text copied'**
  String get copyToClipboard_floatingSnackBar;

  /// No description provided for @copyToClipboard_popupMenuItem.
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard'**
  String get copyToClipboard_popupMenuItem;

  /// No description provided for @default_ChatMemberNotFoundMessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'Chat member not found'**
  String get default_ChatMemberNotFoundMessagingSocketException;

  /// No description provided for @default_ChatNotFoundMessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'Chat not found'**
  String get default_ChatNotFoundMessagingSocketException;

  /// No description provided for @default_ClientExceptionError.
  ///
  /// In en, this message translates to:
  /// **'A HTTP client issue occurred'**
  String get default_ClientExceptionError;

  /// No description provided for @default_ErrorDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get default_ErrorDetails;

  /// No description provided for @default_ErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error message'**
  String get default_ErrorMessage;

  /// No description provided for @default_ErrorPath.
  ///
  /// In en, this message translates to:
  /// **'Error path'**
  String get default_ErrorPath;

  /// No description provided for @default_ErrorTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get default_ErrorTransactionId;

  /// No description provided for @default_ForbiddenMessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'Forbidden request'**
  String get default_ForbiddenMessagingSocketException;

  /// No description provided for @default_FormatExceptionError.
  ///
  /// In en, this message translates to:
  /// **'A response format issue occurred'**
  String get default_FormatExceptionError;

  /// No description provided for @default_InternalErrorMessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'Internal server error'**
  String get default_InternalErrorMessagingSocketException;

  /// No description provided for @default_InvalidChatTypeMessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'Invalid chat type'**
  String get default_InvalidChatTypeMessagingSocketException;

  /// No description provided for @default_MessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while processing the request'**
  String get default_MessagingSocketException;

  /// No description provided for @default_RequestFailureError.
  ///
  /// In en, this message translates to:
  /// **'A server failure occurred'**
  String get default_RequestFailureError;

  /// No description provided for @default_SelfAuthorityAssignmentForbiddenMessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'Self authority assignment is forbidden'**
  String get default_SelfAuthorityAssignmentForbiddenMessagingSocketException;

  /// No description provided for @default_SelfRemovalForbiddenMessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'Self removal is forbidden'**
  String get default_SelfRemovalForbiddenMessagingSocketException;

  /// No description provided for @default_SmsConversationNotFoundMessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'SMS conversation not found'**
  String get default_SmsConversationNotFoundMessagingSocketException;

  /// No description provided for @default_SocketExceptionError.
  ///
  /// In en, this message translates to:
  /// **'A network issue occurred'**
  String get default_SocketExceptionError;

  /// No description provided for @default_TimeoutExceptionError.
  ///
  /// In en, this message translates to:
  /// **'A server timeout occurred'**
  String get default_TimeoutExceptionError;

  /// No description provided for @default_TlsExceptionError.
  ///
  /// In en, this message translates to:
  /// **'A secure network protocol (TLS/SSL) issue occurred'**
  String get default_TlsExceptionError;

  /// No description provided for @default_TypeErrorError.
  ///
  /// In en, this message translates to:
  /// **'A response issue occurred'**
  String get default_TypeErrorError;

  /// No description provided for @default_UnauthorizedMessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized request'**
  String get default_UnauthorizedMessagingSocketException;

  /// No description provided for @default_UnauthorizedRequestFailureError.
  ///
  /// In en, this message translates to:
  /// **'An unauthorized request failure occurred'**
  String get default_UnauthorizedRequestFailureError;

  /// No description provided for @default_UserAlreadyInChatMessagingSocketException.
  ///
  /// In en, this message translates to:
  /// **'User is already in chat'**
  String get default_UserAlreadyInChatMessagingSocketException;

  /// No description provided for @favorites_BodyCenter_empty.
  ///
  /// In en, this message translates to:
  /// **'Currently, you have no favorite numbers.\nAdd favorites from Contacts using the star icon'**
  String get favorites_BodyCenter_empty;

  /// No description provided for @favorites_DeleteConfirmDialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the current favorite number?'**
  String get favorites_DeleteConfirmDialog_content;

  /// No description provided for @favorites_DeleteConfirmDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm deleting'**
  String get favorites_DeleteConfirmDialog_title;

  /// No description provided for @favorites_SnackBar_deleted.
  ///
  /// In en, this message translates to:
  /// **'{name} deleted'**
  String favorites_SnackBar_deleted(String name);

  /// No description provided for @favorites_Text_blingTransferInitiated.
  ///
  /// In en, this message translates to:
  /// **'Performing blind transfer'**
  String get favorites_Text_blingTransferInitiated;

  /// No description provided for @inviteFriends_Dialog_close.
  ///
  /// In en, this message translates to:
  /// **'Hide this message'**
  String get inviteFriends_Dialog_close;

  /// No description provided for @inviteFriends_Dialog_invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get inviteFriends_Dialog_invite;

  /// No description provided for @inviteFriends_Dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Invite your friends \nto try WebTrit'**
  String get inviteFriends_Dialog_title;

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

  /// No description provided for @locale_it.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get locale_it;

  /// No description provided for @locale_uk.
  ///
  /// In en, this message translates to:
  /// **'Ukrainian'**
  String get locale_uk;

  /// No description provided for @login_Button_coreUrlAssignProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get login_Button_coreUrlAssignProceed;

  /// No description provided for @login_Button_otpSigninRequestProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get login_Button_otpSigninRequestProceed;

  /// No description provided for @login_Button_otpSigninVerifyProceed.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get login_Button_otpSigninVerifyProceed;

  /// No description provided for @login_Button_otpSigninVerifyRepeat.
  ///
  /// In en, this message translates to:
  /// **'Resend the code'**
  String get login_Button_otpSigninVerifyRepeat;

  /// No description provided for @login_Button_otpSigninVerifyRepeatInterval.
  ///
  /// In en, this message translates to:
  /// **'Resend the code ({seconds} s)'**
  String login_Button_otpSigninVerifyRepeatInterval(int seconds);

  /// No description provided for @login_Button_passwordSigninProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get login_Button_passwordSigninProceed;

  /// No description provided for @login_Button_signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login_Button_signIn;

  /// No description provided for @login_Button_signupRequestProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get login_Button_signupRequestProceed;

  /// No description provided for @login_Button_signUpToDemoInstance.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get login_Button_signUpToDemoInstance;

  /// No description provided for @login_Button_signupVerifyProceed.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get login_Button_signupVerifyProceed;

  /// No description provided for @login_Button_signupVerifyRepeat.
  ///
  /// In en, this message translates to:
  /// **'Resend the code'**
  String get login_Button_signupVerifyRepeat;

  /// No description provided for @login_Button_signupVerifyRepeatInterval.
  ///
  /// In en, this message translates to:
  /// **'Resend the code ({seconds} s)'**
  String login_Button_signupVerifyRepeatInterval(int seconds);

  /// No description provided for @login_ButtonTooltip_signInToYourInstance.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your WebTrit Cloud Backend'**
  String get login_ButtonTooltip_signInToYourInstance;

  /// No description provided for @login_CoreVersionUnsupportedExceptionError.
  ///
  /// In en, this message translates to:
  /// **'An incompatible instance version provided, please contact the administrator of your system (actual: {actual}, supported: {supportedConstraint})'**
  String login_CoreVersionUnsupportedExceptionError(String actual, String supportedConstraint);

  /// No description provided for @login_requestCredentials_button.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get login_requestCredentials_button;

  /// No description provided for @login_requestCredentials_DialogContent.
  ///
  /// In en, this message translates to:
  /// **'Please provide basic information and specify in the message that you would like to receive an account. Our administrators will verify the information and send the account details to your email.'**
  String get login_requestCredentials_DialogContent;

  /// No description provided for @login_requestCredentials_DialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Request'**
  String get login_requestCredentials_DialogTitle;

  /// No description provided for @login_requestCredentials_title.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get login_requestCredentials_title;

  /// No description provided for @login_RequestFailureEmptyEmailError.
  ///
  /// In en, this message translates to:
  /// **'Cannot send the verification code'**
  String get login_RequestFailureEmptyEmailError;

  /// No description provided for @login_RequestFailureIdentifierIsNotValid.
  ///
  /// In en, this message translates to:
  /// **'The identifier is invalid or does not exist'**
  String get login_RequestFailureIdentifierIsNotValid;

  /// No description provided for @login_RequestFailureIncorrectOtpCodeError.
  ///
  /// In en, this message translates to:
  /// **'Incorrect verification code'**
  String get login_RequestFailureIncorrectOtpCodeError;

  /// No description provided for @login_RequestFailureOtpAlreadyVerifiedError.
  ///
  /// In en, this message translates to:
  /// **'Verification already verified'**
  String get login_RequestFailureOtpAlreadyVerifiedError;

  /// No description provided for @login_RequestFailureOtpExpiredError.
  ///
  /// In en, this message translates to:
  /// **'Verification expired'**
  String get login_RequestFailureOtpExpiredError;

  /// No description provided for @login_RequestFailureOtpNotFoundError.
  ///
  /// In en, this message translates to:
  /// **'Verification not found'**
  String get login_RequestFailureOtpNotFoundError;

  /// No description provided for @login_RequestFailureOtpVerificationAttemptsExceededError.
  ///
  /// In en, this message translates to:
  /// **'Verification attempts exceeded'**
  String get login_RequestFailureOtpVerificationAttemptsExceededError;

  /// No description provided for @login_RequestFailureParametersApplyIssueError.
  ///
  /// In en, this message translates to:
  /// **'Provided data can\'t be processed'**
  String get login_RequestFailureParametersApplyIssueError;

  /// No description provided for @login_RequestFailurePhoneNotFoundError.
  ///
  /// In en, this message translates to:
  /// **'Phone number not found'**
  String get login_RequestFailurePhoneNotFoundError;

  /// No description provided for @login_RequestFailureUnconfiguredBundleIdError.
  ///
  /// In en, this message translates to:
  /// **'The app is not supported by your WebTrit Cloud Backend'**
  String get login_RequestFailureUnconfiguredBundleIdError;

  /// No description provided for @login_SupportedLoginTypeMissedExceptionError.
  ///
  /// In en, this message translates to:
  /// **'The current WebTrit Cloud Backend does not support any login types compatible with this app'**
  String get login_SupportedLoginTypeMissedExceptionError;

  /// No description provided for @login_Text_coreUrlAssignPostDescription.
  ///
  /// In en, this message translates to:
  /// **'If you do not yet have your own WebTrit Cloud Backend - contact sales team {email}.'**
  String login_Text_coreUrlAssignPostDescription(Object email);

  /// No description provided for @login_Text_coreUrlAssignPreDescription.
  ///
  /// In en, this message translates to:
  /// **'In order to make calls via your own VoIP system please enter the URL of WebTrit Cloud Backend (as it was provided to you by your account manager) below.'**
  String get login_Text_coreUrlAssignPreDescription;

  /// No description provided for @login_TextFieldLabelText_coreUrlAssign.
  ///
  /// In en, this message translates to:
  /// **'Enter your WebTrit Cloud Backend URL'**
  String get login_TextFieldLabelText_coreUrlAssign;

  /// No description provided for @login_TextFieldLabelText_otpSigninCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code'**
  String get login_TextFieldLabelText_otpSigninCode;

  /// No description provided for @login_TextFieldLabelText_otpSigninUserRef.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number or email'**
  String get login_TextFieldLabelText_otpSigninUserRef;

  /// No description provided for @login_TextFieldLabelText_passwordSigninPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get login_TextFieldLabelText_passwordSigninPassword;

  /// No description provided for @login_TextFieldLabelText_passwordSigninUserRef.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number or email'**
  String get login_TextFieldLabelText_passwordSigninUserRef;

  /// No description provided for @login_TextFieldLabelText_signupCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code'**
  String get login_TextFieldLabelText_signupCode;

  /// No description provided for @login_TextFieldLabelText_signupEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get login_TextFieldLabelText_signupEmail;

  /// No description provided for @login_Text_otpSigninRequestPostDescription.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_Text_otpSigninRequestPostDescription;

  /// No description provided for @login_Text_otpSigninRequestPreDescription.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_Text_otpSigninRequestPreDescription;

  /// No description provided for @login_Text_otpSigninVerifyPostDescriptionFromEmail.
  ///
  /// In en, this message translates to:
  /// **'If you do not see an email with the verification code from {email} in your inbox, please check your spam folder.'**
  String login_Text_otpSigninVerifyPostDescriptionFromEmail(String email);

  /// No description provided for @login_Text_otpSigninVerifyPostDescriptionGeneral.
  ///
  /// In en, this message translates to:
  /// **'If you do not see an email with the verification code in your inbox, please check your spam folder.'**
  String get login_Text_otpSigninVerifyPostDescriptionGeneral;

  /// No description provided for @login_Text_otpSigninVerifyPreDescriptionUserRef.
  ///
  /// In en, this message translates to:
  /// **'A one-time verification code was sent to the email assigned to provided phone number or email.'**
  String login_Text_otpSigninVerifyPreDescriptionUserRef(String userRef);

  /// No description provided for @login_Text_otpVerifySentToEmailAssignedWithPhone.
  ///
  /// In en, this message translates to:
  /// **'A one-time verification code was sent to the email assigned to the tel:{phone} phone number.'**
  String login_Text_otpVerifySentToEmailAssignedWithPhone(String phone);

  /// No description provided for @login_Text_passwordSigninPostDescription.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_Text_passwordSigninPostDescription;

  /// No description provided for @login_Text_passwordSigninPreDescription.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_Text_passwordSigninPreDescription;

  /// No description provided for @login_Text_signupRequestPostDescription.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_Text_signupRequestPostDescription;

  /// No description provided for @login_Text_signupRequestPostDescriptionDemo.
  ///
  /// In en, this message translates to:
  /// **'If you do not have an account yet, it will be automatically created for you'**
  String get login_Text_signupRequestPostDescriptionDemo;

  /// No description provided for @login_Text_signupRequestPreDescription.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_Text_signupRequestPreDescription;

  /// No description provided for @login_Text_signupRequestPreDescriptionDemo.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_Text_signupRequestPreDescriptionDemo;

  /// No description provided for @login_Text_signupVerifyPostDescriptionFromEmail.
  ///
  /// In en, this message translates to:
  /// **'If you do not see an email with the verification code from {email} in your inbox, please check your spam folder.'**
  String login_Text_signupVerifyPostDescriptionFromEmail(String email);

  /// No description provided for @login_Text_signupVerifyPostDescriptionGeneral.
  ///
  /// In en, this message translates to:
  /// **'If you do not see an email with the verification code in your inbox, please check your spam folder.'**
  String get login_Text_signupVerifyPostDescriptionGeneral;

  /// No description provided for @login_Text_signupVerifyPreDescriptionEmail.
  ///
  /// In en, this message translates to:
  /// **'A one-time verification code was sent to {email}.'**
  String login_Text_signupVerifyPreDescriptionEmail(String email);

  /// No description provided for @loginType_otpSignin.
  ///
  /// In en, this message translates to:
  /// **'OTP sign in'**
  String get loginType_otpSignin;

  /// No description provided for @loginType_passwordSignin.
  ///
  /// In en, this message translates to:
  /// **'Password sign in'**
  String get loginType_passwordSignin;

  /// No description provided for @loginType_signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get loginType_signup;

  /// No description provided for @login_validationCoreUrlError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get login_validationCoreUrlError;

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

  /// No description provided for @login_validationUserRefError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number or email'**
  String get login_validationUserRefError;

  /// No description provided for @logRecordsConsole_AppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Console'**
  String get logRecordsConsole_AppBarTitle;

  /// No description provided for @logRecordsConsole_Button_failureRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get logRecordsConsole_Button_failureRefresh;

  /// No description provided for @logRecordsConsole_Text_failure.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get logRecordsConsole_Text_failure;

  /// No description provided for @main_BottomNavigationBarItemLabel_chats.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get main_BottomNavigationBarItemLabel_chats;

  /// No description provided for @main_BottomNavigationBarItemLabel_contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get main_BottomNavigationBarItemLabel_contacts;

  /// No description provided for @main_BottomNavigationBarItemLabel_favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get main_BottomNavigationBarItemLabel_favorites;

  /// No description provided for @main_BottomNavigationBarItemLabel_keypad.
  ///
  /// In en, this message translates to:
  /// **'Keypad'**
  String get main_BottomNavigationBarItemLabel_keypad;

  /// No description provided for @main_BottomNavigationBarItemLabel_recents.
  ///
  /// In en, this message translates to:
  /// **'Recents'**
  String get main_BottomNavigationBarItemLabel_recents;

  /// No description provided for @main_CompatibilityIssueDialogActions_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get main_CompatibilityIssueDialogActions_logout;

  /// No description provided for @main_CompatibilityIssueDialogActions_update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get main_CompatibilityIssueDialogActions_update;

  /// No description provided for @main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError.
  ///
  /// In en, this message translates to:
  /// **'Incompatible WebTrit Cloud Backend version, please contact the administrator of your system.\n\nInstance version:\n{actual}\n\nSupported version:\n{supportedConstraint}'**
  String main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(String actual, String supportedConstraint);

  /// No description provided for @main_CompatibilityIssueDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Compatibility issue'**
  String get main_CompatibilityIssueDialog_title;

  /// No description provided for @messaging_ActionBtn_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get messaging_ActionBtn_retry;

  /// No description provided for @messaging_ChooseContact_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get messaging_ChooseContact_cancel;

  /// No description provided for @messaging_ChooseContact_empty.
  ///
  /// In en, this message translates to:
  /// **'No contacts found'**
  String get messaging_ChooseContact_empty;

  /// No description provided for @messaging_ChooseContact_title.
  ///
  /// In en, this message translates to:
  /// **'Choose contact:'**
  String get messaging_ChooseContact_title;

  /// No description provided for @messaging_ConfirmDialog_ask.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get messaging_ConfirmDialog_ask;

  /// No description provided for @messaging_ConfirmDialog_cancel.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get messaging_ConfirmDialog_cancel;

  /// No description provided for @messaging_ConfirmDialog_confirm.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get messaging_ConfirmDialog_confirm;

  /// No description provided for @messaging_ConversationBuilders_addUserBtnText.
  ///
  /// In en, this message translates to:
  /// **'Add user'**
  String get messaging_ConversationBuilders_addUserBtnText;

  /// No description provided for @messaging_ConversationBuilders_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get messaging_ConversationBuilders_back;

  /// No description provided for @messaging_ConversationBuilders_back_action.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get messaging_ConversationBuilders_back_action;

  /// No description provided for @messaging_ConversationBuilders_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get messaging_ConversationBuilders_cancel;

  /// No description provided for @messaging_ConversationBuilders_connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection error, please try later'**
  String get messaging_ConversationBuilders_connectionError;

  /// No description provided for @messaging_ConversationBuilders_contactOrNumberSearch_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter name or phone number'**
  String get messaging_ConversationBuilders_contactOrNumberSearch_hint;

  /// No description provided for @messaging_ConversationBuilders_contactSearch_hint.
  ///
  /// In en, this message translates to:
  /// **'Search contacts'**
  String get messaging_ConversationBuilders_contactSearch_hint;

  /// No description provided for @messaging_ConversationBuilders_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get messaging_ConversationBuilders_create;

  /// No description provided for @messaging_ConversationBuilders_createGroup.
  ///
  /// In en, this message translates to:
  /// **'Create group'**
  String get messaging_ConversationBuilders_createGroup;

  /// No description provided for @messaging_ConversationBuilders_externalContacts_heading.
  ///
  /// In en, this message translates to:
  /// **'Cloud PBX contacts'**
  String get messaging_ConversationBuilders_externalContacts_heading;

  /// No description provided for @messaging_ConversationBuilders_groupNameHeadline.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get messaging_ConversationBuilders_groupNameHeadline;

  /// No description provided for @messaging_ConversationBuilders_invalidNumber_message1.
  ///
  /// In en, this message translates to:
  /// **'The contact has an invalid phone number. It should be in the format '**
  String get messaging_ConversationBuilders_invalidNumber_message1;

  /// No description provided for @messaging_ConversationBuilders_invalidNumber_message2.
  ///
  /// In en, this message translates to:
  /// **'. Please fix it in your phone book.'**
  String get messaging_ConversationBuilders_invalidNumber_message2;

  /// No description provided for @messaging_ConversationBuilders_invalidNumber_ok.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get messaging_ConversationBuilders_invalidNumber_ok;

  /// No description provided for @messaging_ConversationBuilders_invalidNumber_title.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get messaging_ConversationBuilders_invalidNumber_title;

  /// No description provided for @messaging_ConversationBuilders_invite_heading.
  ///
  /// In en, this message translates to:
  /// **'Invite users:'**
  String get messaging_ConversationBuilders_invite_heading;

  /// No description provided for @messaging_ConversationBuilders_localContacts_heading.
  ///
  /// In en, this message translates to:
  /// **'Local contacts'**
  String get messaging_ConversationBuilders_localContacts_heading;

  /// No description provided for @messaging_ConversationBuilders_membersHeadline.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get messaging_ConversationBuilders_membersHeadline;

  /// No description provided for @messaging_ConversationBuilders_nameFieldEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a group name'**
  String get messaging_ConversationBuilders_nameFieldEmpty;

  /// No description provided for @messaging_ConversationBuilders_nameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Group Name'**
  String get messaging_ConversationBuilders_nameFieldLabel;

  /// No description provided for @messaging_ConversationBuilders_nameFieldShort.
  ///
  /// In en, this message translates to:
  /// **'Group name must be at least 3 characters'**
  String get messaging_ConversationBuilders_nameFieldShort;

  /// No description provided for @messaging_ConversationBuilders_next_action.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get messaging_ConversationBuilders_next_action;

  /// No description provided for @messaging_ConversationBuilders_noContacts.
  ///
  /// In en, this message translates to:
  /// **'There are no contacts matching the search result'**
  String get messaging_ConversationBuilders_noContacts;

  /// No description provided for @messaging_ConversationBuilders_numberFormatExample.
  ///
  /// In en, this message translates to:
  /// **'+ [country code] [area/operator code] [subscriber number]'**
  String get messaging_ConversationBuilders_numberFormatExample;

  /// No description provided for @messaging_ConversationBuilders_numberSearch_errorError.
  ///
  /// In en, this message translates to:
  /// **'The entered phone number is invalid. It should be entered in the format: '**
  String get messaging_ConversationBuilders_numberSearch_errorError;

  /// No description provided for @messaging_ConversationBuilders_numberSearch_errorHint.
  ///
  /// In en, this message translates to:
  /// **'Phone number format: '**
  String get messaging_ConversationBuilders_numberSearch_errorHint;

  /// No description provided for @messaging_ConversationBuilders_submitBtnText.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get messaging_ConversationBuilders_submitBtnText;

  /// No description provided for @messaging_ConversationBuilders_submitError.
  ///
  /// In en, this message translates to:
  /// **'Error happened while creating group, please try again'**
  String get messaging_ConversationBuilders_submitError;

  /// No description provided for @messaging_ConversationBuilders_title_group.
  ///
  /// In en, this message translates to:
  /// **'Create group'**
  String get messaging_ConversationBuilders_title_group;

  /// No description provided for @messaging_ConversationBuilders_title_new.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get messaging_ConversationBuilders_title_new;

  /// No description provided for @messaging_Conversation_failure.
  ///
  /// In en, this message translates to:
  /// **'Conversation load error'**
  String get messaging_Conversation_failure;

  /// No description provided for @messaging_ConversationInfo_deleteAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this dialog?'**
  String get messaging_ConversationInfo_deleteAsk;

  /// No description provided for @messaging_ConversationInfo_deleteBtn.
  ///
  /// In en, this message translates to:
  /// **'Delete dialog'**
  String get messaging_ConversationInfo_deleteBtn;

  /// No description provided for @messaging_ConversationInfo_title.
  ///
  /// In en, this message translates to:
  /// **'Contact info'**
  String get messaging_ConversationInfo_title;

  /// No description provided for @messaging_ConversationScreen_titlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Dialog:'**
  String get messaging_ConversationScreen_titlePrefix;

  /// No description provided for @messaging_ConversationsScreen_chatsSearch_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter chat or user name'**
  String get messaging_ConversationsScreen_chatsSearch_hint;

  /// No description provided for @messaging_ConversationsScreen_empty.
  ///
  /// In en, this message translates to:
  /// **'No conversations started yet'**
  String get messaging_ConversationsScreen_empty;

  /// No description provided for @messaging_ConversationsScreen_messages_title.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messaging_ConversationsScreen_messages_title;

  /// No description provided for @messaging_ConversationsScreen_noNumberAlert_text.
  ///
  /// In en, this message translates to:
  /// **'You need to have a phone number linked to you account to send SMS messages'**
  String get messaging_ConversationsScreen_noNumberAlert_text;

  /// No description provided for @messaging_ConversationsScreen_noNumberAlert_title.
  ///
  /// In en, this message translates to:
  /// **'No phone number'**
  String get messaging_ConversationsScreen_noNumberAlert_title;

  /// No description provided for @messaging_ConversationsScreen_selectNumberSheet_title.
  ///
  /// In en, this message translates to:
  /// **'Select a number'**
  String get messaging_ConversationsScreen_selectNumberSheet_title;

  /// No description provided for @messaging_ConversationsScreen_smses_title.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get messaging_ConversationsScreen_smses_title;

  /// No description provided for @messaging_ConversationsScreen_smssSearch_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get messaging_ConversationsScreen_smssSearch_hint;

  /// No description provided for @messaging_ConversationsScreen_startDialog.
  ///
  /// In en, this message translates to:
  /// **'Start dialog'**
  String get messaging_ConversationsScreen_startDialog;

  /// No description provided for @messaging_Conversations_tile_empty.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get messaging_Conversations_tile_empty;

  /// No description provided for @messaging_Conversations_tile_you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get messaging_Conversations_tile_you;

  /// No description provided for @messaging_DialogInfo_deleteAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this dialog?'**
  String get messaging_DialogInfo_deleteAsk;

  /// No description provided for @messaging_DialogInfo_deleteBtn.
  ///
  /// In en, this message translates to:
  /// **'Delete dialog'**
  String get messaging_DialogInfo_deleteBtn;

  /// No description provided for @messaging_DialogInfo_title.
  ///
  /// In en, this message translates to:
  /// **'Contact info'**
  String get messaging_DialogInfo_title;

  /// No description provided for @messaging_GroupAuthorities_moderator.
  ///
  /// In en, this message translates to:
  /// **'moderator'**
  String get messaging_GroupAuthorities_moderator;

  /// No description provided for @messaging_GroupAuthorities_noauthorities.
  ///
  /// In en, this message translates to:
  /// **'member'**
  String get messaging_GroupAuthorities_noauthorities;

  /// No description provided for @messaging_GroupAuthorities_owner.
  ///
  /// In en, this message translates to:
  /// **'owner'**
  String get messaging_GroupAuthorities_owner;

  /// No description provided for @messaging_GroupBuilderScreen_addUserBtnText.
  ///
  /// In en, this message translates to:
  /// **'Add user'**
  String get messaging_GroupBuilderScreen_addUserBtnText;

  /// No description provided for @messaging_GroupBuilderScreen_connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection error, please try later'**
  String get messaging_GroupBuilderScreen_connectionError;

  /// No description provided for @messaging_GroupBuilderScreen_groupNameHeadline.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get messaging_GroupBuilderScreen_groupNameHeadline;

  /// No description provided for @messaging_GroupBuilderScreen_membersHeadline.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get messaging_GroupBuilderScreen_membersHeadline;

  /// No description provided for @messaging_GroupBuilderScreen_nameFieldEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a group name'**
  String get messaging_GroupBuilderScreen_nameFieldEmpty;

  /// No description provided for @messaging_GroupBuilderScreen_nameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Group Name'**
  String get messaging_GroupBuilderScreen_nameFieldLabel;

  /// No description provided for @messaging_GroupBuilderScreen_nameFieldShort.
  ///
  /// In en, this message translates to:
  /// **'Group name must be at least 3 characters'**
  String get messaging_GroupBuilderScreen_nameFieldShort;

  /// No description provided for @messaging_GroupBuilderScreen_screenTitle.
  ///
  /// In en, this message translates to:
  /// **'Create group'**
  String get messaging_GroupBuilderScreen_screenTitle;

  /// No description provided for @messaging_GroupBuilderScreen_submitBtnText.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get messaging_GroupBuilderScreen_submitBtnText;

  /// No description provided for @messaging_GroupBuilderScreen_submitError.
  ///
  /// In en, this message translates to:
  /// **'Error happened while creating group, please try again'**
  String get messaging_GroupBuilderScreen_submitError;

  /// No description provided for @messaging_GroupInfo_addUserBtnText.
  ///
  /// In en, this message translates to:
  /// **'Add user'**
  String get messaging_GroupInfo_addUserBtnText;

  /// No description provided for @messaging_GroupInfo_deleteLeaveBtnText.
  ///
  /// In en, this message translates to:
  /// **'Delete and leave'**
  String get messaging_GroupInfo_deleteLeaveBtnText;

  /// No description provided for @messaging_GroupInfo_groupMembersHeadline.
  ///
  /// In en, this message translates to:
  /// **'Group members'**
  String get messaging_GroupInfo_groupMembersHeadline;

  /// No description provided for @messaging_GroupInfo_leaveAndDeleteAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want leave and delete this group?'**
  String get messaging_GroupInfo_leaveAndDeleteAsk;

  /// No description provided for @messaging_GroupInfo_leaveAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to leave this group?'**
  String get messaging_GroupInfo_leaveAsk;

  /// No description provided for @messaging_GroupInfo_leaveBtnText.
  ///
  /// In en, this message translates to:
  /// **'Leave group'**
  String get messaging_GroupInfo_leaveBtnText;

  /// No description provided for @messaging_GroupInfo_makeModeratorAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to make this user a moderator?'**
  String get messaging_GroupInfo_makeModeratorAsk;

  /// No description provided for @messaging_GroupInfo_makeModeratorBtnText.
  ///
  /// In en, this message translates to:
  /// **'Make moderator'**
  String get messaging_GroupInfo_makeModeratorBtnText;

  /// No description provided for @messaging_GroupInfo_removeModeratorAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this user from moderators?'**
  String get messaging_GroupInfo_removeModeratorAsk;

  /// No description provided for @messaging_GroupInfo_removeUserAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this user from the group?'**
  String get messaging_GroupInfo_removeUserAsk;

  /// No description provided for @messaging_GroupInfo_removeUserBtnText.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get messaging_GroupInfo_removeUserBtnText;

  /// No description provided for @messaging_GroupInfo_title.
  ///
  /// In en, this message translates to:
  /// **'Group info'**
  String get messaging_GroupInfo_title;

  /// No description provided for @messaging_GroupInfo_titlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Group:'**
  String get messaging_GroupInfo_titlePrefix;

  /// No description provided for @messaging_GroupInfo_unmakeModeratorBtnText.
  ///
  /// In en, this message translates to:
  /// **'Unmake moderator'**
  String get messaging_GroupInfo_unmakeModeratorBtnText;

  /// No description provided for @messaging_GroupNameDialog_cancelBtnText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get messaging_GroupNameDialog_cancelBtnText;

  /// No description provided for @messaging_GroupNameDialog_fieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter group name'**
  String get messaging_GroupNameDialog_fieldHint;

  /// No description provided for @messaging_GroupNameDialog_fieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get messaging_GroupNameDialog_fieldLabel;

  /// No description provided for @messaging_GroupNameDialog_fieldValidation_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter group name'**
  String get messaging_GroupNameDialog_fieldValidation_empty;

  /// No description provided for @messaging_GroupNameDialog_fieldValidation_short.
  ///
  /// In en, this message translates to:
  /// **'Group name is too short'**
  String get messaging_GroupNameDialog_fieldValidation_short;

  /// No description provided for @messaging_GroupNameDialog_saveBtnText.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get messaging_GroupNameDialog_saveBtnText;

  /// No description provided for @messaging_GroupNameDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get messaging_GroupNameDialog_title;

  /// No description provided for @messaging_GroupScreen_titlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Group:'**
  String get messaging_GroupScreen_titlePrefix;

  /// No description provided for @messaging_MessageField_hint.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get messaging_MessageField_hint;

  /// No description provided for @messaging_MessageListView_typingTrail.
  ///
  /// In en, this message translates to:
  /// **'is typing...'**
  String get messaging_MessageListView_typingTrail;

  /// No description provided for @messaging_MessageView_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get messaging_MessageView_delete;

  /// No description provided for @messaging_MessageView_deleted.
  ///
  /// In en, this message translates to:
  /// **'[deleted]'**
  String get messaging_MessageView_deleted;

  /// No description provided for @messaging_MessageView_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get messaging_MessageView_edit;

  /// No description provided for @messaging_MessageView_edited.
  ///
  /// In en, this message translates to:
  /// **'[edited]'**
  String get messaging_MessageView_edited;

  /// No description provided for @messaging_MessageView_forward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get messaging_MessageView_forward;

  /// No description provided for @messaging_MessageView_forwarded.
  ///
  /// In en, this message translates to:
  /// **'[forwarded]'**
  String get messaging_MessageView_forwarded;

  /// No description provided for @messaging_MessageView_reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get messaging_MessageView_reply;

  /// No description provided for @messaging_MessageView_textcopy.
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard'**
  String get messaging_MessageView_textcopy;

  /// No description provided for @messaging_NewConversation_back_action.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get messaging_NewConversation_back_action;

  /// No description provided for @messaging_NewConversation_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get messaging_NewConversation_cancel;

  /// No description provided for @messaging_NewConversation_contactOrNumberSearch_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter name or phone number'**
  String get messaging_NewConversation_contactOrNumberSearch_hint;

  /// No description provided for @messaging_NewConversation_contactSearch_hint.
  ///
  /// In en, this message translates to:
  /// **'Search contacts'**
  String get messaging_NewConversation_contactSearch_hint;

  /// No description provided for @messaging_NewConversation_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get messaging_NewConversation_create;

  /// No description provided for @messaging_NewConversation_createGroup.
  ///
  /// In en, this message translates to:
  /// **'Create group'**
  String get messaging_NewConversation_createGroup;

  /// No description provided for @messaging_NewConversation_externalContacts_heading.
  ///
  /// In en, this message translates to:
  /// **'Cloud PBX contacts'**
  String get messaging_NewConversation_externalContacts_heading;

  /// No description provided for @messaging_NewConversation_invalidNumber_message.
  ///
  /// In en, this message translates to:
  /// **''**
  String get messaging_NewConversation_invalidNumber_message;

  /// No description provided for @messaging_NewConversation_invalidNumber_message1.
  ///
  /// In en, this message translates to:
  /// **'The contact has an invalid phone number. It should be in the format '**
  String get messaging_NewConversation_invalidNumber_message1;

  /// No description provided for @messaging_NewConversation_invalidNumber_message2.
  ///
  /// In en, this message translates to:
  /// **'. Please fix it in your phone book.'**
  String get messaging_NewConversation_invalidNumber_message2;

  /// No description provided for @messaging_NewConversation_invalidNumber_ok.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get messaging_NewConversation_invalidNumber_ok;

  /// No description provided for @messaging_NewConversation_invalidNumber_title.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get messaging_NewConversation_invalidNumber_title;

  /// No description provided for @messaging_NewConversation_invite_heading.
  ///
  /// In en, this message translates to:
  /// **'Invite users:'**
  String get messaging_NewConversation_invite_heading;

  /// No description provided for @messaging_NewConversation_localContacts_heading.
  ///
  /// In en, this message translates to:
  /// **'Local contacts'**
  String get messaging_NewConversation_localContacts_heading;

  /// No description provided for @messaging_NewConversation_next_action.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get messaging_NewConversation_next_action;

  /// No description provided for @messaging_NewConversation_noContacts.
  ///
  /// In en, this message translates to:
  /// **'There are no contacts matching the search result'**
  String get messaging_NewConversation_noContacts;

  /// No description provided for @messaging_NewConversation_numberFormatExample.
  ///
  /// In en, this message translates to:
  /// **'+ [country code] [area/operator code] [subscriber number]'**
  String get messaging_NewConversation_numberFormatExample;

  /// No description provided for @messaging_NewConversation_numberSearch_errorError.
  ///
  /// In en, this message translates to:
  /// **'The entered phone number is invalid. It should be entered in the format: '**
  String get messaging_NewConversation_numberSearch_errorError;

  /// No description provided for @messaging_NewConversation_numberSearch_errorHint.
  ///
  /// In en, this message translates to:
  /// **'Phone number format: '**
  String get messaging_NewConversation_numberSearch_errorHint;

  /// No description provided for @messaging_NewConversation_title.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get messaging_NewConversation_title;

  /// No description provided for @messaging_ParticipantName_you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get messaging_ParticipantName_you;

  /// No description provided for @messaging_SmsSendingStatus_delivered.
  ///
  /// In en, this message translates to:
  /// **'delivered'**
  String get messaging_SmsSendingStatus_delivered;

  /// No description provided for @messaging_SmsSendingStatus_failed.
  ///
  /// In en, this message translates to:
  /// **'failed'**
  String get messaging_SmsSendingStatus_failed;

  /// No description provided for @messaging_SmsSendingStatus_sent.
  ///
  /// In en, this message translates to:
  /// **'sent'**
  String get messaging_SmsSendingStatus_sent;

  /// No description provided for @messaging_SmsSendingStatus_waiting.
  ///
  /// In en, this message translates to:
  /// **'waiting'**
  String get messaging_SmsSendingStatus_waiting;

  /// No description provided for @messaging_StateBar_connecting.
  ///
  /// In en, this message translates to:
  /// **'CONNECTING'**
  String get messaging_StateBar_connecting;

  /// No description provided for @messaging_StateBar_error.
  ///
  /// In en, this message translates to:
  /// **'DISCONNECTED'**
  String get messaging_StateBar_error;

  /// No description provided for @messaging_StateBar_initializing.
  ///
  /// In en, this message translates to:
  /// **'INITIALIZING'**
  String get messaging_StateBar_initializing;

  /// No description provided for @notifications_errorSnackBarAction_callUserMedia.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get notifications_errorSnackBarAction_callUserMedia;

  /// No description provided for @notifications_errorSnackBar_activeLineBlindTransferWarning.
  ///
  /// In en, this message translates to:
  /// **'You are already on the line with the recipient you are trying to blind transfer to'**
  String get notifications_errorSnackBar_activeLineBlindTransferWarning;

  /// No description provided for @notifications_errorSnackBar_appOffline.
  ///
  /// In en, this message translates to:
  /// **'Your application is currently offline'**
  String get notifications_errorSnackBar_appOffline;

  /// No description provided for @notifications_errorSnackBar_appOnline.
  ///
  /// In en, this message translates to:
  /// **'Your application is online'**
  String get notifications_errorSnackBar_appOnline;

  /// No description provided for @notifications_errorSnackBar_appUnregistered.
  ///
  /// In en, this message translates to:
  /// **'Sorry, your application is currently disconnected from the WebTrit core servers and hence can\'t call right now. Please go to the settings page, and slide the online status toggle switch off and on again to reestablish the connection'**
  String get notifications_errorSnackBar_appUnregistered;

  /// No description provided for @notifications_errorSnackBar_callConnect.
  ///
  /// In en, this message translates to:
  /// **'Connecting to the core failed, trying to reconnect'**
  String get notifications_errorSnackBar_callConnect;

  /// No description provided for @notifications_errorSnackBar_callSignalingClientNotConnect.
  ///
  /// In en, this message translates to:
  /// **'Cannot initiate the call, please check the connection status'**
  String get notifications_errorSnackBar_callSignalingClientNotConnect;

  /// No description provided for @notifications_errorSnackBar_callSignalingClientSessionMissed.
  ///
  /// In en, this message translates to:
  /// **'Authentication error, please re-login'**
  String get notifications_errorSnackBar_callSignalingClientSessionMissed;

  /// No description provided for @notifications_errorSnackBar_callUndefinedLine.
  ///
  /// In en, this message translates to:
  /// **'No idle lines to initiate the call'**
  String get notifications_errorSnackBar_callUndefinedLine;

  /// No description provided for @notifications_errorSnackBar_callUserMedia.
  ///
  /// In en, this message translates to:
  /// **'No access to media input, please check app permissions'**
  String get notifications_errorSnackBar_callUserMedia;

  /// No description provided for @notifications_errorSnackBar_sipServiceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Authentication error with the remote VoIP system'**
  String get notifications_errorSnackBar_sipServiceUnavailable;

  /// No description provided for @notImplemented.
  ///
  /// In en, this message translates to:
  /// **'Sorry, not implemented yet'**
  String get notImplemented;

  /// No description provided for @permission_Button_request.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get permission_Button_request;

  /// No description provided for @permission_manufacturer_Button_gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get permission_manufacturer_Button_gotIt;

  /// No description provided for @permission_manufacturer_Button_toSettings.
  ///
  /// In en, this message translates to:
  /// **'Open app Settings'**
  String get permission_manufacturer_Button_toSettings;

  /// No description provided for @permission_manufacturer_Text_heading.
  ///
  /// In en, this message translates to:
  /// **'To ensure the best user experience, the app needs to be granted the following permissions manually:'**
  String get permission_manufacturer_Text_heading;

  /// No description provided for @permission_manufacturer_Text_trailing.
  ///
  /// In en, this message translates to:
  /// **'Permissions could be changed at any time in the future.'**
  String get permission_manufacturer_Text_trailing;

  /// No description provided for @permission_manufacturer_Text_xiaomi_tip1.
  ///
  /// In en, this message translates to:
  /// **'Go to \"App settings\" → \"Notifications\".'**
  String get permission_manufacturer_Text_xiaomi_tip1;

  /// No description provided for @permission_manufacturer_Text_xiaomi_tip2.
  ///
  /// In en, this message translates to:
  /// **'Find and turn on \"Lockscreen notifications\".'**
  String get permission_manufacturer_Text_xiaomi_tip2;

  /// No description provided for @permission_Text_description.
  ///
  /// In en, this message translates to:
  /// **'To ensure the best user experience, the app needs to be granted the following permissions: microphone for audio calls, camera for video calls, and contacts to simplify reaching them from the app.\n\nPermissions could be changed at any time in the future.'**
  String get permission_Text_description;

  /// No description provided for @permission_manageFullScreenNotificationPermissions.
  ///
  /// In en, this message translates to:
  /// **'Manage Full-Screen Notification Permissions'**
  String get permission_manageFullScreenNotificationPermissions;

  /// No description provided for @permission_manageFullScreenNotificationInstructions_step1.
  ///
  /// In en, this message translates to:
  /// **'Go to your phone\'s Settings.'**
  String get permission_manageFullScreenNotificationInstructions_step1;

  /// No description provided for @permission_manageFullScreenNotificationInstructions_step2.
  ///
  /// In en, this message translates to:
  /// **'Navigate to \'Special App Access\' under the \'Apps & notifications\' section.'**
  String get permission_manageFullScreenNotificationInstructions_step2;

  /// No description provided for @permission_manageFullScreenNotificationInstructions_step3.
  ///
  /// In en, this message translates to:
  /// **'Find and tap on \'Manage full screen intents\'.'**
  String get permission_manageFullScreenNotificationInstructions_step3;

  /// No description provided for @permission_manageFullScreenNotificationInstructions_step4.
  ///
  /// In en, this message translates to:
  /// **'Select the app for which you want to manage full-screen notifications.'**
  String get permission_manageFullScreenNotificationInstructions_step4;

  /// No description provided for @permission_manageFullScreenNotificationInstructions_step5.
  ///
  /// In en, this message translates to:
  /// **'Toggle the permission to enable or disable full-screen notifications for that app.'**
  String get permission_manageFullScreenNotificationInstructions_step5;

  /// No description provided for @recents_BodyCenter_empty.
  ///
  /// In en, this message translates to:
  /// **'Currently you have no {filter}recent calls.'**
  String recents_BodyCenter_empty(Object filter);

  /// No description provided for @recents_DeleteConfirmDialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the current call log?'**
  String get recents_DeleteConfirmDialog_content;

  /// No description provided for @recents_DeleteConfirmDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm deleting'**
  String get recents_DeleteConfirmDialog_title;

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

  /// No description provided for @recents_Text_blingTransferInitiated.
  ///
  /// In en, this message translates to:
  /// **'Performing blind transfer'**
  String get recents_Text_blingTransferInitiated;

  /// No description provided for @recents_HistoryTile_missedCallText.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get recents_HistoryTile_missedCallText;

  /// No description provided for @recentsVisibilityFilter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get recentsVisibilityFilter_all;

  /// No description provided for @recentsVisibilityFilter_all_preposit.
  ///
  /// In en, this message translates to:
  /// **'all'**
  String get recentsVisibilityFilter_all_preposit;

  /// No description provided for @recentsVisibilityFilter_incoming.
  ///
  /// In en, this message translates to:
  /// **'Incoming'**
  String get recentsVisibilityFilter_incoming;

  /// No description provided for @recentsVisibilityFilter_incoming_preposit.
  ///
  /// In en, this message translates to:
  /// **'incoming'**
  String get recentsVisibilityFilter_incoming_preposit;

  /// No description provided for @recentsVisibilityFilter_missed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get recentsVisibilityFilter_missed;

  /// No description provided for @recentsVisibilityFilter_missed_preposit.
  ///
  /// In en, this message translates to:
  /// **'missed'**
  String get recentsVisibilityFilter_missed_preposit;

  /// No description provided for @recentsVisibilityFilter_outgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get recentsVisibilityFilter_outgoing;

  /// No description provided for @recentsVisibilityFilter_outgoing_preposit.
  ///
  /// In en, this message translates to:
  /// **'outgoing'**
  String get recentsVisibilityFilter_outgoing_preposit;

  /// No description provided for @recentTimeAfterMidnight.
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String recentTimeAfterMidnight(DateTime time);

  /// No description provided for @recentTimeBeforeMidnight.
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String recentTimeBeforeMidnight(DateTime time);

  /// No description provided for @request_Id.
  ///
  /// In en, this message translates to:
  /// **'Request id'**
  String get request_Id;

  /// No description provided for @request_StatusCode.
  ///
  /// In en, this message translates to:
  /// **'Status code'**
  String get request_StatusCode;

  /// No description provided for @settings_AboutText_AppVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get settings_AboutText_AppVersion;

  /// No description provided for @settings_AboutText_CoreVersionUndefined.
  ///
  /// In en, this message translates to:
  /// **'?.?.?'**
  String get settings_AboutText_CoreVersionUndefined;

  /// No description provided for @settings_AboutText_StoreVersion.
  ///
  /// In en, this message translates to:
  /// **'Build version in the Store'**
  String get settings_AboutText_StoreVersion;

  /// No description provided for @settings_AboutText_FCMPushNotificationToken.
  ///
  /// In en, this message translates to:
  /// **'FCM Push Notification Token'**
  String get settings_AboutText_FCMPushNotificationToken;

  /// No description provided for @settings_AccountDeleteConfirmDialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete account?'**
  String get settings_AccountDeleteConfirmDialog_content;

  /// No description provided for @settings_AccountDeleteConfirmDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm delete account'**
  String get settings_AccountDeleteConfirmDialog_title;

  /// No description provided for @settings_AppBarTitle_myAccount.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get settings_AppBarTitle_myAccount;

  /// No description provided for @settings_ForceLogoutConfirmDialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to force logout?'**
  String get settings_ForceLogoutConfirmDialog_content;

  /// No description provided for @settings_ForceLogoutConfirmDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm force logout'**
  String get settings_ForceLogoutConfirmDialog_title;

  /// No description provided for @settings_ListViewTileTitle_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_ListViewTileTitle_about;

  /// No description provided for @settings_ListViewTileTitle_accountDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settings_ListViewTileTitle_accountDelete;

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

  /// No description provided for @settings_ListViewTileTitle_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settings_ListViewTileTitle_logout;

  /// No description provided for @settings_ListViewTileTitle_logRecordsConsole.
  ///
  /// In en, this message translates to:
  /// **'Log records console'**
  String get settings_ListViewTileTitle_logRecordsConsole;

  /// No description provided for @settings_ListViewTileTitle_network.
  ///
  /// In en, this message translates to:
  /// **'Network settings'**
  String get settings_ListViewTileTitle_network;

  /// No description provided for @settings_ListViewTileTitle_call_codecs.
  ///
  /// In en, this message translates to:
  /// **'Call codecs'**
  String get settings_ListViewTileTitle_call_codecs;

  /// No description provided for @settings_ListViewTileTitle_registered.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get settings_ListViewTileTitle_registered;

  /// No description provided for @settings_ListViewTileTitle_settings.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settings_ListViewTileTitle_settings;

  /// No description provided for @settings_ListViewTileTitle_termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get settings_ListViewTileTitle_termsConditions;

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

  /// No description provided for @settings_LogoutConfirmDialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get settings_LogoutConfirmDialog_content;

  /// No description provided for @settings_LogoutConfirmDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm logout'**
  String get settings_LogoutConfirmDialog_title;

  /// No description provided for @settings_network_incomingCallType_title.
  ///
  /// In en, this message translates to:
  /// **'Incoming Call Type'**
  String get settings_network_incomingCallType_title;

  /// No description provided for @settings_network_incomingCallType_pushNotification_title.
  ///
  /// In en, this message translates to:
  /// **'Push Notification'**
  String get settings_network_incomingCallType_pushNotification_title;

  /// No description provided for @settings_network_incomingCallType_pushNotification_description.
  ///
  /// In en, this message translates to:
  /// **'When the app is not in use, it stops running and consumes minimal resources, which helps conserve battery life. During an incoming call, the server sends a push notification to the phone, prompting the mobile operating system to launch the app to handle the call. However, this method does not guarantee that all calls will be received. If the phone has been inactive for an extended period, some versions of Android may limit push notifications, potentially causing you to miss an incoming call.'**
  String get settings_network_incomingCallType_pushNotification_description;

  /// No description provided for @settings_network_incomingCallType_socket_title.
  ///
  /// In en, this message translates to:
  /// **'Persistent Connection to the Server'**
  String get settings_network_incomingCallType_socket_title;

  /// No description provided for @settings_network_incomingCallType_socket_description.
  ///
  /// In en, this message translates to:
  /// **'The app continues running in the background and always maintains an active connection to the server. This increases the chances of receiving an incoming call but may drain the battery more quickly.'**
  String get settings_network_incomingCallType_socket_description;

  /// No description provided for @settings_network_androidNotificationName.
  ///
  /// In en, this message translates to:
  /// **'Inbound Calls Service'**
  String get settings_network_androidNotificationName;

  /// No description provided for @settings_network_androidNotificationDescription.
  ///
  /// In en, this message translates to:
  /// **'This is required to receive calls while in background'**
  String get settings_network_androidNotificationDescription;

  /// No description provided for @settings_call_codecs_preferred_audio_title.
  ///
  /// In en, this message translates to:
  /// **'Preferred audio codec'**
  String get settings_call_codecs_preferred_audio_title;

  /// No description provided for @settings_call_codecs_preferred_audio_tip.
  ///
  /// In en, this message translates to:
  /// **'The preferred audio codec is used for audio calls. If the codec is not supported by device, the call will be established using the next available codec.'**
  String get settings_call_codecs_preferred_audio_tip;

  /// No description provided for @settings_call_codecs_preferred_audio_default.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get settings_call_codecs_preferred_audio_default;

  /// No description provided for @settings_call_codecs_preferred_video_title.
  ///
  /// In en, this message translates to:
  /// **'Preferred video codec'**
  String get settings_call_codecs_preferred_video_title;

  /// No description provided for @settings_call_codecs_preferred_video_tip.
  ///
  /// In en, this message translates to:
  /// **'The preferred video codec is used for video calls. If the codec is not supported by device, the call will be established using the next available codec.'**
  String get settings_call_codecs_preferred_video_tip;

  /// No description provided for @settings_call_codecs_preferred_video_default.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get settings_call_codecs_preferred_video_default;

  /// No description provided for @themeMode_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeMode_dark;

  /// No description provided for @themeMode_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeMode_light;

  /// No description provided for @themeMode_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeMode_system;

  /// No description provided for @undefine_DeeplinkConfigurationInvalid_text.
  ///
  /// In en, this message translates to:
  /// **'The autoconfiguration credentials are invalid, please log in'**
  String get undefine_DeeplinkConfigurationInvalid_text;

  /// No description provided for @underDevelopment.
  ///
  /// In en, this message translates to:
  /// **'This page is under development.'**
  String get underDevelopment;

  /// No description provided for @user_agreement_agrement_link.
  ///
  /// In en, this message translates to:
  /// **'The terms and conditions of the agreement'**
  String get user_agreement_agrement_link;

  /// No description provided for @user_agreement_button_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get user_agreement_button_text;

  /// No description provided for @user_agreement_checkbox_text.
  ///
  /// In en, this message translates to:
  /// **'I have read the {url} and consent to its terms.'**
  String user_agreement_checkbox_text(Object url);

  /// No description provided for @user_agreement_description.
  ///
  /// In en, this message translates to:
  /// **'Welcome to {appName}'**
  String user_agreement_description(Object appName);

  /// No description provided for @validationBlankError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a value'**
  String get validationBlankError;

  /// No description provided for @webRegistration_ErrorAcknowledgeDialogActions_demo.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get webRegistration_ErrorAcknowledgeDialogActions_demo;

  /// No description provided for @webRegistration_ErrorAcknowledgeDialogActions_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get webRegistration_ErrorAcknowledgeDialogActions_retry;

  /// No description provided for @webRegistration_ErrorAcknowledgeDialogActions_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get webRegistration_ErrorAcknowledgeDialogActions_skip;

  /// No description provided for @webRegistration_ErrorAcknowledgeDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Web resource error'**
  String get webRegistration_ErrorAcknowledgeDialog_title;

  /// No description provided for @diagnostic_AppBar_title.
  ///
  /// In en, this message translates to:
  /// **'Diagnostic'**
  String get diagnostic_AppBar_title;

  /// No description provided for @diagnosticPermissionDetails_title_statusPermission.
  ///
  /// In en, this message translates to:
  /// **'Status permission'**
  String get diagnosticPermissionDetails_title_statusPermission;

  /// No description provided for @diagnosticPermissionDetails_button_requestPermission.
  ///
  /// In en, this message translates to:
  /// **'Request Permission'**
  String get diagnosticPermissionDetails_button_requestPermission;

  /// No description provided for @diagnosticPermissionDetails_button_managePermission.
  ///
  /// In en, this message translates to:
  /// **'Manage Permission'**
  String get diagnosticPermissionDetails_button_managePermission;

  /// No description provided for @diagnostic_permissionStatus_denied.
  ///
  /// In en, this message translates to:
  /// **'Access Denied'**
  String get diagnostic_permissionStatus_denied;

  /// No description provided for @diagnostic_permissionStatus_granted.
  ///
  /// In en, this message translates to:
  /// **'Access Granted'**
  String get diagnostic_permissionStatus_granted;

  /// No description provided for @diagnostic_permissionStatus_restricted.
  ///
  /// In en, this message translates to:
  /// **'Restricted Access'**
  String get diagnostic_permissionStatus_restricted;

  /// No description provided for @diagnostic_permissionStatus_limited.
  ///
  /// In en, this message translates to:
  /// **'Limited Access'**
  String get diagnostic_permissionStatus_limited;

  /// No description provided for @diagnostic_permissionStatus_permanentlyDenied.
  ///
  /// In en, this message translates to:
  /// **'Access Permanently Denied'**
  String get diagnostic_permissionStatus_permanentlyDenied;

  /// No description provided for @diagnostic_permissionStatus_provisional.
  ///
  /// In en, this message translates to:
  /// **'Provisional Access'**
  String get diagnostic_permissionStatus_provisional;

  /// No description provided for @diagnostic_permission_camera_title.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get diagnostic_permission_camera_title;

  /// No description provided for @diagnostic_permission_microphone_title.
  ///
  /// In en, this message translates to:
  /// **'Microphone'**
  String get diagnostic_permission_microphone_title;

  /// No description provided for @diagnostic_permission_contacts_title.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get diagnostic_permission_contacts_title;

  /// No description provided for @diagnostic_permission_notification_title.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get diagnostic_permission_notification_title;

  /// No description provided for @diagnostic_permission_camera_description.
  ///
  /// In en, this message translates to:
  /// **'This app requires permission to access the camera to make video calls.'**
  String get diagnostic_permission_camera_description;

  /// No description provided for @diagnostic_permission_microphone_description.
  ///
  /// In en, this message translates to:
  /// **'This app requires permission to access the microphone to make audio calls.'**
  String get diagnostic_permission_microphone_description;

  /// No description provided for @diagnostic_permission_contacts_description.
  ///
  /// In en, this message translates to:
  /// **'This app requires permission to access contacts to make calls within your address book.'**
  String get diagnostic_permission_contacts_description;

  /// No description provided for @diagnostic_permission_notification_description.
  ///
  /// In en, this message translates to:
  /// **'Enables the app to trigger incoming call.'**
  String get diagnostic_permission_notification_description;

  /// No description provided for @diagnosticScreen_pushNotificationService_title.
  ///
  /// In en, this message translates to:
  /// **'Push notification service'**
  String get diagnosticScreen_pushNotificationService_title;

  /// No description provided for @diagnosticScreen_permissionsGroup_title.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get diagnosticScreen_permissionsGroup_title;

  /// No description provided for @diagnosticPushDetails_configuration_title.
  ///
  /// In en, this message translates to:
  /// **'Push Notification service configuration'**
  String get diagnosticPushDetails_configuration_title;

  /// No description provided for @diagnosticPushDetails_successMessage.
  ///
  /// In en, this message translates to:
  /// **'The notification service is successfully configured and ready for use to receive messages and handle incoming calls.'**
  String get diagnosticPushDetails_successMessage;

  /// No description provided for @diagnosticPushDetails_errorMessage_intro.
  ///
  /// In en, this message translates to:
  /// **'Some steps to try:\n'**
  String get diagnosticPushDetails_errorMessage_intro;

  /// No description provided for @diagnosticPushDetails_errorMessage_step1.
  ///
  /// In en, this message translates to:
  /// **'1. Ensure your phone is connected to the internet.\n'**
  String get diagnosticPushDetails_errorMessage_step1;

  /// No description provided for @diagnosticPushDetails_errorMessage_step2.
  ///
  /// In en, this message translates to:
  /// **'2. If connected, check that your phone can access Google services by visiting a website.\n'**
  String get diagnosticPushDetails_errorMessage_step2;

  /// No description provided for @diagnosticPushDetails_errorMessage_step3.
  ///
  /// In en, this message translates to:
  /// **'3. Wait a few minutes and try again – Firebase messaging servers may be temporarily down.\n'**
  String get diagnosticPushDetails_errorMessage_step3;

  /// No description provided for @diagnosticPushDetails_errorMessage_step4.
  ///
  /// In en, this message translates to:
  /// **'4. Restart Google Play services to ensure they are functioning correctly.\n'**
  String get diagnosticPushDetails_errorMessage_step4;

  /// No description provided for @diagnosticPushDetails_errorMessage_step5.
  ///
  /// In en, this message translates to:
  /// **'5. Verify that Google Play services are installed on your device.\n'**
  String get diagnosticPushDetails_errorMessage_step5;

  /// No description provided for @diagnostic_pushTokenStatusType_success.
  ///
  /// In en, this message translates to:
  /// **'Service successfully configured'**
  String get diagnostic_pushTokenStatusType_success;

  /// No description provided for @diagnostic_pushTokenStatusType_error.
  ///
  /// In en, this message translates to:
  /// **'Problem with configuration push notification service'**
  String get diagnostic_pushTokenStatusType_error;

  /// No description provided for @sessionStatus_pushNotificationServiceProblem.
  ///
  /// In en, this message translates to:
  /// **'Problem with configuration push notification service'**
  String get sessionStatus_pushNotificationServiceProblem;

  /// No description provided for @diagnostic_pushTokenStatusType_progress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get diagnostic_pushTokenStatusType_progress;

  /// No description provided for @diagnostic_batteryMode_unrestricted_title.
  ///
  /// In en, this message translates to:
  /// **'Unrestricted'**
  String get diagnostic_batteryMode_unrestricted_title;

  /// No description provided for @diagnostic_batteryMode_optimized_title.
  ///
  /// In en, this message translates to:
  /// **'Optimized'**
  String get diagnostic_batteryMode_optimized_title;

  /// No description provided for @diagnostic_batteryMode_restricted_title.
  ///
  /// In en, this message translates to:
  /// **'Restricted'**
  String get diagnostic_batteryMode_restricted_title;

  /// No description provided for @diagnostic_batteryMode_unknown_title.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get diagnostic_batteryMode_unknown_title;

  /// No description provided for @diagnostic_batteryMode_unrestricted_description.
  ///
  /// In en, this message translates to:
  /// **'The app has full access to run in the background without restrictions.'**
  String get diagnostic_batteryMode_unrestricted_description;

  /// No description provided for @diagnostic_batteryMode_optimized_description.
  ///
  /// In en, this message translates to:
  /// **'The app\'s background activity is managed by the system to save the battery. It may not work correctly with incoming calls triggered by push notifications.'**
  String get diagnostic_batteryMode_optimized_description;

  /// No description provided for @diagnostic_batteryMode_restricted_description.
  ///
  /// In en, this message translates to:
  /// **'The app\'s background activity is heavily restricted to conserve the battery. Incoming calls may be missed.'**
  String get diagnostic_batteryMode_restricted_description;

  /// No description provided for @diagnostic_batteryMode_unknown_description.
  ///
  /// In en, this message translates to:
  /// **'The battery mode status is unknown. The app might have unpredictable behavior.'**
  String get diagnostic_batteryMode_unknown_description;

  /// No description provided for @diagnostic_battery_groupTitle.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get diagnostic_battery_groupTitle;

  /// No description provided for @diagnostic_battery_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Battery mode'**
  String get diagnostic_battery_tile_title;

  /// No description provided for @diagnostic_battery_navigate_section.
  ///
  /// In en, this message translates to:
  /// **'Navigate to the Battery section'**
  String get diagnostic_battery_navigate_section;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'it', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'it': return AppLocalizationsIt();
    case 'uk': return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
