import 'package:equatable/equatable.dart';

class GorushInfo with EquatableMixin {
  GorushInfo({
    this.version,
  });

  final String? version;

  @override
  List<Object?> get props => [version];

  @override
  bool get stringify => true;
}
