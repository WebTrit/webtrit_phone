import 'dart:math';

/// An interface for adding jitter to a [Duration].
abstract class Jitter {
  /// Returns a new [Duration] with jitter added to the [base] duration.
  Duration add(Duration base);
}

/// Adds a random jitter to a [Duration].
///
/// The jitter is a random value between 0 and [maxMs] milliseconds.
class RandomJitter implements Jitter {
  /// Creates a [RandomJitter] with an optional [maxMs] (default is 400).
  RandomJitter({this.maxMs = 400}) : _rand = Random();

  /// The maximum jitter in milliseconds.
  final int maxMs;

  /// The random number generator.
  final Random _rand;

  /// Returns [base] plus a random jitter up to [maxMs] milliseconds.
  @override
  Duration add(Duration base) => maxMs <= 0 ? base : base + Duration(milliseconds: _rand.nextInt(maxMs));
}

/// Does not add any jitter to a [Duration].
class NoJitter implements Jitter {
  /// Returns the [base] duration unchanged.
  @override
  Duration add(Duration base) => base;
}
