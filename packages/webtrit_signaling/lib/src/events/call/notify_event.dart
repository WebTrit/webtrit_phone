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
      case DialogNotifyEvent.notifyValue:
        return DialogNotifyEvent.fromJson(json);
      case ReferNotifyEvent.notifyValue:
        return ReferNotifyEvent.fromJson(json);
      default:
        return UnknownNotifyEvent.fromJson(json);
    }
  }
}

class DialogNotifyEvent extends NotifyEvent with EquatableMixin {
  const DialogNotifyEvent({
    super.transaction,
    required super.line,
    required super.callId,
    super.notify,
    super.subscriptionState,
    required this.userActiveCalls,
  });

  static const notifyValue = 'dialog';
  final List<UserActiveCall> userActiveCalls;

  @override
  factory DialogNotifyEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != NotifyEvent.typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal ${NotifyEvent.typeValue}');
    }

    final notifyValue = json['notify'];
    if (notifyValue != DialogNotifyEvent.notifyValue) {
      throw ArgumentError.value(notifyValue, 'notify', 'Not equal ${DialogNotifyEvent.notifyValue}');
    }

    return DialogNotifyEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      notify: json['notify'],
      subscriptionState:
          json['subscription_state'] != null ? SubscriptionState.values.byName(json['subscription_state']) : null,
      userActiveCalls:
          (json['user_active_calls'] as List).map((e) => UserActiveCall.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => [transaction, line, callId, notify, subscriptionState, userActiveCalls];

  @override
  String toString() {
    return 'DialogNotifyEvent{transaction: $transaction, line: $line, callId: $callId, notify: $notify, '
        'subscriptionState: $subscriptionState, userActiveCalls: ${userActiveCalls.length}}';
  }
}

enum UserActiveCallDirection { initiator, recipient }

enum UserActiveCallState { proceeding, early, confirmed, terminated, unknown }

class UserActiveCall extends Equatable {
  UserActiveCall({
    required this.id,
    required this.state,
    required this.callId,
    required this.direction,
    required this.localTag,
    required this.remoteTag,
    required this.remoteNumber,
    this.remoteDisplayName,
  });

  final String id;
  final UserActiveCallState state;
  final String callId;
  final UserActiveCallDirection direction;
  final String localTag;
  final String? remoteTag;
  final String remoteNumber;
  final String? remoteDisplayName;

  factory UserActiveCall.fromJson(Map<String, dynamic> json) {
    return UserActiveCall(
      id: json['id'],
      state: UserActiveCallState.values.firstWhere(
        (e) => e.name == json['state'],
        orElse: () => UserActiveCallState.unknown,
      ),
      callId: json['call_id'],
      direction: UserActiveCallDirection.values.byName(json['direction']),
      localTag: json['local_tag'],
      remoteTag: json['remote_tag'],
      remoteNumber: json['remote_number'],
      remoteDisplayName: json['remote_display_name'],
    );
  }

  @override
  List<Object?> get props => [id, state, callId, direction, localTag, remoteTag, remoteNumber, remoteDisplayName];

  @override
  String toString() {
    return 'UserActiveCall{id: $id, state: $state, callId: $callId, direction: $direction, localTag: $localTag, remoteTag: $remoteTag, remoteNumber: $remoteNumber, remoteDisplayName: $remoteDisplayName}';
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
      subscriptionState:
          json['subscription_state'] != null ? SubscriptionState.values.byName(json['subscription_state']) : null,
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

  final String content;
  final String? contentType;

  @override
  factory UnknownNotifyEvent.fromJson(Map<String, dynamic> json) {
    return UnknownNotifyEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      notify: json['notify'],
      subscriptionState:
          json['subscription_state'] != null ? SubscriptionState.values.byName(json['subscription_state']) : null,
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
