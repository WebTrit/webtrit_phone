import 'package:equatable/equatable.dart';

class ExternalContact extends Equatable {
  final String username;

  ExternalContact(this.username);

  @override
  List<Object> get props => [
        username,
      ];
}
