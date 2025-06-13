import 'package:equatable/equatable.dart';

class CallerIdSettings extends Equatable {
  const CallerIdSettings({
    this.defaultNumber,
    this.matchers = const [],
  });

  final String? defaultNumber;
  final List<NumberMatcher> matchers;

  @override
  List<Object?> get props => [defaultNumber, matchers];

  @override
  String toString() {
    return 'CallerIdSettings(defaultNumber: $defaultNumber, matchers: $matchers)';
  }

  CallerIdSettings copyWithDefaultNumber(String? defaultNumber) {
    return CallerIdSettings(defaultNumber: defaultNumber, matchers: matchers);
  }

  CallerIdSettings copyWithMatchers(List<NumberMatcher> matchers) {
    return CallerIdSettings(defaultNumber: defaultNumber, matchers: matchers);
  }
}

sealed class NumberMatcher {
  bool match(String destinationNumber);
  String get number;
  int get matchIndex;
}

final class PrefixMatcher extends NumberMatcher with EquatableMixin {
  PrefixMatcher(this.prefix, this.number);
  final String prefix;

  @override
  final String number;

  @override
  bool match(String destinationNumber) => destinationNumber.startsWith(prefix);

  @override
  int get matchIndex => prefix.length;

  @override
  String toString() => 'PrefixMatcher(prefix: $prefix, number: $number)';

  @override
  List<Object?> get props => [prefix, number];

  PrefixMatcher copyWith({String? prefix, String? number}) {
    return PrefixMatcher(prefix ?? this.prefix, number ?? this.number);
  }
}
