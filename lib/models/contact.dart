import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/models/contact_email.dart';
import 'package:webtrit_phone/models/contact_phone.dart';

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
    this.thumbnailUrl,
    this.phones = const [],
    this.emails = const [],
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
  final Uri? thumbnailUrl;

  final List<ContactPhone> phones;
  final List<ContactEmail> emails;
  String? get name {
    final aliasName = this.aliasName;
    if (aliasName != null) {
      return aliasName;
    } else if (firstName != null && lastName != null) {
      return [firstName, lastName].readableJoin();
    } else {
      return firstName ?? lastName;
    }
  }

  String? get extension {
    return phones.firstWhereOrNull((element) => element.label == 'ext')?.number;
  }

  String? get mobileNumber {
    return phones.firstWhereOrNull((element) => element.label == 'mobile')?.number;
  }

  List<String> get smsNumbers {
    if (sourceType == ContactSourceType.external) {
      return phones.where((phone) => phone.label == 'sms').map((phone) => phone.number).toList();
    } else {
      return phones.map((phone) => phone.number).toList();
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
        thumbnailUrl,
        phones,
        emails,
      ];

  @override
  bool get stringify => true;
}
