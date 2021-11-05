import 'package:equatable/equatable.dart';

class ContactPhone extends Equatable {
  const ContactPhone({
    required this.number,
    required this.label,
  });

  final String number;
  final String label;

  @override
  List<Object?> get props => [
    number,
    label,
  ];
}
