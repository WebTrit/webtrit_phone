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
    smsNumbers,
    email,
  ];
}
