import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'models.dart';

class LocalContact extends Equatable {
  const LocalContact({
    required this.id,
    this.displayName,
    this.firstName,
    this.lastName,
    this.thumbnail,
    this.phones = const [],
  });

  final String id;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final Uint8List? thumbnail;
  final List<LocalContactPhone> phones;

  @override
  List<Object?> get props => [
        id,
        displayName,
        firstName,
        lastName,
        thumbnail,
        phones,
      ];
}
