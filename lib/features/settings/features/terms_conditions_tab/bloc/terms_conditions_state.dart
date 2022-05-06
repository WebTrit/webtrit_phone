part of 'terms_conditions_bloc.dart';

class TermsConditionsTabState extends Equatable {
  const TermsConditionsTabState({this.info});

  final AccountInfo? info;

  @override
  List<Object?> get props => [
        info,
      ];
}
