import 'package:equatable/equatable.dart';

class LocalContactEmail extends Equatable {
  const LocalContactEmail({
    required this.address,
    required this.label,
  });

  final String address;
  final String label;

  @override
  List<Object?> get props => [
        address,
        label,
      ];
}
