import 'package:equatable/equatable.dart';

String listPropToString(List prop) => '${prop.length}';

class EquatablePropToString<T> extends Equatable {
  const EquatablePropToString(this.prop, this.propToString);

  final T prop;
  final String Function(T prop) propToString;

  @override
  List<Object?> get props => [
        prop,
      ];

  @override
  String toString() => propToString(prop);
}
