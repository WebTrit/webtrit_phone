import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppRegistered extends AppEvent {
  const AppRegistered();
}

class AppUnregistered extends AppEvent {
  const AppUnregistered();
}
