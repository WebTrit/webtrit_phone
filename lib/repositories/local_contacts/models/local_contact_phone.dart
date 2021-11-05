import 'package:equatable/equatable.dart';

class LocalContactPhone extends Equatable {
  const LocalContactPhone({
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
