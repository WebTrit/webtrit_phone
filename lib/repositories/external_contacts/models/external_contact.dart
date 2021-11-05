import 'package:equatable/equatable.dart';

class ExternalContact extends Equatable {
  const ExternalContact({
    required this.id,
    this.displayName,
    this.firstName,
    this.lastName,
    this.number,
    this.ext,
    this.mobile,
  });

  final String id;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final String? number;
  final String? ext;
  final String? mobile;

  @override
  List<Object?> get props => [
        id,
        displayName,
        firstName,
        lastName,
        number,
        ext,
        mobile,
      ];
}
