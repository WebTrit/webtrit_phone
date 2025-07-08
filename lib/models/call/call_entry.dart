import 'package:webtrit_phone/models/call_log_entry.dart';

abstract class CallEntry {
  String get callId;

  int? get line;

  CallDirection get direction;

  DateTime? get acceptedTime;

  DateTime? get hungUpTime;

  bool get isIncoming => direction == CallDirection.incoming;

  bool get isOutgoing => direction == CallDirection.outgoing;

  bool get wasAccepted => acceptedTime != null;

  bool get wasHungUp => hungUpTime != null;
}
