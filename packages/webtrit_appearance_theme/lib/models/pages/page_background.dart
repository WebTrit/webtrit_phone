import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/common.dart';

part 'page_background.freezed.dart';

part 'page_background.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
sealed class PageBackground with _$PageBackground {
  /// The discriminator, declared rather than left to freezed.
  ///
  /// Freezed writes a `$type` of its own and puts the value in the
  /// constructor's initialiser list, where the schema generator cannot see it:
  /// the parameter default it reads is `null`. Declared here it is an ordinary
  /// field with an ordinary default, so the generated schema states
  /// `{'type': 'string', 'default': 'solid'}` and no hand-written map has to
  /// repeat it.
  ///
  /// The wire is unchanged - the key is the union key, and freezed drops its
  /// own `$type` for a variant that declares one. What it costs is a parameter
  /// on every `when` and `map` callback, which is spelt `_` because inside a
  /// branch the value is the branch.
  const factory PageBackground.solid({required String color, @Default('solid') String type}) =
      PageBackgroundSolid;

  const factory PageBackground.gradient({
    required List<String> colors,
    @Default([0.0, 1.0]) List<double> stops,
    @Default(0.0) double beginX,
    @Default(0.0) double beginY,
    @Default(1.0) double endX,
    @Default(1.0) double endY,
    @Default('gradient') String type,
  }) = PageBackgroundGradient;

  const factory PageBackground.image({
    required String imageUrl,
    @Default(BoxFitConfig.cover) BoxFitConfig fit,
    @Default(1.0) double opacity,
    @Default('image') String type,
  }) = PageBackgroundImage;

  factory PageBackground.fromJson(Map<String, Object?> json) => _$PageBackgroundFromJson(json);
}
