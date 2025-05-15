import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/models.dart';

class Recent extends Equatable {
  final CallLogEntry callLogEntry;
  final Contact? contact;

  const Recent({required this.callLogEntry, required this.contact});

  String get name => contact?.maybeName ?? callLogEntry.username ?? callLogEntry.number;

  @override
  String toString() {
    return 'Recent{callLogEntry: $callLogEntry, contact: $contact}';
  }

  @override
  List<Object?> get props => [callLogEntry, contact];
}
