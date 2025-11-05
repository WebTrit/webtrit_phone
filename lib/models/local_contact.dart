import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/models/local_contact_email.dart';

import 'package:webtrit_phone/utils/utils.dart';

import 'local_contact_phone.dart';

class LocalContact extends Equatable {
  const LocalContact({
    required this.id,
    this.displayName,
    this.firstName,
    this.lastName,
    this.thumbnail,
    this.phones = const [],
    this.emails = const [],
  });

  final String id;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final Uint8List? thumbnail;
  final List<LocalContactPhone> phones;
  final List<LocalContactEmail> emails;

  @override
  List<Object?> get props => [
    id,
    displayName,
    firstName,
    lastName,
    EquatablePropToString(thumbnail, (p) => p != null ? 'present' : 'absent'),
    phones,
    emails,
  ];
}
