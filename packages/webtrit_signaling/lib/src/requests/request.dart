import 'package:equatable/equatable.dart';

abstract class Request extends Equatable {
  const Request();

  Map<String, dynamic> toJson();
}
