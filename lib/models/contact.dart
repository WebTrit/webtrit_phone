import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/extensions/iterable.dart';

import 'contact_source_type.dart';

typedef ContactId = int;

const contactIdPathParameterName = 'contactId';

class Contact extends Equatable {
  const Contact({
    required this.id,
    required this.sourceType,
    required this.sourceId,
    this.firstName,
    this.lastName,
    this.aliasName,
    this.thumbnail,
  });

  final ContactId id;
  final ContactSourceType sourceType;
  final String sourceId;
  final String? firstName;
  final String? lastName;
  final String? aliasName;
  final Uint8List? thumbnail;

  String get name {
    final aliasName = this.aliasName;
    if (aliasName != null) {
      return aliasName;
    } else {
      return [firstName, lastName].readableJoin();
    }
  }

  @override
  List<Object?> get props => [
        id,
        sourceType,
        sourceId,
        firstName,
        lastName,
        aliasName,
        thumbnail,
      ];
}
