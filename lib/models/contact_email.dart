import 'package:equatable/equatable.dart';

class ContactEmail extends Equatable {
  const ContactEmail({
    required this.id,
    required this.address,
    required this.label,
  });

  final int id;
  final String address;
  final String label;

  @override
  List<Object?> get props => [
        id,
        address,
        label,
      ];
}
