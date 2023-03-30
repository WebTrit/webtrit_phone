import 'dart:convert';

import 'package:flutter/services.dart';

import '../../app/assets.gen.dart';
import 'images_scheme.dart';
import 'colors_scheme.dart';

class StyleModel {
  StyleModel({
    this.name,
    this.fontFamily,
    this.images,
    this.colors,
  });

  StyleModel.fromJson(dynamic json) {
    name = json['name'];
    fontFamily = json['fontFamily'];
    images = json['images'] != null ? ImagesSchemeModel.fromJson(json['images']) : ImagesSchemeModel();
    colors = json['colors'] != null ? ColorsScheme.fromJson(json['colors']) : ColorsScheme();
  }

  String? name;
  String? fontFamily;
  ImagesSchemeModel? images;
  ColorsScheme? colors;

  static Future<StyleModel> readStyleFromAssets() async {
    final String response = await rootBundle.loadString(Assets.style.webtrit);
    final model = StyleModel.fromJson(jsonDecode(response));
    model.images?.prepare();
    return model;
  }
}
