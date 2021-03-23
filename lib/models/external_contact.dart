import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class ExternalContact extends Equatable {
  final String username;

  ExternalContact(this.username);

  @override
  List<Object> get props => [
        username,
      ];
}
