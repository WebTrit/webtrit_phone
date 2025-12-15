import 'package:equatable/equatable.dart';

class LocalContactPhone extends Equatable {
  const LocalContactPhone({required this.rawNumber, required this.sanitizedNumber, required this.label});

  final String rawNumber;
  final String sanitizedNumber;
  final String label;

  @override
  List<Object?> get props => [rawNumber, sanitizedNumber, label];
}
