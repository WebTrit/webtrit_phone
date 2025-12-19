import 'package:equatable/equatable.dart';

class ContactPhone extends Equatable {
  const ContactPhone({
    required this.id,
    required this.number,
    required this.label,
    required this.favorite,
  });

  final int id;
  final String number;
  final String label;
  final bool favorite;

  @override
  List<Object?> get props => [id, number, label, favorite];
}
