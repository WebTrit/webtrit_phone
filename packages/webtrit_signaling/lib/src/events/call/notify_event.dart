import '../abstract_events.dart';
import 'subscription_state.dart';

class NotifyEvent extends CallEvent {
  const NotifyEvent({
    super.transaction,
    required super.line,
    required super.callId,
    this.notify,
    this.subscriptionState,
    this.contentType,
    required this.content,
  });

  final String? notify;
  final SubscriptionState? subscriptionState;
  final String? contentType;
  final String content;

  @override
  List<Object?> get props => [
        ...super.props,
        notify,
        subscriptionState,
        contentType,
        content,
      ];

  static const typeValue = 'notify';

  factory NotifyEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    SubscriptionState? subscriptionState;
    final subscriptionStateValue = json['subscription_state'];
    if (subscriptionStateValue != null) {
      subscriptionState = SubscriptionState.values.byName(subscriptionStateValue);
    }

    return NotifyEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      notify: json['notify'],
      subscriptionState: subscriptionState,
      contentType: json['content_type'],
      content: json['content'],
    );
  }
}
