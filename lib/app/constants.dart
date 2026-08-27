import 'package:flutter/material.dart';

const kApiClientConnectionTimeout = Duration(seconds: 5);

const kSignalingClientConnectionTimeout = Duration(seconds: 10);

/// How long to wait for signaling to reconnect after an outgoing call is
/// already registered with the system call UI (dialing state).
///
/// Longer than [kSignalingClientConnectionTimeout] because the user is
/// looking at the call screen and expects the call to survive a brief
/// network interruption (e.g. switching from Wi-Fi to LTE).
const kOutgoingCallSignalingWaitTimeout = Duration(seconds: 30);
const _kSignalingClientReconnectDelaySeconds = 3;
const kSignalingClientReconnectDelay = Duration(seconds: _kSignalingClientReconnectDelaySeconds);
const kSignalingClientFastReconnectDelay = Duration(seconds: 1);

/// Debounce window for transient signaling status transitions (connectIssue,
/// inProgress, connectError). Slightly longer than [kSignalingClientReconnectDelay]
/// so one full reconnect cycle is absorbed before the UI updates.
const kSignalingStatusDebounce = Duration(seconds: _kSignalingClientReconnectDelaySeconds, milliseconds: 500);

/// How long the local ringback waits after the first ringing answer of an
/// outgoing call, in case the network is about to send a ringback of its own.
///
/// Operators that play their own tone announce the call as ringing first and
/// send the media right after; on a customer trace that gap was about 0.8 s, so
/// the window is a touch wider. Calls where no network audio follows simply
/// start the tone once it elapses.
const kOutgoingRingbackStartDelay = Duration(seconds: 1);

/// How long [WebtritSignalingService.connect] waits for a terminal event
/// (Connected / Disconnected / ConnectionFailed) before resetting
/// [_startPending] and retrying. Covers the case where the background isolate
/// accepts the connect command but never sends a response — e.g. a WebSocket
/// upgrade that hangs at the OS/TCP level without timing out.
const kSignalingStartPendingTimeout = Duration(seconds: 30);

const kPeerConnectionRetrieveTimeout = Duration(seconds: 5);

const kCompatibilityVerifyRepeatDelay = Duration(seconds: 2);

const kDebounceDuration = Duration(milliseconds: 275);

const kDefaultCountdownRepeatIntervalSeconds = Duration(seconds: 30);

const kInset = kMinInteractiveDimension / 2;

const kMainAppBarBottomPaddingGap = 6.0;

/// Height of a control the app bar carries in its bottom rows - a tab, the
/// search field, the button that clears it.
///
/// Every one of them is a tap target, so this is the floor: pass it to the
/// control directly. Deriving a control's height from the row that holds it
/// is what leaves it short, because the row also carries the gap below.
const kMainAppBarBottomControlHeight = kMinInteractiveDimension;

/// What the app bar reserves for such a row: the control plus the gap that
/// separates it from what follows.
const kMainAppBarBottomTabHeight = kMainAppBarBottomControlHeight + kMainAppBarBottomPaddingGap;
const kMainAppBarBottomSearchHeight = kMainAppBarBottomControlHeight + kMainAppBarBottomPaddingGap;

/// How solid the surfaces at the bottom of the screen are.
///
/// They sit over a backdrop blur, so the fill has to let it through: opaque,
/// the blur is hidden and the surface reads as a strip pasted on the glass.
/// Shared because the tab bar and the banner above it are one pane, and two
/// figures drifting apart would show the seam.
const kBottomSurfaceAlpha = 200;

/// Standard vertical padding (in logical pixels) used around Material list items.
///
/// Prefer this value when constructing edge insets to keep list spacing consistent
/// across the app (e.g., `EdgeInsets.symmetric(vertical: kMaterialListPadding)`).
const double kMaterialListPadding = 8.0;

const kAllPadding16 = EdgeInsets.all(16.0);

/// Universal padding for floating overlays (e.g., overlay or sticky widgets).
///
/// Uses `kToolbarHeight` for the top inset to avoid overlapping the AppBar, and
/// applies `kMaterialListPadding` on the left, right, and bottom for spacing.
const kStickyOverlayPadding = EdgeInsets.only(
  left: kMaterialListPadding,
  right: kMaterialListPadding,
  bottom: kMaterialListPadding,
  top: kToolbarHeight,
);

const kBlankUri = 'about:blank';

const initialMainRout = '/main';

const kAutoprovisionRout = '/autoprovision';

const kSmsMessagingFeatureFlag = 'smsMessaging';
const kChatMessagingFeatureFlag = 'internalMessaging';
const kVoicemailFeatureFlag = 'voicemail';
const kSystemNotificationsFeatureFlag = 'notifications';
const kSystemNotificationsPushFeatureFlag = 'notificationsPush';
const kSipPresenceFeatureFlag = 'sipPresence';
const kSipDialogsFeatureFlag = 'sipDialogs';
const kCallHistoryFeatureFlag = 'callHistory';
const kExtensionsFeatureFlag = 'extensions';

/// Adapter capability for the call-to-action list shown in the client UI.
///
/// Note: the wire value is snake_case (`cta_list`), unlike the other camelCase
/// capability flags. See webtrit_bss_adapter_python `app/bss/models.py` `SupportedEnum`.
const kCtaListFeatureFlag = 'cta_list';

/// Key under `system-info` `adapter.custom` listing the identifier types the
/// backend adapter accepts for OTP sign-in (e.g. `phone_number`, `email`).
///
/// The OTP request screen reads this to show only the inputs the backend
/// supports; absent for older cores, where the app falls back to phone + email.
const kOtpLoginIdentifiersCustomKey = 'otp_login_identifiers';

const kSystemNotificationsTask = 'systemNotificationsTask';
const kSystemNotificationsTaskId = 'systemNotificationsTask-id';

const kLocalPushSourceSystemNotification = 'system-notification';
const kLocalPushSourceMessaging = 'messaging';

const kPresenceActivityKeyAway = 'away';
const kPresenceActivityKeyBusy = 'busy';
const kPresenceActivityKeySleeping = 'sleeping';
const kPresenceActivityKeyDoNotDisturb = 'do-not-disturb';
const kPresenceActivityKeyPermanentAbsence = 'permanent-absence';
const kPresenceActivityKeyOnThePhone = 'on-the-phone';
const kPresenceActivityKeyMeal = 'meal';
const kPresenceActivityKeyMeeting = 'meeting';
const kPresenceActivityKeyAppointment = 'appointment';
const kPresenceActivityKeyVacation = 'vacation';
const kPresenceActivityKeyTravel = 'travel';
const kPresenceActivityKeyInTransit = 'in-transit';

/// Represents the primary or main phone number for a contact.
const kContactMainLabel = 'number';

/// Represents the PBX extension number for a contact.
const kContactExtLabel = 'ext';

/// Represents the phone number used for SMS messaging.
const kContactSmsLabel = 'sms';

/// Represents any additional phone number or contact method.
const kContactAdditionalLabel = 'additional';

/// For reference: Telegram 4 096, Discord 2 000, Signal ~2 000, WhatsApp 65 536.
const kAppMessagingMaxLength = 4096;

/// 160 * 10 de-facto segment/segments cap, but better to make it configurable from system-info
/// TODO: Make this variable configurable based on sms provider capabilities
const kSmsMessagingMaxLength = 1600;
