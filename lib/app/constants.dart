import 'package:flutter/material.dart';

const kApiClientConnectionTimeout = Duration(seconds: 5);

const kSignalingClientConnectionTimeout = Duration(seconds: 10);
const kSignalingClientReconnectDelay = Duration(seconds: 3);
const kSignalingClientFastReconnectDelay = Duration(seconds: 1);

const kPeerConnectionRetrieveTimeout = Duration(seconds: 5);

const kCompatibilityVerifyRepeatDelay = Duration(seconds: 2);

const kDebounceDuration = Duration(milliseconds: 275);

const kDefaultCountdownRepeatIntervalSeconds = Duration(seconds: 30);

const kInset = kMinInteractiveDimension / 2;

const kMainAppBarBottomTabHeight = 42.0;
const kMainAppBarBottomSearchHeight = kMinInteractiveDimension;
const kMainAppBarBottomPaddingGap = 6.0;

const kAllPadding16 = EdgeInsets.all(16.0);

const kBlankUri = 'about:blank';

const initialMainRout = '/main';

const kAutoprovisionRout = '/autoprovision';

const kSmsMessagingFeatureFlag = 'smsMessaging';
const kChatMessagingFeatureFlag = 'internalMessaging';
const kVoicemailFeatureFlag = 'voicemail';
const kSystemNotificationsFeatureFlag = 'notifications';
const kSystemNotificationsPushFeatureFlag = 'notificationsPush';
const kSipPresenceFeatureFlag = 'sipPresence';

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
