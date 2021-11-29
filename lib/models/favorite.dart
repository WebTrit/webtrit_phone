import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  const Favorite({
    required this.id,
    required this.number,
    required this.label,
    this.displayName,
    this.firstName,
    this.lastName,
    this.thumbnail,
  });

  final int id;
  final String number;
  final String label;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final Uint8List? thumbnail;

  String get name {
    final displayName = this.displayName;
    if (displayName != null) {
      return displayName;
    } else {
      final names = [firstName, lastName].where((name) => name != null);
      if (names.isNotEmpty) {
        return names.join(' ');
      } else {
        return number;
      }
    }
  }

  @override
  List<Object?> get props => [
        id,
        number,
        label,
        displayName,
        firstName,
        lastName,
        thumbnail,
      ];
}
