import 'package:equatable/equatable.dart';

import '../abstract_events.dart';
import 'subscription_state.dart';

sealed class NotifyEvent extends CallEvent {
  const NotifyEvent({
    super.transaction,
    required super.line,
    required super.callId,
    this.notify,
    this.subscriptionState,
  });

  static const typeValue = 'notify';
  final String? notify;
  final SubscriptionState? subscriptionState;

  factory NotifyEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    final notifyValue = json['notify'];
    switch (notifyValue) {
      case ReferNotifyEvent.notifyValue:
        return ReferNotifyEvent.fromJson(json);
      default:
        return UnknownNotifyEvent.fromJson(json);
    }
  }
}

enum ReferNotifyState { trying, ok, unknown }

class ReferNotifyEvent extends NotifyEvent with EquatableMixin {
  const ReferNotifyEvent({
    super.transaction,
    required super.line,
    required super.callId,
    super.notify,
    super.subscriptionState,
    required this.state,
  });

  static const notifyValue = 'refer';
  final ReferNotifyState state;

  @override
  factory ReferNotifyEvent.fromJson(Map<String, dynamic> json) {
    final contentStr = json['content'] as String;
    final state = switch (contentStr) {
      String s when s.startsWith('SIP/2.0 100') => ReferNotifyState.trying,
      String s when s.contains('200 OK') => ReferNotifyState.ok,
      _ => ReferNotifyState.unknown,
    };

    return ReferNotifyEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      notify: json['notify'],
      subscriptionState: json['subscription_state'] != null
          ? SubscriptionState.values.byName(json['subscription_state'])
          : null,
      state: state,
    );
  }

  @override
  List<Object?> get props => [transaction, line, callId, notify, subscriptionState, state];

  @override
  String toString() {
    return 'ReferNotifyEvent{transaction: $transaction, line: $line, callId: $callId, notify: $notify, '
        'subscriptionState: $subscriptionState, state: $state}';
  }
}

class UnknownNotifyEvent extends NotifyEvent with EquatableMixin {
  const UnknownNotifyEvent({
    super.transaction,
    required super.line,
    required super.callId,
    super.notify,
    super.subscriptionState,
    required this.content,
    this.contentType,
  });

  final String? content;
  final String? contentType;

  @override
  factory UnknownNotifyEvent.fromJson(Map<String, dynamic> json) {
    return UnknownNotifyEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      notify: json['notify'],
      subscriptionState: json['subscription_state'] != null
          ? SubscriptionState.values.byName(json['subscription_state'])
          : null,
      content: json['content'],
      contentType: json['content_type'],
    );
  }

  @override
  List<Object?> get props => [transaction, line, callId, notify, subscriptionState, content, contentType];

  @override
  String toString() {
    return 'UnknownNotifyEvent{transaction: $transaction, line: $line, callId: $callId, notify: $notify, '
        'subscriptionState: $subscriptionState, contentType: $contentType, content: $content}';
  }
}
