import 'package:flutter/material.dart';

/// The two text button looks the confirm dialog is built from.
///
/// Not a `ThemeExtension` any more, and it was one for no reason: it was put
/// on the theme twice, by two instances of this type - so the second replaced
/// the first, `ThemeData.extensions` being keyed by type - and read from the
/// theme never. What reads it is the confirm dialog factory, which is handed
/// the object. `copyWith` and `lerp` went with the inheritance; they existed
/// to satisfy it, and nothing called them.
///
/// It carried five more members - `callStart`, `callHangup`, `callTransfer`,
/// `callAction` and `callActiveAction` - from before the call screen had
/// styles of its own.
class TextButtonStyles {
  const TextButtonStyles({required this.neutral, required this.dangerous});

  final ButtonStyle? neutral;
  final ButtonStyle? dangerous;
}
