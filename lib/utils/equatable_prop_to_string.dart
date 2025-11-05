import 'package:equatable/equatable.dart';

String _listPropToString(List prop) => 'List(length: ${prop.length})';

/// A wrapper that customizes the `toString` output of an [Equatable] property
/// without affecting equality.
///
/// This is useful when you have large properties (e.g. lists of contacts)
/// that produce verbose `toString` output in logs. By wrapping them with
/// [EquatablePropToString], you can keep equality based on the original value
/// while displaying a compact representation.
class EquatablePropToString<T> extends Equatable {
  /// Creates a new [EquatablePropToString] wrapper.
  ///
  /// The [propToString] function is used only for `toString` representation.
  /// Equality is still determined by the wrapped [prop] itself.
  const EquatablePropToString(this.prop, this.propToString);

  /// Creates a wrapper for list properties.
  ///
  /// The list will be represented as `List(length: N)` in the `toString` output.
  static EquatablePropToString<List<E>> list<E>(List<E> prop) {
    return EquatablePropToString<List<E>>(prop, _listPropToString);
  }

  /// The wrapped property value.
  final T prop;

  /// A function that defines how [prop] is converted to string.
  final String Function(T prop) propToString;

  @override
  List<Object?> get props => [prop];

  @override
  String toString() => propToString(prop);
}
