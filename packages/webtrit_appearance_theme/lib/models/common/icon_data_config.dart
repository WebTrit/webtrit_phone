import 'package:freezed_annotation/freezed_annotation.dart';

part 'icon_data_config.freezed.dart';

part 'icon_data_config.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class IconDataConfig with _$IconDataConfig {
  /// Exact IconData representation.
  const IconDataConfig({
    /// The code point in hex, as the JSON carries it - e.g. `e491`, with or
    /// without an `0x` in front.
    required this.codePoint,

    /// e.g. "MaterialIcons"
    this.fontFamily = 'MaterialIcons',

    /// Mirrors IconData.matchTextDirection
    this.matchTextDirection = false,
  });

  // Held as it arrives rather than parsed on the way in.
  //
  // It used to be an `int` behind a `JsonConverter<int, String>`, and the
  // generated schema described the field rather than the JSON: it said
  // `integer` where the document carries a string, so every real icon failed
  // validation against the contract this package publishes. A field whose type
  // is the type on the wire needs no converter and cannot say the wrong thing.
  //
  // Not a doc comment: the generator copies those into the schema, and the
  // reasoning for a shape belongs beside the code and not in what is published.
  /// The code point in hex, e.g. `e491`.
  @override
  final String codePoint;

  /// The code point as `IconData` wants it.
  ///
  /// The parse moved here from the converter, so it happens where the number
  /// is used instead of on the way in. `0x` is tolerated because a stored
  /// theme may carry it: the converter accepted both spellings and the ones
  /// written before this cannot be asked to choose.
  int get codePointValue => int.parse(codePoint.replaceFirst(RegExp('^0[xX]'), ''), radix: 16);

  @override
  final String fontFamily;

  @override
  final bool matchTextDirection;

  factory IconDataConfig.fromJson(Map<String, dynamic> json) => _$IconDataConfigFromJson(json);

  Map<String, dynamic> toJson() => _$IconDataConfigToJson(this);
}
