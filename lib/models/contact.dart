import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'contact_source_type.dart';

typedef ContactId = int;

class Contact extends Equatable {
  const Contact({
    required this.id,
    required this.sourceType,
    required this.sourceId,
    this.displayName,
    this.firstName,
    this.lastName,
    this.thumbnail,
  });

  final ContactId id;
  final ContactSourceType sourceType;
  final String sourceId;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final Uint8List? thumbnail;

  String get name {
    final displayName = this.displayName;
    if (displayName != null) {
      return displayName;
    } else {
      final names = [firstName, lastName].where((name) => name != null);
      return names.join(' ').trim();
    }
  }

  @override
  List<Object?> get props => [
        id,
        sourceType,
        sourceId,
        displayName,
        firstName,
        lastName,
        thumbnail,
      ];
}
