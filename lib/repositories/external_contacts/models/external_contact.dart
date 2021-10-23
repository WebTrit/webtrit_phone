import 'package:equatable/equatable.dart';

class ExternalContact extends Equatable {
  const ExternalContact({
    required this.displayName,
    required this.number,
  });

  final String displayName;
  final String number;

  @override
  List<Object> get props => [
        displayName,
        number,
      ];
}
