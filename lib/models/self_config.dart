// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SelfConfig with EquatableMixin {
  SelfConfig({
    required this.url,
    required this.expiresAt,
  });

  final Uri url;
  final DateTime expiresAt;

  @override
  List<Object> get props => [url, expiresAt];

  @override
  bool get stringify => true;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
