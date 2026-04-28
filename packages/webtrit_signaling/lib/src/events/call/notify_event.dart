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

  @override
  Map<String, dynamic> toJson();

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

// ---------------------------------------------------------------------------
// ReferNotifyState — sealed class preserving the SIP response code
// ---------------------------------------------------------------------------

sealed class ReferNotifyState {
  const ReferNotifyState();

  factory ReferNotifyState.fromContent(String content) {
    final match = RegExp(r'SIP/2\.0\s+(\d{3})\s*(.*)').firstMatch(content.trim());
    if (match == null) return const ReferFailed(sipCode: null, reason: null);

    final code = int.parse(match.group(1)!);
    final reason = match.group(2)!.trim();

    return switch (code) {
      >= 100 && < 200 => ReferProvisional(sipCode: code, reason: reason),
      >= 200 && < 300 => const ReferAccepted(),
      _ => ReferFailed(sipCode: code, reason: reason),
    };
  }
}

/// Transfer is in progress — target is ringing (1xx provisional).
final class ReferProvisional extends ReferNotifyState {
  const ReferProvisional({required this.sipCode, required this.reason});

  final int sipCode;
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ReferProvisional && sipCode == other.sipCode && reason == other.reason;

  @override
  int get hashCode => Object.hash(sipCode, reason);

  @override
  String toString() => 'ReferProvisional($sipCode $reason)';
}

/// Transfer succeeded — target accepted (2xx).
final class ReferAccepted extends ReferNotifyState {
  const ReferAccepted();

  @override
  bool operator ==(Object other) => other is ReferAccepted;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'ReferAccepted()';
}

/// Transfer failed — target rejected (3xx–6xx) or content was malformed.
/// [sipCode] is null only when the NOTIFY body could not be parsed.
final class ReferFailed extends ReferNotifyState {
  const ReferFailed({required this.sipCode, required this.reason});

  final int? sipCode;
  final String? reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ReferFailed && sipCode == other.sipCode && reason == other.reason;

  @override
  int get hashCode => Object.hash(sipCode, reason);

  @override
  String toString() => sipCode != null ? 'ReferFailed($sipCode $reason)' : 'ReferFailed(malformed)';
}

// ---------------------------------------------------------------------------
// ReferNotifyEvent
// ---------------------------------------------------------------------------

class ReferNotifyEvent extends NotifyEvent with EquatableMixin {
  const ReferNotifyEvent({
    super.transaction,
    required super.line,
    required super.callId,
    super.subscriptionState,
    required this.state,
  });

  static const notifyValue = 'refer';
  final ReferNotifyState state;

  @override
  Map<String, dynamic> toJson() => {
    ...callBaseJson(NotifyEvent.typeValue),
    'notify': notifyValue,
    if (subscriptionState != null) 'subscription_state': subscriptionState!.name,
    'content': switch (state) {
      ReferProvisional(:final sipCode, :final reason) => 'SIP/2.0 $sipCode $reason',
      ReferAccepted() => 'SIP/2.0 200 OK',
      ReferFailed(:final sipCode?, :final reason?) => 'SIP/2.0 $sipCode $reason',
      ReferFailed() => '',
    },
  };

  @override
  factory ReferNotifyEvent.fromJson(Map<String, dynamic> json) {
    final contentStr = json['content'] as String;

    return ReferNotifyEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      subscriptionState: json['subscription_state'] != null
          ? SubscriptionState.values.byName(json['subscription_state'])
          : null,
      state: ReferNotifyState.fromContent(contentStr),
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

// ---------------------------------------------------------------------------
// UnknownNotifyEvent
// ---------------------------------------------------------------------------

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
  Map<String, dynamic> toJson() => {
    ...callBaseJson(NotifyEvent.typeValue),
    if (notify != null) 'notify': notify,
    if (subscriptionState != null) 'subscription_state': subscriptionState!.name,
    if (content != null) 'content': content,
    if (contentType != null) 'content_type': contentType,
  };

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
