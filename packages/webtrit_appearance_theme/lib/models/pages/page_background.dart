import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/common.dart';

part 'page_background.freezed.dart';

part 'page_background.g.dart';

/// What is painted behind a page: one colour, a gradient, or an image.
///
/// Written as a sealed base with three ordinary classes rather than as a freezed
/// union, because a freezed union's variants are classes freezed writes, and the
/// schema generator reads fields off source classes - a generated one has none it
/// can see, so a union and every variant of it came out as an empty object. Each
/// variant here is a class of its own, which the generator describes in full; the
/// only thing left for the package to say is which classes the union is made of,
/// and that is [variantSchemas], two lines below the decoder that dispatches on
/// the same three words.
sealed class PageBackground {
  const PageBackground();

  const factory PageBackground.solid({required String color, String type}) = PageBackgroundSolid;

  const factory PageBackground.gradient({
    required List<String> colors,
    List<double> stops,
    double beginX,
    double beginY,
    double endX,
    double endY,
    String type,
  }) = PageBackgroundGradient;

  const factory PageBackground.image({required String imageUrl, BoxFitConfig fit, double opacity, String type}) =
      PageBackgroundImage;

  factory PageBackground.fromJson(Map<String, Object?> json) => switch (json['type']) {
    'solid' => PageBackgroundSolid.fromJson(json),
    'gradient' => PageBackgroundGradient.fromJson(json),
    'image' => PageBackgroundImage.fromJson(json),
    final unknown => throw CheckedFromJsonException(json, 'type', 'PageBackground', 'Invalid union type "$unknown"!'),
  };

  /// The variants, for [assembleUnions]. Kept beside the decoder above: a new
  /// background is added in both places or in neither.
  static const Map<String, Map<String, Object?>> variantSchemas = {
    'PageBackgroundSolid': PageBackgroundSolid.jsonSchema,
    'PageBackgroundGradient': PageBackgroundGradient.jsonSchema,
    'PageBackgroundImage': PageBackgroundImage.jsonSchema,
  };

  Map<String, Object?> toJson();
}

/// A single colour.
@freezed
@JsonSerializable(explicitToJson: true)
class PageBackgroundSolid extends PageBackground with _$PageBackgroundSolid {
  const PageBackgroundSolid({required this.color, this.type = 'solid'});

  /// The colour to fill with (hex string, e.g. `#3A6EA5`).
  @override
  final String color;

  /// The discriminator. Always `solid`.
  @override
  final String type;

  factory PageBackgroundSolid.fromJson(Map<String, Object?> json) => _$PageBackgroundSolidFromJson(json);

  @override
  Map<String, Object?> toJson() => _$PageBackgroundSolidToJson(this);

  static const Map<String, Object?> jsonSchema = _$PageBackgroundSolidJsonSchema;
}

/// A linear gradient between two points of the page.
@freezed
@JsonSerializable(explicitToJson: true)
class PageBackgroundGradient extends PageBackground with _$PageBackgroundGradient {
  const PageBackgroundGradient({
    required this.colors,
    // No default here, and none anywhere in the contract: a non-empty
    // collection default crashes the schema generator, which hands the
    // analyser's own objects to a literal writer that has no case for them.
    // The value belongs where it is read anyway - a gradient with no stops is
    // an even gradient, and saying so at the point of drawing is clearer than
    // materialising a pair into every document that never asked for one.
    this.stops = const <double>[],
    this.beginX = 0.0,
    this.beginY = 0.0,
    this.endX = 1.0,
    this.endY = 1.0,
    this.type = 'gradient',
  });

  /// The colours to run between (hex strings).
  @override
  final List<String> colors;

  /// Where each colour sits, `0.0` to `1.0`. Empty means an even spread.
  @override
  final List<double> stops;

  @override
  final double beginX;

  @override
  final double beginY;

  @override
  final double endX;

  @override
  final double endY;

  /// The discriminator. Always `gradient`.
  @override
  final String type;

  factory PageBackgroundGradient.fromJson(Map<String, Object?> json) => _$PageBackgroundGradientFromJson(json);

  @override
  Map<String, Object?> toJson() => _$PageBackgroundGradientToJson(this);

  static const Map<String, Object?> jsonSchema = _$PageBackgroundGradientJsonSchema;
}

/// An image, fetched from [imageUrl].
@freezed
@JsonSerializable(explicitToJson: true)
class PageBackgroundImage extends PageBackground with _$PageBackgroundImage {
  const PageBackgroundImage({
    required this.imageUrl,
    this.fit = BoxFitConfig.cover,
    this.opacity = 1.0,
    this.type = 'image',
  });

  @override
  final String imageUrl;

  /// How the image is fitted into the page.
  @override
  final BoxFitConfig fit;

  @override
  final double opacity;

  /// The discriminator. Always `image`.
  @override
  final String type;

  factory PageBackgroundImage.fromJson(Map<String, Object?> json) => _$PageBackgroundImageFromJson(json);

  @override
  Map<String, Object?> toJson() => _$PageBackgroundImageToJson(this);

  static const Map<String, Object?> jsonSchema = _$PageBackgroundImageJsonSchema;
}
