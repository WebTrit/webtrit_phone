import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'contact_source_type.dart';

class Contact extends Equatable {
  const Contact({
    this.id,
    required this.sourceType,
    required this.sourceId,
    this.displayName,
    this.firstName,
    this.lastName,
    this.thumbnail,
  });

  final int? id;
  final ContactSourceType sourceType;
  final String sourceId;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final Uint8List? thumbnail;

  String get name => displayName ?? '$firstName $lastName'.trim();

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
