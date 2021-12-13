part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState({this.info});

  final AccountInfo? info;

  @override
  List<Object?> get props => [
        info,
      ];
}
