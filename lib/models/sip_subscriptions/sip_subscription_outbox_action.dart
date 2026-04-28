import 'package:equatable/equatable.dart';

import 'sip_subscription.dart';

enum SipSubscriptionOutboxActionType { upsert, delete }

class SipSubscriptionOutboxAction extends Equatable {
  const SipSubscriptionOutboxAction({
    required this.action,
    required this.type,
    required this.number,
    this.contactUserId,
    this.sendAttempts = 0,
    this.timestampUsec,
  });

  final SipSubscriptionOutboxActionType action;
  final SipSubscriptionType type;
  final String number;
  final String? contactUserId;
  final int sendAttempts;
  final int? timestampUsec;

  SipSubscriptionOutboxAction copyWith({
    SipSubscriptionOutboxActionType? action,
    SipSubscriptionType? type,
    String? number,
    String? contactUserId,
    int? sendAttempts,
    int? timestampUsec,
  }) {
    return SipSubscriptionOutboxAction(
      action: action ?? this.action,
      type: type ?? this.type,
      number: number ?? this.number,
      contactUserId: contactUserId ?? this.contactUserId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
      timestampUsec: timestampUsec ?? this.timestampUsec,
    );
  }

  @override
  List<Object?> get props => [action, type, number, contactUserId, sendAttempts, timestampUsec];
}
