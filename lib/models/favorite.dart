import 'package:equatable/equatable.dart';

import 'contact.dart';

typedef FavoriteId = int;

class Favorite extends Equatable {
  const Favorite({
    required this.id,
    required this.rawNumber,
    required this.sanitizedNumber,
    required this.label,
    required this.contact,
  });

  final FavoriteId id;
  final String rawNumber;
  final String sanitizedNumber;
  final String label;
  final Contact contact;

  String get name => contact.maybeName ?? rawNumber;

  @override
  List<Object?> get props => [id, rawNumber, sanitizedNumber, label, contact];
}
