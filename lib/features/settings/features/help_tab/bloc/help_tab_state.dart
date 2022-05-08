part of 'help_tab_bloc.dart';

class HelpTabState extends Equatable {
  const HelpTabState({this.info});

  final AccountInfo? info;

  @override
  List<Object?> get props => [
        info,
      ];
}
