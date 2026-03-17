import 'package:equatable/equatable.dart';

enum SipSubscriptionType { blf, presence }

class SipSubscription extends Equatable {
  const SipSubscription({
    required this.type,
    required this.number,
    required this.contactUserId,
    required this.subscribedAt,
  });

  final SipSubscriptionType type;
  final String number;
  final String contactUserId;
  final DateTime subscribedAt;

  @override
  List<Object?> get props => [type, number, contactUserId, subscribedAt];

  @override
  String toString() {
    return 'SipSubscription(type: $type, number: $number, contactUserId: $contactUserId, subscribedAt: $subscribedAt)';
  }
}
