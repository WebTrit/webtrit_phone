import 'package:equatable/equatable.dart';

import 'contact.dart';

typedef FavoriteId = int;

class Favorite extends Equatable {
  const Favorite({
    required this.id,
    required this.number,
    required this.label,
    required this.contact,
  });

  final FavoriteId id;
  final String number;
  final String label;
  final Contact contact;

  String get name => contact.maybeName ?? number;

  @override
  List<Object?> get props => [id, number, label, contact];
}
