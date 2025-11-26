import 'package:flutter/foundation.dart';

class InputMaskStyle with Diagnosticable {
  const InputMaskStyle({this.pattern, this.filter});

  final String? pattern;
  final Map<String, String>? filter;

  InputMaskStyle copyWith({String? pattern, Map<String, String>? filter}) {
    return InputMaskStyle(pattern: pattern ?? this.pattern, filter: filter ?? this.filter);
  }

  static InputMaskStyle lerp(InputMaskStyle? a, InputMaskStyle? b, double t) {
    if (identical(a, b)) return a ?? const InputMaskStyle();
    return t < 0.5 ? (a ?? const InputMaskStyle()) : (b ?? const InputMaskStyle());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('pattern', pattern));
    properties.add(DiagnosticsProperty<Map<String, String>?>('filter', filter));
  }
}
