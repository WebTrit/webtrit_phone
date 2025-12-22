import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/common.dart';

part 'page_background.freezed.dart';

part 'page_background.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
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
