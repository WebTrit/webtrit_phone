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

const String optInputId = 'otpInput';
const optInputKey = Key(optInputId);
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

// Identifier-only entries: controls that have no widget-test key.
const String actionPadOverflowId = 'actionPadOverflow';
const String actionPadTransferId = 'actionPadTransfer';
const String actionPadVoiceCallId = 'actionPadVoiceCall';
const String callActionsAcceptId = 'callActionsAccept';
const String callActionsAudioDeviceId = 'callActionsAudioDevice';
const String callActionsHideKeypadId = 'callActionsHideKeypad';
const String callActionsOptionsId = 'callActionsOptions';
const String callTileDialId = 'callTileDial';
const String callTileMenuId = 'callTileMenu';
const String systemNotificationsBadgeId = 'systemNotificationsBadge';

// Keypad keys: keypadKey1..keypadKey0 for the digits, plus the two symbols.
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
const String contactsSerchInputId = 'contactsSearchInput';
const contactsSerchInputKey = Key(contactsSerchInputId);
const String contactsSerchInputClearId = 'contactsSearchInputClear';
const contactsSerchInputClearKey = Key(contactsSerchInputClearId);
const String contactPhoneTileId = 'contactPhoneTile';
const contactPhoneTileKey = Key(contactPhoneTileId);
const String contactPhoneTileFavIconId = 'contactPhoneTileFavIcon';
const contactPhoneTileFavIconKey = Key(contactPhoneTileFavIconId);
const String contactEmailTileId = 'contactEmailTile';
const contactEmailTileKey = Key(contactEmailTileId);
