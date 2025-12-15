import 'package:equatable/equatable.dart';

class ContactPhone extends Equatable {
  const ContactPhone({
    required this.id,
    required this.rawNumber,
    required this.sanitizedNimber,
    required this.label,
    required this.favorite,
  });

  final int id;
  final String rawNumber;
  final String sanitizedNimber;
  final String label;
  final bool favorite;

  @override
  List<Object?> get props => [id, rawNumber, sanitizedNimber, label, favorite];
}
