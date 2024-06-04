import 'package:equatable/equatable.dart';

class ExternalContact extends Equatable {
  const ExternalContact({
    required this.id,
    this.registered,
    this.firstName,
    this.lastName,
    this.aliasName,
    this.number,
    this.ext,
    this.mobile,
    this.email,
  });

  final String id;
  final bool? registered;
  final String? firstName;
  final String? lastName;
  final String? aliasName;
  final String? number;
  final String? ext;
  final String? mobile;
  final String? email;

  @override
  List<Object?> get props => [
        id,
        registered,
        firstName,
        lastName,
        aliasName,
        number,
        ext,
        mobile,
        email,
      ];
}
