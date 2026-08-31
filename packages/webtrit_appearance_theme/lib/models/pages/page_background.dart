import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/common.dart';

part 'page_background.freezed.dart';

part 'page_background.g.dart';

/// The `type` discriminator carries the constructor name verbatim - `solid`,
/// `gradient`, `image`. This union carried `snake` from the commit that
/// introduced it, alongside the same three single-word factories, so it never
/// produced a snake_cased value; `none` is what the package's other two unions
/// state, and stating it here leaves one rule instead of three. See the wire
/// contract in AGENTS.md.
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
sealed class PageBackground with _$PageBackground {
  const factory PageBackground.solid({required String color}) = PageBackgroundSolid;

  const factory PageBackground.gradient({
    required List<String> colors,
    @Default([0.0, 1.0]) List<double> stops,
    @Default(0.0) double beginX,
    @Default(0.0) double beginY,
    @Default(1.0) double endX,
    @Default(1.0) double endY,
  }) = PageBackgroundGradient;

  const factory PageBackground.image({
    required String imageUrl,
    @Default(BoxFitConfig.cover) BoxFitConfig fit,
    @Default(1.0) double opacity,
  }) = PageBackgroundImage;

  factory PageBackground.fromJson(Map<String, Object?> json) => _$PageBackgroundFromJson(json);
}
