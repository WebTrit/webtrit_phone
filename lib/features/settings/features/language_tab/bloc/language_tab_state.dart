part of 'language_tab_bloc.dart';

class LanguageTabState extends Equatable {
  const LanguageTabState({this.info});

  final AccountInfo? info;

  @override
  List<Object?> get props => [
        info,
      ];
}
