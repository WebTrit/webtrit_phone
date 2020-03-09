import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppUnregister extends AppState {
  const AppUnregister();
}

class AppRegister extends AppState {
  const AppRegister();
}
