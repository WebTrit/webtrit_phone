import 'package:equatable/equatable.dart';

class ContactPhone extends Equatable {
  const ContactPhone({
    required this.id,
    required this.rawNumber,
    required this.sanitizedNumber,
    required this.label,
    required this.favorite,
  });

  final int id;
  final String rawNumber;
  final String sanitizedNumber;
  final String label;
  final bool favorite;

  @override
  List<Object?> get props => [id, rawNumber, sanitizedNumber, label, favorite];
}
