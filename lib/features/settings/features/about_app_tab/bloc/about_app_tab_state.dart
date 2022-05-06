part of 'about_app_tab_bloc.dart';

class AboutAppTabState extends Equatable {
  const AboutAppTabState({this.info});

  final AccountInfo? info;

  @override
  List<Object?> get props => [
        info,
      ];
}
