import 'package:equatable/equatable.dart';

class SipVersion with EquatableMixin {
  SipVersion({this.version});

  final String? version;

  @override
  List<Object?> get props => [version];

  @override
  bool get stringify => true;
}
