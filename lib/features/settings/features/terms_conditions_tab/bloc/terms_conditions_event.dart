part of 'terms_conditions_bloc.dart';

abstract class TermsConditionsTabEvent extends Equatable {
  const TermsConditionsTabEvent();
}

class TermsConditionsTabStarted extends TermsConditionsTabEvent {
  const TermsConditionsTabStarted();

  @override
  List<Object?> get props => [];
}
