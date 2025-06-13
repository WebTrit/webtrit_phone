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

  CallerIdSettings copyWith({String? defaultNumber, List<NumberMatcher>? matchers}) {
    return CallerIdSettings(defaultNumber: defaultNumber ?? this.defaultNumber, matchers: matchers ?? this.matchers);
  }
}

sealed class NumberMatcher {
  String? match(String destinationNumber);
}

final class PrefixMatcher extends NumberMatcher with EquatableMixin {
  PrefixMatcher(this.prefix, this.number);
  final String prefix;
  final String number;

  @override
  String? match(String destinationNumber) {
    if (destinationNumber.startsWith(prefix)) {
      return destinationNumber.substring(prefix.length);
    }
    return null;
  }

  @override
  String toString() => 'PrefixMatcher(prefix: $prefix, number: $number)';

  @override
  List<Object?> get props => [prefix, number];

  PrefixMatcher copyWith({String? prefix, String? number}) {
    return PrefixMatcher(prefix ?? this.prefix, number ?? this.number);
  }
}
