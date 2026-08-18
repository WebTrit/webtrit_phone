import 'package:flutter/foundation.dart';

// Each widget key is paired with a String constant that doubles as the
// accessibility identifier (`Semantics.identifier`) of the same control.
// The key is always built from the constant, so the widget-test anchor and
// the accessibility tree anchor cannot drift apart.

const String loginModeScreenSignUpButtonId = 'loginModeScreenSignUpButton';
const loginModeScreenSignUpButtonKey = Key(loginModeScreenSignUpButtonId);
const String loginModeScreenUrlButtonId = 'loginModeScreenUrlButton';
const loginModeScreenUrlButtonKey = Key(loginModeScreenUrlButtonId);

const String coreUrlInputId = 'coreUrlInput';
const coreUrlInputKey = Key(coreUrlInputId);
const String coreUrlButtonId = 'coreUrlButton';
const coreUrlButtonKey = Key(coreUrlButtonId);

const String signupEmailInputId = 'signupEmailInput';
const signupEmailInputKey = Key(signupEmailInputId);
const String signupVerifyInputId = 'signupVerifyInput';
const signupVerifyInputKey = Key(signupVerifyInputId);
const String signupEmailButtonId = 'signupEmailButton';
const signupEmailButtonKey = Key(signupEmailButtonId);
const String signupVerifyButtonId = 'signupVerifyButton';
const signupVerifyButtonKey = Key(signupVerifyButtonId);

const String otpInputId = 'otpInput';
const otpInputKey = Key(otpInputId);
const String otpVerifyInputId = 'otpVerifyInput';
const otpVerifyInputKey = Key(otpVerifyInputId);
const String otpButtonId = 'otpButton';
const otpButtonKey = Key(otpButtonId);
const String otpVerifyButtonId = 'otpVerifyButton';
const otpVerifyButtonKey = Key(otpVerifyButtonId);

const String passwordUserInputId = 'passwordUserInput';
const passwordUserInputKey = Key(passwordUserInputId);
const String passwordPasswordInputId = 'passwordPasswordInput';
const passwordPasswordInputKey = Key(passwordPasswordInputId);
const String passwordButtonId = 'passwordButton';
const passwordButtonKey = Key(passwordButtonId);

const String loginTypeSegmentOtpSigninId = 'loginTypeSegmentOtpSignin';
const loginTypeSegmentOtpSigninKey = Key(loginTypeSegmentOtpSigninId);
const String loginTypeSegmentPasswordSigninId = 'loginTypeSegmentPasswordSignin';
const loginTypeSegmentPasswordSigninKey = Key(loginTypeSegmentPasswordSigninId);
const String loginTypeSegmentSignupId = 'loginTypeSegmentSignup';
const loginTypeSegmentSignupKey = Key(loginTypeSegmentSignupId);
const String loginTypeSegmentQrSigninId = 'loginTypeSegmentQrSignin';
const loginTypeSegmentQrSigninKey = Key(loginTypeSegmentQrSigninId);

const String contactsAgreementCheckboxId = 'contactsAgreementCheckbox';
const contactsAgreementCheckboxKey = Key(contactsAgreementCheckboxId);
const String contactsAgreementAcceptButtonId = 'contactsAgreementAcceptButton';
const contactsAgreementAcceptButtonKey = Key(contactsAgreementAcceptButtonId);

const String userAgreementCheckboxId = 'userAgreementCheckbox';
const userAgreementCheckboxKey = Key(userAgreementCheckboxId);
const String userAgreementAcceptButtonId = 'userAgreementAcceptButton';
const userAgreementAcceptButtonKey = Key(userAgreementAcceptButtonId);

const String permissionsInitButtonId = 'permissionsProcessButton';
const permissionsInitButtonKey = Key(permissionsInitButtonId);
const String permissionTipsButtonId = 'permissionTipsButton';
const permissionTipsButtonKey = Key(permissionTipsButtonId);

const String mainAppBarId = 'mainAppBar';
const mainAppBarKey = Key(mainAppBarId);
const String settingsLogoutButtonId = 'settingsLogoutButton';
const settingsLogoutButtonKey = Key(settingsLogoutButtonId);

const String confirmDialogYesButtonId = 'confirmDialogYesButton';
const confirmDialogYesButtonKey = Key(confirmDialogYesButtonId);
const String confirmDialogNoButtonId = 'confirmDialogNoButton';
const confirmDialogNoButtonKey = Key(confirmDialogNoButtonId);

const String actionPadVideoCallId = 'actionPadVideoCall';
const actionPadVideoCallKey = Key(actionPadVideoCallId);
const String actionPadBackspaceId = 'actionPadBackspace';
const actionPadBackspaceKey = Key(actionPadBackspaceId);

const String callActionsMuteId = 'callActionsMute';
const callActionsMuteKey = Key(callActionsMuteId);
const String callActionsVideoCallId = 'callActionsVideoCall';
const callActionsVideoCallKey = Key(callActionsVideoCallId);
const String callActionsSpeakerId = 'callActionsSpeaker';
const callActionsSpeakerKey = Key(callActionsSpeakerId);
const String callActionsHoldId = 'callActionsHold';
const callActionsHoldKey = Key(callActionsHoldId);
const String callActionsKeypadId = 'callActionsKeypad';
const callActionsKeypadKey = Key(callActionsKeypadId);
const String callActionsHangupId = 'callActionsHangup';
const callActionsHangupKey = Key(callActionsHangupId);
const String callActionsTransferMenuId = 'callActionsTransferMenu';
const callActionsTransferMenuKey = Key(callActionsTransferMenuId);
const String callActionsTransferMenuBlindInitId = 'callActionsTransferMenuBlindInit';
const callActionsTransferMenuBlindInitKey = Key(callActionsTransferMenuBlindInitId);
const String callActionsTransferMenuAttendedInitId = 'callActionsTransferMenuAttendedInit';
const callActionsTransferMenuAttendedInitKey = Key(callActionsTransferMenuAttendedInitId);
const String callActionsTransferMenuNumberId = 'callActionsTransferAttendedNumber';
const callActionsTransferMenuNumberKey = Key(callActionsTransferMenuNumberId);
const String callFrontCameraPreviewId = 'callFrontCameraPreview';
const callFrontCameraPreviewKey = Key(callFrontCameraPreviewId);
const String callActiveThumbnailId = 'callActiveThumbnail';
const String callControlsToggleId = 'callControlsToggle';
const String callRowId = 'callRow';

// Screen anchors: identify the screen itself, so a flow can tell where it is
// before touching a control. Login needs them because the visible captions
// repeat - "Proceed" names the button on four different screens.
const String chatConversationScreenId = 'chatConversationScreen';
const String contactScreenId = 'contactScreen';
const String loginCoreUrlScreenId = 'loginCoreUrlScreen';
const String loginModeScreenId = 'loginModeScreen';
const String loginOtpRequestScreenId = 'loginOtpRequestScreen';
const String loginOtpVerifyScreenId = 'loginOtpVerifyScreen';
const String loginPasswordScreenId = 'loginPasswordScreen';
const String loginQrScreenId = 'loginQrScreen';
const String loginSignupEmbeddedErrorScreenId = 'loginSignupEmbeddedErrorScreen';
const String loginSignupRequestScreenId = 'loginSignupRequestScreen';
const String loginSignupVerifyScreenId = 'loginSignupVerifyScreen';
const String smsConversationScreenId = 'smsConversationScreen';

// The bottom of a conversation: the field a message is written in, the arrow
// that sends it, and the bar that appears above them while a message is being
// replied to, changed or passed on. The bar carries the id of what it is for,
// because that is the only thing about it that a flow can rely on - its text
// is the message it quotes.
const String messageInputId = 'messageInput';
const String messageSendId = 'messageSend';
const String messageEditBarId = 'messageEditBar';
const String messageForwardBarId = 'messageForwardBar';
const String messageReplyBarId = 'messageReplyBar';
const String messageExchangeCancelId = 'messageExchangeCancel';
const String messageExchangeConfirmId = 'messageExchangeConfirm';
const String conversationMenuId = 'conversationMenu';

// Identifier-only entries: controls that have no widget-test key.
const String actionPadOverflowId = 'actionPadOverflow';
const String appSnackBarId = 'appSnackBar';
const String actionPadTransferId = 'actionPadTransfer';
const String actionPadVoiceCallId = 'actionPadVoiceCall';
const String callActionsAcceptId = 'callActionsAccept';
const String callActionsAudioDeviceId = 'callActionsAudioDevice';
const String callActionsHideKeypadId = 'callActionsHideKeypad';
const String callActionsOptionsId = 'callActionsOptions';
const String callPullBadgeId = 'callPullBadge';
const String callPullDialogId = 'callPullDialog';
const String callPullPickupId = 'callPullPickup';
const String callTileDialId = 'callTileDial';
const String callTileMenuId = 'callTileMenu';
const String chatInfoCallId = 'chatInfoCall';
const String chatInfoVideoCallId = 'chatInfoVideoCall';
const String contactChatId = 'contactChat';
const String contactDialogsSubscriptionId = 'contactDialogsSubscription';
const String contactDialogsSubscriptionInfoId = 'contactDialogsSubscriptionInfo';
const String contactEmailSendId = 'contactEmailSend';
const String contactPhoneChatId = 'contactPhoneChat';
const String contactPhoneMenuId = 'contactPhoneMenu';
const String contactPhoneTransferId = 'contactPhoneTransfer';
const String contactPhoneVideoCallId = 'contactPhoneVideoCall';
const String contactPhoneVoiceCallId = 'contactPhoneVoiceCall';
const String contactPresenceSubscriptionId = 'contactPresenceSubscription';
const String contactPresenceSubscriptionInfoId = 'contactPresenceSubscriptionInfo';
const String conversationsNewId = 'conversationsNew';
const String diagnosticNetworkTestId = 'diagnosticNetworkTest';
const String diagnosticNetworkTestRefreshId = 'diagnosticNetworkTestRefresh';
const String favoritesReorderId = 'favoritesReorder';
const String loginQrAllowCameraButtonId = 'loginQrAllowCameraButton';
const String loginQrOpenSettingsButtonId = 'loginQrOpenSettingsButton';
const String loginSignupEmbeddedRetryButtonId = 'loginSignupEmbeddedRetryButton';
const String otpVerifyResendButtonId = 'otpVerifyResendButton';
const String passwordObscureToggleId = 'passwordObscureToggle';
const String permissionsSettingsButtonId = 'permissionsSettingsButton';
const String presenceSettingsActivityId = 'presenceSettingsActivity';
const String presenceSettingsActivityInfoId = 'presenceSettingsActivityInfo';
const String presenceSettingsAvailabilityId = 'presenceSettingsAvailability';
const String presenceSettingsAvailabilityInfoId = 'presenceSettingsAvailabilityInfo';
const String presenceSettingsConfigSectionId = 'presenceSettingsConfigSection';
const String presenceSettingsDndId = 'presenceSettingsDnd';
const String presenceSettingsDndInfoId = 'presenceSettingsDndInfo';
const String presenceSettingsNoteId = 'presenceSettingsNote';
const String presenceSettingsNoteInfoId = 'presenceSettingsNoteInfo';
const String presenceSettingsPresetId = 'presenceSettingsPreset';
const String presenceSettingsScreenId = 'presenceSettingsScreen';
const String presenceSettingsStatusIconClearId = 'presenceSettingsStatusIconClear';
const String presenceSettingsStatusIconPickId = 'presenceSettingsStatusIconPick';
const String registerStatusSwitchId = 'registerStatusSwitch';
const String sessionStatusTileId = 'sessionStatusTile';
const String signupVerifyResendButtonId = 'signupVerifyResendButton';
const String statusIconPickerId = 'statusIconPicker';
const String statusIconPickerSearchId = 'statusIconPickerSearch';
const String statusIconPickerSearchCloseId = 'statusIconPickerSearchClose';
const String statusIconPickerSearchInputId = 'statusIconPickerSearchInput';
const String systemNotificationsBadgeId = 'systemNotificationsBadge';
const String voicemailMenuId = 'voicemailMenu';
const String voicemailPlaybackId = 'voicemailPlayback';
const String voicemailRetryId = 'voicemailRetry';

const String scrollToBottomId = 'scrollToBottomButton';
const scrollToBottomKey = Key(scrollToBottomId);
const String scrollToTopId = 'scrollToTopButton';
const scrollToTopKey = Key(scrollToTopId);
const String webViewReloadId = 'webViewReload';

// Rows of a list of choices: the visible titles are translated, so the option
// itself has to be identified by what it stands for.
const String settingsLanguageOptionIdPrefix = 'settingsLanguageOption';
const String settingsThemeModeOptionIdPrefix = 'settingsThemeModeOption';
const String settingsIncomingCallTypeOptionIdPrefix = 'settingsIncomingCallTypeOption';
const String mediaSettingsOptionIdPrefix = 'mediaSettingsOption';

// Category tabs of the status icon picker: the tabs are bare icons, so the id
// is built from the category each one stands for.
const String statusIconPickerCategoryIdPrefix = 'statusIconPickerCategory';

/// Stable automation id of an option row, built from what the option means
/// rather than from its position or its translated title.
String settingsOptionId(String prefix, String value) => '$prefix${_capitalize(value)}';

String _capitalize(String value) => value.isEmpty ? value : value[0].toUpperCase() + value.substring(1);

// Keypad keys: keypadKey1..keypadKey0 for the digits, plus the two symbols.
const String keypadNumberInputId = 'keypadNumberInput';
const String keypadKeyIdPrefix = 'keypadKey';
const String keypadKeyStarId = '${keypadKeyIdPrefix}Star';
const String keypadKeyPoundId = '${keypadKeyIdPrefix}Pound';

/// Stable automation id of the keypad key showing [text].
String keypadKeyId(String text) => switch (text) {
  '*' => keypadKeyStarId,
  '#' => keypadKeyPoundId,
  final digit => '$keypadKeyIdPrefix$digit',
};

const String contactsExtContactTileId = 'contactsExtContactTile';
const contactsExtContactTileKey = Key(contactsExtContactTileId);
const String contactsLocalContactTileId = 'contactsLocalContactTile';
const contactsLocalContactTileKey = Key(contactsLocalContactTileId);
const String contactsTabExtId = 'contactsTabExt';
const contactsTabExtKey = Key(contactsTabExtId);
const String contactsTabLocalId = 'contactsTabLocal';
const contactsTabLocalKey = Key(contactsTabLocalId);
const String contactsSearchInputId = 'contactsSearchInput';
const contactsSearchInputKey = Key(contactsSearchInputId);
const String contactsSearchInputClearId = 'contactsSearchInputClear';
const contactsSearchInputClearKey = Key(contactsSearchInputClearId);

const String conversationsSearchInputId = 'conversationsSearchInput';
const conversationsSearchInputKey = Key(conversationsSearchInputId);
const String conversationsSearchInputClearId = 'conversationsSearchInputClear';
const conversationsSearchInputClearKey = Key(conversationsSearchInputClearId);
const String contactPhoneTileId = 'contactPhoneTile';
const contactPhoneTileKey = Key(contactPhoneTileId);
const String contactPhoneTileFavIconId = 'contactPhoneTileFavIcon';
const contactPhoneTileFavIconKey = Key(contactPhoneTileFavIconId);
const String contactEmailTileId = 'contactEmailTile';
const contactEmailTileKey = Key(contactEmailTileId);

/// Id of the [index]th control in a list of identical ones: the first keeps the
/// plain id, the rest are numbered from two, the way a person would count them.
///
/// A row of a list cannot use the identifier of the thing it shows - a call id
/// is generated at call time and a test cannot know it in advance - so position
/// is what is left to address it by.
String numberedId(String id, int index) => index == 0 ? id : '$id${index + 1}';
