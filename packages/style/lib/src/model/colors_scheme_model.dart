import 'dart:ui';

class ColorsScheme {
  ColorsScheme({
    this.primary,
    this.onPrimary,
    this.onSurface,
    this.surface,
    this.onSecondaryContainer,
    this.secondaryContainer,
    this.tertiary,
    this.error,
    this.secondary,
    this.outline,
    this.background,
    this.onBackground,
    this.gradientTab,
  });

  ColorsScheme.fromJson(dynamic json) {
    primary = json['primary'];
    onPrimary = json['onPrimary'];
    onSurface = json['onSurface'];
    surface = json['surface'];
    onSecondaryContainer = json['onSecondaryContainer'];
    secondaryContainer = json['secondaryContainer'];
    tertiary = json['tertiary'];
    error = json['error'];
    secondary = json['secondary'];
    outline = json['outline'];
    background = json['background'];
    onBackground = json['onBackground'];
    gradientTab = json['gradientTabColor'] != null ? json['gradientTabColor'].cast<String>() : [];
  }

  String? primary;
  String? onPrimary;
  String? onSurface;
  String? surface;
  String? onSecondaryContainer;
  String? secondaryContainer;
  String? tertiary;
  String? error;
  String? secondary;
  String? outline;
  String? background;
  String? onBackground;
  List<String>? gradientTab;

  Color? get primaryColor => _toColor(primary);

  Color? get onPrimaryColor => _toColor(onPrimary);

  Color? get onSurfaceColor => _toColor(onSurface);

  Color? get surfaceColor => _toColor(surface);

  Color? get onSecondaryContainerColor => _toColor(onSecondaryContainer);

  Color? get tertiaryColor => _toColor(tertiary);

  Color? get secondaryContainerColor => _toColor(secondaryContainer);

  Color? get errorColor => _toColor(error);

  Color? get secondaryColor => _toColor(secondary);

  Color? get outlineColor => _toColor(outline);

  Color? get backgroundColor => _toColor(background);

  Color? get onBackgroundColor => _toColor(onBackground);

  List<Color> get gradientTabColor => (gradientTab ?? []).map((color) => _toColor(color)!).toList();

  Color? _toColor(String? hexString, {Color? defaultColor}) {
    if (hexString == null) {
      return defaultColor;
    }

    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return defaultColor;
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['onPrimary'] = onPrimary;
    map['onSurface'] = onSurface;
    map['surface'] = surface;
    map['onSecondaryContainer'] = onSecondaryContainer;
    map['secondaryContainer'] = secondaryContainer;
    map['tertiary'] = tertiary;
    map['error'] = error;
    map['secondary'] = secondary;
    map['outline'] = outline;
    map['background'] = background;
    map['onBackground'] = onBackground;
    map['gradientTabColor'] = gradientTab;
    map['primary'] = primary;
    return map;
  }
}
