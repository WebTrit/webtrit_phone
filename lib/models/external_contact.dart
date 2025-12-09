import 'package:equatable/equatable.dart';

class ExternalContact extends Equatable {
  const ExternalContact({
    this.id,
    this.registered,
    this.userRegistered,
    this.isCurrentUser,
    this.firstName,
    this.lastName,
    this.aliasName,
    this.number,
    this.ext,
    this.mobile,
    this.additional,
    this.smsNumbers,
    this.email,
  });

  final String? id;

  /// SIP Registered status
  final bool? registered;

  /// User account registered status
  final bool? userRegistered;

  /// Is currently loggined user
  final bool? isCurrentUser;

  final String? firstName;
  final String? lastName;
  final String? aliasName;
  final String? number;
  final String? ext;
  final String? mobile;
  final List<String>? additional;
  final List<String>? smsNumbers;
  final String? email;

  @override
  List<Object?> get props => [
    id,
    registered,
    userRegistered,
    isCurrentUser,
    firstName,
    lastName,
    aliasName,
    number,
    ext,
    mobile,
    additional,
    smsNumbers,
    email,
  ];
}

/// Extension to provide a stable sourceId for ExternalContact
extension ExternalContactExtensions on ExternalContact {
  /// Returns a stable, non-null sourceId for synchronization and deduplication purposes.
  /// Priority:
  ///   1. `id` (API-provided unique identifier)
  ///   2. `number`, `mobile`, `email`
  ///   3. deterministic hash of name/email
  ///   4. fallback hash for anonymous or incomplete contacts (e.g. empty fields)
  String get safeSourceId {
    if (id?.trim().isNotEmpty ?? false) {
      return id!;
    }

    if (number?.trim().isNotEmpty ?? false) {
      return 'number_${number!.trim()}';
    }

    if (mobile?.trim().isNotEmpty ?? false) {
      return 'mobile_${mobile!.trim()}';
    }

    if (email?.trim().isNotEmpty ?? false) {
      return 'email_${email!.trim()}';
    }

    // Generate a deterministic fallback sourceId based on contact's name and email.
    // Ensures stable identity across syncs when no ID, number, mobile, or email is available.
    // May still produce collisions if fields are empty or identical across multiple contacts.
    final stableKey = '${firstName ?? ''}_${lastName ?? ''}_${email ?? ''}'.toLowerCase().trim();
    final hash = stableKey.hashCode;

    return 'hash_$hash';
  }
}
