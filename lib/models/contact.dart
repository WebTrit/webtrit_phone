import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class Contact extends Equatable {
  final String username;

  Contact(this.username);

  @override
  List<Object> get props => [
        username,
      ];
}
