import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/models/contact_email.dart';
import 'package:webtrit_phone/models/contact_phone.dart';
import 'package:webtrit_phone/models/presence/presence_info.dart';

import 'contact_source_type.dart';

typedef ContactId = int;

const contactIdPathParameterName = 'contactId';

class Contact extends Equatable {
  Contact({
    required this.id,
    required this.sourceType,
    this.sourceId,
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
    this.presenceInfo = const [],
  });

  final ContactId id;
  final ContactSourceType sourceType;
  final String? sourceId;

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
  final List<PresenceInfo> presenceInfo;

  /// Computed getter for contact's PBX network `extension`.
  late final String? extension = phones.firstWhereOrNull((element) => element.label == 'ext')?.number;

  /// Computed getter for contact's first mobile phone number
  /// also known as the primary phone number or `main` number.
  late final String? mobileNumber = phones.firstWhereOrNull((element) => element.label == 'mobile')?.number;

  /// Computed list for contact's of sms phone numbers
  /// suitable as list of number to wich user can send sms messages.
  ///
  /// If the contact is external, only the `sms` numbers are returned.
  /// Otherwise, all the numbers are returned for phonebook contacts.
  late final List<String> smsNumbers = phones
      .where((phone) => (sourceType == ContactSourceType.local) || phone.label == 'sms')
      .map((phone) => phone.number)
      .toList();

  late final ContactPhone? extensionPhone = phones.firstWhereOrNull((element) => element.label == 'ext');

  late final ContactPhone? mobilePhone = phones.firstWhereOrNull((element) => element.label == 'mobile');

  late final List<ContactPhone> additionalNumbers = phones
      .where((phone) => phone.label == 'additional')
      .toList();

  /// Computed name of the contact in a single string if possible.
  ///
  /// Returns a [String] representing the name of the contact
  /// in the format `"aliasName"` or `"firstName lastName"`
  /// or `null` if no name source is available.
  late final String? maybeName =
      aliasName ?? (firstName != null && lastName != null ? '$firstName $lastName' : firstName ?? lastName);

  /// Computed displaing title for the contact.
  ///
  /// Used for displaying the contact title in the UI, for identifying the contact in any case of data absence.
  ///
  /// The display title is determined by the following order of preference:
  /// - `name` if it is not null
  /// - `extension` if `name` is null and `extension` is not null
  /// - `mobileNumber` if both `name` and `extension` are null
  /// - `sourceId` if none of the above exist
  /// - `id` as a fallback if all fields are absent
  late final String displayTitle = maybeName ?? extension ?? mobileNumber ?? sourceId ?? id.toString();

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
    presenceInfo,
  ];

  @override
  bool get stringify => true;
}
