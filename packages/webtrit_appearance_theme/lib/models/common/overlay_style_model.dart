import 'package:freezed_annotation/freezed_annotation.dart';

part 'overlay_style_model.freezed.dart';

part 'overlay_style_model.g.dart';

@Freezed()
class OverlayStyleModel with _$OverlayStyleModel {
  const factory OverlayStyleModel({
    required String statusBarColor,
    required String statusBarIconBrightness,
    String? statusBarBrightness,
    String? systemNavigationBarColor,
    String? systemNavigationBarIconBrightness,
  }) = _OverlayStyleModel;

  factory OverlayStyleModel.fromJson(Map<String, dynamic> json) => _$OverlayStyleModelFromJson(json);
}
