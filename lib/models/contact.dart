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
    this.registered,
    this.userRegistered,
    this.isCurrentUser,
    this.firstName,
    this.lastName,
    this.aliasName,
    this.thumbnail,
  });

  final ContactId id;
  final ContactSourceType sourceType;
  final String sourceId;

  /// SIP Registered status
  final bool? registered;

  /// User account registered status
  final bool? userRegistered;

  /// Is currently loggined user
  final bool? isCurrentUser;

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
        registered,
        userRegistered,
        isCurrentUser,
        firstName,
        lastName,
        aliasName,
        thumbnail,
      ];
}
