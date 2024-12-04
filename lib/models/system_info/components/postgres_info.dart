import 'package:equatable/equatable.dart';

class PostgresInfo with EquatableMixin {
  PostgresInfo({
    this.version,
  });

  final String? version;

  @override
  List<Object?> get props => [version];

  @override
  bool get stringify => true;
}
