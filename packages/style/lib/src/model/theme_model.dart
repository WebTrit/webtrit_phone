import 'images_scheme_model.dart';
import 'colors_scheme_model.dart';

class ThemeModel {
  ThemeModel({
    this.name,
    this.fontFamily,
    this.images,
    this.colors,
  });

  ThemeModel.fromJson(dynamic json) {
    name = json['name'];
    fontFamily = json['fontFamily'];
    images = json['images'] != null ? ImagesSchemeModel.fromJson(json['images']) : ImagesSchemeModel();
    colors = json['colors'] != null ? ColorsScheme.fromJson(json['colors']) : ColorsScheme();
  }

  String? name;
  String? fontFamily;
  ImagesSchemeModel? images;
  ColorsScheme? colors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    if (images != null) {
      map['images'] = images?.toJson();
    }
    map['fontFamily'] = fontFamily;
    if (colors != null) {
      map['colors'] = colors?.toJson();
    }
    return map;
  }
}
